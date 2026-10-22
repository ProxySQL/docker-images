#!/usr/bin/env bash
set -euo pipefail

if [[ $# != 4 || ! "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ||
      ! "$3" =~ ^(debian|centos)$ || ! "$4" =~ ^(amd64|arm64)$ ]]; then
    echo "Usage: $0 IMAGE VERSION debian|centos amd64|arm64" >&2
    exit 1
fi

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
docker run --rm --interactive --network none --platform "linux/$4" \
    --mount "type=bind,src=${SCRIPT_DIR}/proxysql-centos/ca-distrust,dst=/tmp/ca-distrust,readonly" \
    --entrypoint bash "$1" -s -- "$2" "$3" "$4" <<'VERIFY'
set -euo pipefail
version=$1
distro=$2
arch=$3

case "$distro" in
    debian)
        bundle=/etc/ssl/certs/ca-certificates.crt
        actual_arch=$(dpkg --print-architecture)
        ;;
    centos)
        bundle=/etc/pki/tls/certs/ca-bundle.crt
        case "$(rpm --eval '%{_arch}')" in
            x86_64) actual_arch=amd64 ;;
            aarch64) actual_arch=arm64 ;;
            *) echo 'Unsupported RPM architecture' >&2; exit 1 ;;
        esac
        ;;
esac
test "$actual_arch" = "$arch"
test "${PROXYSQL_VERSION:-}" = "$version"

# Check the effective bundle, rather than the presence of source certificates:
# distros can retain a root's PEM file while removing its trust.
test -s "$bundle"
grep -q 'BEGIN CERTIFICATE' "$bundle"
openssl crl2pkcs7 -nocrl -certfile "$bundle" >/dev/null
for cert in /tmp/ca-distrust/*.crt; do
    case "${cert##*/}" in
        emSign_ECC_Root_CA_-_G3.crt)
            expected_fingerprint=86:A1:EC:BA:08:9C:4A:8D:3B:BE:27:34:C6:12:BA:34:1D:81:3E:04:3C:F9:E8:A8:62:CD:5C:57:A3:6B:BE:6B
            ;;
        Comodo_AAA_Services_root.crt)
            expected_fingerprint=D7:A7:A0:FB:5D:7E:27:31:D7:71:E9:48:4E:BC:DE:F7:1D:5F:0C:3E:0A:29:48:78:2B:C8:3E:E0:EA:69:9E:F4
            ;;
        *) echo 'FAIL: unknown CA test fixture' >&2; exit 1 ;;
    esac
    fingerprint=$(openssl x509 -in "$cert" -noout -fingerprint -sha256)
    test "${fingerprint#*=}" = "$expected_fingerprint"
    if openssl verify -no_check_time -CAfile "$bundle" "$cert" >/dev/null 2>&1; then
        echo "FAIL: distrusted CA remains trusted: ${cert##*/}" >&2
        exit 1
    fi
    echo "PASS: ${cert##*/} is not trusted"
done

if [[ "$distro" == debian ]]; then
    ca_version=$(dpkg-query -W -f='${Version}' ca-certificates)
    dpkg --compare-versions "$ca_version" ge '20250419+deb13u1'
else
    ca_version=$(rpm -q ca-certificates)
fi
echo "CA package: $ca_version"

version_output=$(proxysql --version 2>&1)
grep -Eq "ProxySQL version ${version//./\.}([^0-9.]|$)" <<<"$version_output"
echo "$version_output"

work=$(mktemp -d)
pid=
cleanup() {
    if [[ -n "$pid" ]]; then
        kill "$pid" 2>/dev/null || true
        wait "$pid" 2>/dev/null || true
    fi
    rm -rf "$work"
}
trap cleanup EXIT
mkdir "$work/data"
cat >"$work/proxysql.cnf" <<'CONFIG'
admin_variables = {
    admin_credentials = "smoke:smoke"
    mysql_ifaces = "127.0.0.1:6032"
}
mysql_variables = {
    threads = 1
    interfaces = "127.0.0.1:6033"
}
CONFIG
proxysql -f --idle-threads -c "$work/proxysql.cnf" -D "$work/data" >"$work/proxysql.log" 2>&1 &
pid=$!
client_options=(--ssl-mode=DISABLED)
if mysql --version | grep -qi MariaDB; then
    client_options=(--skip-ssl)
fi
for attempt in {1..40}; do
    if result=$(mysql "${client_options[@]}" --protocol=tcp --host=127.0.0.1 \
        --port=6032 --user=smoke --password=smoke --connect-timeout=2 \
        --batch --skip-column-names --execute='SELECT 1' 2>"$work/client.log"); then
        test "$result" = 1
        echo "PASS: ProxySQL $version / $distro / $arch startup and admin SELECT 1"
        exit 0
    fi
    if ! kill -0 "$pid" 2>/dev/null; then
        break
    fi
    sleep 0.5
done
cat "$work/proxysql.log" "$work/client.log" >&2
echo 'FAIL: ProxySQL admin interface did not become ready' >&2
exit 1
VERIFY

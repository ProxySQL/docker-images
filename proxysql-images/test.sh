#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VERS="${VERS:-}"
if [ -z "$VERS" ]; then
	RESPONSE=$(curl -sf --max-time 30 "https://api.github.com/repos/sysown/proxysql/releases/latest") || {
		echo "ERROR: Failed to fetch latest release from GitHub API" >&2
		exit 1
	}
	VERS=$(echo "$RESPONSE" | jq -r '.tag_name // empty' | sed 's/^v//')
	if [ -z "$VERS" ]; then
		echo "ERROR: Could not determine latest ProxySQL version from GitHub API response" >&2
		exit 1
	fi
fi

DIST="${DIST:-debian}"
IMAGE="proxysql-test:${VERS}-${DIST}"
DERIVED_IMAGE="proxysql-test-derived:${VERS}-${DIST}"
FAILED=0

cleanup() {
	docker rmi -f "$IMAGE" >/dev/null 2>&1 || true
	docker rmi -f "$DERIVED_IMAGE" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "=== Testing proxysql-${DIST} with VERS=${VERS} ==="

docker buildx build --build-arg VERS="$VERS" -t "$IMAGE" --load -q "${SCRIPT_DIR}/proxysql-${DIST}"

echo "--- Test 1: PROXYSQL_VERSION env var is set ---"
ENV_VERSION=$(docker run --rm "$IMAGE" printenv PROXYSQL_VERSION)
if [ "$ENV_VERSION" = "$VERS" ]; then
	echo "PASS: PROXYSQL_VERSION=${ENV_VERSION}"
else
	echo "FAIL: expected PROXYSQL_VERSION=${VERS}, got '${ENV_VERSION}'"
	FAILED=1
fi

echo "--- Test 2: PROXYSQL_VERSION matches installed proxysql version ---"
INSTALLED_VERSION=$(docker run --rm "$IMAGE" proxysql --version 2>/dev/null | grep -oP 'ProxySQL version \K[0-9]+\.[0-9]+\.[0-9]+' || true)
if [ -z "$INSTALLED_VERSION" ]; then
	INSTALLED_VERSION=$(docker run --rm "$IMAGE" proxysql --version 2>&1 | sed -n 's/.*ProxySQL version \([0-9.]*\).*/\1/p')
fi
if [ "$INSTALLED_VERSION" = "$VERS" ]; then
	echo "PASS: installed version matches (${INSTALLED_VERSION})"
else
	echo "FAIL: installed version '${INSTALLED_VERSION}' != expected '${VERS}'"
	FAILED=1
fi

echo "--- Test 3: ENV is inherited by derived images ---"
DERIVED_IMAGE="proxysql-test-derived:${VERS}-${DIST}"
TMPDIR_DERIVED=$(mktemp -d)
echo "FROM ${IMAGE}" > "${TMPDIR_DERIVED}/Dockerfile"
docker build -t "$DERIVED_IMAGE" "$TMPDIR_DERIVED" -q
rm -rf "$TMPDIR_DERIVED"
DERIVED_VERSION=$(docker run --rm "$DERIVED_IMAGE" printenv PROXYSQL_VERSION)
if [ "$DERIVED_VERSION" = "$VERS" ]; then
	echo "PASS: derived image inherits PROXYSQL_VERSION=${DERIVED_VERSION}"
else
	echo "FAIL: derived image PROXYSQL_VERSION='${DERIVED_VERSION}', expected '${VERS}'"
	FAILED=1
fi

echo ""
if [ "$FAILED" -eq 0 ]; then
	echo "=== All tests PASSED ==="
else
	echo "=== Some tests FAILED ==="
	exit 1
fi

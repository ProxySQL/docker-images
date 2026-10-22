# Docker images for building and running ProxySQL

Images can be found at:
- https://hub.docker.com/r/proxysql/packaging
- https://hub.docker.com/r/proxysql/proxysql

> [!NOTE]
> - DockerHub images are tagged respective to ProxySQL version or previous if no change - e.g.: build-debian13-v3.0.3
> - DockerHub images without version are always the latest version

> [!NOTE]
> - this git repository uses tags refering to a ProxySQL version - e.g.: tag 'v3.0.3'
> - to get the Dockerfiles used for building and release of ProxySQL v3.0.3, use `git chekout v3.0.3`

#### build-images
- used for building of proxysql packages usibg GCC
- based on upstream images
- added GCC build tooling
- added build dependencies

#### build-clang-images
- used for building of proxysql packages using CLang
- based on upstream images
- added CLANG build tooling
  - clang must use lld
  - RH based distros still pull GCC as dependency
- added build dependencies

#### pkgtest-images
- used for basic testing of built proxysql packages
- based on upstream images
- added runtime dependencies

#### proxysql-images
- proxysql prebuild image

### Runtime image security refreshes

Runtime images are refreshed every Monday at 04:17 UTC, on runtime-image
changes merged into `main`, and through **Actions → Refresh ProxySQL runtime
images → Run workflow**. Configure repository secrets `DOCKERHUB_USERNAME`
and `DOCKERHUB_TOKEN` with permission to push to `proxysql/proxysql`.

`proxysql-images/releases.json` is the reviewed release policy. It currently
refreshes **3.0.11**, the version published under `latest`. Update the policy
when publishing a new supported release. Do not derive `latest` from GitHub's
most recently published release: maintenance releases from an older major
series can be newer by date. An empty `aliases` list refreshes a historical
version without moving floating tags. Duplicate aliases and aliases for an
unrelated release line are rejected before any image is built.

The workflow builds Debian and CentOS images on native AMD64 and ARM64 runners
with `--pull --no-cache`. Each image must pass effective CA-bundle checks,
version/architecture checks, and a ProxySQL startup/admin `SELECT 1` test.
Only after **all** build/test jobs succeed are the verified per-architecture
`refresh-<version>-<distro>-<arch>` staging images promoted to multiarch release
tags. These bounded staging tags are reused by later refreshes.

The normal tag convention is preserved: Debian receives the version and
configured aliases both with and without `-debian`; CentOS receives the same
names with `-centos`. The ProxySQL application version stays unchanged during
an OS security refresh, while the image digest changes. Existing containers
must be pulled and recreated to receive the fix; digest-pinned deployments
must explicitly select the new digest.

For [sysown/proxysql#6519](https://github.com/sysown/proxysql/issues/6519), Debian
requires `ca-certificates >= 20250419+deb13u1`, the security update described in
[DSA-6572-1](https://lists.debian.org/debian-security-announce/2026/msg00487.html).
CentOS explicitly distrusts the same two roots until the distro supplies the
corresponding update. The public certificates in
`proxysql-images/proxysql-centos/ca-distrust/` come from Debian's Mozilla CA
package and have these SHA-256 fingerprints:

- emSign ECC Root CA - G3:
  `86:A1:EC:BA:08:9C:4A:8D:3B:BE:27:34:C6:12:BA:34:1D:81:3E:04:3C:F9:E8:A8:62:CD:5C:57:A3:6B:BE:6B`
- AAA Certificate Services:
  `D7:A7:A0:FB:5D:7E:27:31:D7:71:E9:48:4E:BC:DE:F7:1D:5F:0C:3E:0A:29:48:78:2B:C8:3E:E0:EA:69:9E:F4`

The CA regression test uses `openssl verify -no_check_time` against the
effective trust bundle. It therefore detects trusted roots even after they
expire, and does not mistake retained but distrusted source PEM files for
active trust anchors.

---
### How to build images

> [!NOTE]
> - default build is MULTIARCH
> - built images are cached, and need LOAD or PUSH to be available
> - PUSH needs `docker credentials` authentication to `hub.docker.com`

#### Native-arch
run `make` inside of one of the folders to build native image, and load it into local image store
e.g.:

    cd build-images
    make clean
    NOMULTIARCH=1 LOAD=1 make [target]

#### Multi-arch
run `make` inside of one of the folders to build multi-arch images,
 and push to `hub.docker.com` image registry,
 supported architectures are amd64 and arm64.
e.g.:

    cd build-images
    make clean
    PUSH=1 make [target]

---
### Ubuntu 26.04 (resolute) packaging builders

Ubuntu 26.04 packaging is supported starting with ProxySQL 3.0.12, 3.1.12,
and 4.0.12. The same builder images serve all three tiers. To build and load
the image tags referenced by ProxySQL's `docker-compose.yml` locally:

```bash
make -C build-images VERS=4.0.0 LOAD=1 build-ubuntu26
make -C build-clang-images VERS=4.0.0 LOAD=1 build-clang-ubuntu26
```

For release CI, publish the AMD64 and ARM64 images using `PUSH=1` instead of
`LOAD=1` after configuring the multiarch builder described below.

---
### Setup Docker for local multiarch via Qemu

> [!NOTE]
> - Using buildx with Docker requires Docker engine 19.03 or newer
> - since Docker v23, BuildX is packaged and will be installed if you install from upstream

Install docker from upstream 
- https://docs.docker.com/engine/install/

Qemu is required for multiarch local builds

    apt-get install --no-install-recommends qemu-system-arm

Bootstrap BuildX for local multiarch using qemu

    docker rm -f buildx_buildkit_multiarch0
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    docker buildx rm multiarch
    docker buildx create --name multiarch --driver docker-container --use
    docker buildx inspect --bootstrap
    docker buildx ls
    
---
### Setup Docker for distributed native multiarch

> [!NOTE]
> - This requires native hosts for buidling respective arch
> - docker and buildx must be installed on all nodes
> - make sure to test the ssh connection first

    docker buildx rm distarch
    docker buildx create --name distarch --node local_amd64
    docker buildx create --name distarch --append --node remote_arm64 ssh://root@<IP>:<PORT>
    docker buildx use distarch
    docker buildx inspect --bootstrap
    docker buildx ls

---
### Inner workings

Runing image build

    docker buildx build -t proxysql/packaging:build-debian11 --platform linux/arm64,linux/amd64 proxysql-build-debian11

Uploading finished build

    docker credentials
    docker buildx build -t proxysql/packaging:build-debian11 --platform linux/arm64,linux/amd64 proxysql-build-debian11 --push


---
### Resources...
- install buildx https://docs.docker.com/buildx/working-with-buildx/#linux-packages
- buildx multiarch https://docs.docker.com/desktop/multi-arch/
- multiarch build tcp cluster https://fy.blackhats.net.au/blog/html/2020/08/06/docker_buildx_for_multiarch_builds.html
- multiarch build ssh remotes https://dev.to/aboozar/build-docker-multi-platform-image-using-buildx-remote-builder-node-5631
- issues https://github.com/docker/buildx/issues/495

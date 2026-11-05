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

### Publish runtime images with GitHub Actions

Use **Actions → Publish ProxySQL Images → Run workflow** on `main` and enter
the published stable version, without `v` (for example, `3.0.12`). Leave
**publish** unchecked for a build and test run, or check it to publish after
all tests pass. The equivalent CLI command is:

```bash
gh workflow run proxysql-publish.yml --repo ProxySQL/docker-images --ref main \
  -f version=3.0.12 -F publish=true
```

The workflow builds Debian 13 and CentOS 10 images on native AMD64 and ARM64
GitHub-hosted runners. Each build installs the requested version from the
signed ProxySQL package repository, so the release must be deployed there
for both distributions and architectures first. Draft and prerelease
GitHub releases are rejected.

Tests check the image architecture, version environment variable, installed
ProxySQL version, MySQL and PostgreSQL clients, configuration file, and a
running ProxySQL admin query. All four images must pass before any Docker
Hub writes. The publishing job downloads the tested images as artifacts,
checks their image IDs and publishes them without rebuilding. Artifacts are
retained for one day.

Publishing uses the existing repository secrets `DOCKERHUB_USERNAME` and
`DOCKERHUB_TOKEN`; the token needs write access to `proxysql/proxysql`. Local
`docker login` is not required. Pull requests build and test the latest
stable release without logging in or publishing. Manual publishing is
restricted to `main`, and manual runs are serialized.

The version tags are `X.Y.Z` (Debian), `X.Y.Z-debian` and `X.Y.Z-centos`, with
both architectures in each manifest. Per-architecture tags are also
published as `X.Y.Z-{debian,centos}-{amd64,arm64}`. Only when the requested
version is the current latest stable GitHub release does the workflow
update `latest`, `X.Y`, `X` and the corresponding `-debian` and `-centos`
aliases. Publishing an older release leaves those aliases unchanged.

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

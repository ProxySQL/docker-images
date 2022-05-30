# Docker images for building ProxySQL

Images can be found at:
https://hub.docker.com/repository/docker/proxysql/packaging

#### build-images
- used for building of proxysql packages
- based on upstream images
- added GCC build tooling
- added build dependencies

#### build-clang-images
- used for building of proxysql packages
- based on upstream images
- added CLANG build tooling
  - clang must use lld
  - RH based distros still pull GCC as dependency
- added build dependencies

#### pkgtest-images
- used for basic testing of built proxysql packages
- based on upstream images
- added runtime dependencies

#### HowTo native-arch
run make inside of one of the folders to build native image,
e.g.:

    # cd build-images
    # make clean
    # make [target]

#### HowTo multi-arch
run make inside of one of the folders to build multi-arch images,
supported architectures are amd64 and arm64.
e.g.:

    # cd build-images
    # make clean
    # make -f Makefile.multiarch [target]

#### Setup Docker for multiarch

Install docker from upstream
- https://docs.docker.com/engine/install/

Qemu is required for non-native arch image builds

    apt-get install qemu-system-arm

Install BuildX plugin for Docker
- https://github.com/docker/buildx#linux-packages
- https://github.com/docker/buildx/releases

```
mkdir -p ~/.docker/cli-plugins/
wget -O ~/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.7.1/buildx-v0.7.1.linux-amd64
chmod a+x ~/.docker/cli-plugins/docker-buildx
```

Bootstrap BuildX

    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    docker buildx create --name multiarch --driver docker-container --use
    docker buildx inspect --bootstrap

Run image build

    docker buildx build -t proxysql/packaging:build-debian11 --platform linux/arm64,linux/amd64 proxysql-build-debian11

Upload finished build

    docker credentials
    docker buildx build -t proxysql/packaging:build-debian11 --platform linux/arm64,linux/amd64 proxysql-build-debian11 --push

#### Resources...
- install buildx https://docs.docker.com/buildx/working-with-buildx/#linux-packages
- buildx multiarch https://docs.docker.com/desktop/multi-arch/
- multiarch build cluster https://fy.blackhats.net.au/blog/html/2020/08/06/docker_buildx_for_multiarch_builds.html
- issues https://github.com/docker/buildx/issues/495

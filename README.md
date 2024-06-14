# Docker images for building and running ProxySQL

Images can be found at:
- https://hub.docker.com/repository/docker/proxysql/packaging
- https://hub.docker.com/repository/docker/proxysql/proxysql

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

#### proxysql-images
- proxysql prebuild image

---
### How to build images
#### Native-arch
run make inside of one of the folders to build native image,
e.g.:

    cd build-images
    make clean
    make [target]

#### Multi-arch
run make inside of one of the folders to build multi-arch images,
supported architectures are amd64 and arm64.
e.g.:

    cd build-images
    make clean
    make -f Makefile.multiarch [target]

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

    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
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
    docker buildx create --name distarch --append --node remote_arm64 ssh://root@<IP>
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

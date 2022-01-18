# Docker images for building ProxySQL

Images can be found at:
https://hub.docker.com/r/renecannao/proxysql/

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

#### HowTo
run make inside of one of the folders to build images,
e.g:

    # cd build-images
    # make clean
    # make proxysql-build-debian11

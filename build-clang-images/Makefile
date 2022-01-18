
NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}


.PHONY: default
default: build

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | awk '{print $3}' | xargs -r 'docker rmi | grep "proxysql/packaging"'

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: build
build: build-clang-centos build-clang-fedora build-clang-debian build-clang-ubuntu

.SILENT:
.PHONY: build-clang-centos
build-clang-centos: build-clang-centos8

.PHONY: build-clang-centos8
build-clang-centos8:
	echo 'building build-clang-centos8'
	docker build --rm --tag proxysql/packaging:build-clang-centos8 build-clang-centos8 > /dev/null
	echo 'tagged build-clang-centos8'


.SILENT:
.PHONY: build-clang-fedora
build-clang-fedora: build-clang-fedora34

.PHONY: build-clang-fedora34
build-clang-fedora34:
	echo 'building build-clang-fedora34'
	docker build --rm --tag proxysql/packaging:build-clang-fedora34 build-clang-fedora34 > /dev/null
	echo 'tagged build-clang-fedora34'


.SILENT:
.PHONY: build-clang-debian
build-clang-debian: build-clang-debian11

.PHONY: build-clang-debian11
build-clang-debian11:
	echo 'building build-clang-debian11'
	docker build --rm --tag proxysql/packaging:build-clang-debian11 build-clang-debian11 > /dev/null
	echo 'tagged build-clang-debian11'


.SILENT:
.PHONY: build-clang-ubuntu
build-clang-ubuntu: build-clang-ubuntu20

.PHONY: build-clang-ubuntu20
build-clang-ubuntu20:
	echo 'building build-clang-ubuntu20'
	docker build --rm --tag proxysql/packaging:build-clang-ubuntu20 build-clang-ubuntu20 > /dev/null
	echo 'tagged build-clang-ubuntu20'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"









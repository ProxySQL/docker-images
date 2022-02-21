#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT = >/dev/null
endif


.PHONY: default
default: pkgtest

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | awk '{print $3}' | xargs -r 'docker rmi | grep "proxysql/packaging"'

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: pkgtest
pkgtest: pkgtest-centos pkgtest-fedora pkgtest-debian pkgtest-ubuntu pkgtest-opensuse pkgtest-almalinux


.SILENT:
.PHONY: pkgtest-centos
pkgtest-centos: pkgtest-centos6 pkgtest-centos7 pkgtest-centos8

.PHONY: pkgtest-centos6
pkgtest-centos6:
	echo 'building pkgtest-centos6'
	docker build --rm --tag proxysql/packaging:pkgtest-centos6 pkgtest-centos6 ${SILENT}
	echo 'tagged pkgtest-centos6'

.PHONY: pkgtest-centos7
pkgtest-centos7:
	echo 'building pkgtest-centos7'
	docker build --rm --tag proxysql/packaging:pkgtest-centos7 pkgtest-centos7 ${SILENT}
	echo 'tagged pkgtest-centos7'

.PHONY: pkgtest-centos8
pkgtest-centos8:
	echo 'building pkgtest-centos8'
	docker build --rm --tag proxysql/packaging:pkgtest-centos8 pkgtest-centos8 ${SILENT}
	echo 'tagged pkgtest-centos8'


.SILENT:
.PHONY: pkgtest-fedora
pkgtest-fedora: pkgtest-fedora27 pkgtest-fedora28 pkgtest-fedora33 pkgtest-fedora34

.PHONY: pkgtest-fedora27
pkgtest-fedora27:
	echo 'building pkgtest-fedora27'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora27 pkgtest-fedora27 ${SILENT}
	echo 'tagged pkgtest-fedora27'

.PHONY: pkgtest-fedora28
pkgtest-fedora28:
	echo 'building pkgtest-fedora28'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora28 pkgtest-fedora28 ${SILENT}
	echo 'tagged pkgtest-fedora28'

.PHONY: pkgtest-fedora33
pkgtest-fedora33:
	echo 'building pkgtest-fedora33'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora33 pkgtest-fedora33 ${SILENT}
	echo 'tagged pkgtest-fedora33'

.PHONY: pkgtest-fedora34
pkgtest-fedora34:
	echo 'building pkgtest-fedora34'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora34 pkgtest-fedora34 ${SILENT}
	echo 'tagged pkgtest-fedora34'


.SILENT:
.PHONY: pkgtest-debian
pkgtest-debian: pkgtest-debian8 pkgtest-debian9 pkgtest-debian10 pkgtest-debian11

.PHONY: pkgtest-debian8
pkgtest-debian8:
	echo 'building pkgtest-debian8'
	docker build --rm --tag proxysql/packaging:pkgtest-debian8 pkgtest-debian8 ${SILENT}
	echo 'tagged pkgtest-debian8'

.PHONY: pkgtest-debian9
pkgtest-debian9:
	echo 'building pkgtest-debian9'
	docker build --rm --tag proxysql/packaging:pkgtest-debian9 pkgtest-debian9 ${SILENT}
	echo 'tagged pkgtest-debian9'

.PHONY: pkgtest-debian10
pkgtest-debian10:
	echo 'building pkgtest-debian10'
	docker build --rm --tag proxysql/packaging:pkgtest-debian10 pkgtest-debian10 ${SILENT}
	echo 'tagged pkgtest-debian10'

.PHONY: pkgtest-debian11
pkgtest-debian11:
	echo 'building pkgtest-debian11'
	docker build --rm --tag proxysql/packaging:pkgtest-debian11 pkgtest-debian11 ${SILENT}
	echo 'tagged pkgtest-debian11'



.SILENT:
.PHONY: pkgtest-ubuntu
pkgtest-ubuntu: pkgtest-ubuntu14 pkgtest-ubuntu16 pkgtest-ubuntu18 pkgtest-ubuntu20

.PHONY: pkgtest-ubuntu14
pkgtest-ubuntu14:
	echo 'building pkgtest-ubuntu14'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu14 pkgtest-ubuntu14 ${SILENT}
	echo 'tagged pkgtest-ubuntu14'

.PHONY: pkgtest-ubuntu16
pkgtest-ubuntu16:
	echo 'building pkgtest-ubuntu16'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu16 pkgtest-ubuntu16 ${SILENT}
	echo 'tagged pkgtest-ubuntu16'

.PHONY: pkgtest-ubuntu18
pkgtest-ubuntu18:
	echo 'building pkgtest-ubuntu18'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu18 pkgtest-ubuntu18 ${SILENT}
	echo 'tagged pkgtest-ubuntu18'

.PHONY: pkgtest-ubuntu20
pkgtest-ubuntu20:
	echo 'building pkgtest-ubuntu20'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu20 pkgtest-ubuntu20 ${SILENT}
	echo 'tagged pkgtest-ubuntu20'


.SILENT:
.PHONY: pkgtest-opensuse
pkgtest-opensuse: pkgtest-opensuse15

.PHONY: pkgtest-opensuse15
pkgtest-opensuse15:
	echo 'pkgtesting pkgtest-opensuse15'
	docker build --rm --tag proxysql/packaging:pkgtest-opensuse15 pkgtest-opensuse15 ${SILENT}
	echo 'tagged pkgtest-opensuse15'


.SILENT:
.PHONY: pkgtest-almalinux
pkgtest-centos: pkgtest-almalinux8

.PHONY: pkgtest-almalinux8
pkgtest-almalinux8:
	echo 'building pkgtest-almalinux8'
	docker build --rm --tag proxysql/packaging:pkgtest-almalinux8 pkgtest-almalinux8 ${SILENT}
	echo 'tagged pkgtest-almalinux8'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

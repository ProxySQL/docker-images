#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT = >/dev/null
endif


.PHONY: default
default: build

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | awk '{print $3}' | xargs -r 'docker rmi | grep "proxysql/packaging"'

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: build
build: build-centos build-fedora build-debian build-ubuntu build-opensuse build-almalinux


.SILENT:
.PHONY: build-centos
build-centos: build-centos6 build-centos7 build-centos8

.PHONY: build-centos6
build-centos6:
	echo 'building build-centos6'
	docker build --rm --tag proxysql/packaging:build-centos6 build-centos6 ${SILENT}
	echo 'tagged build-centos6'

.PHONY: build-centos7
build-centos7:
	echo 'building build-centos7'
	docker build --rm --tag proxysql/packaging:build-centos7 build-centos7 ${SILENT}
	echo 'tagged build-centos7'

.PHONY: build-centos8
build-centos8:
	echo 'building build-centos8'
	docker build --rm --tag proxysql/packaging:build-centos8 build-centos8 ${SILENT}
	echo 'tagged build-centos8'


.SILENT:
.PHONY: build-fedora
build-fedora: build-fedora27 build-fedora28 build-fedora33 build-fedora34

.PHONY: build-fedora27
build-fedora27:
	echo 'building build-fedora27'
	docker build --rm --tag proxysql/packaging:build-fedora27 build-fedora27 ${SILENT}
	echo 'tagged build-fedora27'

.PHONY: build-fedora28
build-fedora28:
	echo 'building build-fedora28'
	docker build --rm --tag proxysql/packaging:build-fedora28 build-fedora28 ${SILENT}
	echo 'tagged build-fedora28'

.PHONY: build-fedora33
build-fedora33:
	echo 'building build-fedora33'
	docker build --rm --tag proxysql/packaging:build-fedora33 build-fedora33 ${SILENT}
	echo 'tagged build-fedora33'

.PHONY: build-fedora34
build-fedora34:
	echo 'building build-fedora34'
	docker build --rm --tag proxysql/packaging:build-fedora34 build-fedora34 ${SILENT}
	echo 'tagged build-fedora34'


.SILENT:
.PHONY: build-debian
build-debian: build-debian8 build-debian9 build-debian10 build-debian11

.PHONY: build-debian8
build-debian8:
	echo 'building build-debian8'
	docker build --rm --tag proxysql/packaging:build-debian8 build-debian8 ${SILENT}
	echo 'tagged build-debian8'

.PHONY: build-debian9
build-debian9:
	echo 'building build-debian9'
	docker build --rm --tag proxysql/packaging:build-debian9 build-debian9 ${SILENT}
	echo 'tagged build-debian9'

.PHONY: build-debian10
build-debian10:
	echo 'building build-debian10'
	docker build --rm --tag proxysql/packaging:build-debian10 build-debian10 ${SILENT}
	echo 'tagged build-debian10'

.PHONY: build-debian11
build-debian11:
	echo 'building build-debian11'
	docker build --rm --tag proxysql/packaging:build-debian11 build-debian11 ${SILENT}
	echo 'tagged build-debian11'


.SILENT:
.PHONY: build-ubuntu
build-ubuntu: build-ubuntu14 build-ubuntu16 build-ubuntu18 build-ubuntu20

.PHONY: build-ubuntu14
build-ubuntu14:
	echo 'building build-ubuntu14'
	docker build --rm --tag proxysql/packaging:build-ubuntu14 build-ubuntu14 ${SILENT}
	echo 'tagged build-ubuntu14'

.PHONY: build-ubuntu16
build-ubuntu16:
	echo 'building build-ubuntu16'
	docker build --rm --tag proxysql/packaging:build-ubuntu16 build-ubuntu16 ${SILENT}
	echo 'tagged build-ubuntu16'

.PHONY: build-ubuntu18
build-ubuntu18:
	echo 'building build-ubuntu18'
	docker build --rm --tag proxysql/packaging:build-ubuntu18 build-ubuntu18 ${SILENT}
	echo 'tagged build-ubuntu18'

.PHONY: build-ubuntu20
build-ubuntu20:
	echo 'building build-ubuntu20'
	docker build --rm --tag proxysql/packaging:build-ubuntu20 build-ubuntu20 ${SILENT}
	echo 'tagged build-ubuntu20'


.SILENT:
.PHONY: build-opensuse
build-opensuse: build-opensuse15

.PHONY: build-opensuse15
build-opensuse15:
	echo 'building build-opensuse15'
	docker build --rm --tag proxysql/packaging:build-opensuse15 build-opensuse15 ${SILENT}
	echo 'tagged build-opensuse15'


.SILENT:
.PHONY: build-almalinux
build-almalinux: build-almalinux8

.PHONY: build-almalinux8
build-almalinux8:
	echo 'building build-almalinux8'
	docker build --rm --tag proxysql/packaging:build-almalinux8 build-almalinux8 ${SILENT}
	echo 'tagged build-almalinux8'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

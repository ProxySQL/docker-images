
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
build: build-centos build-fedora build-debian build-ubuntu build-suse build-almalinux

.SILENT:
.PHONY: build-centos
build-centos: proxysql-build-centos6 proxysql-build-centos6.7v2 proxysql-build-centos7 proxysql-build-centos8

.PHONY: proxysql-build-centos6
proxysql-build-centos6:
	echo 'building proxysql-build-centos6'
	docker build --rm --tag proxysql/packaging:build-centos6 proxysql-build-centos6 ${SILENT}
	echo 'tagged proxysql-build-centos6'

.PHONY: proxysql-build-centos6.7v2
proxysql-build-centos6.7v2:
	echo 'building proxysql-build-centos6.7v2'
	docker build --rm --tag proxysql/packaging:build-centos6.7v2 proxysql-build-centos6.7v2 ${SILENT}
	echo 'tagged proxysql-build-centos6.7v2'

.PHONY: proxysql-build-centos7
proxysql-build-centos7:
	echo 'building proxysql-build-centos7'
	docker build --rm --tag proxysql/packaging:build-centos7 proxysql-build-centos7 ${SILENT}
	echo 'tagged proxysql-build-centos7'

.PHONY: proxysql-build-centos8
proxysql-build-centos8:
	echo 'building proxysql-build-centos8'
	docker build --rm --tag proxysql/packaging:build-centos8 proxysql-build-centos8 ${SILENT}
	echo 'tagged proxysql-build-centos8'


.SILENT:
.PHONY: build-fedora
build-fedora: proxysql-build-fedora24 proxysql-build-fedora27 proxysql-build-fedora28 proxysql-build-fedora33 proxysql-build-fedora34

.PHONY: proxysql-build-fedora24
proxysql-build-fedora24:
	echo 'building proxysql-build-fedora24'
	docker build --rm --tag proxysql/packaging:build-fedora24 proxysql-build-fedora24 ${SILENT}
	echo 'tagged proxysql-build-fedora24'

.PHONY: proxysql-build-fedora27
proxysql-build-fedora27:
	echo 'building proxysql-build-fedora27'
	docker build --rm --tag proxysql/packaging:build-fedora27 proxysql-build-fedora27 ${SILENT}
	echo 'tagged proxysql-build-fedora27'

.PHONY: proxysql-build-fedora28
proxysql-build-fedora28:
	echo 'building proxysql-build-fedora28'
	docker build --rm --tag proxysql/packaging:build-fedora28 proxysql-build-fedora28 ${SILENT}
	echo 'tagged proxysql-build-fedora28'

.PHONY: proxysql-build-fedora33
proxysql-build-fedora33:
	echo 'building proxysql-build-fedora33'
	docker build --rm --tag proxysql/packaging:build-fedora33 proxysql-build-fedora33 ${SILENT}
	echo 'tagged proxysql-build-fedora33'

.PHONY: proxysql-build-fedora34
proxysql-build-fedora34:
	echo 'building proxysql-build-fedora34'
	docker build --rm --tag proxysql/packaging:build-fedora34 proxysql-build-fedora34 ${SILENT}
	echo 'tagged proxysql-build-fedora34'


.SILENT:
.PHONY: build-debian
build-debian: proxysql-build-debian8 proxysql-build-debian9 proxysql-build-debian10 proxysql-build-debian11

.PHONY: proxysql-build-debian8
proxysql-build-debian8:
	echo 'building proxysql-build-debian8'
	docker build --rm --tag proxysql/packaging:build-debian8 proxysql-build-debian8 ${SILENT}
	echo 'tagged proxysql-build-debian8'

.PHONY: proxysql-build-debian9
proxysql-build-debian9:
	echo 'building proxysql-build-debian9'
	docker build --rm --tag proxysql/packaging:build-debian9 proxysql-build-debian9 ${SILENT}
	echo 'tagged proxysql-build-debian9'

.PHONY: proxysql-build-debian10
proxysql-build-debian10:
	echo 'building proxysql-build-debian10'
	docker build --rm --tag proxysql/packaging:build-debian10 proxysql-build-debian10 ${SILENT}
	echo 'tagged proxysql-build-debian10'

.PHONY: proxysql-build-debian11
proxysql-build-debian11:
	echo 'building proxysql-build-debian11'
	docker build --rm --tag proxysql/packaging:build-debian11 proxysql-build-debian11 ${SILENT}
	echo 'tagged proxysql-build-debian11'


.SILENT:
.PHONY: build-ubuntu
build-ubuntu: proxysql-build-ubuntu14 proxysql-build-ubuntu16 proxysql-build-ubuntu18 proxysql-build-ubuntu20

.PHONY: proxysql-build-ubuntu14
proxysql-build-ubuntu14:
	echo 'building proxysql-build-ubuntu14'
	docker build --rm --tag proxysql/packaging:build-ubuntu14 proxysql-build-ubuntu14 ${SILENT}
	echo 'tagged proxysql-build-ubuntu14'

.PHONY: proxysql-build-ubuntu16
proxysql-build-ubuntu16:
	echo 'building proxysql-build-ubuntu16'
	docker build --rm --tag proxysql/packaging:build-ubuntu16 proxysql-build-ubuntu16 ${SILENT}
	echo 'tagged proxysql-build-ubuntu16'

.PHONY: proxysql-build-ubuntu18
proxysql-build-ubuntu18:
	echo 'building proxysql-build-ubuntu18'
	docker build --rm --tag proxysql/packaging:build-ubuntu18 proxysql-build-ubuntu18 ${SILENT}
	echo 'tagged proxysql-build-ubuntu18'

.PHONY: proxysql-build-ubuntu20
proxysql-build-ubuntu20:
	echo 'building proxysql-build-ubuntu20'
	docker build --rm --tag proxysql/packaging:build-ubuntu20 proxysql-build-ubuntu20 ${SILENT}
	echo 'tagged proxysql-build-ubuntu20'


.SILENT:
.PHONY: build-suse
build-suse: proxysql-build-opensuse15

.PHONY: proxysql-build-opensuse15
proxysql-build-opensuse15:
	echo 'building proxysql-build-opensuse15'
	docker build --rm --tag proxysql/packaging:build-opensuse15 proxysql-build-opensuse15 ${SILENT}
	echo 'tagged proxysql-build-opensuse15'


.SILENT:
.PHONY: build-almalinux
build-almalinux: proxysql-build-almalinux8

.PHONY: proxysql-build-almalinux8
proxysql-build-almalinux8:
	echo 'building proxysql-build-almalinux8'
	docker build --rm --tag proxysql/packaging:build-almalinux8 proxysql-build-almalinux8 ${SILENT}
	echo 'tagged proxysql-build-almalinux8'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

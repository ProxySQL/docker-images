
NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}


.PHONY: default
default: pkgtest

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | awk '{print $3}' | xargs -r 'docker rmi | grep "proxysql/packaging"'

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: pkgtest
pkgtest: pkgtest-centos pkgtest-fedora pkgtest-debian pkgtest-ubuntu pkgtest-suse


.SILENT:
.PHONY: pkgtest-centos
pkgtest-centos: proxysql-pkgtest-centos6 proxysql-pkgtest-centos7 proxysql-pkgtest-centos8

.PHONY: proxysql-pkgtest-centos6
proxysql-pkgtest-centos6:
	echo 'building proxysql-pkgtest-centos6'
	docker build --rm --tag proxysql/packaging:pkgtest-centos6 proxysql-pkgtest-centos6 > /dev/null
	echo 'tagged proxysql-pkgtest-centos6'

.PHONY: proxysql-pkgtest-centos7
proxysql-pkgtest-centos7:
	echo 'building proxysql-pkgtest-centos7'
	docker build --rm --tag proxysql/packaging:pkgtest-centos7 proxysql-pkgtest-centos7 > /dev/null
	echo 'tagged proxysql-pkgtest-centos7'

.PHONY: proxysql-pkgtest-centos8
proxysql-pkgtest-centos8:
	echo 'building proxysql-pkgtest-centos8'
	docker build --rm --tag proxysql/packaging:pkgtest-centos8 proxysql-pkgtest-centos8 > /dev/null
	echo 'tagged proxysql-pkgtest-centos8'


.SILENT:
.PHONY: pkgtest-fedora
pkgtest-fedora: proxysql-pkgtest-fedora24 proxysql-pkgtest-fedora27 proxysql-pkgtest-fedora28 proxysql-pkgtest-fedora33 proxysql-pkgtest-fedora34

.PHONY: proxysql-pkgtest-fedora24
proxysql-pkgtest-fedora24:
	echo 'building proxysql-pkgtest-fedora24'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora24 proxysql-pkgtest-fedora24 > /dev/null
	echo 'tagged proxysql-pkgtest-fedora24'

.PHONY: proxysql-pkgtest-fedora27
proxysql-pkgtest-fedora27:
	echo 'building proxysql-pkgtest-fedora27'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora27 proxysql-pkgtest-fedora27 > /dev/null
	echo 'tagged proxysql-pkgtest-fedora27'

.PHONY: proxysql-pkgtest-fedora28
proxysql-pkgtest-fedora28:
	echo 'building proxysql-pkgtest-fedora28'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora28 proxysql-pkgtest-fedora28 > /dev/null
	echo 'tagged proxysql-pkgtest-fedora28'

.PHONY: proxysql-pkgtest-fedora33
proxysql-pkgtest-fedora33:
	echo 'building proxysql-pkgtest-fedora33'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora33 proxysql-pkgtest-fedora33 > /dev/null
	echo 'tagged proxysql-pkgtest-fedora33'

.PHONY: proxysql-pkgtest-fedora34
proxysql-pkgtest-fedora34:
	echo 'building proxysql-pkgtest-fedora34'
	docker build --rm --tag proxysql/packaging:pkgtest-fedora34 proxysql-pkgtest-fedora34 > /dev/null
	echo 'tagged proxysql-pkgtest-fedora34'


.SILENT:
.PHONY: pkgtest-debian
pkgtest-debian: proxysql-pkgtest-debian8 proxysql-pkgtest-debian9 proxysql-pkgtest-debian10 proxysql-pkgtest-debian11

.PHONY: proxysql-pkgtest-debian8
proxysql-pkgtest-debian8:
	echo 'building proxysql-pkgtest-debian8'
	docker build --rm --tag proxysql/packaging:pkgtest-debian8 proxysql-pkgtest-debian8 > /dev/null
	echo 'tagged proxysql-pkgtest-debian8'

.PHONY: proxysql-pkgtest-debian9
proxysql-pkgtest-debian9:
	echo 'building proxysql-pkgtest-debian9'
	docker build --rm --tag proxysql/packaging:pkgtest-debian9 proxysql-pkgtest-debian9 > /dev/null
	echo 'tagged proxysql-pkgtest-debian9'

.PHONY: proxysql-pkgtest-debian10
proxysql-pkgtest-debian10:
	echo 'building proxysql-pkgtest-debian10'
	docker build --rm --tag proxysql/packaging:pkgtest-debian10 proxysql-pkgtest-debian10 > /dev/null
	echo 'tagged proxysql-pkgtest-debian10'

.PHONY: proxysql-pkgtest-debian11
proxysql-pkgtest-debian11:
	echo 'building proxysql-pkgtest-debian11'
	docker build --rm --tag proxysql/packaging:pkgtest-debian11 proxysql-pkgtest-debian11 > /dev/null
	echo 'tagged proxysql-pkgtest-debian11'



.SILENT:
.PHONY: pkgtest-ubuntu
pkgtest-ubuntu: proxysql-pkgtest-ubuntu14 proxysql-pkgtest-ubuntu16 proxysql-pkgtest-ubuntu18 proxysql-pkgtest-ubuntu20

.PHONY: proxysql-pkgtest-ubuntu14
proxysql-pkgtest-ubuntu14:
	echo 'building proxysql-pkgtest-ubuntu14'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu14 proxysql-pkgtest-ubuntu14 > /dev/null
	echo 'tagged proxysql-pkgtest-ubuntu14'

.PHONY: proxysql-pkgtest-ubuntu16
proxysql-pkgtest-ubuntu16:
	echo 'building proxysql-pkgtest-ubuntu16'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu16 proxysql-pkgtest-ubuntu16 > /dev/null
	echo 'tagged proxysql-pkgtest-ubuntu16'

.PHONY: proxysql-pkgtest-ubuntu18
proxysql-pkgtest-ubuntu18:
	echo 'building proxysql-pkgtest-ubuntu18'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu18 proxysql-pkgtest-ubuntu18 > /dev/null
	echo 'tagged proxysql-pkgtest-ubuntu18'

.PHONY: proxysql-pkgtest-ubuntu20
proxysql-pkgtest-ubuntu20:
	echo 'building proxysql-pkgtest-ubuntu20'
	docker build --rm --tag proxysql/packaging:pkgtest-ubuntu20 proxysql-pkgtest-ubuntu20 > /dev/null
	echo 'tagged proxysql-pkgtest-ubuntu20'


.SILENT:
.PHONY: pkgtest-suse
pkgtest-suse: proxysql-pkgtest-opensuse15

.PHONY: proxysql-pkgtest-opensuse15
proxysql-pkgtest-opensuse15:
	echo 'pkgtesting proxysql-pkgtest-opensuse15'
	docker build --rm --tag proxysql/packaging:pkgtest-opensuse15 proxysql-pkgtest-opensuse15
	echo 'tagged proxysql-pkgtest-opensuse15'


.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

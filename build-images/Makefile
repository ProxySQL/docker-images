#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT=-q
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
build: $(wildcard build-*)


.PHONY: build-centos
build-centos:
	make $(wildcard build-centos*)

.PHONY: build-fedora
build-fedora:
	make $(wildcard build-fedora*)

.PHONY: build-debian
build-debian:
	make $(wildcard build-debian*)

.PHONY: build-ubuntu
build-ubuntu:
	make $(wildcard build-ubuntu*)

.PHONY: build-opensuse
build-opensuse:
	make $(wildcard build-opensuse*)

.PHONY: build-almalinux
build-almalinux:
	make $(wildcard build-almalinux*)


.SILENT:
.PHONY: build-*
build-*:
	echo 'building $@'
	docker build --rm --tag proxysql/packaging:$@ $@ ${SILENT}
	echo 'tagged $@'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

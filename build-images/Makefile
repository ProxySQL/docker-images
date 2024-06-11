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
	docker images -a | grep "proxysql/packaging" | grep "build-" | grep -v "build-clang-" | awk '{print $$3}' | sort | uniq | xargs -r docker rmi -f

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

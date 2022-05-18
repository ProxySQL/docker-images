#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT=-q
endif


.PHONY: default
default: build-clang

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | grep "build-clang" | awk '{print $$3}' | sort | uniq | xargs -r docker rmi -f

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: build-clang
build-clang: $(wildcard build-clang*)


.PHONY: build-clang-centos
build-clang-centos:
	make $(wildcard build-clang-centos*)

.PHONY: build-clang-fedora
build-clang-fedora:
	make $(wildcard build-clang-fedora*)

.PHONY: build-clang-debian
build-clang-debian:
	make $(wildcard build-clang-debian*)

.PHONY: build-clang-ubuntu
build-clang-ubuntu:
	make $(wildcard build-clang-ubuntu*)

.PHONY: build-clang-opensuse
build-clang-opensuse:
	make $(wildcard build-clang-opensuse*)

.PHONY: build-clang-almalinux
build-clang-almalinux:
	make $(wildcard build-clang-almalinux*)


.SILENT:
.PHONY: build-clang-*
build-clang-*:
	echo 'building $@'
	docker build --rm --tag proxysql/packaging:$@ $@ ${SILENT}
	echo 'tagged $@'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

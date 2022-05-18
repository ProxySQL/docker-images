#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT=-q
endif


.PHONY: default
default: pkgtest

.PHONY: clean
clean:
	docker images -a | grep "proxysql/packaging" | grep "pkgtest-" | awk '{print $$3}' | sort | uniq | xargs -r docker rmi -f

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: pkgtest
pkgtest: $(wildcard pkgtest-*)


.PHONY: pkgtest-centos
pkgtest-centos:
	make $(wildcard pkgtest-centos*)

.PHONY: pkgtest-fedora
pkgtest-fedora:
	make $(wildcard pkgtest-fedora*)

.PHONY: pkgtest-debian
pkgtest-debian:
	make $(wildcard pkgtest-debian*)

.PHONY: pkgtest-ubuntu
pkgtest-ubuntu:
	make $(wildcard pkgtest-ubuntu*)

.PHONY: pkgtest-opensuse
pkgtest-opensuse:
	make $(wildcard pkgtest-opensuse*)

.PHONY: pkgtest-almalinux
pkgtest-almalinux:
	make $(wildcard pkgtest-almalinux*)


.SILENT:
.PHONY: pkgtest-*
pkgtest-*:
	echo 'building $@'
	docker build --rm --tag proxysql/packaging:$@ $@ ${SILENT}
	echo 'tagged $@'



.ONESHELL: images
images:
	echo 'Finished building'
	docker images | grep "proxysql/packaging"

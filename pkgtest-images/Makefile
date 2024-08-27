#!/usr/bin/make -f

# default multiarch
MULTIARCH := 1

ifdef NOMULTIARCH
override undefine MULTIARCH
endif

ifdef LOAD
override LOAD := --load
endif

ifdef PUSH
override PUSH := --push
endif

ifdef SILENT
override SILENT := -q
endif

ifdef NOCACHE
override NOCACHE := --no-cache
endif

ifndef VERS
# get latest development version
VERS := $(shell curl -s "https://api.github.com/repos/sysown/proxysql/git/refs/tags" | jq -r '.[].ref' | grep -v 'refs/tags/v' | sort | tail -1 | sed 's|refs/tags/||')
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
pkgtest-centos: $(wildcard pkgtest-centos*)

.PHONY: pkgtest-fedora
pkgtest-fedora: $(wildcard pkgtest-fedora*)

.PHONY: pkgtest-debian
pkgtest-debian: $(wildcard pkgtest-debian*)

.PHONY: pkgtest-ubuntu
pkgtest-ubuntu: $(wildcard pkgtest-ubuntu*)

.PHONY: pkgtest-opensuse
pkgtest-opensuse: $(wildcard pkgtest-opensuse*)

.PHONY: pkgtest-almalinux
pkgtest-almalinux: $(wildcard pkgtest-almalinux*)


NOARM64 := pkgtest-centos6 pkgtest-ubuntu14
PLTFRMS := linux/arm64/v8 linux/amd64

#.SILENT: pkgtest-*
.PHONY: pkgtest-*
.NOTPARALLEL: pkgtest-*
pkgtest-*: BLD_PLTFRMS=$(if $(findstring $@, $(NOARM64)),$(filter-out linux/arm64%,$(PLTFRMS)),$(PLTFRMS))
pkgtest-*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(BLD_PLTFRMS))
pkgtest-*:
ifndef MULTIARCH
	@echo "building native $@ for 'native'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-v${VERS} --pull $@ ${LOAD} ${SILENT}
else
	@echo "building multiarch $@ for '$(ARG_PLTFRMS)'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-v${VERS} --pull --platform $(ARG_PLTFRMS) $@ ${PUSH} ${SILENT}
endif
	@echo 'tagged $@'


list:
	@echo "Available 'proxysql/packaging:pkgtest-*' images:"
	@docker images | grep "proxysql/packaging" | grep "pkgtest-"

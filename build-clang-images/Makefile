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
build-clang-centos: $(wildcard build-clang-centos*)

.PHONY: build-clang-fedora
build-clang-fedora: $(wildcard build-clang-fedora*)

.PHONY: build-clang-debian
build-clang-debian: $(wildcard build-clang-debian*)

.PHONY: build-clang-ubuntu
build-clang-ubuntu: $(wildcard build-clang-ubuntu*)

.PHONY: build-clang-opensuse
build-clang-opensuse: $(wildcard build-clang-opensuse*)

.PHONY: build-clang-almalinux
build-clang-almalinux: $(wildcard build-clang-almalinux*)


NOARM64 := build-clang-centos6 build-clang-ubuntu14
PLTFRMS := linux/arm64/v8 linux/amd64

#.SILENT: build-*
.PHONY: build-clang-*
.NOTPARALLEL: build-clang-*
build-clang-*: BLD_PLTFRMS=$(if $(findstring $@, $(NOARM64)),$(filter-out linux/arm64%,$(PLTFRMS)),$(PLTFRMS))
build-clang-*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(BLD_PLTFRMS))
build-clang-*:
ifndef MULTIARCH
	@echo "building native $@ for 'native'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-${VERS} --pull $@ ${PUSH} ${SILENT}
else
	@echo "building multiarch $@ for '$(ARG_PLTFRMS)'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-${VERS} --pull --platform $(ARG_PLTFRMS) $@ ${PUSH} ${SILENT}
endif
	@echo 'tagged $@'


list:
	@echo "Available 'proxysql/packaging:build-clang-*' images:"
	@docker images | grep "proxysql/packaging" | grep "build-clang-"

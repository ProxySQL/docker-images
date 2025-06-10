#!/usr/bin/make -f

# default multiarch
MULTIARCH := 1

ifdef NOMULTIARCH
override undefine MULTIARCH
endif

ifdef LOAD
override LOAD := --load
override undefine MULTIARCH
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
build-centos: $(wildcard build-centos*)

.PHONY: build-fedora
build-fedora: $(wildcard build-fedora*)

.PHONY: build-debian
build-debian: $(wildcard build-debian*)

.PHONY: build-ubuntu
build-ubuntu: $(wildcard build-ubuntu*)

.PHONY: build-opensuse
build-opensuse: $(wildcard build-opensuse*)

.PHONY: build-almalinux
build-almalinux: $(wildcard build-almalinux*)


NOARM64 := build-centos6 build-ubuntu14
PLTFRMS := linux/arm64/v8 linux/amd64

#.SILENT: build-*
.PHONY: build-*
.NOTPARALLEL: build-*
build-*: BLD_PLTFRMS=$(if $(findstring $@, $(NOARM64)),$(filter-out linux/arm64%,$(PLTFRMS)),$(PLTFRMS))
build-*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(BLD_PLTFRMS))
build-*:
ifndef MULTIARCH
	@echo "building native $@ for 'native'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-v${VERS} --pull $@ ${LOAD} ${SILENT}
else
	@echo "building multiarch $@ for '$(ARG_PLTFRMS)'"
	docker buildx build ${NOCACHE} -t proxysql/packaging:$@ -t proxysql/packaging:$@-v${VERS} --pull --platform $(ARG_PLTFRMS) $@ ${PUSH} ${SILENT}
endif
	@echo 'tagged $@'


list:
	@echo "Available 'proxysql/packaging:build-*' images:"
	@docker images | grep "proxysql/packaging" | grep "build-" | grep -v "build-clang-"

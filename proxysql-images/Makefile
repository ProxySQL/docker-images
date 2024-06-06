#!/usr/bin/make -f

NPROCS := $(shell nproc)
export MAKEFLAGS=-j ${NPROCS}

ifdef SILENT
override SILENT=-q
endif

ifdef NOCACHE
override NOCACHE=--no-cache
endif

ifndef VERS
VERS=$(shell curl -sI https://github.com/sysown/proxysql/releases/latest | grep location: | grep -Po '\d[\d\.]+')
endif


.PHONY: default
default: proxysql

.PHONY: clean
clean:
	docker images -a | grep "proxysql/proxysql" | awk '{print $$3}' | sort | uniq | xargs -r docker rmi -f

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: proxysql
proxysql: $(wildcard proxysql-*)


.PHONY: proxysql-centos
proxysql-centos: $(wildcard proxysql-centos*)

.PHONY: proxysql-debian
proxysql-debian: $(wildcard proxysql-debian*)

DFLTDST := debian
PLTFRMS := linux/arm64/v8 linux/amd64

#.SILENT: proxysql-*
.PHONY: proxysql-*
.NOTPARALLEL: proxysql-*
proxysql-*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(PLTFRMS))
proxysql-*: DIST=$(patsubst proxysql-%,%,$@)
proxysql-*: TAGV=$(if $(findstring $(DFLTDST),$@), $(shell echo "-t proxysql/proxysql:${VERS}"),)
proxysql-*: TAGD=$(shell echo "-t proxysql/proxysql:${VERS}-${DIST}")
proxysql-*: TAGL=$(shell echo "-t proxysql/proxysql:latest-${DIST}")
proxysql-*: TAGP=$(if $(findstring $(DFLTDST),$@), $(shell echo "-t proxysql/proxysql:latest"),)
proxysql-*:
	@echo "building v$(VERS) of $@ for '$(ARG_PLTFRMS)'"
ifndef MULTIARCH
	@# build native only
	docker build --build-arg VERS=$(VERS) ${NOCACHE} $(TAGV) $(TAGD) $(TAGL) $(TAGP) --pull $@ ${SILENT}
endif
ifdef MULTIARCH
	@# try building, fallback to native
	docker buildx build --build-arg VERS=$(VERS) ${NOCACHE} $(TAGV) $(TAGD) $(TAGL) $(TAGP) --pull --platform $(ARG_PLTFRMS) $@ --push ${SILENT} || \
	docker buildx build --build-arg VERS=$(VERS) ${NOCACHE} $(TAGV) $(TAGD) $(TAGL) $(TAGP) --pull $@ --push ${SILENT}
endif
	@echo 'tagged $@'


images:
	@echo "Available 'proxysql/packaging' images:"
	docker images | grep "proxysql/packaging"

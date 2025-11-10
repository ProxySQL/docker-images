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
# get latest release version
VERS := $(shell curl -s "https://api.github.com/repos/sysown/proxysql/releases/latest" | jq -r '.name' | tr -d 'v')
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
# use bash as shell
#proxysql-*: SHELL := /bin/bash
proxysql-*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(PLTFRMS))
proxysql-*: DIST=$(patsubst proxysql-%,%,$@)
proxysql-*: TAGL=$(if $(findstring $(DFLTDST),$@),$(shell echo "-t proxysql/proxysql:latest"),)
proxysql-*: TAGLD=$(shell echo "-t proxysql/proxysql:latest-${DIST}")
proxysql-*: TAGV=$(if $(findstring $(DFLTDST),$@),$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS}"),)
proxysql-*: TAGS=$(if $(findstring $(DFLTDST),$@),$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS%.*}"),)
proxysql-*: TAGM=$(if $(findstring $(DFLTDST),$@),$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS%%.*}"),)
proxysql-*: TAGVD=$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS}-${DIST}")
proxysql-*: TAGSD=$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS%.*}-${DIST}")
proxysql-*: TAGMD=$(shell VERS=${VERS}; echo "-t proxysql/proxysql:$${VERS%%.*}-${DIST}")
proxysql-*: TAGSALL=
proxysql-*:
ifndef MULTIARCH
	@echo "building native $@ for 'native'"
	docker buildx build ${NOCACHE} --build-arg VERS=${VERS} ${TAGL} ${TAGLD} ${TAGV} ${TAGS} ${TAGM} ${TAGVD} ${TAGSD} ${TAGMD} --pull $@ ${LOAD} ${PUSH} ${SILENT}
else
	@echo "building multiarch $@ for '$(ARG_PLTFRMS)'"
	docker buildx build ${NOCACHE} --build-arg VERS=${VERS} ${TAGL} ${TAGLD} ${TAGV} ${TAGS} ${TAGM} ${TAGVD} ${TAGSD} ${TAGMD} --pull --platform $(ARG_PLTFRMS) $@ ${PUSH} ${SILENT}
endif
	@echo 'tagged $@'


list:
	@echo "Available 'proxysql/proxysql' images:"
	@docker images | grep "proxysql/proxysql"

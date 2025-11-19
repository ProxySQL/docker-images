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


.PHONY: default
default: build

.PHONY: clean
clean:
	docker images -a | grep "proxysql/ci-infra" | awk '{print $$3}' | sort | uniq | xargs -r docker rmi -f

.PHONY: cleanall
cleanall:
	docker system prune -a


.PHONY: build
build: $(filter-out Makefile,$(wildcard *))


NOARM64 := 
PLTFRMS := linux/arm64/v8 linux/amd64

#.SILENT: build-*
.PHONY: *
.NOTPARALLEL: *
*: BLD_PLTFRMS=$(if $(findstring $@, $(NOARM64)),$(filter-out linux/arm64%,$(PLTFRMS)),$(PLTFRMS))
*: ARG_PLTFRMS=$(subst $() ,$(shell echo ,),$(BLD_PLTFRMS))
*:
ifndef MULTIARCH
	@echo "building native $@ for 'native'"
	docker buildx build ${NOCACHE} -t proxysql/ci-infra:$@ --pull $@ ${LOAD} ${SILENT}
else
	@echo "building multiarch $@ for '$(ARG_PLTFRMS)'"
	docker buildx build ${NOCACHE} -t proxysql/ci-infra:$@ --pull --platform $(ARG_PLTFRMS) $@ ${PUSH} ${SILENT}
endif
	@echo 'tagged $@'


list:
	@echo "Available 'proxysql/ci-infra' images:"
	@docker images | grep "proxysql/ci-infra"

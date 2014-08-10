DOCKER = docker -H $(DOCKER_HOST)
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')
CP = cp

DOCKER_RUN_OPTS = --volumes-from my-data
SUB_MAKEFILES = $(addsuffix /Makefile,$(wildcard containers/*))

default: build

run build destroy: $(SUB_MAKEFILES)
	for d in containers/*; do \
  base=`basename $$d`; \
  (cd $$d && $(MAKE) $@ BASE=$$base); \
  done

%/Makefile: sub_Makefile
	$(CP) sub_Makefile $@

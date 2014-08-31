DOCKER = docker -H $(DOCKER_HOST)
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')
CP = cp
FIND = find
XARGS = xargs

DOCKER_RUN_OPTS = --volumes-from my-data
SUB_MAKEFILES = $(addsuffix /Makefile,$(wildcard containers/*))

default: build

run build destroy: make
	for d in containers/*; do \
  (cd $$d && $(MAKE) $@); \
  done

make: $(SUB_MAKEFILES)

%/Makefile: sub_Makefile
	$(CP) sub_Makefile $@

clean:
	$(FIND) . \! -name '.git' -type f -name '*~' -print0 | $(XARGS) -0 $(RM) $(RMF)
	for d in containers/*; do \
  (cd $$d && $(MAKE) $@); \
  done

DOCKER = docker -H $(DOCKER_HOST)
DOCKER_HOST = $(shell boot2docker up 2>&1 | awk -F= '/export/{print $$2}')

DOCKER_RUN_OPTS = --volumes-from my-data

default: build

run:
	for d in containers/*; do \
  base=`basename $$d`; \
  docker_run_another_opt=; \
  if [ -f $$d/docker_run_another_opt.conf ]; then docker_run_another_opt=`cat $$d/docker_run_another_opt.conf`; fi; \
  (cd $$d && $(DOCKER) run $(DOCKER_RUN_OPTS) -d $$docker_run_another_opt --name $$base $$base); \
  done

build:
	for d in containers/*; do \
  base=`basename $$d`; \
  (cd $$d && $(DOCKER) build -t $$base .); \
  done

COMMAND :=docker-compose
COMMAND_FILE :=docker-compose.yml
IS_LOCAL ?= $(shell bash -c 'read -p "The environment is local ( yes or no ) ? : " pwd; echo $$pwd')
PWD := $(shell pwd)
PATH_NGINX=$(PWD)/etc/nginx
PATH_TO_FILE :=$(PWD)/.environment
PATH_ENV_FILE :=$(PWD)/.env

IS_SSL ?= $(shell bash -c 'read -p "Add SSL certificate? ( yes or no ) ? : " pwd; echo $$pwd')


# configure is the first target. always check is file .env exist
configure:
ifneq ("$(wildcard $(PATH_TO_FILE))","")
	@echo "For re-configure actions please execute : 'make clear && make configure'"
else
#ifeq ($(IS_LOCAL),yes)
#	$(eval ENVIROMENT := $(shell bash -c 'echo local'))
#	$(eval ROOT_PATH := $(shell bash -c 'read -p "What is the root path? : " pwd; echo $$pwd'))
#	$(eval DOMAINS := $(shell bash -c 'read -p "What domains do you want to add? (ex: domain.com , *.domain.com , sub.domain.com) : " pwd; echo $$pwd'))
#	@echo '$(ENVIROMENT)'
#else
	$(eval ENVIROMENT := $(shell bash -c 'read -p "What is the name of the environment? : " pwd; echo $$pwd'))
	$(eval ROOT_PATH := $(shell bash -c 'read -p "What is the root path? : " pwd; echo $$pwd'))
	$(eval DOMAINS := $(shell bash -c 'read -p "What domains do you want to add? (ex: domain.com , sub.domain.com) : " pwd; echo $$pwd'))
	$(eval DASHBOARD := $(shell bash -c 'read -p "What is the name of the dashboard? (ex: dashboard.domain.com ) : " pwd; echo $$pwd'))
	$(eval DATABASE := $(shell bash -c 'read -p "What is the name of the database? : " pwd; echo $$pwd'))
	$(eval PASSWORD := $(shell bash -c 'read -p "What is the password for root user of the database? : " pwd; echo $$pwd'))
ifeq ($(IS_SSL),yes)
	echo "DOMAINS_SSL=$(DOMAINS),$(DASHBOARD)" > $(PATH_ENV_FILE)
else
	echo "DOMAINS_SSL=" > $(PATH_ENV_FILE)
endif
	@echo '$(ENVIROMENT)'
#endif
	echo $(ENVIROMENT) > $(PATH_TO_FILE)
	echo "ROOT_PATH=$(ROOT_PATH)" >> $(PATH_ENV_FILE)
	echo "DOMAINS=$(DOMAINS)" >> $(PATH_ENV_FILE)
	echo "DASHBOARD=$(DASHBOARD)" >> $(PATH_ENV_FILE)
	echo "DATABASE=$(DATABASE)" >> $(PATH_ENV_FILE)
	echo "PASSWORD=$(PASSWORD)" >> $(PATH_ENV_FILE)
	mkdir $(PWD)/data
endif

status: configure
	$(COMMAND) -f $(COMMAND_FILE) config

build: configure
	$(COMMAND) -f $(COMMAND_FILE) build

logs: configure
	$(COMMAND) -f $(COMMAND_FILE) logs -f

install: configure
	$(COMMAND) -f $(COMMAND_FILE) up -d

rebuild-start: configure
	$(COMMAND) -f $(COMMAND_FILE) up -d --force-recreate

down: configure
	$(COMMAND) -f $(COMMAND_FILE) down

clear: configure
	rm -rf $(PATH_TO_FILE)
	rm -rf $(PATH_ENV_FILE)

start: configure
	$(eval SERVICE := $(shell bash -c 'read -p "What service ? : " pwd; echo $$pwd'))
	$(COMMAND) -f $(COMMAND_FILE) start $(SERVICE)

stop: configure
	$(eval SERVICE := $(shell bash -c 'read -p "What service ? : " pwd; echo $$pwd'))
	$(COMMAND) -f $(COMMAND_FILE) stop $(SERVICE)

services: configure
	docker ps

login: configure
	$(eval SERVICE := $(shell bash -c 'read -p "What service ? : " pwd; echo $$pwd'))
	docker exec -ti $(SERVICE) bash

prune:
	# clean all that is not actively used
	docker system prune -af

# Regular Makefile part for buildpypi itself
help:
	@echo 'Current Environment : $(ENV)'
	@echo '-	-	-	-	-	-	'
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  install		execute $(COMMAND) -f $(COMMAND_FILE) up -d'
	@echo '  logs			execute $(COMMAND) -f $(COMMAND_FILE) logs -f'
	@echo '  rebuild-start		execute $(COMMAND) -f $(COMMAND_FILE) up -d --force-recreate'
	@echo '  stop			execute $(COMMAND) -f $(COMMAND_FILE) stop [SERVICE] '
	@echo '  start			execute $(COMMAND) -f $(COMMAND_FILE) start [SERVICE] '
	@echo '  down			execute $(COMMAND) -f $(COMMAND_FILE) down'
	@echo '  status		execute $(COMMAND) -f $(COMMAND_FILE) config'
	@echo '  prune			shortcut for docker system prune -af. Cleanup inactive containers and cache.'
	@echo '  configure		configure the Environment'
	@echo '  clear			remove env file from folder'
	@echo '-	-	-	-	-	-	'
	@echo ''
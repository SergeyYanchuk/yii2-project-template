export VAGRANT_CWD := ${CURDIR}/misc
export PROJECT_NAME := 'yii2-project-template'
override NAME = 'default'
all:
	@echo 'you must enter target'

deploy-prod: hg-pull hg-up-clean install-vendor prod yii-migrate-deploy clear-assets

deploy-dev: hg-pull hg-up-clean install-vendor dev yii-migrate-deploy clear-assets

local: install-vendor-local dev-local yii-migrate-local clear-assets-local

prod:
	./src/init --env=Production --overwrite=y

dev:
	./src/init --env=Development --overwrite=y

dev-local:
	vagrant ssh -c 'php /var/www/${PROJECT_NAME}/src/init --env=Development --overwrite=y'

hg-pull:
	hg pull

hg-up-clean:
	hg up -C
	
hg-up-clean-prod:
	hg up -C default
	
hg-up-clean-testing:
	hg up -C

install-vendor:
	composer install -d src

update-vendor:
	composer update -d src
	
install-vendor-local:
	vagrant ssh -c 'cd /var/www/${PROJECT_NAME}/src && composer global require "fxp/composer-asset-plugin:1.0.0"'
	vagrant ssh -c 'composer install -d /var/www/${PROJECT_NAME}/src'

update-vendor-local:
	vagrant ssh -c 'composer update -d /var/www/${PROJECT_NAME}/src'

vg-up:
	vagrant up

vg-halt:
	vagrant halt

vg-reload:
	vagrant reload --provision

vg-ssh:
	vagrant ssh

yii-migrate-down-local:
	vagrant ssh -c 'php /var/www/${PROJECT_NAME}/src/yii migrate/down --migrationPath=@console/migrations'

yii-migrate-local:
	vagrant ssh -c 'php /var/www/${PROJECT_NAME}/src/yii migrate/up --migrationPath=@console/migrations'

yii-migrate-deploy:
	php ${CURDIR}/src/yii migrate --migrationPath=${CURDIR}/src/console/migrations

yii-migrate-create:
	vagrant ssh -c 'php /var/www/${PROJECT_NAME}/src/yii migrate/create $(NAME)'

clear-assets:
	rm -r ${CURDIR}/src/frontend/web/assets/* 2>/dev/null
	rm -r ${CURDIR}/src/backend/web/assets/* 2>/dev/null

clear-assets-local:
	vagrant ssh -c 'sudo rm -rf /var/www/${PROJECT_NAME}/src/frontend/web/assets/*'
	vagrant ssh -c 'sudo rm -rf /var/www/${PROJECT_NAME}/src/backend/web/assets/*'


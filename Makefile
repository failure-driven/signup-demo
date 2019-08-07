PROJECT := signup-demo

default: build

.PHONY: build
build: 
	bin/full-build

.PHONY: clean
clean:
	bundle exec rake db:migrate:reset

.PHONY: master
master:
	git checkout master

.PHONY: ddd1
ddd1:
	git checkout ddd/1-no-redirect

.PHONY: ddd2
ddd2:
	git checkout ddd/2-no-react

.PHONY: oauth
oauth:
	git checkout omniauth

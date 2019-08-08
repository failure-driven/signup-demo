PROJECT := signup-demo

default: build

.PHONY: build clean git_checkout master ddd1 ddd2 oauth

build: 
	bin/full-build

clean:
	bundle exec rake db:migrate:reset

master:
	git checkout .
	git checkout master

ddd1:
	git checkout .
	git checkout ddd/1-no-redirect

ddd2:
	git checkout .
	git checkout ddd/2-no-react

oauth:
	git checkout .
	git checkout omniauth

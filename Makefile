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

.PHONY: pg-init
pg-init:
	PGPORT=5432 asdf exec initdb tmp/postgres -E utf8 || echo "postgres already initialised"

.PHONY: pg-start
pg-start:
	PGPORT=5432 asdf exec pg_ctl -D tmp/postgres -l tmp/postgres/logfile start || echo "pg was probably running"

.PHONY: pg-stop
pg-stop:
	PGPORT=5432 asdf exec pg_ctl -D tmp/postgres stop -s -m fast || echo "postgres already stopped"


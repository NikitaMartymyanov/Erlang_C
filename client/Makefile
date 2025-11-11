PROJECT_NAME = client
REBAR3 = rebar3
ERL = erl

.DEFAULT_GOAL :=help

.PHONY: help compile run

help: 
	@echo "Доступные команды:"
	@echo "make compile- Компиляция проекта"
	@echo "make run - Запуск"

compile: 
	@$(REBAR3) compile

run:
	@$(REBAR3) shell --eval "subscriber:main()."
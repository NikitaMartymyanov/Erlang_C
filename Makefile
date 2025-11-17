PROJECT_NAME = client
REBAR3 = rebar3
ERL = erl
CC = gcc
SERVER_DIR = server
CLIENT_DIR = client
SERVER_SOURCE = $(SERVER_DIR)/server.c
SERVER_TARGET = $(SERVER_DIR)/server

.DEFAULT_GOAL := help

.PHONY: help install server client clean

help: 
	@echo "Доступные команды:"
	@echo "make install   - Установка всех нужных бибилиотек (ОБЯЗАТЕЛЬНО при первом запуске проекта)"
	@echo "make server    - Компиляция и запуск сервера"
	@echo "make client    - Компиляция и запуск клиента"
	@echo "make clean     - Очистка скомпилированных файлов"
# Установка
install:
	@chmod +x install.sh
	@./install.sh
# Сервер
server: $(SERVER_TARGET)
	@echo "Запуск сервера..."
	@cd $(SERVER_DIR) && ./server

$(SERVER_TARGET): $(SERVER_SOURCE)
	@echo "Компиляция сервера..."
	@cd $(SERVER_DIR) && $(CC) server.c -o server -lzmq

# Клиент
client: 
	@echo "Запуск клиента..."
	@cd $(CLIENT_DIR) && $(REBAR3) compile
	@cd $(CLIENT_DIR) && $(REBAR3) release
	@cd $(CLIENT_DIR) && _build/default/rel/client/bin/client console

# Очистка
clean:
	@echo "Очистка файлов сервера..."
	@rm -f $(SERVER_TARGET)
	@echo "Очистка файлов клиента..."
	@cd $(CLIENT_DIR) && $(REBAR3) clean
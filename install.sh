set -e #Выход при ошибке
sudo apt update
clear

echo "=== Установка Erlang ==="
sudo apt install erlang

echo "=== Установка Rebar3 ==="
sudo apt install rebar3

echo "=== Установка ZMQ ==="
sudo apt install libzmq3-dev

echo "=== Установка завершена ==="
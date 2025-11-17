-module(subscriber).
-export([main/0]).

main() ->
    {ok, _} = application:ensure_all_started(chumak),  %% Правильный запуск chumak
    {ok, Socket} = chumak:socket(sub),
    ok = chumak:subscribe(Socket, <<>>),

    case chumak:connect(Socket, tcp, "localhost", 5555) of
        {ok, _BindPid} ->
            io:format("Connected successfully with Socket: ~p\n", [Socket]),
            loop(Socket);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for connect: ~p \n", [X])
    end.

loop(Socket) ->
    case chumak:recv(Socket) of
        {ok, Data} ->
            io:format("Received: ~p\n", [Data]),
            loop(Socket);
        {error, Reason} ->
            io:format("Receive error: ~p\n", [Reason])
    end.
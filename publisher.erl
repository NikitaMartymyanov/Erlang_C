-module(publisher).
-export([main/0]).

main() ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(pub),

    case chumak:bind(Socket, "ipc:///tmp/mysocket") of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Socket]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,
    loop(Socket, 1).

loop(Socket, Pos) ->
    ok = chumak:send(Socket, <<"A", Pos, "Hello A">>),
    ok = chumak:send(Socket, <<"B", Pos, "Hello B">>),
    io:format("."),
    timer:sleep(1000),
    loop(Socket, Pos + 1).
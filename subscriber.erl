-module(subscriber).
-export([main/1]).

main(Topic) ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(sub),
    chumak:subscribe(Socket, Topic),

    case chumak:connect(Socket, "ipc:///tmp/mysocket") of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Socket]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,
    loop(Socket).

loop(Socket) ->
    {ok, Data1} = chumak:recv_multipart(Socket),
    io:format("Received by multipart ~p\n", [Data1]),
    {ok, Data2} = chumak:recv(Socket),
    io:format("Received ~p\n", [Data2]),
    loop(Socket).

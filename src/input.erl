-module(input).

-export([read_line/0]).

read_line() ->
  case io:get_line("") of
    eof -> eof;
    Line ->
      case io_lib:fread("~s~s~d~s", Line) of
        {ok, [Command, Name, Card_Number, [_|Limit]], _} ->
          [Command, Name, Card_Number, Limit];
        {error, _} ->
          case io_lib:fread("~s~s~s", Line) of
            {ok, [Command, Name, [_|Amount]], _} ->
              [Command, Name, Amount];
            {error, _} -> eof
          end
      end
  end.

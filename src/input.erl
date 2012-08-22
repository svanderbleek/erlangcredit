-module(input).

-export([read_line/0,make_int/1]).

read_line() ->
  case io:get_line("") of
    eof -> eof;
    Line ->
      case io_lib:fread("~s~s~d~s", Line) of
        {ok, [Command, Name, Card_Number, [_|Limit]], _} ->
          [Command, Name, Card_Number, make_int(Limit)];
        {error, _} ->
          case io_lib:fread("~s~s~s", Line) of
            {ok, [Command, Name, [_|Amount]], _} ->
              [Command, Name, make_int(Amount)];
            {error, _} -> eof
          end
      end
  end.

make_int(String) ->
  element(1, string:to_integer(String)).

-module(input).

-export([read_line/0,make_int/1]).

read_line() ->
  case io:get_line("") of
    eof -> eof;
    Line ->
      parse_line(Line)
  end.

parse_line(Line) ->
  Forms = [try_add_form(Line), try_credit_form(Line)],
  hd(lists:flatten(Forms)).

try_add_form(Line) ->
  case io_lib:fread("~s~s~d~s", Line) of
    {ok, [Command, Name, Card_Number, [_|Limit]], "\n"} ->
      {Command, Name, Card_Number, input:make_int(Limit)};
    {ok, _, _} -> [];
    {error, _} -> []
  end.

try_credit_form(Line) ->
  case io_lib:fread("~s~s~s", Line) of
    {ok, [Command, Name, [_|Amount]], "\n"} ->
      {Command, Name, input:make_int(Amount)};
    {ok, _, _} -> [];
    {error, _} -> [] 
  end.

make_int(String) ->
  element(1, string:to_integer(String)).

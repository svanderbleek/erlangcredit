-module(credit).

-export([main/1]).

main(_) ->
  Accounts = dict:new(),
  process(input:read_line(), Accounts).

process(eof, Accounts) ->
  output:write_data(Accounts);
process([Command, Name, Card_Number, Limit], Accounts) ->
  process(input:read_line(), Accounts);
process([Command, Name, Amount], Accounts) ->
  process(input:read_line(), Accounts).

-module(credit).

-export([main/1]).

main(_) ->
  Accounts = dict:new(),
  process(input:read_line(), Accounts).

process(eof, Accounts) ->
  output:write_accounts(Accounts);

process(["Add", Name, Card_Number, Limit], Accounts) ->
  Updated = operations:add(Name, Card_Number, Limit, Accounts),
  process(input:read_line(), Updated);

process(["Charge", Name, Amount], Accounts) ->
  Updated = operations:charge(Name, Amount, Accounts),
  process(input:read_line(), Updated);

process(["Credit", Name, Amount], Accounts) ->
  Updated = operations:credit(Name, Amount, Accounts),
  process(input:read_line(), Updated).

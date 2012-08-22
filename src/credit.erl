-module(credit).

-export([main/1]).

main(_) ->
  Accounts = dict:new(),
  process(input:read_line(), Accounts).

process(eof, Accounts) ->
  output:write_accounts(Accounts);
process([_, Name, Card_Number, Limit], Accounts) ->
  Updated = operations:add(Name, Card_Number, Limit, Accounts),
  process(input:read_line(), Updated);
process([Command, Name, Amount], Accounts) ->
  case Command of
    "Charge" -> Updated = operations:charge(Name, Amount, Accounts);
    "Credit" -> Updated = operations:credit(Name, Amount, Accounts)
  end,
  process(input:read_line(), Updated).

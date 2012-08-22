-module(output).

-export([write_accounts/1]).

write_accounts(Accounts) ->
  write_account(lists:reverse(dict:to_list(Accounts))).

write_account([{Name, {Balance, Limit}}|Accounts]) ->
  io:fwrite("~s: $~w\n", [Name, Balance]),
  write_account(Accounts);
write_account([{Name, error}|Accounts]) ->
  io:fwrite("~s: ~w\n", [Name, error]),
  write_account(Accounts);
write_account([]) ->
  ok.

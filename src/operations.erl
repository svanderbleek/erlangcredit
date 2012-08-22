-module(operations).

-export([add/4, charge/3, credit/3]).

-define(BALANCE, 0).

add(Name, Card_Number, Limit, Accounts) ->
  case validation:luhn_10(Card_Number) of
    true -> 
      dict:store(Name, {?BALANCE, Limit}, Accounts);
    false -> 
      dict:store(Name, error, Accounts)
  end.

charge(Name, Amount, Accounts) ->
  update_account(Name, attempt_charge(Amount), Accounts).

attempt_charge(Amount) ->
  fun (Account) -> 
    attempt_charge(Amount, Account) 
  end.

attempt_charge(Amount, {Balance, Limit}) when Amount =< Limit - Balance ->
  {Balance + Amount, Limit};
attempt_charge(_, {Balance, Limit}) ->
  {Balance, Limit}.

credit(Name, Amount, Accounts) ->
  update_account(Name, credit(Amount), Accounts).

credit(Amount) ->
  fun ({Balance, Limit}) ->
    {Balance - Amount, Limit}
  end.

update_account(Name, Update_Function, Accounts) ->
  try dict:update(Name, Update_Function, Accounts) of
    Updated -> Updated
  catch
    error:_ -> Accounts
  end.

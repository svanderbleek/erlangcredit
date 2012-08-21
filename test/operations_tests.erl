-module(operations_tests).

-include_lib("eunit/include/eunit.hrl").

add_test() ->
  First_Add  = operations:add("Tom", 4111111111111111, 1000, dict:new()),
  Second_Add = operations:add("Lisa", 5454545454545454, 3000, First_Add),
  Third_Add  = operations:add("Quincy", 1234567890123456, 2000, Second_Add),
  Dict_Add   = dict:store("Lisa", {0, 3000}, dict:store("Tom", {0, 1000}, dict:new())),
  ?assertEqual(Third_Add, Dict_Add).

charge_test() ->
  Before_Charge = operations:add("Tom", 4111111111111111, 1000, dict:new()),
  After_Charge  = operations:charge("Tom", 300, Before_Charge),
  After_Decline = operations:charge("Tom", 800, After_Charge),
  ?assertEqual(dict:fetch("Tom", After_Charge), {300, 1000}),
  ?assertEqual(dict:fetch("Tom", After_Decline), {300, 1000}).

credit_test() ->
  Before_Credit = operations:add("Tom", 4111111111111111, 1000, dict:new()),
  After_Credit  = operations:credit("Tom", 100, Before_Credit),
  ?assertEqual(dict:fetch("Tom", After_Credit), {-100, 1000}).

no_account_test() ->
  Empty = dict:new(),
  After = operations:charge("Tom", 100, Empty),  
  operations:credit("Tom", 100, After).

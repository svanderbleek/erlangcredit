-module(validation_tests).

-include_lib("eunit/include/eunit.hrl").

luhn_10_test() ->
  ?assert(validation:luhn_10(4111111111111111)),
  ?assertNot(validation:luhn_10(1234567890123456)).

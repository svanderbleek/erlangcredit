-module(validation).

-export([luhn_10/1]).

luhn_10(Card_Number) ->
  double_every_other_and_sum(digit_list(Card_Number)) rem 10 =:= 0.

% the alternating doubling starts in right to left order
double_every_other_and_sum(Digit_List) ->
  double_every_other_and_sum(lists:reverse(Digit_List), 0, false).

% when doubling we actually sum the sum of the digits
double_every_other_and_sum([H|T], Accumulator, Double) when Double  ->
  double_every_other_and_sum(T, Accumulator + digit_sum(2*H), not Double);

double_every_other_and_sum([H|T], Accumulator, Double) ->
  double_every_other_and_sum(T, Accumulator + H, not Double);

double_every_other_and_sum([], Accumulator, _) ->
  Accumulator.

digit_sum(Number) ->
  lists:sum(digit_list(Number)).

digit_list(Number) ->
  [D - $0 || D <- integer_to_list(Number)].

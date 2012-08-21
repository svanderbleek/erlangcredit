-module(process).

-behavior(application).
-export([start/2, stop/1]).

-behaviour(supervisor).
-export([init/1]).

start(_, []) ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []). 

stop(_) ->
  ok.

init([]) ->
  {ok, {{one_for_all, 1, 1}, []}}.

-module(sw_SUITE).
-include_lib("common_test/include/ct.hrl").

-compile(export_all).

suite() ->
    [{timetrap, {seconds, 30}}].

init_per_group(_Group, Config) ->
    Config.

end_per_group(_Group, _Config) ->
    ok.

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(graphql),
    ok = init_mnesia(Config),
    {ok, _} = application:ensure_all_started(sw_core),
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_Case, Config) ->
    Config.

end_per_testcase(_Case, _Config) ->
    ok.

groups() ->
    [{setup, [], [live]},
     {tour_queries, [], [first_query]}].

all() -> [
          {group, setup},
          {group, tour_queries}
         ].

%% -- Mnesia initialization ----------------------
init_mnesia(Config) ->
    {ok, _} = application:ensure_all_started(mnesia),
    FixtureDir = ?config(data_dir, Config),
    ok = sw_core_db:create_fixture(ram_copies, FixtureDir),
    ok.

%% -- SETUP --------------------------------------
live(Config) ->
    Running = [element(1, Runners)
               || Runners <- proplists:get_value(running, application:info())],
    true = lists:member(sw_core, Running),
    ok.

%% -- TOUR ---------------------------------------
first_query(Config) ->
    run_query(Config, "first").

%% -- INTERNALS ----------------------------------
run_query(Config, Name) ->
    DataDir = ?config(data_dir, Config),
    Query = filename:join(DataDir, Name ++ ".query"),
    Result = filename:join(DataDir, Name ++ ".result"),

    {ok, QueryDoc} = file:read_file(Query),
    {ok, ExpectedJson} = file:read_file(Result),
    Expected = canonicalize_json(ExpectedJson),

    {ok, AST} = graphql:parse(QueryDoc),
    Elaborated = graphql:elaborate(AST),
    {ok, #{ fun_env := FunEnv, ast := AST2}} =
        graphql:type_check(Elaborated),
    Ctx = #{
      params => #{},
      operation_name => undefined
     },
    Response = graphql:execute(Ctx, AST2),
    Expected = jsx:encode(Response),
    ok.



canonicalize_json(Input) ->
    jsx:encode(jsx:decode(Input)).

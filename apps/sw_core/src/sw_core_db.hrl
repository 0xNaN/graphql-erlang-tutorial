%% Database Schema definition files

%% tag::factionRecord[]
-record(faction,
        {id :: integer(),
         name :: integer()}).
%% end::factionRecord[]

%% tag::starshipRecord[]
-record(starship,
        {id :: integer(),
         pilots :: [integer()],
         mglt :: integer(),
         starship_class :: binary(),
         hyperdrive_rating :: float()
}).
%% end::starshipRecord[]

%% tag::transportRecord[]
-record(transport,
        {id :: integer(),
         edited :: calendar:datetime(),
         consumables :: binary() | undefined,
         name :: binary(),
         created :: calendar:datetime(),
         cargo_capacity :: float() | nan,
         passengers :: binary() | undefined,
         crew :: binary(),
         length :: float(),
         model :: binary(),
         cost :: float(),
         max_atmosphering_speed :: integer(),
         manufacturers :: [binary()],
         faction = undefined :: undefined | integer()
}).
%% end::transportRecord[]

-record(film,
        {id :: integer(),
         edited :: calendar:datetime(),
         created :: calendar:datetime(),
         starships :: [integer()],
         species :: [integer()],
         vehicles :: [integer()],
         planets :: [integer()],
         producers :: [binary()],
         title :: binary(),
         episode :: atom(),
         episode_id :: integer(),
         director :: binary(),
         release_date :: binary(),
         opening_crawl :: binary(),
         characters :: [integer()] }).
         
-record(species,
        {id :: integer(),
         edited :: binary(),
         created :: binary(),
         classification :: binary(),
         name :: binary(),
         designation :: binary(),
         eye_colors :: [binary()],
         people :: [integer()],
         skin_colors :: [binary()],
         language :: binary(),
         hair_colors :: [binary()],
         homeworld :: binary(),
         average_lifespan :: integer(),
         average_height :: integer()
}).

-record(person,
        {id :: integer(),
         edited :: calendar:datetime(),
         name :: binary(),
         created :: calendar:datetime(),
         gender :: binary(),
         skin_color :: binary(),
         hair_color :: binary(),
         height :: integer(),
         eye_color :: binary(),
         mass :: float() | nan,
         homeworld :: integer(),
         birth_year :: binary()
}).

%% tag::planetRecord[]
-record(planet,
        {id :: integer(),
         edited :: calendar:datetime(),
         climate :: binary(),
         surface_water :: integer(),
         name :: binary(),
         diameter :: integer(),
         rotation_period :: integer(),
         created :: calendar:datetime(),
         terrains :: [binary()],
         gravity :: binary(),
         orbital_period :: integer() | nan,
         population :: integer() | nan
}).
%% end::planetRecord[]

-record(vehicle,
        {id :: integer(),
         vehicle_class :: binary(),
         pilots :: [integer()]}).

-record(sequences, {key, value}).

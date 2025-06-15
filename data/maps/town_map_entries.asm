MACRO external_map
	dn \2, \1
	dw \3
ENDM

; the appearance of towns and routes in the town map
ExternalMapEntries:
	table_width 3
	; x, y, name
	external_map  3, 11, PalletTownName
	external_map  3,  8, ViridianCityName
	external_map  3,  3, PewterCityName
	external_map 11,  2, CeruleanCityName
	external_map 15,  5, LavenderTownName
	external_map 11,  9, VermilionCityName
	external_map  8,  5, CeladonCityName
	external_map  9, 13, FuchsiaCityName
	external_map  3, 15, CinnabarIslandName
	external_map  1,  2, IndigoPlateauName
	external_map 11,  5, SaffronCityName
	external_map  1,  0, PalletTownName ; unused
	external_map  3, 10, Route1Name
	external_map  3,  6, Route2Name
	external_map  5,  3, Route3Name
	external_map  9,  2, Route4Name
	external_map 11,  3, Route5Name
	external_map 11,  8, Route6Name
	external_map  9,  5, Route7Name
	external_map 14,  5, Route8Name
	external_map 14,  2, Route9Name
	external_map 15,  4, Route10Name
	external_map 13,  9, Route11Name
	external_map 15,  9, Route12Name
	external_map 14, 11, Route13Name
	external_map 12, 12, Route14Name
	external_map 11, 13, Route15Name
	external_map  6,  5, Route16Name
	external_map  5,  8, Route17Name
	external_map  7, 13, Route18Name
	external_map  7, 15, Route19Name
	external_map  5, 15, Route20Name
	external_map  3, 13, Route21Name
	external_map  1,  8, Route22Name
	external_map  1,  6, Route23Name
	external_map 11,  1, Route24Name
	external_map 12,  0, Route25Name
	external_map  0,  8, Route28Name
	external_map  0,  8, MtSilverName
	external_map  3, 14, CinnabarVolcanoName
	assert_table_length FIRST_INDOOR_MAP


MACRO internal_map
	db \1 + 1
	dn \3, \2
	dw \4
ENDM

; the appearance of buildings and dungeons in the town map
InternalMapEntries:
	; maximum map id subject to this rule, x, y, name
	internal_map OAKS_LAB,                       3, 11, PalletTownName
	internal_map VIRIDIAN_GYM,                   3,  8, ViridianCityName
	internal_map VIRIDIAN_FOREST_SOUTH_GATE,     3,  6, Route2Name
	internal_map VIRIDIAN_FOREST,                3,  4, ViridianForestName
	internal_map PEWTER_POKECENTER,              3,  3, PewterCityName
	internal_map MT_MOON_B2F,                    7,  2, MountMoonName
	internal_map CERULEAN_MART,                 11,  2, CeruleanCityName
	internal_map MT_MOON_POKECENTER,             6,  2, Route4Name
	internal_map CERULEAN_TRASHED_HOUSE_COPY,   11,  2, CeruleanCityName
	internal_map DAYCARE,                       11,  4, Route5Name
	internal_map UNDERGROUND_PATH_ROUTE_6_COPY, 11,  6, Route6Name
	internal_map UNDERGROUND_PATH_ROUTE_7_COPY, 10,  5, Route7Name
	internal_map UNDERGROUND_PATH_ROUTE_8,      12,  5, Route8Name
	internal_map ROCK_TUNNEL_1F,                15,  3, RockTunnelName
	internal_map POWER_PLANT,                   15,  4, PowerPlantName
	internal_map ROUTE_11_GATE_2F,              14,  9, Route11Name
	internal_map ROUTE_12_GATE_1F,              15,  7, Route12Name
	internal_map BILLS_HOUSE,                   13,  0, SeaCottageName
	internal_map VERMILION_DOCK,                11,  9, VermilionCityName
	internal_map SS_ANNE_B1F_ROOMS,             10, 10, SSAnneName
	internal_map VICTORY_ROAD_1F,                1,  4, VictoryRoadName
	internal_map HALL_OF_FAME,                   1,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_NORTH_SOUTH,  11,  5, UndergroundPathName
	internal_map CHAMPIONS_ROOM,                 1,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_WEST_EAST,    11,  5, UndergroundPathName
	internal_map CELADON_HOTEL,                  8,  5, CeladonCityName
	internal_map LAVENDER_POKECENTER,           15,  5, LavenderTownName
	internal_map POKEMON_TOWER_7F,              15,  5, PokemonTowerName
	internal_map LAVENDER_CUBONE_HOUSE,         15,  5, LavenderTownName
	internal_map WARDENS_HOUSE,                  9, 13, FuchsiaCityName
	internal_map SAFARI_ZONE_GATE,               9, 12, SafariZoneName
	internal_map FUCHSIA_MEETING_ROOM,           9, 13, FuchsiaCityName
	internal_map SEAFOAM_ISLANDS_B4F,            6, 15, SeafoamIslandsName
	internal_map VERMILION_OLD_ROD_HOUSE,       11,  9, VermilionCityName
	internal_map FUCHSIA_GOOD_ROD_HOUSE,         9, 13, FuchsiaCityName
	internal_map POKEMON_MANSION_1F,             3, 15, PokemonMansionName
	internal_map CINNABAR_MART_COPY,             3, 15, CinnabarIslandName
	internal_map INDIGO_PLATEAU_LOBBY,           1,  2, IndigoPlateauName
	internal_map MR_PSYCHICS_HOUSE,             11,  5, SaffronCityName
	internal_map ROUTE_15_GATE_2F,              10, 13, Route15Name
	internal_map ROUTE_16_FLY_HOUSE,             5,  5, Route16Name
	internal_map ROUTE_12_SUPER_ROD_HOUSE,      15, 10, Route12Name
	internal_map ROUTE_18_GATE_2F,               8, 13, Route18Name
	internal_map SEAFOAM_ISLANDS_1F,             6, 15, SeafoamIslandsName
	internal_map ROUTE_22_GATE,                  1,  7, Route22Name
	internal_map VICTORY_ROAD_2F,                1,  4, VictoryRoadName
	internal_map ROUTE_12_GATE_2F,              15,  7, Route12Name
	internal_map VERMILION_TRADE_HOUSE,         11,  9, VermilionCityName
	internal_map DIGLETTS_CAVE,                  4,  4, DiglettsCaveName
	internal_map VICTORY_ROAD_3F,                1,  4, VictoryRoadName
	internal_map UNUSED_MAP_CE,                  8,  5, RocketHQName
	internal_map SILPH_CO_8F,                   11,  5, SilphCoName
	internal_map POKEMON_MANSION_B1F,            3, 15, PokemonMansionName
	internal_map SAFARI_ZONE_NORTH_REST_HOUSE,   9, 12, SafariZoneName
	internal_map CERULEAN_CAVE_1F,              10,  1, CeruleanCaveName
	internal_map NAME_RATERS_HOUSE,             15,  5, LavenderTownName
	internal_map CERULEAN_BADGE_HOUSE,          11,  2, CeruleanCityName
	internal_map ROCK_TUNNEL_B1F,               15,  3, RockTunnelName
	internal_map SILPH_CO_ELEVATOR,             11,  5, SilphCoName
	internal_map AGATHAS_ROOM,                   1,  2, PokemonLeagueName
	internal_map MT_SILVER_CAVE_1F,				 0,  8, MtSilverCaveName
	internal_map CINNABAR_VOLCANO,			     3, 14, CinnabarVolcanoName
	db -1 ; end

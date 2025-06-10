DEF HIDE EQU $11
DEF SHOW EQU $15

; MissableObjects indexes (see data/maps/hide_show_data.asm)
; this is a list of the sprites that can be enabled/disabled during the game
; sprites marked with an X are constants that are never used
; because those sprites are not (de)activated in a map's script
; (they are either items or sprites that deactivate after battle
; and are detected in wMissableObjectList)

	const_def
	const HS_PALLET_TOWN_OAK               ; 00
	const HS_LYING_OLD_MAN                 ; 01
	const HS_OLD_MAN                       ; 02
	const HS_MUSEUM_GUY                    ; 03
	const HS_GYM_GUY                       ; 04
	const HS_CERULEAN_RIVAL                ; 05
	const HS_CERULEAN_ROCKET               ; 06
	const HS_CERULEAN_GUARD_1              ; 07
	const HS_CERULEAN_CAVE_GUY             ; 08
	const HS_CERULEAN_GUARD_2              ; 09
	const HS_SAFFRON_CITY_1                ; 0A
	const HS_SAFFRON_CITY_2                ; 0B
	const HS_SAFFRON_CITY_3                ; 0C
	const HS_SAFFRON_CITY_4                ; 0D
	const HS_SAFFRON_CITY_5                ; 0E
	const HS_SAFFRON_CITY_6                ; 0F
	const HS_SAFFRON_CITY_7                ; 10
	const HS_SAFFRON_CITY_8                ; 11
	const HS_SAFFRON_CITY_9                ; 12
	const HS_SAFFRON_CITY_A                ; 13
	const HS_SAFFRON_CITY_B                ; 14
	const HS_SAFFRON_CITY_C                ; 15
	const HS_SAFFRON_CITY_D                ; 16
	const HS_SAFFRON_CITY_E                ; 17
	const HS_SAFFRON_CITY_F                ; 18
	const HS_ROUTE_1_OAK		      	   ; 19 added
	const HS_ROUTE_2_ITEM_1                ; 1A X
	const HS_ROUTE_2_ITEM_2                ; 1B X
	const HS_ROUTE_4_ITEM                  ; 1C X
	const HS_ROUTE_9_ITEM                  ; 1D X
	const HS_ROUTE_12_SNORLAX              ; 1E
	const HS_ROUTE_12_ITEM_1               ; 1F X
	const HS_ROUTE_12_ITEM_2               ; 20 X
	const HS_ROUTE_15_ITEM                 ; 21 X
	const HS_ROUTE_16_SNORLAX              ; 22
	const HS_ROUTE_22_RIVAL_1              ; 23
	const HS_ROUTE_22_RIVAL_2              ; 24
	const HS_NUGGET_BRIDGE_GUY             ; 25
	const HS_ROUTE_24_ITEM                 ; 26 X
	const HS_ROUTE_25_ITEM                 ; 27 X
	const HS_ROUTE_28_BIRD1                ; 28 Post game
	const HS_ROUTE_28_BIRD2                ; 29 Post game
	const HS_ROUTE_28_BIRD3                ; 2A Post game
	const HS_ROUTE_28_LT_SURGE             ; 2B Post game
	const HS_ROUTE_28_RARE_CANDY           ; 2C Post game
	const HS_MT_SILVER_ERIKA               ; 2D Post game
	const HS_MT_SILVER_BLAINE              ; 2E Post game
	const HS_MT_SILVER_KOGA 			   ; 2F Post game
	const HS_MT_SILVER_CAVE_GUARD1 		   ; 30 Post game
	const HS_MT_SILVER_CAVE_GUARD2 		   ; 31 Post game
	const HS_MT_SILVER_CAVE_WEEZING1 	   ; 32 Post game
	const HS_MT_SILVER_CAVE_WEEZING2 	   ; 33 Post game
	const HS_MT_SILVER_CAVE_FULL_RESTORE   ; 34 Post game
	const HS_DAISY_SITTING                 ; 35
	const HS_DAISY_WALKING                 ; 36
	const HS_TOWN_MAP                      ; 37
	const HS_OAKS_LAB_RIVAL                ; 38
	const HS_STARTER_BALL_1                ; 39
	const HS_STARTER_BALL_2                ; 3A
	const HS_STARTER_BALL_3                ; 3B
	const HS_OAKS_LAB_OAK_1                ; 3C
	const HS_POKEDEX_1                     ; 3D
	const HS_POKEDEX_2                     ; 3E
	const HS_OAKS_LAB_OAK_2                ; 3F
	const HS_OAKS_LAB_SCIENTIST            ; 40 added
	const HS_VIRIDIAN_GYM_GIOVANNI         ; 41
	const HS_VIRIDIAN_GYM_ITEM             ; 42 X
	const HS_OLD_AMBER                     ; 43
	const HS_PEWTER_GYM_BROCK1             ; 44 added
	const HS_PEWTER_GYM_BROCK2             ; 45 added
	const HS_CERULEAN_CAVE_1F_ITEM_1       ; 46 X
	const HS_CERULEAN_CAVE_1F_ITEM_2       ; 47 X
	const HS_CERULEAN_CAVE_1F_ITEM_3       ; 48 X
	const HS_POKEMON_TOWER_2F_RIVAL        ; 49
	const HS_POKEMON_TOWER_3F_ITEM         ; 4A X
	const HS_POKEMON_TOWER_4F_ITEM_1       ; 4B X
	const HS_POKEMON_TOWER_4F_ITEM_2       ; 4C X
	const HS_POKEMON_TOWER_4F_ITEM_3       ; 4D X
	const HS_POKEMON_TOWER_5F_ITEM         ; 4E X
	const HS_POKEMON_TOWER_6F_ITEM_1       ; 4F X
	const HS_POKEMON_TOWER_6F_ITEM_2       ; 50 X
	const HS_POKEMON_TOWER_7F_ROCKET_1     ; 51 X
	const HS_POKEMON_TOWER_7F_ROCKET_2     ; 52 X
	const HS_POKEMON_TOWER_7F_ROCKET_3     ; 53 X
	const HS_POKEMON_TOWER_7F_MR_FUJI      ; 54
	const HS_MR_FUJIS_HOUSE_MR_FUJI        ; 55
	const HS_CELADON_MANSION_EEVEE_GIFT    ; 56
	const HS_CELADON_GYM_ERIKA1            ; 57 added
	const HS_CELADON_GYM_ERIKA2            ; 58 added
	const HS_GAME_CORNER_ROCKET            ; 59
	const HS_WARDENS_HOUSE_ITEM            ; 5A X
	const HS_FUCHSIA_GYM_KOGA              ; 5B added
	const HS_POKEMON_MANSION_1F_ITEM_1     ; 5C X
	const HS_POKEMON_MANSION_1F_ITEM_2     ; 5D X
	const HS_CINNABAR_GYM_BLAINE1          ; 5E added
	const HS_CINNABAR_GYM_BLAINE2          ; 5F added
	const HS_FIGHTING_DOJO_GIFT_1          ; 60
	const HS_FIGHTING_DOJO_GIFT_2          ; 61
	const HS_SILPH_CO_1F_RECEPTIONIST      ; 62
	const HS_VOLTORB_1                     ; 63 X
	const HS_VOLTORB_2                     ; 64 X
	const HS_VOLTORB_3                     ; 65 X
	const HS_ELECTRODE_1                   ; 66 X
	const HS_VOLTORB_4                     ; 67 X
	const HS_VOLTORB_5                     ; 68 X
	const HS_ELECTRODE_2                   ; 69 X
	const HS_VOLTORB_6                     ; 6A X
	const HS_ZAPDOS                        ; 6B X
	const HS_POWER_PLANT_ITEM_1            ; 6C X
	const HS_POWER_PLANT_ITEM_2            ; 6D X
	const HS_POWER_PLANT_ITEM_3            ; 6E X
	const HS_POWER_PLANT_ITEM_4            ; 6F X
	const HS_POWER_PLANT_ITEM_5            ; 70 X
	const HS_MOLTRES                       ; 71 X
	const HS_VICTORY_ROAD_2F_ITEM_1        ; 72 X
	const HS_VICTORY_ROAD_2F_ITEM_2        ; 73 X
	const HS_VICTORY_ROAD_2F_ITEM_3        ; 74 X
	const HS_VICTORY_ROAD_2F_ITEM_4        ; 75 X
	const HS_VICTORY_ROAD_2F_BOULDER       ; 76
	const HS_BILL_POKEMON                  ; 77
	const HS_BILL_1                        ; 78
	const HS_BILL_2                        ; 79
	const HS_VIRIDIAN_FOREST_ITEM_1        ; 7A X
	const HS_VIRIDIAN_FOREST_ITEM_2        ; 7B X
	const HS_VIRIDIAN_FOREST_ITEM_3        ; 7C X
	const HS_MT_MOON_1F_ITEM_1             ; 7D X
	const HS_MT_MOON_1F_ITEM_2             ; 7E X
	const HS_MT_MOON_1F_ITEM_3             ; 7F X
	const HS_MT_MOON_1F_ITEM_4             ; 80 X
	const HS_MT_MOON_1F_ITEM_5             ; 81 X
	const HS_MT_MOON_1F_ITEM_6             ; 82 X
	const HS_MT_MOON_B2F_FOSSIL_1          ; 83
	const HS_MT_MOON_B2F_FOSSIL_2          ; 84
	const HS_MT_MOON_B2F_ITEM_1            ; 85 X
	const HS_MT_MOON_B2F_ITEM_2            ; 86 X
	const HS_CERULEAN_BULBASAUR            ; 87 added
	const HS_VERMILION_GYM_LT_SURGE1       ; 88 added
	const HS_VERMILION_GYM_LT_SURGE2       ; 89 added
	const HS_VERMILION_DOCK_MEW            ; 8A added
	const HS_SS_ANNE_2F_RIVAL              ; 8B
	const HS_SS_ANNE_1F_ROOMS_ITEM         ; 8C X
	const HS_SS_ANNE_2F_ROOMS_ITEM_1       ; 8D X
	const HS_SS_ANNE_2F_ROOMS_ITEM_2       ; 8E X
	const HS_SS_ANNE_B1F_ROOMS_ITEM_1      ; 8F X
	const HS_SS_ANNE_B1F_ROOMS_ITEM_2      ; 90 X
	const HS_SS_ANNE_B1F_ROOMS_ITEM_3      ; 91 X
	const HS_VICTORY_ROAD_3F_ITEM_1        ; 92 X
	const HS_VICTORY_ROAD_3F_ITEM_2        ; 93 X
	const HS_VICTORY_ROAD_3F_BOULDER       ; 94
	const HS_ROCKET_HIDEOUT_B1F_ITEM_1     ; 95 X
	const HS_ROCKET_HIDEOUT_B1F_ITEM_2     ; 96 X
	const HS_ROCKET_HIDEOUT_B2F_ITEM_1     ; 97 X
	const HS_ROCKET_HIDEOUT_B2F_ITEM_2     ; 98 X
	const HS_ROCKET_HIDEOUT_B2F_ITEM_3     ; 99 X
	const HS_ROCKET_HIDEOUT_B2F_ITEM_4     ; 9A X
	const HS_ROCKET_HIDEOUT_B3F_ITEM_1     ; 9B X
	const HS_ROCKET_HIDEOUT_B3F_ITEM_2     ; 9C X
	const HS_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 9D
	const HS_ROCKET_HIDEOUT_B4F_ITEM_1     ; 9E X
	const HS_ROCKET_HIDEOUT_B4F_ITEM_2     ; 9F X
	const HS_ROCKET_HIDEOUT_B4F_ITEM_3     ; A0 X
	const HS_ROCKET_HIDEOUT_B4F_ITEM_4     ; A1
	const HS_ROCKET_HIDEOUT_B4F_ITEM_5     ; A2
;	const HS_SILPH_CO_2F_1                 ; -- XXX never (de)activated?
	const HS_SILPH_CO_2F_2                 ; A3
	const HS_SILPH_CO_2F_3                 ; A4
	const HS_SILPH_CO_2F_4                 ; A5
	const HS_SILPH_CO_2F_5                 ; A6
	const HS_SILPH_CO_3F_1                 ; A7
	const HS_SILPH_CO_3F_2                 ; A8
	const HS_SILPH_CO_3F_ITEM              ; A9 X
	const HS_SILPH_CO_4F_1                 ; AA
	const HS_SILPH_CO_4F_2                 ; AB
	const HS_SILPH_CO_4F_3                 ; AC
	const HS_SILPH_CO_4F_ITEM_1            ; AD X
	const HS_SILPH_CO_4F_ITEM_2            ; AE X
	const HS_SILPH_CO_4F_ITEM_3            ; AF X
	const HS_SILPH_CO_5F_1                 ; B0
	const HS_SILPH_CO_5F_2                 ; B1
	const HS_SILPH_CO_5F_3                 ; B2
	const HS_SILPH_CO_5F_4                 ; B3
	const HS_SILPH_CO_5F_ITEM_1            ; B4 X
	const HS_SILPH_CO_5F_ITEM_2            ; B5 X
	const HS_SILPH_CO_5F_ITEM_3            ; B6 X
	const HS_SILPH_CO_6F_1                 ; B7
	const HS_SILPH_CO_6F_2                 ; B8
	const HS_SILPH_CO_6F_3                 ; B9
	const HS_SILPH_CO_6F_ITEM_1            ; BA X
	const HS_SILPH_CO_6F_ITEM_2            ; BB X
	const HS_SILPH_CO_7F_1                 ; BC
	const HS_SILPH_CO_7F_2                 ; BD
	const HS_SILPH_CO_7F_3                 ; BE
	const HS_SILPH_CO_7F_4                 ; BF
	const HS_SILPH_CO_7F_RIVAL             ; C0
	const HS_SILPH_CO_7F_ITEM_1            ; C1 X
	const HS_SILPH_CO_7F_ITEM_2            ; C2 X
;	const HS_SILPH_CO_7F_8                 ; -- XXX sprite doesn't exist
	const HS_SILPH_CO_8F_1                 ; C3
	const HS_SILPH_CO_8F_2                 ; C4
	const HS_SILPH_CO_8F_3                 ; C5
	const HS_SILPH_CO_9F_1                 ; C6
	const HS_SILPH_CO_9F_2                 ; C7
	const HS_SILPH_CO_9F_3                 ; C8
	const HS_SILPH_CO_10F_1                ; C9
	const HS_SILPH_CO_10F_2                ; CA
;	const HS_SILPH_CO_10F_3                ; -- XXX never (de)activated?
	const HS_SILPH_CO_10F_ITEM_1           ; CB X
	const HS_SILPH_CO_10F_ITEM_2           ; CC X
	const HS_SILPH_CO_10F_ITEM_3           ; CD X
	const HS_SILPH_CO_11F_1                ; CE
	const HS_SILPH_CO_11F_2                ; CF
	const HS_SILPH_CO_11F_3                ; D0
;	const HS_UNUSED_MAP_F4_1               ; -- XXX sprite doesn't exist
	const HS_POKEMON_MANSION_2F_ITEM       ; D1 X
	const HS_POKEMON_MANSION_3F_ITEM_1     ; D2 X
	const HS_POKEMON_MANSION_3F_ITEM_2     ; D3 X
	const HS_POKEMON_MANSION_B1F_ITEM_1    ; D4 X
	const HS_POKEMON_MANSION_B1F_ITEM_2    ; D5 X
	const HS_POKEMON_MANSION_B1F_ITEM_3    ; D6 X
	const HS_POKEMON_MANSION_B1F_ITEM_4    ; D7 X
	const HS_POKEMON_MANSION_B1F_ITEM_5    ; D8 X
	const HS_SAFARI_ZONE_EAST_ITEM_1       ; D9 X
	const HS_SAFARI_ZONE_EAST_ITEM_2       ; DA X
	const HS_SAFARI_ZONE_EAST_ITEM_3       ; DB X
	const HS_SAFARI_ZONE_EAST_ITEM_4       ; DC X
	const HS_SAFARI_ZONE_NORTH_ITEM_1      ; DD X
	const HS_SAFARI_ZONE_NORTH_ITEM_2      ; DE X
	const HS_SAFARI_ZONE_WEST_ITEM_1       ; DF X
	const HS_SAFARI_ZONE_WEST_ITEM_2       ; E0 X
	const HS_SAFARI_ZONE_WEST_ITEM_3       ; E1 X
	const HS_SAFARI_ZONE_WEST_ITEM_4       ; E2 X
	const HS_SAFARI_ZONE_CENTER_ITEM       ; E3 X
	const HS_CERULEAN_CAVE_2F_ITEM_1       ; E4 X
	const HS_CERULEAN_CAVE_2F_ITEM_2       ; E5 X
	const HS_CERULEAN_CAVE_2F_ITEM_3       ; E6 X
	const HS_MEWTWO                        ; E7 X
	const HS_CERULEAN_CAVE_B1F_ITEM_1      ; E8 X
	const HS_CERULEAN_CAVE_B1F_ITEM_2      ; E9 X
	const HS_VICTORY_ROAD_1F_ITEM_1        ; EA X
	const HS_VICTORY_ROAD_1F_ITEM_2        ; EB X
	const HS_CHAMPIONS_ROOM_OAK            ; EC
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_1  ; ED
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_2  ; EF
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; F0
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; F1
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; F2
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; F3
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; F4
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; F5
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; F6
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; F7
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; F8
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; F9
	const HS_ARTICUNO                      ; FA X 
	const HS_MT_SILVER1F_HYPNO             ; FB added
	const HS_MT_SILVER1F_BROCK             ; FC added
	const HS_MT_SILVER1F_SABRINA           ; FD added
	const HS_SAFFRON_GYM_SABRINA           ; FE added
DEF NUM_HS_OBJECTS EQU const_value

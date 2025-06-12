	object_const_def
	const_export CINNABARISLAND_GIRL
	const_export CINNABARISLAND_GAMBLER

CinnabarIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event  6,  7, POKEMON_MANSION_1F, 2
	warp_event 18,  7, CINNABAR_GYM, 1
	warp_event  6, 13, CINNABAR_LAB, 1
	warp_event 11, 15, CINNABAR_POKECENTER, 1
	warp_event 15, 15, CINNABAR_MART, 1

	def_bg_events
	bg_event  9,  9, TEXT_CINNABARISLAND_SIGN
	bg_event 16, 15, TEXT_CINNABARISLAND_MART_SIGN
	bg_event 12, 15, TEXT_CINNABARISLAND_POKECENTER_SIGN
	bg_event  9, 15, TEXT_CINNABARISLAND_POKEMONLAB_SIGN
	bg_event 13,  7, TEXT_CINNABARISLAND_GYM_SIGN

	def_object_events
	object_event 12,  9, SPRITE_GIRL, WALK, LEFT_RIGHT, TEXT_CINNABARISLAND_GIRL
	object_event 14, 10, SPRITE_GAMBLER, STAY, NONE, TEXT_CINNABARISLAND_GAMBLER

	def_warps_to CINNABAR_ISLAND

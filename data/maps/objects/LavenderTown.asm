	object_const_def
	const_export LAVENDERTOWN_LITTLE_GIRL
	const_export LAVENDERTOWN_COOLTRAINER_M
	const_export LAVENDERTOWN_SUPER_NERD

LavenderTown_Object:
	db $2c ; border block

	def_warp_events
	warp_event  7,  7, LAVENDER_POKECENTER, 1
	warp_event 18,  7, POKEMON_TOWER_1F, 1
	warp_event 11, 11, MR_FUJIS_HOUSE, 1
	warp_event 19, 15, LAVENDER_MART, 1
	warp_event  7, 15, LAVENDER_CUBONE_HOUSE, 1
	warp_event 11, 15, NAME_RATERS_HOUSE, 1

	def_bg_events
	bg_event 15, 11, TEXT_LAVENDERTOWN_SIGN
	bg_event 13,  5, TEXT_LAVENDERTOWN_SILPH_SCOPE_SIGN
	bg_event 20, 15, TEXT_LAVENDERTOWN_MART_SIGN
	bg_event  8,  7, TEXT_LAVENDERTOWN_POKECENTER_SIGN
	bg_event  9, 11, TEXT_LAVENDERTOWN_POKEMON_HOUSE_SIGN
	bg_event 21,  9, TEXT_LAVENDERTOWN_POKEMON_TOWER_SIGN

	def_object_events
	object_event 19, 11, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, TEXT_LAVENDERTOWN_LITTLE_GIRL
	object_event 13, 12, SPRITE_COOLTRAINER_M, STAY, NONE, TEXT_LAVENDERTOWN_COOLTRAINER_M
	object_event 12,  9, SPRITE_SUPER_NERD, STAY, NONE, TEXT_LAVENDERTOWN_SUPER_NERD

	def_warps_to LAVENDER_TOWN

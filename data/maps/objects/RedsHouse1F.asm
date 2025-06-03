	object_const_def
	const_export REDSHOUSE1F_MOM

RedsHouse1F_Object:
	db $a ; border block

	def_warp_events
IF DEF(_BLUE)
	warp_event  2,  7, LAST_MAP, 2
	warp_event  3,  7, LAST_MAP, 2
ELSE ; _RED
	warp_event  2,  7, LAST_MAP, 1
	warp_event  3,  7, LAST_MAP, 1
ENDC
	warp_event  7,  1, REDS_HOUSE_2F, 1

	def_bg_events
	bg_event  3,  1, TEXT_REDSHOUSE1F_TV

	def_object_events
	
IF DEF(_BLUE)
	object_event  5,  4, SPRITE_DAISY, STAY, LEFT, TEXT_REDSHOUSE1F_MOM
ELSE ; _RED
	object_event  5,  4, SPRITE_MOM, STAY, LEFT, TEXT_REDSHOUSE1F_MOM
ENDC

	def_warps_to REDS_HOUSE_1F

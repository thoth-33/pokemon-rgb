	object_const_def
	const_export CINNABARVOLCANOB1F_MAX_ETHER
	const_export CINNABARVOLCANOB1F_X_SPECIAL

CinnabarVolcanoB1F_Object:
	db $02 ; border block

	def_warp_events
	warp_event 25, 23, CINNABAR_VOLCANO, 4
	warp_event 33, 27, CINNABAR_VOLCANO, 5

	def_bg_events
	bg_event  25, 27, TEXT_CINNABARVOLCANOB1F_SIGN

	def_object_events
	object_event 18,  0, SPRITE_POKE_BALL, STAY, NONE, CINNABARVOLCANOB1F_MAX_ETHER, MAX_ETHER
	object_event 33,  4, SPRITE_POKE_BALL, STAY, NONE, CINNABARVOLCANOB1F_X_SPECIAL, X_SPECIAL

	def_warps_to CINNABAR_VOLCANO_B1F

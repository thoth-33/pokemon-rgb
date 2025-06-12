	object_const_def
	const_export CINNABARVOLCANOTOP_MOLTRES

CinnabarVolcanoTop_Object:
	db $43 ; border block

	def_warp_events
	warp_event 10, 13, CINNABAR_VOLCANO, 6

	def_bg_events

	def_object_events
	object_event  9,  6, SPRITE_MOLTRES, STAY, DOWN, TEXT_CINNABARVOLCANOTOP_MOLTRES, MOLTRES, 50
	
	def_warps_to CINNABAR_VOLCANO_TOP

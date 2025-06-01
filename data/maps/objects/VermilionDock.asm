	object_const_def
	const_export VERMILION_DOCK_MEW

VermilionDock_Object:
	db $0d ; border block

	def_warp_events
	warp_event 17,  4, LAST_MAP, 6
	warp_event 18,  4, LAST_MAP, 7
	warp_event 17,  6, SS_ANNE_1F, 1
	warp_event 18,  6, SS_ANNE_1F, 2

	def_bg_events

	def_object_events
	object_event 27,  4, SPRITE_MEW, STAY, DOWN, TEXT_VERMILION_DOCK_MEW, MEW, 50

	def_warps_to VERMILION_DOCK

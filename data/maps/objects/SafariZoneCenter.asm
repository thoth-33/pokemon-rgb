	object_const_def
	const_export SAFARIZONECENTER_NUGGET

SafariZoneCenter_Object:
	db $2 ; border block

	def_warp_events
	warp_event 18, 29, SAFARI_ZONE_GATE, 3
	warp_event 19, 29, SAFARI_ZONE_GATE, 4
	warp_event  4, 14, SAFARI_ZONE_WEST, 5
	warp_event  4, 15, SAFARI_ZONE_WEST, 6
	warp_event 18,  4, SAFARI_ZONE_NORTH, 5
	warp_event 19,  4, SAFARI_ZONE_NORTH, 6
	warp_event 33, 14, SAFARI_ZONE_EAST, 3
	warp_event 33, 15, SAFARI_ZONE_EAST, 4
	warp_event 21, 23, SAFARI_ZONE_CENTER_REST_HOUSE, 1

	def_bg_events
	bg_event 22, 24, TEXT_SAFARIZONECENTER_REST_HOUSE_SIGN
	bg_event 18, 26, TEXT_SAFARIZONECENTER_TRAINER_TIPS_SIGN

	def_object_events
	object_event 18, 14, SPRITE_POKE_BALL, STAY, NONE, TEXT_SAFARIZONECENTER_NUGGET, NUGGET

	def_warps_to SAFARI_ZONE_CENTER

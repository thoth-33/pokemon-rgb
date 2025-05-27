	object_const_def
	const_export ROUTE1_YOUNGSTER1
	const_export ROUTE1_YOUNGSTER2
	const_export ROUTE1_OAK

Route1_Object:
	db $b ; border block

	def_warp_events

	def_bg_events
	bg_event  9, 27, TEXT_ROUTE1_SIGN

	def_object_events
	object_event  5, 24, SPRITE_YOUNGSTER, WALK, UP_DOWN, TEXT_ROUTE1_YOUNGSTER1
	object_event 15, 13, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, TEXT_ROUTE1_YOUNGSTER2
	object_event 10, 28, SPRITE_OAK, STAY, DOWN, TEXT_ROUTE1_OAK ; oak

	def_warps_to ROUTE_1

	; unused
	warp_to 2, 7, 4

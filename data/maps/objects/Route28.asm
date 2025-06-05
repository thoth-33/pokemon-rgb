	object_const_def
	const_export ROUTE28_GUARD
	const_export ROUTE28_BIRD1
	const_export ROUTE28_BIRD2
	const_export ROUTE28_BIRD3
	const_export ROUTE28_LT_SURGE
	const_export ROUTE28_RARE_CANDY

Route28_Object:
	db $2C ; border block

	def_warp_events
	warp_event 37,  4, ROUTE_22_GATE, 5
	warp_event 37,  5, ROUTE_22_GATE, 6

	def_bg_events
	bg_event  33,  7, TEXT_ROUTE28_SIGN

	def_object_events
	object_event  22,  11, SPRITE_GUARD, STAY, DOWN, TEXT_ROUTE28_GUARD
	object_event  22,  12, SPRITE_FEAROW, WALK, UP_DOWN, TEXT_ROUTE28_FEAROW
	object_event  20,  13, SPRITE_PIDGEOT, WALK, LEFT_RIGHT, TEXT_ROUTE28_PIDGEOT
	object_event  25,  13, SPRITE_PIDGEOT, WALK, LEFT_RIGHT, TEXT_ROUTE28_PIDGEOT2
	object_event  32,  11, SPRITE_ROCKER, STAY, UP, TEXT_ROUTE28_LT_SURGE
	object_event  25,   3, SPRITE_POKE_BALL, STAY, NONE, TEXT_ROUTE28_RARE_CANDY, RARE_CANDY

	def_warps_to ROUTE_28
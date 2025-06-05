	object_const_def
	const_export ROUTE22GATE_GUARD

Route22Gate_Object:
	db $a ; border block

	def_warp_events
	warp_event  8,  7, ROUTE_22, 1
	warp_event  9,  7, ROUTE_22, 1
	warp_event  8,  0, ROUTE_23, 1
	warp_event  9,  0, ROUTE_23, 2
	warp_event  0,  4, ROUTE_28, 1
	warp_event  0,  5, ROUTE_28, 2

	def_bg_events

	def_object_events
	object_event 10,  2, SPRITE_GUARD, STAY, LEFT, TEXT_ROUTE22GATE_GUARD ; person
	object_event  1,  2, SPRITE_GUARD, STAY, DOWN, TEXT_ROUTE28GATE_GUARD ; MT_SILVER

	def_warps_to ROUTE_22_GATE

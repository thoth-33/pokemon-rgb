Route28_Object:
	db $2C ; border block

	def_warp_events
	warp_event 37,  4, ROUTE_22_GATE, 5
	warp_event 37,  5, ROUTE_22_GATE, 6

	def_bg_events

	def_object_events

	def_warps_to ROUTE_28
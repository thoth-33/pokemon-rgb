MtSilver1F_Object:
	db $7D ; border block

	def_warp_events
	warp_event  8, 35, MT_SILVER, 1
	warp_event  9, 35, MT_SILVER, 1
	warp_event 13,  1, MT_SILVER_CAVE_2F, 1

	def_bg_events

	def_object_events


	def_warps_to MT_SILVER_CAVE_1F

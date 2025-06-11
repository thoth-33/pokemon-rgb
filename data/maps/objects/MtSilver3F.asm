	object_const_def
	const_export MT_SILVER3F_GIOVANNI
	const_export MT_SILVER3F_ROCKET1
	const_export MT_SILVER3F_ROCKET2
	const_export MT_SILVER3F_ROCKET3

MtSilver3F_Object:
	db $7D ; border block

	def_warp_events
	warp_event  9, 33, MT_SILVER_CAVE_2F, 2

	def_bg_events

	def_object_events
	object_event 10,  6, SPRITE_GIOVANNI, STAY, UP, TEXT_MT_SILVER3F_GIOVANNI, OPP_GIOVANNI, 4
	object_event  9, 23, SPRITE_ROCKET, STAY, RIGHT, TEXT_MT_SILVER3F_ROCKET1, OPP_ROCKET,  42
	object_event 10, 19, SPRITE_ROCKET, STAY, LEFT,  TEXT_MT_SILVER3F_ROCKET2, OPP_ROCKET,  43
	object_event  9, 15, SPRITE_ROCKET, STAY, RIGHT, TEXT_MT_SILVER3F_ROCKET3, OPP_ROCKET,  44

	def_warps_to MT_SILVER_CAVE_3F

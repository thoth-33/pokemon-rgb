	object_const_def
	const_export MT_SILVER2F_WHIRLPOOL1
	const_export MT_SILVER2F_WHIRLPOOL2

MtSilver2F_Object:
	db $7D ; border block

	def_warp_events
	warp_event 19, 33, MT_SILVER_CAVE_1F, 3
	warp_event  7,  5, MT_SILVER_CAVE_3F, 1

	def_bg_events

	def_object_events
	object_event  8, 18, SPRITE_WHIRLPOOL, STAY, ANY_DIR, TEXT_MT_SILVER2F_WHIRLPOOL1
	object_event  9, 18, SPRITE_WHIRLPOOL, STAY, ANY_DIR, TEXT_MT_SILVER2F_WHIRLPOOL2

	def_warps_to MT_SILVER_CAVE_2F

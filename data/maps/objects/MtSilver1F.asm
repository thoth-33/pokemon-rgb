	object_const_def
	const_export MT_SILVER1F_ROCK_GUARD
	const_export MT_SILVER1F_PSYCH_GUARD
	const_export MT_SILVER1F_HYPNO
	const_export MT_SILVER1F_BROCK
	const_export MT_SILVER1F_SABRINA

MtSilver1F_Object:
	db $7D ; border block

	def_warp_events
	warp_event  8, 35, MT_SILVER, 1
	warp_event  9, 35, MT_SILVER, 1
	warp_event 13,  1, MT_SILVER_CAVE_2F, 1

	def_bg_events

	def_object_events
	object_event  9, 28, SPRITE_GUARD, STAY, LEFT, TEXT_MT_SILVER1F_ROCK_GUARD
	object_event  9,  1, SPRITE_GUARD, STAY, DOWN, TEXT_MT_SILVER1F_PSYCH_GUARD
	object_event 10,  4, SPRITE_HYPNO, STAY, DOWN, TEXT_MT_SILVER1F_HYPNO
	object_event  7, 31, SPRITE_SUPER_NERD, STAY, DOWN, TEXT_MT_SILVER1F_BROCK
	object_event  9,  8, SPRITE_GIRL, STAY, RIGHT, TEXT_MT_SILVER1F_SABRINA

	def_warps_to MT_SILVER_CAVE_1F

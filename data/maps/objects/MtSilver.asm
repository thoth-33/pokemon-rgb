	object_const_def
	const_export MT_SILVER_TREE_GUARD
	const_export MT_SILVER_CAVE_GUARD1
	const_export MT_SILVER_CAVE_GUARD2
	const_export MT_SILVER_ERIKA
	const_export MT_SILVER_BLAINE
	const_export MT_SILVER_KOGA

MtSilver_Object:
	db $2C ; border block

	def_warp_events
	warp_event 14,  3, MT_SILVER_CAVE_1F, 1

	def_bg_events

	def_object_events
	object_event 24, 25, SPRITE_GUARD, STAY, RIGHT, TEXT_MT_SILVER_TREE_GUARD
	object_event 14,  4, SPRITE_GUARD, STAY, DOWN, TEXT_MT_SILVER_CAVE_GUARD1
	object_event 13,  4, SPRITE_GUARD, STAY, DOWN, TEXT_MT_SILVER_CAVE_GUARD2
	object_event 31, 25, SPRITE_SILPH_WORKER_F, STAY, RIGHT, TEXT_MT_SILVER_ERIKA
	object_event 27, 25, SPRITE_MIDDLE_AGED_MAN, STAY, RIGHT, TEXT_MT_SILVER_BLAINE
	object_event 14,  4, SPRITE_KOGA, STAY, DOWN, TEXT_MT_SILVER_KOGA

	def_warps_to MT_SILVER

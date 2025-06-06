	object_const_def
	const_export ROUTE3_SUPER_NERD
	const_export ROUTE3_YOUNGSTER1
	const_export ROUTE3_YOUNGSTER2
	const_export ROUTE3_COOLTRAINER_F1
	const_export ROUTE3_YOUNGSTER3
	const_export ROUTE3_COOLTRAINER_F2
	const_export ROUTE3_YOUNGSTER4
	const_export ROUTE3_YOUNGSTER5
	const_export ROUTE3_COOLTRAINER_F3

Route3_Object:
	db $2c ; border block

	def_warp_events

	def_bg_events
	bg_event 59,  9, 10, TEXT_ROUTE3_SIGN

	def_object_events
	object_event 57, 11, SPRITE_SUPER_NERD, STAY, NONE, TEXT_ROUTE3_SUPER_NERD
	object_event 10,  6, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_ROUTE3_YOUNGSTER1, OPP_BUG_CATCHER, 4
	object_event 14,  4, SPRITE_YOUNGSTER, STAY, DOWN, TEXT_ROUTE3_YOUNGSTER2, OPP_YOUNGSTER, 1
	object_event 16,  9, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE3_COOLTRAINER_F1, OPP_LASS, 1
	object_event 19,  5, SPRITE_YOUNGSTER, STAY, DOWN, TEXT_ROUTE3_YOUNGSTER3, OPP_BUG_CATCHER, 5
	object_event 23,  4, SPRITE_COOLTRAINER_F, STAY, LEFT, TEXT_ROUTE3_COOLTRAINER_F2, OPP_LASS, 2
	object_event 22,  9, SPRITE_YOUNGSTER, STAY, LEFT, TEXT_ROUTE3_YOUNGSTER4, OPP_YOUNGSTER, 2
	object_event 24,  6, SPRITE_YOUNGSTER, STAY, RIGHT, TEXT_ROUTE3_YOUNGSTER5, OPP_BUG_CATCHER, 6
	object_event 33, 10, SPRITE_COOLTRAINER_F, STAY, UP, TEXT_ROUTE3_COOLTRAINER_F3, OPP_LASS, 3

	def_warps_to ROUTE_3

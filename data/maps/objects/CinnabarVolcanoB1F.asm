CinnabarVolcanoB1F_Object:
	db $02 ; border block

	def_warp_events
	warp_event 25, 23, CINNABAR_VOLCANO, 4
	warp_event 33, 27, CINNABAR_VOLCANO, 5

	def_bg_events

	def_object_events


	def_warps_to CINNABAR_VOLCANO_B1F

CinnabarVolcano_Script:
	ld a, CINNABAR_VOLCANO
	ld [wLastMap], a
	call EnableAutoTextBoxDrawing
	ld hl, CinnabarVolcano_ScriptPointers
	ld a, [wCinnabarVolcanoCurScript]
	jp CallFunctionInTable
	
CinnabarVolcano_ScriptPointers:
	def_script_pointers
	dw_const CinnabarVolcanoDefaultScript,      SCRIPT_CINNABAR_VOLCANO_DEFAULT
	dw_const CinnabarVolcanoPlayerMovingScript, SCRIPT_CINNABAR_VOLCANO_PLAYER_MOVING
	
CinnabarVolcanoDefaultScript:
	ld hl, wMiscFlags
	bit BIT_PUSHED_BOULDER, [hl]
	res BIT_PUSHED_BOULDER, [hl]
	jr z, .ventCheck
	ld hl, VolcanoHolesCoords
	call CheckBoulderCoords
	ret nc
	ld a, [wCoordIndex]
	cp $2
	jr z, .boulder2FellDownHole
	cp $3
	jr z, .boulder3FellDownHole
	cp $4
	jr z, .boulder4FellDownHole
	SetEvent EVENT_VOLCANO_BOULDER1_DOWN_HOLE
	ld a, HS_CINNABARVOLCANO_BOULDER1
	ld [wMissableObjectIndex], a
	predef HideObject
	jr .ventCheck
.boulder2FellDownHole
	SetEvent EVENT_VOLCANO_BOULDER2_DOWN_HOLE
	ld a, HS_CINNABARVOLCANO_BOULDER2
	ld [wMissableObjectIndex], a
	predef HideObject
	jr .ventCheck
.boulder3FellDownHole
	SetEvent EVENT_VOLCANO_BOULDER3_DOWN_HOLE
	ld a, HS_CINNABARVOLCANO_BOULDER3
	ld [wMissableObjectIndex], a
	predef HideObject
	jr .ventCheck
.boulder4FellDownHole
	SetEvent EVENT_VOLCANO_BOULDER4_DOWN_HOLE
	ld a, HS_CINNABARVOLCANO_BOULDER4
	ld [wMissableObjectIndex], a
	predef HideObject
	jr .ventCheck
.ventCheck
	ld hl, VolcanoHeatCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_CINNABAR_VOLCANO_HEAT
	ldh [hTextID], a
	call CinnabarVolcanoScript_MoveRight
	ld a, SCRIPT_CINNABAR_VOLCANO_PLAYER_MOVING
	ld [wCinnabarVolcanoCurScript], a
	jp DisplayTextID
	ret
	
VolcanoHolesCoords:
	dbmapcoord 20, 27
	dbmapcoord  4, 23
	dbmapcoord  3, 13
	dbmapcoord 31, 11
	db -1 ; end	
	
VolcanoHeatCoords:
	dbmapcoord 21, 27
	dbmapcoord  5, 23
	dbmapcoord  4, 13
	dbmapcoord 32, 11
	db -1 ; end	
	
CinnabarVolcanoScript_MoveRight:
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_RIGHT
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	jp StartSimulatingJoypadStates
	
CinnabarVolcanoPlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_CINNABAR_VOLCANO_DEFAULT
	ld [wCinnabarVolcanoCurScript], a
	ret

CinnabarVolcano_TextPointers:
	def_text_pointers
	dw_const BoulderText,              TEXT_CINNABARVOLCANO_BOULDER1
	dw_const BoulderText,              TEXT_CINNABARVOLCANO_BOULDER2
	dw_const BoulderText,              TEXT_CINNABARVOLCANO_BOULDER3
	dw_const BoulderText,              TEXT_CINNABARVOLCANO_BOULDER4
	dw_const PickUpItemText,           TEXT_CINNABARVOLCANO_FIRE_STONE
	dw_const CinnabarVolcanoSign1Text, TEXT_CINNABARVOLCANO_SIGN1
	dw_const CinnabarVolcanoSign2Text, TEXT_CINNABARVOLCANO_SIGN2
	dw_const CinnabarVolcanoHeatText,  TEXT_CINNABAR_VOLCANO_HEAT
	
CinnabarVolcanoSign1Text:
	text_far _CinnabarVolcanoSign1Text
	text_end	

CinnabarVolcanoSign2Text:
	text_far _CinnabarVolcanoSign2Text
	text_end
	
CinnabarVolcanoHeatText:
	text_asm
	ld hl, CinnabarVolcanoHeatText_Warning
	call PrintText
	jp TextScriptEnd
	
CinnabarVolcanoHeatText_Warning:
	text_far _CinnabarVolcanoHeatText_Warning
	text_end
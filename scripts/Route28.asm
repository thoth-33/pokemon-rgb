Route28_Script:
	ld a, ROUTE_28
	ld [wLastMap], a
	call EnableAutoTextBoxDrawing
	ld hl, Route28_ScriptPointers
	ld a, [wRoute28CurScript]
	jp CallFunctionInTable
	
Route28_ScriptPointers:
	def_script_pointers
	dw_const Route28DefaultScript,          SCRIPT_ROUTE28_DEFAULT
	dw_const Route28PlayerMovingScript,     SCRIPT_ROUTE28_PLAYER_MOVING
	dw_const Route28LTSurgeTalkScript,      SCRIPT_ROUTE28_LT_SURGE_TALK
	dw_const Route28LTSurgeExitScript,      SCRIPT_ROUTE28_LT_SURGE_EXIT
	dw_const Route28NoopScript,             SCRIPT_ROUTE28_NOOP
	
Route28NoopScript:
ret
	
Route28DefaultScript:
	CheckEvent EVENT_LT_SURGE_REMATCH_BEAT
	jr nz, .SurgeWalkAndTalk ; set to z for debug
	ld hl, Route28GuardCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, TEXT_ROUTE28_GUARD
	ldh [hTextID], a
	call Route28Script_MoveRight
	ld a, SCRIPT_ROUTE28_PLAYER_MOVING
	ld [wRoute28CurScript], a
	jp DisplayTextID
.SurgeWalkAndTalk
	ld hl, Route28SurgeCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a	
	ld a, HS_ROUTE_28_LT_SURGE
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, ROUTE28_LT_SURGE
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 31
	jr z, .player_standing_left
	ld de, .LTSurgeWalkUpMovement
	jr .move_sprite
.player_standing_left
	ld de, .LTSurgeWalkLeftMovement
.move_sprite
	ld a, ROUTE28_LT_SURGE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_ROUTE28_LT_SURGE_TALK
	ld [wRoute28CurScript], a	
	ret
	
.LTSurgeWalkUpMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end
	
.LTSurgeWalkLeftMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db -1 ; end
	
Route28GuardCoords:
	dbmapcoord  22,  12
	dbmapcoord  22,  13
	db -1 ; end
	
Route28SurgeCoords:
	dbmapcoord  32,   7
	dbmapcoord  31,   6
	db -1 ; end
	
Route28Script_MoveRight:
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_RIGHT
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	jp StartSimulatingJoypadStates
	
Route28PlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, SCRIPT_ROUTE28_DEFAULT
	ld [wRoute28CurScript], a
	ret
	
Route28LTSurgeTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_ROUTE28_LT_SURGE
	ldh [hTextID], a
	call DisplayTextID
	ld a, ROUTE28_LT_SURGE
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 31
	jr nz, .player_standing_left
	ld de, .LTSurgeWalkRightMovement
	jr .move_sprite
.player_standing_left
	ld de, .LTSurgeWalkAroundMovement
.move_sprite
	ld a, ROUTE28_LT_SURGE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_ROUTE28_LT_SURGE_EXIT
	ld [wRoute28CurScript], a	
	ret
	
.LTSurgeWalkAroundMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
.LTSurgeWalkRightMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
Route28LTSurgeExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_28_LT_SURGE
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_VERMILION_GYM_LT_SURGE2 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_ROUTE_28_BIRD1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_28_BIRD2
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_28_BIRD3
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SCRIPT_ROUTE28_NOOP
	ld [wRoute28CurScript], a	
	ret

Route28_TextPointers:
	def_text_pointers
	dw_const Route28GuardText,       TEXT_ROUTE28_GUARD
	dw_const Route28FearowText,      TEXT_ROUTE28_FEAROW
	dw_const Route28PidgeotText,     TEXT_ROUTE28_PIDGEOT
	dw_const Route28PidgeotText,     TEXT_ROUTE28_PIDGEOT2
	dw_const Route28LTSurgeText,     TEXT_ROUTE28_LT_SURGE
	dw_const PickUpItemText,         TEXT_ROUTE28_RARE_CANDY
	dw_const Route28SignText,        TEXT_ROUTE28_SIGN

Route28GuardText:
	text_asm
	CheckEvent EVENT_LT_SURGE_REMATCH_BEAT
	jr z, .notBeat
	ld hl, Route28GuardText_Pass
	call PrintText
	jp TextScriptEnd
.notBeat
	SetEvent EVENT_LT_SURGE_REMATCH
	ld hl, Route28GuardText_Stop
	call PrintText
	jp TextScriptEnd
	
Route28GuardText_Stop:
	text_far _Route28GuardText_Stop
	text_end

Route28GuardText_Pass:
	text_far _Route28GuardText_Pass
	text_end
	
Route28PidgeotText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, PIDGEOT
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text_far _SaffronCityPidgeotText
	text_end
	
Route28FearowText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text_far _Route16FlyHouseFearowText
	text_end
	
Route28LTSurgeText:
	text_asm
	ld hl, Route28LTSurgeText_Done
	call PrintText
	jp TextScriptEnd
	
Route28LTSurgeText_Done:
	text_far _Route28LTSurgeText_Done
	text_end
	
Route28SignText:
	text_far _Route28SignText
	text_end
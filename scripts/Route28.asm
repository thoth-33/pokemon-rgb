Route28_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route28_ScriptPointers
	ld a, [wRoute28CurScript]
	jp CallFunctionInTable
	
Route28_ScriptPointers:
	def_script_pointers
	dw_const Route28DefaultScript,          SCRIPT_ROUTE28_DEFAULT
	dw_const Route28PlayerMovingScript,     SCRIPT_ROUTE28_PLAYER_MOVING
	
Route28DefaultScript:
	CheckEvent EVENT_LT_SURGE_REMATCH_BEAT
	ret nz
	ld hl, Route28ScriptCoords
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
	
Route28ScriptCoords:
	dbmapcoord  22,  12
	dbmapcoord  22,  13
	db -1 ; end
	
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

Route28_TextPointers:
	def_text_pointers
	dw_const Route28GuardText,       TEXT_ROUTE28_GUARD
	dw_const Route28FearowText,      TEXT_ROUTE28_FEAROW
	dw_const Route28PidgeotText,     TEXT_ROUTE28_PIDGEOT
	dw_const Route28PidgeotText,     TEXT_ROUTE28_PIDGEOT2
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
	
Route28Script_MoveRight:
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_RIGHT
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	jp StartSimulatingJoypadStates
	
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
	
Route28SignText:
	text_far _Route28SignText
	text_end
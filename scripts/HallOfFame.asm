HallOfFame_Script:
	call EnableAutoTextBoxDrawing
	ld hl, HallOfFame_ScriptPointers
	ld a, [wHallOfFameCurScript]
	jp CallFunctionInTable

HallofFameRoomClearScripts: ; unreferenced
	xor a
	ld [wJoyIgnore], a
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_ScriptPointers:
	def_script_pointers
	dw_const HallOfFameDefaultScript,            SCRIPT_HALLOFFAME_DEFAULT
	dw_const HallOfFameOakCongratulationsScript, SCRIPT_HALLOFFAME_OAK_CONGRATULATIONS
	dw_const HallOfFameResetEventsAndSaveScript, SCRIPT_HALLOFFAME_RESET_EVENTS_AND_SAVE
	dw_const HallOfFameNoopScript,               SCRIPT_HALLOFFAME_NOOP

HallOfFameNoopScript:
	ret

HallOfFameResetEventsAndSaveScript:
	call Delay3
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wJoyIgnore], a
	predef HallOfFamePC
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld hl, wStatusFlags7
	res BIT_NO_MAP_MUSIC, [hl]
	ASSERT wStatusFlags7 + 1 == wElite4Flags
	inc hl
	set BIT_UNUSED_BEAT_ELITE_4, [hl] ; unused
	xor a ; SCRIPT_*_DEFAULT
	ld hl, wLoreleisRoomCurScript
	ld [hli], a ; wLoreleisRoomCurScript
	ld [hli], a ; wBrunosRoomCurScript
	ld [hl], a ; wAgathasRoomCurScript
	ld [wLancesRoomCurScript], a
	ld [wHallOfFameCurScript], a
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, INDIGO_PLATEAU_EVENTS_END, 1
	xor a
	ld [wHallOfFameCurScript], a
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	farcall SaveSAVtoSRAM
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	jp Init

HallOfFameDefaultScript:
	ld a, PAD_A | PAD_B | PAD_SELECT | PAD_START | PAD_RIGHT | PAD_LEFT | PAD_UP | PAD_DOWN
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, HallOfFameEntryMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_HALLOFFAME_OAK_CONGRATULATIONS
	ld [wHallOfFameCurScript], a
	ret

HallOfFameEntryMovement:
	db PAD_UP, 5
	db -1 ; end

HallOfFameOakCongratulationsScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, HALLOFFAME_OAK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	xor a
	ld [wJoyIgnore], a
	inc a ; PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	CheckEvent EVENT_OAK_BEAT
	ld a, TEXT_HALLOFFAME_REMATCH_OAK
	jr nz, .RematchText
	ld a, TEXT_HALLOFFAME_OAK
.RematchText
	ldh [hTextID], a
	call DisplayTextID
	ld a, PAD_A | PAD_B | PAD_SELECT | PAD_START | PAD_RIGHT | PAD_LEFT | PAD_UP | PAD_DOWN
	ld [wJoyIgnore], a
	CheckEvent EVENT_PLAYER_IS_CHAMPION
	jr nz, .skip ; dont reapply these after the first time around. Messes with post-game
	ld a, HS_CERULEAN_CAVE_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OAKS_LAB_OAK_1 
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_STARTER_BALL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_STARTER_BALL_2
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_STARTER_BALL_3
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OAKS_LAB_SCIENTIST 
	ld [wMissableObjectIndex], a
	predef ShowObject
.skip
	SetEvent EVENT_PLAYER_IS_CHAMPION
	ld a, SCRIPT_HALLOFFAME_RESET_EVENTS_AND_SAVE
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_TextPointers:
	def_text_pointers
	dw_const HallOfFameOakText, TEXT_HALLOFFAME_OAK
	dw_const HallOfFameRematchOakText, TEXT_HALLOFFAME_REMATCH_OAK

HallOfFameOakText:
	text_far _HallOfFameOakText
	text_end

HallOfFameRematchOakText:
	text_far _HallOfFameRematchOakText
	text_end
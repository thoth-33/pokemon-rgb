MtSilver1F_Script:
	ld a, MT_SILVER_CAVE_1F
	ld [wLastMap], a
	call EnableAutoTextBoxDrawing
	ld hl, MtSilver1F_ScriptPointers
	ld a, [wMtSilver1FCurScript]
	jp CallFunctionInTable

MtSilver1F_ScriptPointers:
	def_script_pointers
	dw_const MtSilver1FBrockScript,        SCRIPT_MT_SILVER1F_BROCK
	dw_const MtSilver1FBrockTalkScript,    SCRIPT_MT_SILVER1F_BROCK_TALK
	dw_const MtSilver1FBrockExitScript,    SCRIPT_MT_SILVER1F_BROCK_EXIT
	dw_const MtSilver1FSabrinaScript,      SCRIPT_MT_SILVER1F_SABRINA
	dw_const MtSilver1FSabrinaTalkScript,  SCRIPT_MT_SILVER1F_SABRINA_TALK
	dw_const MtSilver1FPlayerMovingScript, SCRIPT_MT_SILVER1F_PLAYER_MOVING
	dw_const MtSilver1FNoopScript,         SCRIPT_MT_SILVER1F_NOOP
	
MtSilver1FBrockScript:
	CheckEvent EVENT_BROCK_REMATCH_BEAT
	ret nz ; set to nz for debug
	ld hl, MtSilver1FBrockCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER1F_BROCK
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER1F_BROCK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, .BrockWalkMovement
	ld a, MT_SILVER1F_BROCK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER1F_BROCK_TALK
	ld [wMtSilver1FCurScript], a	
	ret
	
.BrockWalkMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
MtSilver1FBrockCoords:
	dbmapcoord  8,   35
	db -1 ; end

MtSilver1FBrockTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_MT_SILVER1F_BROCK
	ldh [hTextID], a
	call DisplayTextID
	ld a, MT_SILVER1F_BROCK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, .BrockExitMovement
	ld a, MT_SILVER1F_BROCK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER1F_BROCK_EXIT
	ld [wMtSilver1FCurScript], a	
	ret
	
.BrockExitMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db -1 ; end

MtSilver1FBrockExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_MT_SILVER1F_BROCK
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_PEWTER_GYM_BROCK2
	ld [wMissableObjectIndex], a
	predef ShowObject
	
	ld a, HS_MT_SILVER1F_BOULDER1B
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER1F_BOULDER2B
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER1F_BOULDER3B
	ld [wMissableObjectIndex], a
	predef HideObject
	
	ld a, HS_MT_SILVER1F_BOULDER1A
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_MT_SILVER1F_BOULDER2A
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_MT_SILVER1F_BOULDER3A
	ld [wMissableObjectIndex], a
	predef ShowObject
	
	ld a, SCRIPT_MT_SILVER1F_SABRINA
	ld [wMtSilver1FCurScript], a	
	ret
	
MtSilver1FSabrinaScript:
	CheckEvent EVENT_SABRINA_REMATCH_BEAT
	jr z, .SabrinaWalk ; set to z for debug
	ld hl, MtSilver1FHypnoCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	ld a, MT_SILVER1F_HYPNO
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_MT_SILVER1F_HYPNO
	ldh [hTextID], a
	call MtSilver1FScript_MoveUp
	ld a, SCRIPT_MT_SILVER1F_PLAYER_MOVING
	ld [wMtSilver1FCurScript], a
	jp DisplayTextID
.SabrinaWalk
	ld hl, MtSilver1FSabrinaCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER1F_SABRINA
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER1F_SABRINA
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 13
	jr z, .player_standing_left
	ld de, .SabrinaWalkFarMovement
	jr .move_sprite
.player_standing_left
	ld de, .SabrinaWalkCloseMovement
.move_sprite
	ld a, MT_SILVER1F_SABRINA
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER1F_SABRINA_TALK
	ld [wMtSilver1FCurScript], a	
	ret
	
.SabrinaWalkFarMovement:
	db NPC_MOVEMENT_RIGHT
.SabrinaWalkCloseMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
MtSilver1FHypnoCoords:
	dbmapcoord  9, 4
	db -1 ; end	
	
MtSilver1FSabrinaCoords:
	dbmapcoord 13, 8
	dbmapcoord 14, 8
	db -1 ; end

MtSilver1FScript_MoveUp:
	ld hl, wSimulatedJoypadStatesEnd
	ld a, D_UP
	ld [hli], a
	ld [hl], a
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	ld [wJoyIgnore], a
	jp StartSimulatingJoypadStates
	
MtSilver1FPlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	call Delay3
	ld a, TEXT_MT_SILVER1F_PSYCH_GUARD
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_SABRINA_REMATCH
	ld a, SCRIPT_MT_SILVER1F_SABRINA
	ld [wMtSilver1FCurScript], a	
	ret

MtSilver1FSabrinaTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	call UpdateSprites
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	ld a, MT_SILVER1F_SABRINA
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_MT_SILVER1F_SABRINA
	ldh [hTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_SAFFRON_GYM_SABRINA
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_MT_SILVER1F_SABRINA
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call GBFadeInFromBlack
	xor a
	ld [wJoyIgnore], a
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ld a, SCRIPT_MT_SILVER1F_NOOP
	ld [wMtSilver1FCurScript], a	
	ret

MtSilver1FNoopScript:
ret ; to-do
	
MtSilver1F_TextPointers:
	def_text_pointers
	dw_const MtSilver1FRockGuardText,  TEXT_MT_SILVER1F_ROCK_GUARD
    dw_const MtSilver1FPsychGuardText, TEXT_MT_SILVER1F_PSYCH_GUARD
    dw_const MtSilver1FHypnoText,      TEXT_MT_SILVER1F_HYPNO
    dw_const MtSilver1FBrockText,      TEXT_MT_SILVER1F_BROCK
    dw_const MtSilver1FSabrinaText,    TEXT_MT_SILVER1F_SABRINA
	
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER1B
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER2B
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER3B
	
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER1A
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER2A
	dw_const BoulderText, TEXT_MT_SILVER1F_BOULDER3A
	
MtSilver1FRockGuardText:
	text_asm
	CheckEvent EVENT_BROCK_REMATCH_BEAT
	jr nz, .done
	SetEvent EVENT_BROCK_REMATCH
	ld hl, MtSilver1FRockGuardText_Brock
	call PrintText
	jp TextScriptEnd
.done
	ld hl, MtSilver1FRockGuardText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilver1FRockGuardText_Brock:
	text_far _MtSilver1FRockGuardText_Brock
	text_end
	
MtSilver1FRockGuardText_Done:
	text_far _MtSilver1FRockGuardText_Done
	text_end

MtSilver1FPsychGuardText:
	text_asm
	CheckEvent EVENT_SABRINA_REMATCH_BEAT
	jr nz, .done
	SetEvent EVENT_SABRINA_REMATCH
	ld hl, MtSilver1FPsychGuardText_Sabrina
	call PrintText
	jp TextScriptEnd
.done
	ld hl, MtSilver1FPsychGuardText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilver1FPsychGuardText_Sabrina:
	text_far _MtSilver1FPsychGuardText_Sabrina
	text_end
	
MtSilver1FPsychGuardText_Done:
	text_far _MtSilver1FPsychGuardText_Done
	text_end
	
MtSilver1FBrockText:
	text_asm
	ld hl, MtSilver1FBrockText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilver1FBrockText_Done:
	text_far _MtSilver1FBrockText_Done
	text_end
	
MtSilver1FSabrinaText:
	text_asm
	ld hl, MtSilver1FSabrinaText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilver1FSabrinaText_Done:
	text_far _MtSilver1FSabrinaText_Done
	text_end
	
MtSilver1FHypnoText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, HYPNO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text_far _MtSilver1FHypnoText
	text_end

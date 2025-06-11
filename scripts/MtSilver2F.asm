MtSilver2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtSilver2F_ScriptPointers
	ld a, [wMtSilver2FCurScript]
	jp CallFunctionInTable

MtSilver2F_ScriptPointers:
	def_script_pointers
	dw_const MtSilver2FDefaultScript,    SCRIPT_MT_SILVER2F_DEFAULT
	dw_const MtSilver2FMistyTalkScript,  SCRIPT_MT_SILVER2F_MISTY_TALK
	dw_const MtSilver2FMistyExitScript,  SCRIPT_MT_SILVER2F_MISTY_EXIT
	dw_const MtSilver2FNoopScript,       SCRIPT_MT_SILVER2F_NOOP

MtSilver2FNoopScript:
ret

MtSilver2FDefaultScript:
	CheckEvent EVENT_MISTY_REMATCH_BEAT
	ret nz ; set to nz for debug
	ld hl, MtSilver2FMistyCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER2F_MISTY
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER2F_MISTY  
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 1
	jr z, .player_standing_left
	ld de, .MistyWalkShortMovement
	jr .move_sprite
.player_standing_left
	ld de, .MistyWalkLongMovement
.move_sprite
	ld a, MT_SILVER2F_MISTY 
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER2F_MISTY_TALK
	ld [wMtSilver2FCurScript], a	
	ret
	
.MistyWalkLongMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
.MistyWalkShortMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
MtSilver2FMistyCoords:
	dbmapcoord  1,   20
	dbmapcoord  2,   20
	db -1 ; end
	
MtSilver2FMistyTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_MT_SILVER2F_MISTY
	ldh [hTextID], a
	call DisplayTextID
	ld a, MT_SILVER2F_MISTY
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 1
	jr z, .player_standing_left
	ld de, .MistyWalkAroundMovement
	jr .move_sprite
.player_standing_left
	ld de, .MistyWalkRightMovement
.move_sprite
	ld a, MT_SILVER2F_MISTY
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER2F_MISTY_EXIT
	ld [wMtSilver2FCurScript], a	
	ret
	
.MistyWalkAroundMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; endd
.MistyWalkRightMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; endd
	
MtSilver2FMistyExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_MT_SILVER2F_MISTY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_CERULEAN_GYM_MISTY2 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, SCRIPT_MT_SILVER2F_NOOP
	ld [wMtSilver2FCurScript], a	
	ret

MtSilver2F_TextPointers:
	def_text_pointers
	dw_const MtSilver2FMistyText,      TEXT_MT_SILVER2F_MISTY
	dw_const MtSilver2FWhirlpoolText,  TEXT_MT_SILVER2F_WHIRLPOOL1
	dw_const MtSilver2FWhirlpoolText,  TEXT_MT_SILVER2F_WHIRLPOOL2
	dw_const MtSilver2FWaterGuardText, TEXT_MT_SILVER2F_WATER_GUARD
	dw_const PickUpItemText,           TEXT_MT_SILVER2F_ESCAPE_ROPE
	dw_const PickUpItemText,           TEXT_MT_SILVER2F_TM_DRAGON_RAGE
	
MtSilver2FWhirlpoolText:
	text_asm
	SetEvent EVENT_MISTY_REMATCH
	ld hl, .Wooshing
	call PrintText
	ld hl, MtSilver2FWaterGuardText_Misty
	call PrintText
	jp TextScriptEnd

.Wooshing
	text_far _MtSilver2FWhirlpoolText
	text_end
	
MtSilver2FWaterGuardText:
	text_asm
	CheckEvent EVENT_MISTY_REMATCH_BEAT
	jr nz, .done
	SetEvent EVENT_MISTY_REMATCH
	ld hl, MtSilver2FWaterGuardText_Misty
	call PrintText
	jp TextScriptEnd
.done
	ld hl, MtSilver2FWaterGuardText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilver2FWaterGuardText_Misty:
	text_far _MtSilver2FWaterGuardText_Misty
	text_end

MtSilver2FWaterGuardText_Done:
	text_far _MtSilver2FWaterGuardText_Done
	text_end
	
MtSilver2FMistyText:
	text_asm
	ld hl, MtSilver2FMistyText_Done
	call PrintText
	jp TextScriptEnd	
	
MtSilver2FMistyText_Done:
	text_far _MtSilver2FMistyText_Done
	text_end
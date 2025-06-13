MtSilver_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtSilver_ScriptPointers
	ld a, [wMtSilverCurScript]
	jp CallFunctionInTable

MtSilver_ScriptPointers:
	def_script_pointers
	dw_const MtSilverErikaScript,        SCRIPT_MT_SILVER_ERIKA
	dw_const MtSilverErikaTalkScript,    SCRIPT_MT_SILVER_ERIKA_TALK
	dw_const MtSilverErikaExitScript,    SCRIPT_MT_SILVER_ERIKA_EXIT
	dw_const MtSilverBlaineScript,       SCRIPT_MT_SILVER_BLAINE
	dw_const MtSilverBlaineTalkScript,   SCRIPT_MT_SILVER_BLAINE_TALK
	dw_const MtSilverBlaineExitScript,   SCRIPT_MT_SILVER_BLAINE_EXIT
	dw_const MtSilverKogaScript,         SCRIPT_MT_SILVER_KOGA
	dw_const MtSilverKogaTalkScript,     SCRIPT_MT_SILVER_KOGA_TALK
	dw_const MtSilverNoopScript,         SCRIPT_MT_SILVER_NOOP

MtSilverErikaScript:
	CheckEvent EVENT_ERIKA_REMATCH_BEAT
	ret z ; set to nz for debug
	ld hl, MtSilverErikaCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER_ERIKA
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER_ERIKA
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 22
	jr z, .player_standing_top
	ld de, .ErikaWalkCloseMovement
	jr .move_sprite
.player_standing_top
	ld de, .ErikaWalkFarMovement
.move_sprite
	ld a, MT_SILVER_ERIKA
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER_ERIKA_TALK
	ld [wMtSilverCurScript], a	
	ret
	
.ErikaWalkCloseMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end
	
.ErikaWalkFarMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end
	
MtSilverErikaCoords:
	dbmapcoord  35,   22
	dbmapcoord  35,   23
	db -1 ; end
	
MtSilverErikaTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_MT_SILVER_ERIKA
	ldh [hTextID], a
	call DisplayTextID
	ld a, MT_SILVER_ERIKA
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 22
	jr z, .player_standing_top
	ld de, .ErikaWalkAroundMovement
	jr .move_sprite
.player_standing_top
	ld de, .ErikaWalkRightMovement
.move_sprite
	ld a, MT_SILVER_ERIKA
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER_ERIKA_EXIT
	ld [wMtSilverCurScript], a	
	ret
	
.ErikaWalkAroundMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
.ErikaWalkRightMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
MtSilverErikaExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_MT_SILVER_ERIKA
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_CELADON_GYM_ERIKA1 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, SCRIPT_MT_SILVER_BLAINE
	ld [wMtSilverCurScript], a	
	ret
	
MtSilverBlaineScript:
	CheckEvent EVENT_BLAINE_REMATCH_BEAT
	jr nz, .BlaineWalk ; set to z for debug
	call MtSilverStumpsScript
	ret
.BlaineWalk
	ld hl, MtSilverBlaineCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER_BLAINE
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER_BLAINE
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 24
	jr z, .player_standing_top
	ld de, .BlaineWalkBottomMovement
	jr .move_sprite
.player_standing_top
	ld de, .BlaineWalkTopMovement
.move_sprite
	ld a, MT_SILVER_BLAINE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER_BLAINE_TALK
	ld [wMtSilverCurScript], a	
	ret
	
.BlaineWalkBottomMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
.BlaineWalkTopMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
MtSilverBlaineCoords:
	dbmapcoord  31,   24
	dbmapcoord  31,   25
	db -1 ; end

MtSilverBlaineTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_MT_SILVER_BLAINE
	ldh [hTextID], a
	call DisplayTextID
	ld a, MT_SILVER_BLAINE
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 24
	jr z, .player_standing_top
	ld de, .BlaineWalkUpMovement
	jr .move_sprite
.player_standing_top
	ld de, .BlaineWalkDownMovement
.move_sprite
	ld a, MT_SILVER_BLAINE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER_BLAINE_EXIT
	ld [wMtSilverCurScript], a	
	ret
	
.BlaineWalkDownMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
.BlaineWalkUpMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

MtSilverBlaineExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_MT_SILVER_BLAINE
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_CINNABAR_GYM_BLAINE2 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, SCRIPT_MT_SILVER_KOGA
	ld [wMtSilverCurScript], a	
	ret

MtSilverKogaScript:
	call MtSilverBurnedScript
	CheckEvent EVENT_KOGA_REMATCH_BEAT
	ret z
	ld hl, MtSilverKogaCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a	
	ld a, HS_MT_SILVER_KOGA
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MT_SILVER_KOGA
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 14
	jr z, .player_standing_left
	ld de, .KogaWalkRightMovement
	jr .move_sprite
.player_standing_left
	ld de, .KogaWalkLeftMovement
.move_sprite
	ld a, MT_SILVER_KOGA
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MT_SILVER_KOGA_TALK
	ld [wMtSilverCurScript], a	
	ret
	
.KogaWalkLeftMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
.KogaWalkRightMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
MtSilverKogaCoords:
	dbmapcoord  14, 8
	dbmapcoord  15, 8
	db -1 ; end

MtSilverKogaTalkScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	call UpdateSprites
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	ld a, MT_SILVER_KOGA
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_MT_SILVER_KOGA
	ldh [hTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_FUCHSIA_GYM_KOGA
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_MT_SILVER_KOGA
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call GBFadeInFromBlack
	xor a
	ld [wJoyIgnore], a
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ld a, SCRIPT_MT_SILVER_NOOP
	ld [wMtSilverCurScript], a	
	ret

MtSilverNoopScript:
	call MtSilverBurnedScript
	ret

MtSilverStumpsScript:
	; Check if the current map matches the last visited map
	ld a, [wCurMap]
	ld hl, wLastMap
	cp [hl]
	jr nz, .replaceTiles	
	; Run again after a battle
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	
.replaceTiles ; Set variables to avoid repeated runs
	ld a, [wCurMap]
	ld [wLastMap], a
	ld hl, wCurrentMapScriptFlags
	res BIT_CUR_MAP_LOADED_1, [hl]
    ld a, 1
    ld [wSkipRedraw], a

	ld a, $83
	ld [wNewTileBlockID], a
	ld b, 10
	ld c, 11
	predef ReplaceTileBlock
	ld a, $82
	ld [wNewTileBlockID], a
	ld b, 10
	ld c, 12
	predef ReplaceTileBlock	
	ld a, $80
	ld [wNewTileBlockID], a
	ld b, 11
	ld c, 12
	predef ReplaceTileBlock
	ld a, $81
	ld [wNewTileBlockID], a
	ld b, 11
	ld c, 11
	predef ReplaceTileBlock
	ld b, 12
	ld c, 11
	predef ReplaceTileBlock
	xor a
    ld [wSkipRedraw], a
	ld a, [wXCoord] ; Dont redraw if too far right
	cp $1e
	ret nc
	jpfar RedrawMapView

MtSilverBurnedScript:
	; Check if the current map matches the last visited map
	ld a, [wCurMap]
	ld hl, wLastMap
	cp [hl]
	jr nz, .replaceTiles	
	; Run again after a battle
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	
.replaceTiles ; Set variables to avoid repeated runs
	ld a, [wCurMap]
	ld [wLastMap], a
	ld hl, wCurrentMapScriptFlags
	res BIT_CUR_MAP_LOADED_1, [hl]
    ld a, 1
    ld [wSkipRedraw], a

	ld a, $85
	ld [wNewTileBlockID], a
	ld b, 10
	ld c, 11
	predef ReplaceTileBlock
	ld a, $7a
	ld [wNewTileBlockID], a
	ld b, 10
	ld c, 12
	predef ReplaceTileBlock	
	ld b, 11
	ld c, 12
	predef ReplaceTileBlock
	ld b, 12
	ld c, 12
	predef ReplaceTileBlock
	ld a, $84
	ld [wNewTileBlockID], a
	ld b, 11
	ld c, 11
	predef ReplaceTileBlock
	ld b, 12
	ld c, 11
	predef ReplaceTileBlock
	xor a
    ld [wSkipRedraw], a
	ld a, [wXCoord] ; Dont redraw if too far right
	cp $1e
	ret nc
	cp $10          ; Dont redraw if too far left
	ret c
	ld a, [wYCoord] ; Dont redraw if too far up
	cp $10
	ret c
	jpfar RedrawMapView

MtSilver_TextPointers:
	def_text_pointers
	dw_const MtSilverTreeGuardText,  TEXT_MT_SILVER_TREE_GUARD
    dw_const MtSilverCaveGuard1Text, TEXT_MT_SILVER_CAVE_GUARD1
    dw_const MtSilverCaveGuard2Text, TEXT_MT_SILVER_CAVE_GUARD2
    dw_const MtSilverErikaText,      TEXT_MT_SILVER_ERIKA
    dw_const MtSilverBlaineText,     TEXT_MT_SILVER_BLAINE
    dw_const MtSilverKogaText,       TEXT_MT_SILVER_KOGA
	dw_const MtSilverWeezingText,    TEXT_MT_SILVER_WEEZING1
	dw_const MtSilverWeezingText,    TEXT_MT_SILVER_WEEZING2
	dw_const PickUpItemText,         TEXT_MT_SILVER_FULL_RESTORE
	dw_const MtSilverSignText,       TEXT_MT_SILVER_SIGN
	
MtSilverTreeGuardText:
	text_asm
	CheckEvent EVENT_ERIKA_REMATCH_BEAT
	jr z, .erika ; set to nz debug
	CheckEvent EVENT_BLAINE_REMATCH_BEAT
	jr nz, .done
	;fallthrough
	SetEvent EVENT_BLAINE_REMATCH
	ld hl, MtSilverTreeGuardText_Blaine
	call PrintText
	jp TextScriptEnd
.erika
	CheckEvent EVENT_ERIKA_REMATCH
	jr nz, .skip
	SetEvent EVENT_ERIKA_REMATCH
	ld a, HS_CELADON_GYM_ERIKA1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_CELADON_GYM_ERIKA2
	ld [wMissableObjectIndex], a
	predef ShowObject
.skip
	ld hl, MtSilverTreeGuardText_Erika
	call PrintText
	jp TextScriptEnd
.done
	ld hl, MtSilverTreeGuardText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilverTreeGuardText_Erika:
	text_far _MtSilverTreeGuardText_Erika
	text_end

MtSilverTreeGuardText_Blaine:
	text_far _MtSilverTreeGuardText_Blaine
	text_end
	
MtSilverTreeGuardText_Done:
	text_far _MtSilverTreeGuardText_Done
	text_end
	
MtSilverCaveGuard1Text:
	text_asm
	SetEvent EVENT_KOGA_REMATCH
	ld hl, MtSilverCaveGuard1Text_Koga
	call PrintText
	jp TextScriptEnd
	
MtSilverCaveGuard1Text_Koga:
	text_far _MtSilverCaveGuard1Text_Koga
	text_end
	
MtSilverCaveGuard2Text:
	text_asm
	ld hl, MtSilverCaveGuard2Text_Done
	call PrintText
	jp TextScriptEnd
	
MtSilverCaveGuard2Text_Done:
	text_far _MtSilverCaveGuard2Text_Done
	text_end
	
MtSilverErikaText:
	text_asm
	ld hl, MtSilverErikaText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilverErikaText_Done:
	text_far _MtSilverErikaText_Done
	text_end
	
MtSilverBlaineText:
	text_asm
	ld hl, MtSilverBlaineText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilverBlaineText_Done:
	text_far _MtSilverBlaineText_Done
	text_end
	
MtSilverKogaText:
	text_asm
	ld hl, MtSilverKogaText_Done
	call PrintText
	jp TextScriptEnd
	
MtSilverKogaText_Done:
	text_far _MtSilverKogaText_Done
	text_end
	
MtSilverWeezingText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, WEEZING
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text_far _MtSilverWeezingText
	text_end
	
MtSilverSignText:
	text_far _MtSilverSignText
	text_end
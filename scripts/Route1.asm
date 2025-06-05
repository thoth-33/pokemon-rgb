Route1_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route1_ScriptPointers
	ld a, [wRoute1CurScript]
	jp CallFunctionInTable

Route1ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wRoute1CurScript], a
	ret

Route1_ScriptPointers:
	def_script_pointers
	dw_const Route1DefaultScript,        SCRIPT_ROUTE1_DEFAULT
	dw_const Route1OakStartBattleScript, SCRIPT_ROUTE1_OAK_START_BATTLE
	dw_const Route1OakAfterBattleScript, SCRIPT_ROUTE1_OAK_AFTER_BATTLE
	dw_const Route1OakExitScript,        SCRIPT_ROUTE1_OAK_EXIT
	dw_const Route1NoopScript,           SCRIPT_ROUTE1_NOOP

Route1NoopScript:
	ret

Route1DefaultScript:
	CheckEvent EVENT_PLAYER_IS_CHAMPION
	ret z
	ld hl, .PlayerCoordinatesArray
	call ArePlayerCoordsInArray
	ret nc
	ld a, SFX_STOP_ALL_MUSIC
;	ld [wNewSoundID], a
	call PlaySound
	ld c, 0 ; BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld a, [wCoordIndex]
	ldh [hSavedCoordIndex], a
	ld a, HS_ROUTE_1_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject
	call Delay3
	ld a, ROUTE1_OAK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	xor a
	ldh [hJoyHeld], a
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ldh a, [hSavedCoordIndex]
	cp $2
	jr nz, .player_standing_left
	ld de, .PlayerOnRight
	jr .move_sprite
.player_standing_left
	ld de, .PlayerOnLeft
.move_sprite
	call MoveSprite
	ld a, SCRIPT_ROUTE1_OAK_START_BATTLE
	ld [wRoute1CurScript], a
	ret

.PlayerOnRight: ; bottom coord
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
.PlayerOnLeft: ; top coord
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

.PlayerCoordinatesArray:
	dbmapcoord 10,  31
	dbmapcoord 11,  31
	db -1 ; end

Route1SetFacingDirectionScript:
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	ld a, ROUTE1_OAK
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

Route1OakStartBattleScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	call Route1SetFacingDirectionScript
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_ROUTE1_OAK
	ldh [hTextID], a
	call DisplayTextID
	call Delay3
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a

	; select which team to use during the encounter
	ld a, [wRivalStarter]
	cp STARTER2
	jr nz, .NotSquirtle
	ld a, $2 ; If rival has squirtle, you have charmander, oak gets venusaur
	jr .done
.NotSquirtle
	cp STARTER1
	jr z, .Charmander
	ld a, $3 ; If rival got neither squirtle or charmander, he got bulbasaur, you got squirtle, oak gets charizard.
	jr .done
.Charmander
	ld a, $1 ; if rival got charmander, you have bulbasuar, oak gets blastoise 
.done
	ld [wTrainerNo], a

	call Route1SetFacingDirectionScript
	ld a, SCRIPT_ROUTE1_OAK_AFTER_BATTLE
	ld [wRoute1CurScript], a
	ret

Route1OakAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route1ResetScripts
	call Route1SetFacingDirectionScript
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, TEXT_ROUTE1_OAK_AFTER
	ldh [hTextID], a
	call DisplayTextID
	ld a, ROUTE1_OAK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 11
	jr nz, .player_standing_right
	ld de, .OakWalkLeftAroundPlayerMovement
	jr .move_sprite
.player_standing_right
	ld de, .OakWalkRightAroundPlayerMovement
.move_sprite
	ld a, ROUTE1_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SFX_STOP_ALL_MUSIC
;	ld [wNewSoundID], a
	call PlaySound
	farcall Music_RivalAlternateStart
	ld a, SCRIPT_ROUTE1_OAK_EXIT
	ld [wRoute1CurScript], a
	ret

.OakWalkRightAroundPlayerMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end
.OakWalkLeftAroundPlayerMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route1OakExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_1_OAK
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OAKS_LAB_OAK_1 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_OAKS_LAB_SCIENTIST 
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ld a, SCRIPT_ROUTE1_NOOP
	ld [wRoute1CurScript], a
	ret

Route1_TextPointers:
	def_text_pointers
	dw_const Route1Youngster1Text,   TEXT_ROUTE1_YOUNGSTER1
	dw_const Route1Youngster2Text,   TEXT_ROUTE1_YOUNGSTER2
	dw_const Route1OakText,          TEXT_ROUTE1_OAK
	dw_const Route1OakAfterText,     TEXT_ROUTE1_OAK_AFTER
	dw_const Route1SignText,         TEXT_ROUTE1_SIGN

Route1Youngster1Text:
	text_asm
	CheckAndSetEvent EVENT_GOT_POTION_SAMPLE
	jr nz, .got_item
	ld hl, .MartSampleText
	call PrintText
	lb bc, POTION, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .GotPotionText
	jr .done
.bag_full
	ld hl, .NoRoomText
	jr .done
.got_item
	ld hl, .AlsoGotPokeballsText
.done
	call PrintText
	jp TextScriptEnd

.MartSampleText:
	text_far _Route1Youngster1MartSampleText
	text_end

.GotPotionText:
	text_far _Route1Youngster1GotPotionText
	sound_get_item_1
	text_end

.AlsoGotPokeballsText:
	text_far _Route1Youngster1AlsoGotPokeballsText
	text_end

.NoRoomText:
	text_far _Route1Youngster1NoRoomText
	text_end

Route1Youngster2Text:
	text_far _Route1Youngster2Text
	text_end

Route1SignText:
	text_far _Route1SignText
	text_end

Route1OakText:
	text_asm
	ld hl, .Text
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, Route1OakDefeatedText
	ld de, Route1OakVictoryText
	call SaveEndBattleTextPointers
	jp TextScriptEnd

.Text:
	text_far _Route1OakText
	text_end

Route1OakDefeatedText:
	text_far _Route1OakDefeatedText
	text_end

Route1OakVictoryText:
	text_far _Route1OakVictoryText
	text_end

Route1OakAfterText:
	text_far _Route1OakAfterText
	text_end

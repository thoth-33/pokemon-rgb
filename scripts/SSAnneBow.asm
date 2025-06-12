SSAnneBow_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SSAnne5TrainerHeaders
	ld de, SSAnneBow_ScriptPointers
	ld a, [wSSAnneBowCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSSAnneBowCurScript], a
	ret

SSAnneBow_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SSANNEBOW_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SSANNEBOW_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SSANNEBOW_END_BATTLE
	dw_const SSAnneBowOakPostBattleScript,		    SCRIPT_SSANNEBOW_OAK_POST_BATTLE
	dw_const SSAnneBowOakExitScript,		        SCRIPT_SSANNEBOW_OAK_EXIT

SSAnneBowOakPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	ret z
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_SSANNEBOW_OAK_POSTBATTLE
	ldh [hTextID], a
	call DisplayTextID
	ld a, SSANNEBOW_OAK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 6
	jr z, .player_standing_top
	ld de, .OakWalkRightMovement
	jr .move_sprite
.player_standing_top
	ld de, .OakWalkAroundMovement
.move_sprite
	ld a, SSANNEBOW_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_SSANNEBOW_OAK_EXIT
	ld [wSSAnneBowCurScript], a	
	ld [wCurMapScript], a
	ret
	
.OakWalkAroundMovement:
	db NPC_MOVEMENT_DOWN
.OakWalkRightMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end
	
SSAnneBowOakExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_SS_ANNE_BOW_OAK
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OAKS_LAB_OAK_1 
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, SCRIPT_SSANNEBOW_DEFAULT
	ld [wSSAnneBowCurScript], a	
	ret

SSAnneBow_TextPointers:
	def_text_pointers
	dw_const SSAnneBowSuperNerdText,     TEXT_SSANNEBOW_SUPER_NERD
	dw_const SSAnneBowSailor1Text,       TEXT_SSANNEBOW_SAILOR1
	dw_const SSAnneBowCooltrainerMText,  TEXT_SSANNEBOW_COOLTRAINER_M
	dw_const SSAnneBowSailor2Text,       TEXT_SSANNEBOW_SAILOR2
	dw_const SSAnneBowSailor3Text,       TEXT_SSANNEBOW_SAILOR3
	dw_const SSAnneBowOakText,           TEXT_SSANNEBOW_OAK
	dw_const SSAnneBowOakPostBattleText, TEXT_SSANNEBOW_OAK_POSTBATTLE

SSAnneBowOakText:
	text_asm	
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .SSAnneBowOakEndBattleText
	ld de, .SSAnneBowOakEndBattleText
	call SaveEndBattleTextPointers
	call Delay3
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a
	ld a, [wRivalStarter] ; select which team to use during the encounter
	cp SQUIRTLE
	jr nz, .NotSquirtle
	ld a, $2 ; If rival has squirtle, you have charmander, oak gets venusaur
	jr .done
.NotSquirtle
	cp CHARMANDER
	jr z, .Charmander
	ld a, $3 ; If rival got bulbasaur, you got squirtle, oak gets charizard.
	jr .done
.Charmander
	ld a, $1 ; if rival got charmander, you have bulbasuar, oak gets blastoise 
.done
	ld [wTrainerNo], a
	ld a, SCRIPT_SSANNEBOW_OAK_POST_BATTLE
	ld [wSSAnneBowCurScript], a
	jp TextScriptEnd
	
.PreBattleText:
	text_far _SSAnneBowOakPreBattleText
	text_end

.SSAnneBowOakEndBattleText:
	text_far _SSAnneBowOakEndBattleText
	text_end
	
SSAnneBowOakPostBattleText:
	text_far _SSAnneBowOakPostBattleText
	text_end

SSAnne5TrainerHeaders:
	def_trainers 4
SSAnne5TrainerHeader0:
	trainer EVENT_BEAT_SS_ANNE_5_TRAINER_0, 3, SSAnneBowSailor2BattleText, SSAnneBowSailor2EndBattleText, SSAnneBowSailor2AfterBattleText
SSAnne5TrainerHeader1:
	trainer EVENT_BEAT_SS_ANNE_5_TRAINER_1, 3, SSAnneBowSailor3BattleText, SSAnneBowSailor3EndBattleText, SSAnneBowSailor3AfterBattleText
	db -1 ; end

SSAnneBowSuperNerdText:
	text_far _SSAnneBowSuperNerdText
	text_end

SSAnneBowSailor1Text:
	text_far _SSAnneBowSailor1Text
	text_end

SSAnneBowCooltrainerMText:
	text_far _SSAnneBowCooltrainerMText
	text_end

SSAnneBowSailor2Text:
	text_asm
	ld hl, SSAnne5TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SSAnneBowSailor2BattleText:
	text_far _SSAnneBowSailor2BattleText
	text_end

SSAnneBowSailor2EndBattleText:
	text_far _SSAnneBowSailor2EndBattleText
	text_end

SSAnneBowSailor2AfterBattleText:
	text_far _SSAnneBowSailor2AfterBattleText
	text_end

SSAnneBowSailor3Text:
	text_asm
	ld hl, SSAnne5TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SSAnneBowSailor3BattleText:
	text_far _SSAnneBowSailor3BattleText
	text_end

SSAnneBowSailor3EndBattleText:
	text_far _SSAnneBowSailor3EndBattleText
	text_end

SSAnneBowSailor3AfterBattleText:
	text_far _SSAnneBowSailor3AfterBattleText
	text_end

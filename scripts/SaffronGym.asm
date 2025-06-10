SaffronGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, SaffronGymTrainerHeaders
	ld de, SaffronGym_ScriptPointers
	ld a, [wSaffronGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSaffronGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "SAFFRON CITY@"

.LeaderName:
	db "SABRINA@"

SaffronGymResetScripts:
	xor a ; SCRIPT_SAFFRONGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	ret

SaffronGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SAFFRONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SAFFRONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SAFFRONGYM_END_BATTLE
	dw_const SaffronGymSabrinaPostBattle,           SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	dw_const SaffronGymNoopScript,                  SCRIPT_SAFFRONGYM_NOOP

SaffronGymNoopScript:
ret

SaffronGymSabrinaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SaffronGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	CheckEvent EVENT_SABRINA_REMATCH
	jr nz, SabrinaRematchPostBattle
; fallthrough
SaffronGymSabrinaReceiveTM46Script:
	ld a, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA
	lb bc, TM_PSYWAVE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM46
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM46
	jr .gymVictory
.BagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_TM46_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_MARSHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_MARSHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_SAFFRON_GYM_TRAINER_0, EVENT_BEAT_SAFFRON_GYM_TRAINER_6

	jp SaffronGymResetScripts

SaffronGymSetFacingDirectionScript:
	ld a, [wXCoord]
	cp 8
	jr z, .player_standing_left
	cp 10
	jr z, .player_standing_right
	ld a, [wYCoord]
	cp 7
	jr z, .player_standing_top
	ld a, PLAYER_DIR_UP ;fallthrough, player standing bottom
	ld [wPlayerMovingDirection], a
	xor a ; SPRITE_FACING_DOWN
	jr .set_facing_direction
.player_standing_left
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_LEFT
	jr .set_facing_direction
.player_standing_right
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
	jr .set_facing_direction
.player_standing_top
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
.set_facing_direction
	ldh [hSpriteFacingDirection], a
	ld a, SAFFRONGYM_SABRINA
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

SabrinaRematchPostBattle:
	call UpdateSprites
	call SaffronGymSetFacingDirectionScript
	SetEvent EVENT_SABRINA_REMATCH_BEAT
	ld a, TEXT_SAFFRONGYM_REMATCH_POST_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_SAFFRON_GYM_SABRINA  
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER1F_HYPNO
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call GBFadeInFromBlack
	xor a
	ld [wJoyIgnore], a
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ld a, SCRIPT_SAFFRONGYM_NOOP
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	ret


SaffronGym_TextPointers:
	def_text_pointers
	dw_const SaffronGymSabrinaText,               TEXT_SAFFRONGYM_SABRINA
	dw_const SaffronGymChanneler1Text,            TEXT_SAFFRONGYM_CHANNELER1
	dw_const SaffronGymYoungster1Text,            TEXT_SAFFRONGYM_YOUNGSTER1
	dw_const SaffronGymChanneler2Text,            TEXT_SAFFRONGYM_CHANNELER2
	dw_const SaffronGymYoungster2Text,            TEXT_SAFFRONGYM_YOUNGSTER2
	dw_const SaffronGymChanneler3Text,            TEXT_SAFFRONGYM_CHANNELER3
	dw_const SaffronGymYoungster3Text,            TEXT_SAFFRONGYM_YOUNGSTER3
	dw_const SaffronGymYoungster4Text,            TEXT_SAFFRONGYM_YOUNGSTER4
	dw_const SaffronGymGymGuideText,              TEXT_SAFFRONGYM_GYM_GUIDE
	dw_const SaffronGymSabrinaMarshBadgeInfoText, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	dw_const SaffronGymSabrinaReceivedTM46Text,   TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM46
	dw_const SaffronGymSabrinaTM46NoRoomText,     TEXT_SAFFRONGYM_SABRINA_TM46_NO_ROOM
	dw_const SaffronGymRematchPostBattleText,     TEXT_SAFFRONGYM_REMATCH_POST_BATTLE

SaffronGymTrainerHeaders:
	def_trainers 2
SaffronGymTrainerHeader0:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_0, 3, SaffronGymChanneler1BattleText, SaffronGymChanneler1EndBattleText, SaffronGymChanneler1AfterBattleText
SaffronGymTrainerHeader1:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_1, 3, SaffronGymYoungster1BattleText, SaffronGymYoungster1EndBattleText, SaffronGymYoungster1AfterBattleText
SaffronGymTrainerHeader2:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_2, 3, SaffronGymChanneler2BattleText, SaffronGymChanneler2EndBattleText, SaffronGymChanneler2AfterBattleText
SaffronGymTrainerHeader3:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_3, 3, SaffronGymYoungster2BattleText, SaffronGymYoungster2EndBattleText, SaffronGymYoungster2AfterBattleText
SaffronGymTrainerHeader4:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_4, 3, SaffronGymChanneler3BattleText, SaffronGymChanneler3EndBattleText, SaffronGymChanneler3AfterBattleText
SaffronGymTrainerHeader5:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_5, 3, SaffronGymYoungster3BattleText, SaffronGymYoungster3EndBattleText, SaffronGymYoungster3AfterBattleText
SaffronGymTrainerHeader6:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_6, 3, SaffronGymYoungster4BattleText, SaffronGymYoungster4EndBattleText, SaffronGymYoungster4AfterBattleText
	db -1 ; end

SaffronGymSabrinaText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM46
	jr nz, .afterBeat
	call z, SaffronGymSabrinaReceiveTM46Script
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	CheckEvent EVENT_SABRINA_REMATCH_BEAT
	jr nz, .postGame
	CheckEvent EVENT_SABRINA_REMATCH
	jr nz, .SabrinaRematch
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .done
.postGame
	ld hl, .PostGameGoodLuckText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .Text
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .ReceivedMarshBadgeText
	ld de, .ReceivedMarshBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $6
	ld [wGymLeaderNo], a
	ld a, SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	ld [wSaffronGymCurScript], a
	jr .done
 .SabrinaRematch
 	ld hl, .PreBattleRematchText
 	call PrintText
 	call Delay3
 	ld hl, wStatusFlags3
 	set BIT_TALKED_TO_TRAINER, [hl]
 	set BIT_PRINT_END_BATTLE_TEXT, [hl]
 	ld hl, SaffronGymRematchDefeatedText
 	ld de, SaffronGymRematchVictoryText
 	call SaveEndBattleTextPointers
 	ld a, OPP_SABRINA
 	ld [wCurOpponent], a
 	ld a, 2
 	ld [wTrainerNo], a
	ld a, SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	ld [wSaffronGymCurScript], a
.done
	jp TextScriptEnd

.Text:
	text_far _SaffronGymSabrinaText
	text_end

.ReceivedMarshBadgeText:
	text_far _SaffronGymSabrinaReceivedMarshBadgeText
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_promptbutton
	text_end

.PostBattleAdviceText:
	text_far _SaffronGymSabrinaPostBattleAdviceText
	text_end

.PreBattleRematchText
	text_far _SaffronGymRematchPreBattleText
	text_end

.PostGameGoodLuckText
	text_far _SaffronGymSabrinaGoodLuckText
	text_end

SaffronGymRematchDefeatedText:
	text_far _SaffronGymRematchDefeatedText
	text_end

SaffronGymRematchVictoryText:
	text_far _SaffronGymRematchVictoryText
	text_end

SaffronGymRematchPostBattleText:
	text_far _SaffronGymRematchPostBattleText
	text_end

SaffronGymSabrinaMarshBadgeInfoText:
	text_far _SaffronGymSabrinaMarshBadgeInfoText
	text_end

SaffronGymSabrinaReceivedTM46Text:
	text_far _SaffronGymSabrinaReceivedTM46Text
	sound_get_item_1
	text_far _TM46ExplanationText
	text_end

SaffronGymSabrinaTM46NoRoomText:
	text_far _SaffronGymSabrinaTM46NoRoomText
	text_end

SaffronGymChanneler1Text:
	text_asm
	ld hl, SaffronGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster1Text:
	text_asm
	ld hl, SaffronGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler2Text:
	text_asm
	ld hl, SaffronGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster2Text:
	text_asm
	ld hl, SaffronGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler3Text:
	text_asm
	ld hl, SaffronGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster3Text:
	text_asm
	ld hl, SaffronGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster4Text:
	text_asm
	ld hl, SaffronGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	call PrintText
	jr .done
.afterBeat
	ld hl, .BeatSabrinaText
	call PrintText
.done
	jp TextScriptEnd

.ChampInMakingText:
	text_far _SaffronGymGuideChampInMakingText
	text_end

.BeatSabrinaText:
	text_far _SaffronGymGuideBeatSabrinaText
	text_end

SaffronGymChanneler1BattleText:
	text_far _SaffronGymChanneler1BattleText
	text_end

SaffronGymChanneler1EndBattleText:
	text_far _SaffronGymChanneler1EndBattleText
	text_end

SaffronGymChanneler1AfterBattleText:
	text_far _SaffronGymChanneler1AfterBattleText
	text_end

SaffronGymYoungster1BattleText:
	text_far _SaffronGymYoungster1BattleText
	text_end

SaffronGymYoungster1EndBattleText:
	text_far _SaffronGymYoungster1EndBattleText
	text_end

SaffronGymYoungster1AfterBattleText:
	text_far _SaffronGymYoungster1AfterBattleText
	text_end

SaffronGymChanneler2BattleText:
	text_far _SaffronGymChanneler2BattleText
	text_end

SaffronGymChanneler2EndBattleText:
	text_far _SaffronGymChanneler2EndBattleText
	text_end

SaffronGymChanneler2AfterBattleText:
	text_far _SaffronGymChanneler2AfterBattleText
	text_end

SaffronGymYoungster2BattleText:
	text_far _SaffronGymYoungster2BattleText
	text_end

SaffronGymYoungster2EndBattleText:
	text_far _SaffronGymYoungster2EndBattleText
	text_end

SaffronGymYoungster2AfterBattleText:
	text_far _SaffronGymYoungster2AfterBattleText
	text_end

SaffronGymChanneler3BattleText:
	text_far _SaffronGymChanneler3BattleText
	text_end

SaffronGymChanneler3EndBattleText:
	text_far _SaffronGymChanneler3EndBattleText
	text_end

SaffronGymChanneler3AfterBattleText:
	text_far _SaffronGymChanneler3AfterBattleText
	text_end

SaffronGymYoungster3BattleText:
	text_far _SaffronGymYoungster3BattleText
	text_end

SaffronGymYoungster3EndBattleText:
	text_far _SaffronGymYoungster3EndBattleText
	text_end

SaffronGymYoungster3AfterBattleText:
	text_far _SaffronGymYoungster3AfterBattleText
	text_end

SaffronGymYoungster4BattleText:
	text_far _SaffronGymYoungster4BattleText
	text_end

SaffronGymYoungster4EndBattleText:
	text_far _SaffronGymYoungster4EndBattleText
	text_end

SaffronGymYoungster4AfterBattleText:
	text_far _SaffronGymYoungster4AfterBattleText
	text_end

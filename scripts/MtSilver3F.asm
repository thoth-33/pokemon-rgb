MtSilver3F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtSilver3FTrainerHeaders
	ld de, MtSilver3F_ScriptPointers
	ld a, [wMtSilver3FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtSilver3FCurScript], a
	ret

MtSilver3F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_MT_SILVER3F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_MT_SILVER3F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_MT_SILVER3F_END_BATTLE
	dw_const MtSilver3FGiovanniPostBattle,		    SCRIPT_MT_SILVER3F_GIOVANNI_POST_BATTLE

MtSilver3FGiovanniPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	ret z
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, TEXT_MT_SILVER3F_GIOVANNI_POSTBATTLE
	ldh [hTextID], a
	SetEvents EVENT_GIOVANNI_REMATCH_BEAT
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_MT_SILVER3F_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER3F_ROCKET1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER3F_ROCKET2
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_MT_SILVER3F_ROCKET3
	ld [wMissableObjectIndex], a
	predef HideObject
	CheckEventReuseA EVENT_GOT_TM27
	jr nz, .skip ; in-case you never got the TM
	ld a, HS_VIRIDIAN_GYM_GIOVANNI
	ld [wMissableObjectIndex], a
	predef ShowObject
.skip
	call UpdateSprites
	call GBFadeInFromBlack
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MT_SILVER3F_DEFAULT
	ld [wMtSilver3FCurScript], a
	ld [wCurMapScript], a
	ret

MtSilver3F_TextPointers:
	def_text_pointers
	dw_const MtSilver3FGiovanniText,           TEXT_MT_SILVER3F_GIOVANNI
	dw_const MtSilver3FRocket1Text,            TEXT_MT_SILVER3F_ROCKET1
	dw_const MtSilver3FRocket2Text,            TEXT_MT_SILVER3F_ROCKET2
	dw_const MtSilver3FRocket3Text,            TEXT_MT_SILVER3F_ROCKET3
	dw_const MtSilver3FGiovanniPostBattleText, TEXT_MT_SILVER3F_GIOVANNI_POSTBATTLE
	
MtSilver3FGiovanniText:
	text_asm
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .MtSilver3FGiovanniEndBattleText
	ld de, .MtSilver3FGiovanniEndBattleText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_MT_SILVER3F_GIOVANNI_POST_BATTLE
	ld [wMtSilver3FCurScript], a
	jp TextScriptEnd
	
.PreBattleText:
	text_far _MtSilver3FGiovanniPreBattleText
	text_end

.MtSilver3FGiovanniEndBattleText:
	text_far _MtSilver3FGiovanniEndBattleText
	text_end
	
MtSilver3FGiovanniPostBattleText:
	text_far _MtSilver3FGiovanniPostBattleText
	text_end
	
MtSilver3FTrainerHeaders:
	def_trainers 2
MtSilver3FTrainerHeader0:
	trainer EVENT_BEAT_MT_SILVER3F_ROCKET1, 2, MtSilver3FRocket1BattleText, MtSilver3FRocket1EndBattleText, MtSilver3FRocket1AfterBattleText
MtSilver3FTrainerHeader1:
	trainer EVENT_BEAT_MT_SILVER3F_ROCKET2, 2, MtSilver3FRocket2BattleText, MtSilver3FRocket2EndBattleText, MtSilver3FRocket2AfterBattleText
MtSilver3FTrainerHeader2:
	trainer EVENT_BEAT_MT_SILVER3F_ROCKET3, 2, MtSilver3FRocket3BattleText, MtSilver3FRocket3EndBattleText, MtSilver3FRocket3AfterBattleText
	db -1 ; end	
	
MtSilver3FRocket1Text:
	text_asm
	ld hl, MtSilver3FTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtSilver3FRocket1BattleText:
	text_far _MtSilver3FRocket1BattleText
	text_end

MtSilver3FRocket1EndBattleText:
	text_far _MtSilver3FRocket1EndBattleText
	text_end

MtSilver3FRocket1AfterBattleText:
	text_far _MtSilver3FRocket1AfterBattleText
	text_end
	
MtSilver3FRocket2Text:
	text_asm
	ld hl, MtSilver3FTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtSilver3FRocket2BattleText:
	text_far _MtSilver3FRocket2BattleText
	text_end

MtSilver3FRocket2EndBattleText:
	text_far _MtSilver3FRocket2EndBattleText
	text_end

MtSilver3FRocket2AfterBattleText:
	text_far _MtSilver3FRocket2AfterBattleText
	text_end
	
MtSilver3FRocket3Text:
	text_asm
	ld hl, MtSilver3FTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtSilver3FRocket3BattleText:
	text_far _MtSilver3FRocket3BattleText
	text_end

MtSilver3FRocket3EndBattleText:
	text_far _MtSilver3FRocket3EndBattleText
	text_end

MtSilver3FRocket3AfterBattleText:
	text_far _MtSilver3FRocket3AfterBattleText
	text_end
CinnabarVolcanoTop_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call EnableAutoTextBoxDrawing
	ld hl, CinnabarVolcanoTopTrainerHeaders
	ld de, CinnabarVolcanoTop_ScriptPointers
	ld a, [wCinnabarVolcanoTopCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCinnabarVolcanoTopCurScript], a
	ret

CinnabarVolcanoTop_ScriptPointers:
	def_script_pointers
	dw_const CinnabarVolcanoTopDefaultScript,            SCRIPT_CINNABARVOLCANOTOP_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, 	 SCRIPT_CINNABARVOLCANOTOP_START_BATTLE
	dw_const EndTrainerBattle,                     		 SCRIPT_CINNABARVOLCANOTOP_END_BATTLE


CinnabarVolcanoTop_TextPointers:
	def_text_pointers
	dw_const CinnabarVolcanoTopMoltresText,      TEXT_CINNABARVOLCANOTOP_MOLTRES

CinnabarVolcanoTopTrainerHeaders:
	def_trainers
MoltresTrainerHeader:
	trainer EVENT_BEAT_MOLTRES, 0, CinnabarVolcanoTopMoltresBattleText, CinnabarVolcanoTopMoltresBattleText, CinnabarVolcanoTopMoltresBattleText
	db -1 ; end

CinnabarVolcanoTopMoltresText:
	text_asm
	ld hl, MoltresTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

CinnabarVolcanoTopMoltresBattleText:
	text_far _CinnabarVolcanoTopMoltresBattleText
	text_asm
	ld a, MOLTRES
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

CinnabarVolcanoTopDefaultScript:
	ret
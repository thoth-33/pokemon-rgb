Route1_Script:
	jp EnableAutoTextBoxDrawing
	ld hl, Route1_ScriptPointers
	ld a, [wRoute1CurScript]
	jp CallFunctionInTable

Route1_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route1_TextPointers:
	def_text_pointers
	dw_const Route1Youngster1Text, TEXT_ROUTE1_YOUNGSTER1
	dw_const Route1Youngster2Text, TEXT_ROUTE1_YOUNGSTER2
	dw_const Route1OakText,        TEXT_OAK
	dw_const Route1SignText,       TEXT_ROUTE1_SIGN

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
	ld hl, OakBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	
	call Delay3
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a
	; select which team to use during the encounter
	ld a, [wRivalStarter]
	cp $B1
	jr nz, .NotSquirtle
	ld a, $2 ; If rival has squirtle, you have charmander, oak gets venusaur
	jr .done
.NotSquirtle
	cp $B0
	jr z, .Charmander
	ld a, $3 ; If rival got neither squirtle or charmander, he got bulbasaur, you got squirtle, oak gets charizard.
	jr .done
.Charmander
	ld a, $1 ; if rival got charmander, you have bulbasuar, oak gets blastoise 
.done
	ld [wTrainerNo], a

	ld a, $2
	ld [wRoute1CurScript], a
	
	ld hl, OakDefeatedText
	ld de, OakWonText
	call SaveEndBattleTextPointers
	ld a, HS_ROUTE_1_OAK
	ld [wMissableObjectIndex], a
	predef HideObject
	jp TextScriptEnd

OakBeforeBattleText:
	text_far _OakBeforeBattleText
	text_end

OakDefeatedText:
	text_far _OakDefeatedText
	text_end

OakWonText:
	text_far _OakWonText
	text_end

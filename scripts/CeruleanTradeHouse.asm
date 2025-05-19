CeruleanTradeHouse_Script:
	jp EnableAutoTextBoxDrawing

CeruleanTradeHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanTradeHouseGrannyText,    TEXT_CERULEANTRADEHOUSE_GRANNY
	dw_const CeruleanTradeHouseGamblerText,   TEXT_CERULEANTRADEHOUSE_GAMBLER
	dw_const CeruleanTradeHouseGirlText,      TEXT_CERULEANTRADEHOUSE_GIRL
	dw_const CeruleanTradeHouseBulbasaurText, TEXT_CERULEANTRADEHOUSE_BULBASAUR
	dw_const CeruleanTradeHouseOddishText,    TEXT_CERULEANTRADEHOUSE_ODDISH
	dw_const CeruleanTradeHouseSandshrewText, TEXT_CERULEANTRADEHOUSE_SANDSHREW

CeruleanTradeHouseGrannyText:
	text_far _CeruleanTradeHouseGrannyText
	text_end

CeruleanTradeHouseGamblerText:
	text_asm
	ld a, TRADE_FOR_LOLA
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd
	
CeruleanTradeHouseGirlText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	CheckEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
	jr nz, .AlreadyHasBulbasuar
	ld hl, CeruleanHouse1Text_Melanie1
	call PrintText
	ld a, [wRivalStarter]
	cp $B0 ; Rival got Charmander
	jr z, .EndScript
	ld hl, CeruleanHouse1Text_Melanie2
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .RefuseBulbasuar
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, BULBASAUR
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, BULBASAUR, 10
	call GivePokemon
	jr nc, .EndScript
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, CeruleanHouse1Text_Melanie3
	call PrintText
	ld a, HS_CERULEAN_BULBASAUR
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
.EndScript
	jp TextScriptEnd

.RefuseBulbasuar
	ld hl, CeruleanHouse1Text_Melanie5
	call PrintText
	jp TextScriptEnd
	
.AlreadyHasBulbasuar
	ld hl, CeruleanHouse1Text_Melanie4
	call PrintText
	jp TextScriptEnd
	
CeruleanHouse1Text_Melanie1:
	text_far MelanieText1
	text_waitbutton
	text_end

CeruleanHouse1Text_Melanie2:
	text_far MelanieText2
	text_end

CeruleanHouse1Text_Melanie3:
	text_far MelanieText3
	text_waitbutton
	text_end

CeruleanHouse1Text_Melanie4:
	text_far MelanieText4
	text_waitbutton
	text_end

CeruleanHouse1Text_Melanie5:
	text_far MelanieText5
	text_waitbutton
	text_end
	
MelanieText1::
	text "I take care of"
	line "injured #MON."

	para "I nursed this"
	line "BULBASAUR back to"
	cont "health."

	para "It needs a good"
	line "trainer to take"
	cont "care of it now.@"
	text_end

MelanieText2::
	text "I know! Would you"
	line "take care of this"
	cont "BULBASAUR?"
	done

MelanieText3::
	text "Please take care"
	line "of BULBASAUR!@"
	text_end

MelanieText4::
	text "Is BULBASAUR"
	line "doing well?@"
	text_end

MelanieText5::
	text "Oh..."
	line "That's too bad...@"
	text_end
	
CeruleanTradeHouseBulbasaurText:
	text_far MelanieBulbasaurText
	text_asm
	ld a, BULBASAUR
	call PlayCry
	jp TextScriptEnd

CeruleanTradeHouseOddishText:
	text_far MelanieOddishText
	text_asm
	ld a, ODDISH
	call PlayCry
	jp TextScriptEnd

CeruleanTradeHouseSandshrewText:
	text_far MelanieSandshrewText
	text_asm
	ld a, SANDSHREW
	call PlayCry
	jp TextScriptEnd
	
MelanieBulbasaurText::
	text "BULBASAUR: Bubba!"
	line "Zoar!@"
	text_end

MelanieOddishText::
	text "ODDISH: Orddissh!@"
	text_end

MelanieSandshrewText::
	text "SANDSHREW: Pikii!@"
	text_end
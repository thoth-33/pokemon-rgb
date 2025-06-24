DisplayPokemonCenterDialogue_::
	call SaveScreenTilesToBuffer1 ; save screen
	ld a, [wDifficulty]
	and a
	ld hl, PokemonCenterWelcomeHardText
	jr nz, .loadWelcome
	ld hl, PokemonCenterWelcomeText
.loadWelcome
	call PrintText
	ld hl, wStatusFlags4
	bit BIT_USED_POKECENTER, [hl]
	set BIT_UNKNOWN_4_1, [hl]
	set BIT_USED_POKECENTER, [hl]
	jr nz, .skipShallWeHealYourPokemon
	ld hl, ShallWeHealYourPokemonText
	call PrintText
.skipShallWeHealYourPokemon

	; display cash on hand
	ld a, [wDifficulty]
	and a
	jr z, .skipMoney
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
.skipMoney

	call YesNoChoicePokeCenter ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .declinedHealing ; if the player chose No

	; have to pay on hard mode
	ld a, [wDifficulty]
	and a
	jr z, .startHeal

	; check if we can afford it
	xor a
	ldh [hMoney], a
	ldh [hMoney + 2], a
	ld a, $5
	ldh [hMoney + 1], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	
	; cant afford, heal anyway
	ld hl, PokemonCenterCantAffordText
	call PrintText
	xor a
	ld [wPlayerMoney], a
	ld [wPlayerMoney + 1], a
	ld [wPlayerMoney + 2], a
	jr .startHeal
	
	; can afford, take money
.enoughMoney
	xor a
	ld [wPriceTemp], a
	ld [wPriceTemp + 2], a
	ld a, $5
	ld [wPriceTemp + 1], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef

.startHeal
	call SetLastBlackoutMap
	call LoadScreenTilesFromBuffer1 ; restore screen

	; update money display
	ld a, [wDifficulty]
	and a
	jr z, .skipMoneyUpdate
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
.skipMoneyUpdate

	ld hl, NeedYourPokemonText
	call PrintText
	ld a, $18
	ld [wSprite01StateData1ImageIndex], a ; make the nurse turn to face the machine
	call Delay3
	predef HealParty
	farcall AnimateHealingMachine ; do the healing machine animation
	xor a
	ld [wMusicFade], a
;	ld a, [wAudioSavedROMBank]
;	ld [wAudioROMBank], a
	ld a, [wMapMusicSoundID]
	ld [wLastMusicSoundID], a
;	ld [wNewSoundID], a
	call PlayMusic
	ld hl, PokemonFightingFitText
	call PrintText
	ld a, $14
	ld [wSprite01StateData1ImageIndex], a ; make the nurse bow
	ld c, a
	call DelayFrames
	jr .done
.declinedHealing
	call LoadScreenTilesFromBuffer1 ; restore screen
.done
	ld hl, PokemonCenterFarewellText
	call PrintText
	jp UpdateSprites

PokemonCenterWelcomeText:
	text_far _PokemonCenterWelcomeText
	text_end
	
PokemonCenterWelcomeHardText:
	text_far _PokemonCenterWelcomeHardText
	text_end

PokemonCenterCantAffordText:
	text_far _PokemonCenterCantAffordText
	text_end

ShallWeHealYourPokemonText:
	text_pause
	text_far _ShallWeHealYourPokemonText
	text_end

NeedYourPokemonText:
	text_far _NeedYourPokemonText
	text_end

PokemonFightingFitText:
	text_far _PokemonFightingFitText
	text_end

PokemonCenterFarewellText:
	text_pause
	text_far _PokemonCenterFarewellText
	text_end

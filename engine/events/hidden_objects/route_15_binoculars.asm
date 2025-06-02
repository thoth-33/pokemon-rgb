Route15GateLeftBinoculars:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	call EnableAutoTextBoxDrawing
	CheckEvent EVENT_BEAT_ARTICUNO
	jr nz, .ArticunoFought
	tx_pre Route15UpstairsBinocularsText
	ld a, ARTICUNO
	ld [wCurPartySpecies], a
	call PlayCry
	ld d, PAL_ARTICUNO
	jp DisplayMonFrontSpriteInBox
.ArticunoFought
	tx_pre Route15UpstairsBinocularsText2
	ld a, DEWGONG
	ld [wCurPartySpecies], a
	call PlayCry
	ld d, PAL_DEWGONG
	jp DisplayMonFrontSpriteInBox

Route15UpstairsBinocularsText::
	text_far _Route15UpstairsBinocularsText
	text_end

Route15UpstairsBinocularsText2::
	text_far _Route15UpstairsBinocularsText2
	text_end
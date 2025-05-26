; Helper functions for oak intro

GetNidorinoPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_GLOOM
ELSE
	ld a, PAL_GREENMON
ENDC
	jr GotPalID

GetRedPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, [wPlayerGender]
	and a
	jr z, .boyOak
	ld a, PAL_ERIKA
	jr .girlOak
.boyOak
	ld a, PAL_HERO
.girlOak
ELSE
	ld a, PAL_REDMON
ENDC
	jr GotPalID

GetRivalPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_GARY1
ELSE
	ld a, PAL_MEWMON
ENDC
	jr GotPalID

GotPalID:
	ld e, 0
	ld d, a

	ld a, 2
	ldh [rSVBK], a
	CALL_INDIRECT LoadSGBPalette
	xor a
	ldh [rSVBK], a
	ret


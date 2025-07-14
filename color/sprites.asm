LoadOverworldSpritePalettes:
	ldh a, [rSVBK]
	ld b, a
	xor a
	ldh [rSVBK], a
	push bc
	; Does the map we're on use dark/night palettes?
	; Load the matching Object Pals if so
	ld a, [wCurMapTileset]
	ld hl, SpritePalettesNite
	cp CAVERN
	jr z, .gotPaletteList
	; If it is the Pokemon Center, load different pals for the Heal Machine to flash
	ld hl, SpritePalettesPokecenter
	cp POKECENTER
	jr z, .gotPaletteList
	ld a, [wCurMap]
	cp INDIGO_PLATEAU_LOBBY
	jr z, .gotPaletteList
	cp WARDENS_HOUSE
	jr z, .gotPaletteList
	; If not, load the normal Object Pals
	ld hl, SpritePalettes
.gotPaletteList
	pop bc
	ld a, b
	ldh [rSVBK], a
	jr LoadSpritePaletteData

LoadAttackSpritePalettes:
	ld hl, AttackSpritePalettes

LoadSpritePaletteData:
	ldh a, [rSVBK]
	ld b, a
	ld a, 2
	ldh [rSVBK], a
	push bc

	ld de, W2_SprPaletteData
	ld b, $40
.sprCopyLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .sprCopyLoop
	ld a, 1
	ld [W2_ForceOBPUpdate], a

	pop af
	ldh [rSVBK], a
	ret

; Set an overworld sprite's colors
; On entering, A contains the flags (without a color palette) and de is the destination.
; This is called in the middle of a loop in engine/overworld/oam.asm, once per sprite.
ColorOverworldSprite::
	push af
	push bc
	push de
	and $f8
	ld b, a

	ldh a, [hSpriteOffset2]
	ld e, a
	ld d, wSpriteStateData1 >> 8
	ld a, [de] ; Load A with picture ID
	dec a

	ld de, SpritePaletteAssignments
	jr z, .colorHero ; pulls operation out of loop for hero sprite
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [de] ; Get the picture ID's palette

	; If it's 8, that means no particular palette is assigned
	cp SPR_PAL_RANDOM
	jr nz, .norandomColor

	; Bill is always brown
	ld a, [wCurMap]
	cp BILLS_HOUSE
	ld a, SPR_PAL_BROWN
	jr z, .norandomColor

	; This is a (somewhat) random but consistent color
	ldh a, [hSpriteOffset2]
	swap a
.randomloop
	cp 6
	jr c, .norandomColor
	sub 6
	jr .randomloop

.norandomColor

	pop de
	or b
	ld [de], a
	inc hl
	inc e
	pop bc
	pop af
	ret
	
.colorHero
	ld a, [wPlayerFlying]
	and a
	jr nz, .flying
	ld a, [wWalkBikeSurfState]
	cp a, 2
	jr z, .surfing
	ld a, [wPlayerGender]
	and a
IF DEF(_BLUE)
	ld a, SPR_PAL_BLUE
ELSE ; _RED
	ld a, SPR_PAL_ORANGE
ENDC
	jr z, .norandomColor
IF DEF(_BLUE)
	ld a, SPR_PAL_YELLOW
ELSE
	ld a, SPR_PAL_GREEN
ENDC
	jr .norandomColor
.surfing
	ld a, SPR_PAL_EMOJI
    jr .norandomColor
.flying
	ld a, SPR_PAL_BROWN
    jr .norandomColor
	
; Color the Party menu pokemon sprites
LoadSinglePartySpritePalette::
; Load a single sprite palette
	ld a, [wMonPartySpriteSpecies]
	ld b, 0
	call GetPartySpritePalette
	ld d, a
	xor a
	ld e, a
	ld [wPartySpritePaletteSlot], a
	call LoadMenuPalette_Sprite
	ld a, 2
	ldh [rSVBK], a
	ld [W2_ForceOBPUpdate], a
	xor a
	ldh [rSVBK], a
	ret

LoadPartyMenuSpritePalettes::
; Load the party sprites palettes	
	ld hl,PartySpritePalettes
	call LoadSpritePaletteData
	ld a, %11100100
	ldh [rOBP1], a
	ret

FindPartySpritePalette::
	ld a, [hPartyMonIndex]
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
 	add hl, bc
	ld a, [hl]
	call GetPartySpritePalette
	ld [wPartySpritePaletteSlot], a
	ret

GetPartySpritePalette:
	ld [wPokedexNum], a ; Store a in wram to be used in the function
	predef IndexToPokedex ; Convert ID to Pokedex ID
	ld a, [wPokedexNum] ; Get the result of the function
	cp 152 ; check for and ID higher than Mew's
	jr c, .notAboveMew ; Jump if not higher than Mew's
	xor a ; if higher than Mew's then give ID 0 so that purple palette is assigned
.notAboveMew
	ld hl, MonMenuIconPals
	ld b, 0
	ld c, a ; Add the pokemon pokedex ID which is used as a pointer in the palette assignment list
	add hl, bc
	ld a, [hl] ; Load pokemon assigned palette
	ret

; This is called whenever [wUpdateSpritesEnabled] != 1 (overworld sprites not enabled?).
;
; This sometimes does occur on the overworld, such as when exclamation marks appear, and
; when trees are being cut or boulders are being moved. Though, when in the overworld,
; W2_SpritePaletteMap is all blanked out (set to 9) except for the exclamation mark tile,
; so this function usually won't do anything.
;
; This colorizes: attack sprites, party menu, exclamation mark, trades, perhaps more?
ColorNonOverworldSprites::
	ld a, 2
	ldh [rSVBK], a

	ld hl, wShadowOAM
	ld b, 40

.spriteLoop
	inc hl
	inc hl
	ld a, [hli] ; tile
	ld e, a
	ld d, W2_SpritePaletteMap >> 8
	ld a, [de]
	cp 8 ; if 8, colorize based on attack type
	jr z, .getAttackType
	cp 9 ; if 9, do not colorize (use whatever palette it's set to already)
	jr z, .nextSprite
	cp 10 ; if 10 (used in game freak intro), color based on sprite number
	jr z, .gameFreakIntro
	jr .setPalette ; Otherwise, use the value as-is

.gameFreakIntro: ; The stars under the logo all get different colors
	ld a, b
	and 3
	add 4
	jr .setPalette

.getAttackType
	push hl

	; Load animation (move) being used
	xor a
	ldh [rSVBK], a
	ld a, [wAnimationID]
	ld d, a
	ld a, 2
	ldh [rSVBK], a

	; If the absorb animation is playing, it's always green. (Needed for leech seed)
	ld a, d
	cp ABSORB
	ld a, GRASS
	jr z, .gotType

	; Make stun spore and solarbeam yellow, despite being grass moves
	ld a, d
	cp STUN_SPORE
	ld a, ELECTRIC
	jr z, .gotType
	ld a, d
	cp SOLARBEAM
	ld a, ELECTRIC
	jr z, .gotType

	; Make tri-attack yellow, despite being a normal move
	ld a, d
	cp TRI_ATTACK
	ld a, ELECTRIC
	jr z, .gotType

	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn
	ld a, [wEnemyMoveType] ; Enemy move type
	jr .gotType
.playersTurn
	ld a, [wPlayerMoveType] ; Move type
.gotType
	ld hl, TypeColorTable
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	pop hl

.setPalette
	ld c, a
	ld a, $f8
	and [hl]
	or c
	ld [hl], a

.nextSprite
	inc hl
	dec b
	jr nz, .spriteLoop

.end
	xor a
	ldh [rSVBK], a
	ret

; Called whenever an animation plays in-battle. There are two animation tilesets, each
; with its own palette.
LoadAnimationTilesetPalettes:
	push de
	ld a, [wWhichBattleAnimTileset] ; Animation tileset (0-2)
	ld c, a
	ld a, 2
	ldh [rSVBK], a

	xor a
	ld [W2_UseOBP1], a

	call LoadAttackSpritePalettes

	; Indices 0 and 2 both refer to "AnimationTileset1", just different amounts of it.
	; 0 is in-battle, 2 is during a trade.
	; Index 1 refers to "AnimationTileset2".
	ld a, c
	cp 1
	ld hl, AnimationTileset2Palettes
	jr z, .gotPalette
	ld hl, AnimationTileset1Palettes
.gotPalette
	ld de, W2_SpritePaletteMap
	ld b, $80
.copyLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec b
	jr nz, .copyLoop

	;Per-ball colors for pokeballs
	ld a, c
	and a		;check if c == 0
	jr nz, .notBall
	ld a, [wCurItem]
	cp SAFARI_BALL
	ld b, ATK_PAL_GREEN
	jr z, .gotColor
 	cp POKE_BALL
	ld b, ATK_PAL_RED
	jr z, .gotColor
	cp GREAT_BALL
	ld b, ATK_PAL_BLUE
	jr z, .gotColor
	cp ULTRA_BALL
	ld b, ATK_PAL_GREY
	jr z, .gotColor
	ld b, ATK_PAL_PURPLE ;masterball color
.gotColor
	ld a, b
	ld [W2_SpritePaletteMap + $33], a
	ld [W2_SpritePaletteMap + $43], a
	ld [W2_SpritePaletteMap + $37], a
	ld [W2_SpritePaletteMap + $47], a
	ld [W2_SpritePaletteMap + $38], a
	ld [W2_SpritePaletteMap + $48], a
.notBall

	; If in a trade, some of the tiles near the end are different. Override some tiles
	; for the link cable, and replace the "purple" palette to match the exact color of
	; the link cable.
	ld a, c
	cp 2
	jr nz, .done

	; Replace ATK_PAL_PURPLE with PAL_MEWMON
	ld d, PAL_MEWMON
	ld e, ATK_PAL_PURPLE
	call LoadSGBPalette_Sprite

	; Set the link cable sprite tiles
	ld a, ATK_PAL_PURPLE
	ld hl, W2_SpritePaletteMap + $7e
	ld [hli], a
	ld [hli], a

.done
	ld a, 1
	ld [W2_ForceOBPUpdate], a

	xor a
	ldh [rSVBK], a

	pop de
	ret


; Set all sprite palettes to not be colorized by "ColorNonOverworldSprites".
ClearSpritePaletteMap:
	ldh a, [rSVBK]
	ld b, a
	ld a, 2
	ldh [rSVBK], a
	push bc

	ld hl, W2_SpritePaletteMap
	ld b, $0 ; $100
	ld a, 9
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	pop af
	ldh [rSVBK], a
	ret

AnimationTileset1Palettes:
	INCBIN "color/data/animtileset1palettes.bin"

AnimationTileset2Palettes:
	INCBIN "color/data/animtileset2palettes.bin"

TypeColorTable: ; Used for a select few sprites to be colorized based on attack type
	table_width 1, TypeColorTable
	db 0 ; NORMAL EQU $00
	db 0 ; FIGHTING EQU $01
	db 0 ; FLYING EQU $02
	db 7 ; POISON EQU $03
	db 3 ; GROUND EQU $04
	db 3 ; ROCK EQU $05
	db 0
	db 5 ; BUG EQU $07
	db 7 ; GHOST EQU $08
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2 ; FIRE EQU $14
	db 1 ; WATER EQU $15
	db 5 ; GRASS EQU $16
	db 4 ; ELECTRIC EQU $17
	db 7 ; PSYCHIC EQU $18
	db 6 ; ICE EQU $19
	db 1 ; DRAGON EQU $1A
	assert_table_length NUM_TYPES

INCLUDE "color/sprite_pals.asm"
INCLUDE "color/menu_icon_pals.asm"
INCLUDE "color/data/spritepalettes.asm"

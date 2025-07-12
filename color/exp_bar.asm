DEF EXP_BAR_START EQU $90
DEF EXP_BAR_END   EQU $98

AnimateEXPBarAgain:
	call LoadMonData
	call IsCurrentMonBattleMon
	ret nz
	xor a
	ld [wEXPBarPixelLength], a
	hlcoord 17, 11
	ld a, EXP_BAR_START
	ld c, TILE_WIDTH
.loop
	ld [hld], a
	dec c
	jr nz, .loop
AnimateEXPBar:
	call LoadMonData
	call IsCurrentMonBattleMon
	ret nz
	ld d, MAX_LEVEL
	ld a, [wDifficulty] ; Check if player is on hard mode
	and a
	jr z, .next ; no level caps if not on hard mode
	callfar GetLevelCap
	ld a, [wMaxLevel]
	ld d, a
.next	
	ld a, [wBattleMonLevel]
	cp d
	ret z
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	callfar CalcEXPBarPixelLength
	ld hl, wEXPBarPixelLength
	ld a, [hl]
	ld b, a
	ldh a, [hQuotient + 3]
	ld [hl], a
	sub b
	jr z, .done
	ld b, a
	ld c, TILE_WIDTH
	hlcoord 17, 11
.loop1
	ld a, [hl]
	cp EXP_BAR_END
	jr nz, .loop2
	dec hl
	dec c
	jr z, .done
	jr .loop1
.loop2
	inc a
	ld [hl], a
	call DelayFrame
	dec b
	jr z, .done
	jr .loop1
.done
	ld bc, TILE_WIDTH
	hlcoord 10, 11
	ld de, wTileMapBackup + 10 + 11 * 20
	call CopyData
	ld c, $20
	jp DelayFrames

KeepEXPBarFull:
	call IsCurrentMonBattleMon
	ret nz
	ld a, [wEXPBarKeepFullFlag]
	set 0, a
	ld [wEXPBarKeepFullFlag], a
	ld a, [wCurEnemyLevel]
	ret

IsCurrentMonBattleMon:
	ld a, [wPlayerMonNumber]
	ld b, a
	ld a, [wWhichPokemon]
	cp b
	ret

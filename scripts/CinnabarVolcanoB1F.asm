CinnabarVolcanoB1F_Script:
	call EnableAutoTextBoxDrawing
	; Check if the current map matches the last visited map
	ld a, [wCurMap]
	ld hl, wLastMap
	cp [hl]
	jr nz, .replaceTiles	
	; Run again after a battle
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	
.replaceTiles ; Set variables to avoid repeated runs
	ld a, [wCurMap]
	ld [wLastMap], a
	ld hl, wCurrentMapScriptFlags
	res BIT_CUR_MAP_LOADED_1, [hl]
    ld a, 1
    ld [wSkipRedraw], a

	ld a, $85
	ld [wNewTileBlockID], a
	CheckEvent EVENT_VOLCANO_BOULDER1_DOWN_HOLE
	jr z, .skip1
	ld b, 13
	ld c, 10
	predef ReplaceTileBlock
.skip1
	CheckEvent EVENT_VOLCANO_BOULDER2_DOWN_HOLE
	jr z, .skip2
	ld b, 11
	ld c,  2
	predef ReplaceTileBlock	
.skip2
	ld a, $84
	ld [wNewTileBlockID], a
	CheckEvent EVENT_VOLCANO_BOULDER3_DOWN_HOLE
	jr z, .skip3
	ld b,  6
	ld c,  1
	predef ReplaceTileBlock
.skip3
	CheckEvent EVENT_VOLCANO_BOULDER4_DOWN_HOLE
	jr z, .skip4
	ld b,  5
	ld c, 15
	predef ReplaceTileBlock
.skip4
	xor a
    ld [wSkipRedraw], a
	jpfar RedrawMapView
	
CinnabarVolcanoB1F_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,             TEXT_CINNABARVOLCANOB1F_MAX_ETHER
	dw_const PickUpItemText,             TEXT_CINNABARVOLCANOB1F_X_SPECIAL
	dw_const CinnabarVolcanoB1FSignText, TEXT_CINNABARVOLCANOB1F_SIGN

CinnabarVolcanoB1FSignText:
	text_far _CinnabarVolcanoB1FSignText
	text_end	
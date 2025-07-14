ShowMoveInfo:
	; read the new move's info
	ld a, [wMoveNum]
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld a, [wMoveNum]
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wBuffer
	ld a, BANK(Moves)
	call FarCopyData
	; bold P (for PP)
	ld de, PTile
	ld hl, vChars2 tile $72
	lb bc, BANK(PTile), 1
	call CopyVideoDataDouble
	; add a pop-up with the new move's info
	hlcoord 0, 0
	lb bc, 4, 18
	call TextBoxBorder
	ld a, 3
	call HidePartySprites
	; show the move's name
	hlcoord 2, 2
	ld de, wStringBuffer
	call PlaceString
	; show learnmon's name and learns label
	hlcoord 2, 1
	ld de, wLearnMoveMonName	
	call PlaceString
	; find name length
	ld b, NAME_LENGTH
	ld hl, wLearnMoveMonName
.loop
	ld a, [hli]
	cp "@"
	jr z, .foundLength
	dec b
	jr nz, .loop
.foundLength
	ld a, NAME_LENGTH
	sub b ; a = NAME_LENGTH - b = actual length
	ld c, a
	ld b, 0
	hlcoord 2, 1
	add hl, bc
	ld de, LearnLabelText
	call PlaceString
	; PP label
	hlcoord 2, 4
	ld de, MovePPLabel
	call PlaceString
	; Pwr label
	hlcoord 11, 3
	ld de, MovePwrLabel
	call PlaceString
	; Acc label
	hlcoord 11, 4
	ld de, MoveAccLabel
	call PlaceString
	; place the move's type
	hlcoord 2, 3
	predef PrintBufferedMoveType
	; place the move's power
	hlcoord 15, 3
	ld de, wBuffer + 2
	ld a, [de]
	cp 1
	jr z, .nullString
	and a
	jr z, .nullString
	jr .notZero1
.nullString
	ld de, NullMoveInfoLabel
	call PlaceString
	jr .powerDone
.notZero1
	lb bc, 1, 3
	call PrintNumber
.powerDone
	; place the move's accuracy
	ld a, [wBuffer + 4]
	call ConvertPercentages
	ld [wBuffer + 6], a ; after the actual move data
	ld de, wBuffer + 6
	hlcoord 15, 4
	lb bc, 1, 3
	call PrintNumber
	; place the move's PP
	hlcoord 6, 4
	ld de, wBuffer + 5
	lb bc, 1, 2
	call PrintNumber
	ret

ShowForgetMoveBox:
	; add a pop-up with the old move's info
	hlcoord 0, 6
	lb bc, 4, 18
	call TextBoxBorder
	ld a, 6
	call HidePartySprites
	; show forgets label
	hlcoord 2, 7
	ld de, ForgetsLabelText
	call PlaceString
	; PP label
	hlcoord 2, 10
	ld de, MovePPLabel
	call PlaceString
	; Pwr label
	hlcoord 11, 9
	ld de, MovePwrLabel
	call PlaceString
	; Acc label
	hlcoord 11, 10
	ld de, MoveAccLabel
	call PlaceString
	ret
	
ShowForgetMoveInfo::
	; Clear screen spaces
	hlcoord 2, 8
	lb bc, 1, 12
	call ClearScreenArea
	hlcoord 15, 9
	lb bc, 2, 3
	call ClearScreenArea
	hlcoord 2, 9
	lb bc, 1, 9
	call ClearScreenArea
	hlcoord 6, 10
	lb bc, 1, 3
	call ClearScreenArea	
	; Load old move's information
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0 ; where is cursor pointing? (0-3)
	add hl, bc ; points to the move in memory
	ld a, [hl] ; a should be holding the move ID
	ld [wNamedObjectIndex], a
	push af
	call GetMoveName ; move name in wNameBuffer
	pop af
	dec a
	ld de, wPlayerMoveNum
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wBuffer
	ld a, BANK(Moves)
	call FarCopyData
	; show the move's name
	hlcoord 2, 8
	ld de, wNameBuffer
	call PlaceString
	; place the move's type
	hlcoord 2, 9
	predef PrintBufferedMoveType
	; place the move's power
	hlcoord 15, 9
	ld de, wBuffer + 2
	ld a, [de]
	cp 1
	jr z, .nullString
	and a
	jr z, .nullString
	jr .notZero1
.nullString
	ld de, NullMoveInfoLabel
	call PlaceString
	jr .powerDone
.notZero1
	lb bc, 1, 3
	call PrintNumber
.powerDone
	; place the move's accuracy
	ld a, [wBuffer + 4]
	call ConvertPercentages
	ld [wBuffer + 6], a ; after the actual move data
	ld de, wBuffer + 6
	hlcoord 15, 10
	lb bc, 1, 3
	call PrintNumber
	; place the move's PP
	hlcoord 6, 10
	ld de, wBuffer + 5
	lb bc, 1, 2
	call PrintNumber
	ret

LearnMovePartyIcon:
	ld a, [wCurPartySpecies]
	ld [wMonPartySpriteSpecies], a
	farcall LoadSinglePartyMonSprite
	ld a, 112
	ld [wBaseCoordY], a
	ld [wBaseCoordX], a
	ld hl, wShadowOAM
	ld c, $4
.loop
	ld a, [wBaseCoordY]
	add [hl]
	ld [hli], a
	ld a, [wBaseCoordX]
	add [hl]
	ld [hli], a
	inc hl
	inc hl
	dec c
	jr nz, .loop
	; print level below the icon
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	ld [wLoadedMonLevel], a
	hlcoord 14, 16
	cp 10
	jr nc, .print
	inc hl ; center label if mon is >L10
.print
	call PrintLevel
	ret

; Converts internal accuracy value to percentage
; Input:  A = internal accuracy (e.g. $D8)
; Output: A = percent (e.g. 85)
ConvertPercentages:
    ld hl, AccuracyLookupTable
.loop
    ld b, [hl]       ; internal value
    inc hl
    ld c, [hl]       ; display value
    inc hl
    cp b
    jr nz, .loop
    ld a, c
    ret
	
AccuracyLookupTable:
    db $FF, 100
    db $F2,  95
    db $E5,  90
    db $D8,  85
    db $CC,  80
    db $BF,  75
    db $B2,  70
    db $A5,  65
    db $99,  60
    db $8C,  55
    db $4C,  30

HidePartySprites:
	add a
	add a
	ld c, a
	ld hl, wShadowOAM ; beginning of wram OAM
	ld de, 4 ; amounf of byte to skip to go from Y to Y
	ld a, 160 ; the Y coordinate under the screen
.loop
	ld [hl], a
	add hl, de
	dec c 
	jr nz, .loop
	ret
  
LearnLabelText:    db " GAINS", "@"
ForgetsLabelText:  db "BY FORGETTING", "@"
MovePPLabel:       db "<BOLD_P><BOLD_P>:", "@"
MovePwrLabel:      db "PWR:", "@"
MoveAccLabel:      db "ACC:", "@"
NullMoveInfoLabel: db "---@"
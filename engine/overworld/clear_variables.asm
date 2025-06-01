ClearVariablesOnEnterMap::
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ldh [rWY], a
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld [wStepCounter], a
	ld [wLoneAttackNo], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ldh [hJoyHeld], a
	ld [wActionResultOrTookBattleTurn], a
	ld [wUnusedMapVariable], a
	ld hl, wCardKeyDoorY
	ld [hli], a
	ld [hl], a
	ld hl, wWhichTrade
	ld bc, wStandingOnWarpPadOrHole - wWhichTrade
	call FillMemory
	; Clear a possible bad game state after a Trainer Fly
	ld hl, wStatusFlags5
	set BIT_FLY_TRAINER, [hl] ; Tells the trainer encounter script to cancel any pending encounters
	ld hl, wMiscFlags
	res BIT_SCRIPTED_NPC_MOVEMENT, [hl] ; Clear encountered trainer flag (avoid blocked buttons after a Trainer Fly)
	ret

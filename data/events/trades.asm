TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH
	; give mon, get mon, dialog id, nickname
	; The two instances of TRADE_DIALOGSET_EVOLUTION are a leftover
	; from the Japanese Blue trades, which used species that evolve.
	; TRADE_DIALOGSET_EVOLUTION did not refer to evolution in Japanese
	; Red/Green. Japanese Blue changed _AfterTrade2Text to say your Pokémon
	; "went and evolved" and also changed the trades to match. English
	; Red/Blue uses the original JP Red/Green trades but with the JP Blue
	; post-trade text.
	db KANGASKHAN, KADABRA,   TRADE_DIALOGSET_CASUAL,    "HOUDINI@@@@" ; ROUTE 11
	db ABRA,       MR_MIME,   TRADE_DIALOGSET_CASUAL,    "MARCEL@@@@@" ; ROUTE 2
	db ELECTABUZZ, HAUNTER,   TRADE_DIALOGSET_HAPPY,     "CASPER@@@@@" ; ROUTE 16
	db PONYTA,     SEEL,      TRADE_DIALOGSET_CASUAL,    "SAILOR@@@@@" ; CINNABAR LAB
	db SPEAROW,    FARFETCHD, TRADE_DIALOGSET_HAPPY,     "DUX@@@@@@@@" ; VERMILLION CITY
	db SLOWBRO,    LICKITUNG, TRADE_DIALOGSET_CASUAL,    "MARC@@@@@@@" ; ROUTE 18
	db POLIWHIRL,  JYNX,      TRADE_DIALOGSET_EVOLUTION, "LOLA@@@@@@@" ; CERULEAN CITY
	db GROWLITHE,  KRABBY,    TRADE_DIALOGSET_EVOLUTION, "SHELLY@@@@@" ; CINNABAR LAB
	db MAGMAR,     MACHOKE,   TRADE_DIALOGSET_HAPPY,     "APOLLO@@@@@" ; CINNABAR LAB
	db MAROWAK,    GRAVELER,  TRADE_DIALOGSET_HAPPY,     "FLINT@@@@@@" ; ROUTE 5
	assert_table_length NUM_NPC_TRADES
	


MtSilver2FWildMons:
	def_grass_wildmons 10 ; encounter rate
	db  45, GOLBAT
	db  42, MACHOKE
	db  45, RHYHORN
IF DEF(_RED)
	db  42, PINSIR
ENDC
IF DEF(_BLUE)
	db  42, SCYTHER
ENDC
	db  50, GOLBAT
	db  45, GOLBAT
	db  45, GOLDUCK
	db  40, RHYHORN
	db  45, GOLBAT
	db  48, MACHOKE
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
    db 35, POLIWAG
    db 38, POLIWAG
    db 40, POLIWAG
    db 42, POLIWAG
    db 44, POLIWAG
    db 40, POLIWHIRL
    db 42, POLIWHIRL
    db 44, POLIWHIRL
    db 40, POLIWHIRL
    db 45, POLIWHIRL
	end_water_wildmons

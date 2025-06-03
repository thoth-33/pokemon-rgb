_RedsHouse1FMomWakeUpText::
IF DEF(_BLUE)
	text "DAISY: Right."
ELSE ; _RED
	text "MOM: Right."
ENDC
	line "All kids leave"
	cont "home some day."
	cont "It said so on TV."

	para "Grandpa, next"
	line "door, is looking"
	cont "for you."
	done

_RedsHouse1FMomYouShouldRestText::
IF DEF(_BLUE)
	text "DAISY: <PLAYER>!"
ELSE ; _RED
	text "MOM: <PLAYER>!"
ENDC
	line "You should take a"
	cont "quick rest."
	prompt

_RedsHouse1FMomLookingGreatText::
IF DEF(_BLUE)
	text "DAISY: Oh good!"
ELSE ; _RED
	text "MOM: Oh good!"
ENDC
	line "You and your"
	cont "#MON are"
	cont "looking great!"
	cont "Take care now!"
	done

_RedsHouse1FTVStandByMeMovieText::
	text "There's a movie"
	line "on TV. Four boys"
	cont "are walking on"
	cont "railroad tracks."

	para "I better go too."
	done

_RedsHouse1FTVWrongSideText::
	text "Oops, wrong side."
	done

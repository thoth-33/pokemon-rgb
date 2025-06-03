IF DEF(_BLUE)
RedPicFront:: INCBIN "gfx/gstrainers/rival1.pic"
GreenPicFront:: INCBIN "gfx/gstrainers/yellow.pic"
ELSE ; _RED
RedPicFront:: INCBIN "gfx/gstrainers/red.pic"
GreenPicFront:: INCBIN "gfx/gstrainers/green.pic"
ENDC
rept 11 ; Padding
	db 0
endr
ShrinkPic1::  INCBIN "gfx/player/shrink1.pic"
ShrinkPic2::  INCBIN "gfx/player/shrink2.pic"

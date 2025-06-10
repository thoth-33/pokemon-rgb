MtSilver2F_Script:
	ret

MtSilver2F_TextPointers:
	def_text_pointers
	dw_const MtSilver2FWhirlpoolText, TEXT_MT_SILVER2F_WHIRLPOOL1
	dw_const MtSilver2FWhirlpoolText, TEXT_MT_SILVER2F_WHIRLPOOL2
	
MtSilver2FWhirlpoolText:
	text_far _MtSilver2FWhirlpoolText
	text_end
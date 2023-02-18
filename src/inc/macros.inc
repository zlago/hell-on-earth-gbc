macro lb ; "load bytes", ld for two n8 to one r16
	assert -128 <= (\2) && (\2) <= 255, "Second argument to `lb` must be 8-bit!"
	assert -128 <= (\3) && (\3) <= 255, "Third argument to `lb` must be 8-bit!"
	ld \1, (((\2) << 8) & $FF00) | ((\3) & $FF)
	endm

macro rom_bank ; just check examples
	if _NARG == 0 ; apparently needs to be all caps
		ldh a, [hShadowROMB]
		ld [rROMB], a
		;println "restored bank"
	else
		if ISCONST(\1) == 0
			ld a, bank(\1)
			assert fail, $4000 <= (\1) && (\1) < $8000 && (\1) != 0, "not a romx label?"
			;print "loaded a, "
		elif (\1) != 0
			warn "not constant, not 0?"
		endc
		if _NARG < 2
			ldh [hShadowROMB], a
			;print "saved, "
		else
		endc
		ld [rROMB], a
		;println "switched bank"
	endc
	endm
/* examples :
rom_bank ; restore romx bank
rom_bank 0 ; bankswitches to whats already in a
rom_bank xTiles ; switch romx to `bank(xTiles)` and save bank to shadow
rom_bank xInterruptCode, 0 ; switch romx to `bank(xInterruptCode)` without saving to shadow*/

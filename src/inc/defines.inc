; basically unused
def PALETTE_DMG equ $3f
; game related
def START_Y equ $e2
def START_X equ $76
def MAX_ACTORS equ 16
; tile collision
def TILE_SOLID equ %00000001
; vblank tasks
def VBLANK_TEXT equ %00000001
; save constants
def SAVE_VERSION equ $01 ; increment this each time the format updates
	; $00 is treated as 'empty file'
if def(VERIFY) == 0
	def SAVE_VERIFY equs "'hoe' best title"
	endc
; save verification outputs
rsreset
def SAVE_VALID    rb ; save is valid
def SAVE_CHECKSUM rb ; checksum doesnt match
def SAVE_OLD      rb ; save version mismatch
def SAVE_EMPTY    rb ; file is empty
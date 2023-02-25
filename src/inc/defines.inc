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
def SAVE_VERSION equ $00 ; increment this each time the format updates
if def(VERIFY) == 0
	def SAVE_VERIFY equs "ur a girlkisser"
	endc
; load output
rsreset
def LOAD_SUCCESS rb
def LOAD_WRONGVER rb
def LOAD_WRONGVERIFY rb
def LOAD_WRONGCRC rb
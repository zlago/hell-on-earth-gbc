# rgbds defines
# flags
ASM_FLAGS  = -h -Wall -p ${PAD_VAL} $(addprefix -I,${INC_PATHS}) $(addprefix -D,${INC_PATHS})
LINK_FLAGS = -p ${PAD_VAL}
FIX_FLAGS  = -v -l 0x33 -j -C -t ${HDR_NAME} -k ${LICENSEE} -m ${HDR_MBC} -r ${HDR_RAM} -n ${HDR_VER} -p ${PAD_VAL}
# include paths
INC_PATHS = src/inc/ src/res/
# (string) constants for rgbasm
DEFINES = 
# pad value
PAD_VAL = 0xFF

# ROM defines
# filename for the binary
BIN_NAME = hell
# name for the header
HDR_TITLE = "HELL"
# new licensee code
HDR_LICENSEE = "ZS"
# mapper used
HDR_MBC = MBC5+RAM+BATTERY
# rgbfix will set ROM size for you
# RAM size
HDR_RAM = 2
# ROM version size
HDR_VER = 0

# dependencies
ASM_REQS = $(patsubst src/%.sm83,obj/%.o,$(shell find src/ -name '*.sm83'))
GFX_REQS = 

all: bin/${BIN_NAME}.gb

obj/%.o: src/%.sm83 $(GFX_REQS)
	rgbasm ${ASM_FLAGS} -o $@ $<

bin/${BIN_NAME}.gb: $(ASM_REQS) $(GFX_REQS)
	rgblink ${LINK_FLAGS} -m bin/${BIN_NAME}.map -n bin/${BIN_NAME}.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@

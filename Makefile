# rgbds defines
# flags
ASM_FLAGS  = -h -Wall -p ${PAD_VAL} $(addprefix -I,${INC_PATHS}) $(addprefix -D,${DEFINES})
LINK_FLAGS = -p ${PAD_VAL}
FIX_FLAGS  = -v -l 0x33 -j -C -t ${HDR_TITLE} -k ${HDR_LICENSEE} -m ${HDR_MBC} -r ${HDR_RAM} -n ${HDR_VER} -p ${PAD_VAL}
# include paths
INC_PATHS = src/inc/ src/res/
# (string?) constants for rgbasm
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

.PHONY: all release dev clean

dev: bin/${BIN_NAME}-dev.gbc

release: bin/${BIN_NAME}.gbc

all: bin/${BIN_NAME}.gbc bin/${BIN_NAME}-dev.gbc

clean:
	rm -rf bin/
	rm -rf obj/
	rm -rf src/res/

bin/:
	mkdir bin/

obj/:
	mkdir obj/

obj/%.o: src/%.sm83 $(GFX_REQS) obj/
	rgbasm ${ASM_FLAGS} -o $@ $<

bin/${BIN_NAME}.gbc: $(ASM_REQS) bin/ # "release" build
	rgblink ${LINK_FLAGS} -m bin/${BIN_NAME}.map -n bin/${BIN_NAME}.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@

bin/${BIN_NAME}-dev.gbc: $(ASM_REQS) bin/ # "dev" build
	rgblink ${LINK_FLAGS} -S romx=256,wramx -m bin/${BIN_NAME}-dev.map -n bin/${BIN_NAME}-dev.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@

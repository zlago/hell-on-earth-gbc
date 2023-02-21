# rgbds defines
# flags
ASM_FLAGS  = -h -Wall -p ${PAD_VAL} $(addprefix -I,${INC_PATHS}) $(addprefix -D,${DEFINES})
LINK_FLAGS = -p ${PAD_VAL}
FIX_FLAGS  = -f hg -l 0x33 -j -C -t ${HDR_TITLE} -k ${HDR_LICENSEE} -m ${HDR_MBC} -r ${HDR_RAM} -n ${HDR_VER} -p ${PAD_VAL}
# include paths
INC_PATHS = src/inc/ src/res/ res/
# (string?) constants for rgbasm
DEFINES = ${CONFIG}
# pad value
PAD_VAL = 0xFF

# ROM defines
# filename for the binary
BIN_NAME = hell
# name for the header
HDR_TITLE = "HOE(yes) (DEMO)"
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
ASM_REQS = $(shell find src/inc/ -name '*.inc')
LINK_REQS = $(patsubst src/%.sm83,obj/%.o,$(shell find src/ -name '*.sm83'))
GFX_REQS = res/map.bin res/tileset.2bpp res/player.2bpp res/splash.2bpp res/flavor.bin res/menumap.tilemap

.PHONY: all release dev clean

dev: bin/${BIN_NAME}-dev.gbc

release: bin/${BIN_NAME}.gbc

all: bin/${BIN_NAME}.gbc bin/${BIN_NAME}-dev.gbc

clean:
	rm -rf bin/
	rm -rf obj/
	rm -rf res/

bin/:
	mkdir bin/

obj/:
	mkdir obj/

res/:
	mkdir res/

res/flavor.bin: src/res/flavor.png src/res/1bit.dpal res/
	superfamiconv tiles -v --mode gb -T 8192 -B 1 -F -D -p src/res/1bit.dpal -d $@ -i $<

res/map.bin: src/res/map.png res/tileset.2bpp src/res/rev.dpal res/
	superfamiconv map -v --mode gb --split-width 256 --split-height 256 -F -t res/tileset.2bpp -p src/res/rev.dpal -i $< -d $@

res/menumap.tilemap: src/res/menumap.png src/res/1bit.dpal res/
	superfamiconv tiles -v --mode gb -F -T  24 -B 2 -p src/res/1bit.dpal -i $< -d res/menumap.2bpp
	superfamiconv tiles -v --mode gb -F -T  24 -B 1 -p src/res/1bit.dpal -i $< -d res/menumap.1bpp
	superfamiconv map   -v --mode gb -F -T 224 -B 2 -p src/res/1bit.dpal -i $< -t res/menumap.2bpp -d $@

res/tileset.2bpp: src/res/tileset.png res/
	rgbgfx -c "#000, #00f, #0ff, #fff" -o $@ $<

res/player.2bpp: src/res/player.png res/
	rgbgfx -c "#00f, #0ff, #000, #fff" -o $@ $<

res/splash.2bpp: src/res/splash.png res/
	rgbgfx -u -c "#000, #00f, #0ff, #fff" -o $@ -t res/splash.tilemap $<

obj/%.o: src/%.sm83 $(ASM_REQS) $(GFX_REQS) obj/ 
	rgbasm ${ASM_FLAGS} -o $@ $<

bin/${BIN_NAME}.gbc: $(LINK_REQS) bin/ # "release" build
	rgblink ${LINK_FLAGS} -m bin/${BIN_NAME}.map -n bin/${BIN_NAME}.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@

bin/${BIN_NAME}-dev.gbc: $(LINK_REQS) bin/ # "dev" build
	rgblink ${LINK_FLAGS} -S romx=256,wramx -m bin/${BIN_NAME}-dev.map -n bin/${BIN_NAME}-dev.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@

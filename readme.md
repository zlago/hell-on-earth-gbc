### hell on earth (placeholder title)

hopefully a (GBC only) game

### compiling

dependencies:
- [RGBDS](https://github.com/gbdev/rgbds), v6.0.0 should work
- [SuperFamiconv](https://github.com/Optiroc/SuperFamiconv)
- GNU make (v4.3 should work) (todo: add link)

all of the above must be located in your PATH

to build:
1. run `make` (bigger binary, should crash instead of "failing silently") or `make release` in the repo root

file structure:

`bin/` binaries

`obj/` assembly artifacts

`res/` asset conversion artifacts

`src/` source (RGBDS assembly files)

`src/inc/` include files

`src/res` assets
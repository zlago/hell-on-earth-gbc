### hell on earth (placeholder title)

hopefully a (GBC only) game

### compiling

dependencies:
- [RGBDS](https://gihttps://github.com/gbdev/rgbds/actions/runs/4231985498),
youll need\* at least a build from 2023-02-21
- [SuperFamiconv](https://github.com/Optiroc/SuperFamiconv)
- GNU make (v4.3 should work) (todo: add link)

all of the above must be located in your PATH

to build:
1. run `make` (bigger binary, should crash instead of
"failing silently") or `make release` in the repo root

file structure:

`bin/` binaries

`obj/` assembly artifacts

`res/` asset conversion artifacts

`src/` source (RGBDS assembly files)

`src/inc/` include files

`src/res` assets

\*due to a funky quirk in v0.6.1, you must edit the `res/menumap.tilemap` rule
(`-q res/map.palmap` -> `-Q -a res/map.palmap`) if you want to build with v0.6.1
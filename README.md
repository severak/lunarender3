# lunarender3

experimental openstreetmap renderer - work in progress

status: I can read PBF/MVT, now I need to understand what's inside.

## idea

1. use [tilemaker](https://github.com/systemed/tilemaker) to make vector tiles
2. use this (*lunarender3*) tool to render map
3. profit! (or at least have map with nice colors)

I am far away from point 3, but I have some ideas:

- instead of JSON stylesheet use Lua (hence lunarender name)
- make app capable working both as localhost server and backend for public map (behind some Nginx)

## previous work

- original [lunarender](https://github.com/severak/lunarender)
- 2018 [proof of concept](https://github.com/severak/lunatest) in Go
- [mapstyles](https://github.com/severak/mapstyles) which will be ported to this version

## data & links

- [Vector tile specification](https://github.com/mapbox/vector-tile-spec) (as we are implementing our own parser)
- [test data](https://data.maptiler.com/downloads/europe/luxembourg/) (Luexembourg from OpenMapTiles)
- [OpenMapTiles schema](https://openmaptiles.org/schema/)
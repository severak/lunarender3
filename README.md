# lunarender3

experimental openstreetmap renderer - work in progress

status: I can read PBF/MVT and make some debug images using styles hardcoded in Nim.

![Hello world!](examples/world1.png)

<details>
  <summary>More nice pictures</summary>

![Hello world no 2!](examples/world2.png)

![Kleinbettingen](examples/kleinbettingen.png)

![Beroun](examples/beroun.png)

![Beroun](examples/beroun-big.png)

</details>

## idea

1. use [tilemaker](https://github.com/systemed/tilemaker) to make vector tiles
2. use this tool (*lunarender3*) to render map
3. profit! (or at least have map with nice colors)

I am far away from point 3, but I have some ideas:

- instead of JSON stylesheet use Lua (hence lunarender name)
- make app capable working both as localhost server and backend for public map (behind some Nginx)

## my previous work

- original [lunarender](https://github.com/severak/lunarender)
- 2018 [proof of concept](https://github.com/severak/lunatest) in Go
- [mapstyles](https://github.com/severak/mapstyles) which will be ported to this version

## data & links

- [Vector tile specification](https://github.com/mapbox/vector-tile-spec) (as we are implementing our own parser)
- [Vector tiles test suite](https://github.com/mapbox/mvt-fixtures)
- [OpenMapTiles schema](https://openmaptiles.org/schema/)
- current [test data](https://data.maptiler.com/downloads/europe/luxembourg/) (Luxembourg from OpenMapTiles)
- [MAKI icons](https://labs.mapbox.com/maki-icons/)

## TODO

- unreverse reversed y coordinate
- handle missing tiles gracefully
- handle broken tiles gracefully
- bind other interfaces to be able to host demo on server
- derive zoom levels above 14 from zoom 14
- be able to write rules in lua
- optimize a lot
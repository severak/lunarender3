import jester except server
import pixie
import cligen
import mbtiles
import tile
import strutils
import benchy
import style
import zippy

proc server(data="test.mbtiles") =
  ## starts tile-serving server
  var mapdata = openTiles(data)

  router myrouter:
    get "/":
      resp "Lunarender v3 OK"
    get "/@tileset/@zoom/@x/@y/debug.png":
      # TODO - conds aby nebyly parametry prazdny
      let image = newImage(256, 256)
      image.fill(rgba(255, 255, 255, 255))
      var font = readFont("Gidole-Regular.ttf")
      font.size = 20

      image.fillText(font.typeset(@"zoom" & " x=" & @"x" & " y=" & @"y"), translate(vec2(10, 10)))
      strokePath(image, "M 0 0 L 0 256 L 256 256 L 256 0 Z", "green".parseHtmlColor)
      resp encodeImage(image, ffPng), "image/png"
    get "/@tileset/@zoom/@x/@y/debug512.png":
      # TODO - conds aby nebyly parametry prazdny
      let image = newImage(512, 512)
      image.fill(rgba(255, 255, 255, 255))
      var font = readFont("Gidole-Regular.ttf")
      font.size = 20

      image.fillText(font.typeset(@"zoom" & " x=" & @"x" & " y=" & @"y"), translate(vec2(10, 10)))
      strokePath(image, "M 0 0 L 0 512 L 512 512 L 512 0 Z", "green".parseHtmlColor)
      resp encodeImage(image, ffPng), "image/png"
    get "/@tileset/@zoom/@x/@y/tile.png":
      var z = parseInt(@"zoom")
      var x = parseInt(@"x")
      var y = parseInt(@"y")
      var tile = mapdata.getTile(x, y, z)
      var tileDecoded = decodeVectorTile(tile)
      var rules = makeExampleRuleset()
      var image = drawTile(tileDecoded, rules, 256, z)
      resp encodeImage(image, ffPng), "image/png"
    get "/@tileset/@zoom/@x/@y/tile512.png":
      var z = parseInt(@"zoom")
      var x = parseInt(@"x")
      var y = parseInt(@"y")
      var tile = mapdata.getTile(x, y, z)
      var tileDecoded = decodeVectorTile(tile)
      var rules = makeExampleRuleset()
      var image = drawTile(tileDecoded, rules, 512, z)
      resp encodeImage(image, ffPng), "image/png"
    get "/lr1/@zoom/@x/@y/text.txt":
      var z = parseInt(@"zoom")
      var x = parseInt(@"x")
      var y = parseInt(@"y")
      var tile = mapdata.getTile(x, y, z)
      var vek = decodeVectorTile(tile)
      resp $(vek)
    get "/tiles/@zoom/@x/@y/tile.pbf":
      var z = parseInt(@"zoom")
      var x = parseInt(@"x")
      var y = parseInt(@"y")
      let ymax = 2 ^ z
      var tile = mapdata.getTile(x, ymax-y, z)
      echo "ymax = ", ymax
      echo "kek ", x, ",",  (ymax-y), ",",  z
      if tile == "":
        resp Http404
      resp uncompress(tile), "application/vnd.mapbox-vector-tile"

  var jester = initJester(myrouter)
  jester.serve()

proc single(data="test.mbtiles", z=0, x=0, y=0, dest="test.png") =
  ## renders single tile
  echo "We gonna render tile ", z, ", ", x, ",", y, " now."
  echo "opening database..."
  var map = openTiles(data)
  echo "geting tile..."
  var tile = getTile(map, x, y, z)
  echo "decoding tile..."
  var decoded = decodeVectorTile(tile)
  echo "rendering it..."
  # var img = testDrawTile(decoded, 512)
  var rules = makeExampleRuleset()
  var img = drawTile(decoded, rules, 512, z)
  writeFile(img, dest)
  echo "Done."

proc benchmark(data="test.mbtiles", z=0, x=0, y=0) =
  ## run some benchmarks
  echo "Benchmarking..."
  timeIt "opening tileset":
    let benchMap = openTiles(data)
    discard closeTiles(benchMap)
    keep(benchMap)
  let map = openTiles(data)
  timeIt "getting tile from set":
    let tileBench = getTile(map, z, x, y)
    keep(tileBench)
  let tile = getTile(map, z, x, y)
  timeIt "decoding tile":
    let decodedBench = decodeVectorTile(tile)
    keep(decodedBench)
  let decoded = decodeVectorTile(tile)
  timeIt "draw test image":
    let imgBench = testDrawTile(decoded, 256);
    keep(imgBench)
  let rules = makeExampleRuleset()
  timeIt "draw tile using rules":
    let imgBench = drawTile(decoded, rules, 256, z)
  echo "Done."

when isMainModule:
  dispatchMulti([server], [single], [benchmark])
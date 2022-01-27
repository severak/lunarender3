import jester except server
import pixie
import cligen

router myrouter:
  get "/":
    resp "Lunarender v3 OK"
  get "/@tileset/@zoom/@x/@y/debug.png":
    # TODO - conds aby nebyly parametry prazdny
    let image = newImage(256, 256)
    image.fill(rgba(255, 255, 255, 255))
    var font = readFont("Gidole-Regular.ttf")
    font.size = 20

    image.fillText(font.typeset(" x=" & @"x" & " y=" & @"y"), translate(vec2(10, 10)))
    strokePath(image, "M 0 0 L 0 256 L 256 256 L 256 0 Z", "green".parseHtmlColor)
    resp encodeImage(image, ffPng), "image/png"
  get "/@tileset/@zoom/@x/@y/debug512.png":
    # TODO - conds aby nebyly parametry prazdny
    let image = newImage(512, 512)
    image.fill(rgba(255, 255, 255, 255))
    var font = readFont("Gidole-Regular.ttf")
    font.size = 20

    image.fillText(font.typeset(" x=" & @"x" & " y=" & @"y"), translate(vec2(10, 10)))
    strokePath(image, "M 0 0 L 0 512 L 512 512 L 512 0 Z", "green".parseHtmlColor)
    resp encodeImage(image, ffPng), "image/png"

proc server(data="") =
  var jester = initJester(myrouter)
  jester.serve()

proc kek() =
  echo "KEK"

when isMainModule:
  dispatchMulti([server], [kek])
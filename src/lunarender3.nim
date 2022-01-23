import jester
import pixie

routes:
  get "/":
    resp "Lunarender v3 OK"
  get "/@tileset/@zoom/@x/@y":
    # TODO - conds aby nebyly parametry prazdny
    let image = newImage(256, 256)
    image.fill(rgba(255, 255, 255, 255))
    var font = readFont("Gidole-Regular.ttf")
    font.size = 20

    image.fillText(font.typeset(" x=" & @"x" & " y=" & @"y"), translate(vec2(10, 10)))
    resp encodeImage(image, ffPng), "image/png"
    # resp "Tile " & @"tileset" & ": zoom=" & @"zoom" & " x=" & @"x" & " y=" & @"y" & "..."
  

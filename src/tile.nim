import streams
import zippy
import nimpb/nimpb
import vector_tile_pb

import std/tables

import pixie
import vmath

const CMD_MOVE_TO = 1
const CMD_LINE_TO = 2
const CMD_SEG_END = 7

type
    # Subpath* = ref seq[Vec2]

    Feature* = object
        layer*: string
        tags*: Table[string, string]
        geometry*: seq[seq[Vec2]]
        # TODO - type of path to draw to make life easier
    
    Tile* = object 
        features*: seq[Feature]

proc `$`(tileValue: vector_tile_Tile_Value): string =
    if tileValue.hasstringValue:
        return tileValue.stringValue
    elif tileValue.hasfloatValue:
        return $(tileValue.floatValue)
    elif tileValue.hasdoubleValue:
        return $(tileValue.doubleValue)
    elif tileValue.hasintValue:
        return $(tileValue.intValue)
    elif tilevalue.hassintValue:
        return $(tileValue.sintValue)
    elif tileValue.hasboolValue:
        return $(tileValue.boolValue)
    else:
        return "?"

proc uncompressWhenNeeded(data: string): Stream = 
    try:
        newStringStream(uncompress(data))
    except ZippyError:
        newStringStream(data)

proc decodeTags(layer: vector_tile_Tile_Layer, featIn: vector_tile_Tile_Feature, featOut: var Feature) = 
    var key = ""
    var val = ""
    featOut.tags = initTable[string, string]()
    for tagOrd, tag in featIn.tags:
        if tagOrd mod 2 == 0:
            key = layer.keys[tag]
        else:
            val = $(layer.values[tag])
            featOut.tags[key] = val

proc transcodeGeometry(layer: vector_tile_Tile_Layer, featIn: vector_tile_Tile_Feature, featOut: var Feature) =
    # ported from https://github.com/tilezen/mapbox-vector-tile/blob/master/mapbox_vector_tile/decoder.py
    var i = 0
    var dx = int32(0)
    var dy = int32(0)
    while i != len(featIn.geometry):
        let geom = featIn.geometry
        let firstGeomByte = featIn.geometry[i]
        let cmd = firstGeomByte and 0x07
        let count = int(firstGeomByte shr 3)

        i = i + 1

        if cmd == CMD_SEG_END:
            # TODO - close paths, but how?
            discard
        elif cmd == CMD_LINE_TO or cmd == CMD_MOVE_TO:
            var subpath = newSeq[Vec2]()
            for point in 1 .. count:
                var rawx = geom[i]
                var x = zigzagDecode(geom[i])
                i = i + 1

                var rawy = geom[i]
                var y = zigzagDecode(geom[i])
                i = i + 1

                x = x + dx
                y = y + dy

                dx = x
                dy = y

                var coord = Vec2()
                coord.x = float32(x) / float32(layer.extent)
                coord.y = float32(y) / float32(layer.extent)
                subpath.add(coord)
            featOut.geometry.add(subpath)

proc decodeVectorTile(data: string): Tile =
    var tileOut = Tile()
    let tileIn = readvector_tile_Tile(uncompressWhenNeeded(data))
    for layer in tileIn.layers:
        if len(layer.features) > 0:
            for featIn in layer.features:
                var featOut = Feature()
                featOut.layer = layer.name
                decodeTags(layer, featIn, featOut)
                transcodeGeometry(layer, featIn, featOut)
                tileOut.features.add(featOut)
    return tileOut


proc cmdToStr(cmd: uint32): string =
    if cmd == CMD_LINE_TO:
        "line"
    elif cmd == CMD_MOVE_TO:
        "move"
    elif cmd == CMD_SEG_END:
        "close"
    else:
        "?"

proc testDecode(mvtName: string, destName: string): bool = 
    const imgSize = 512
    let img = newImage(imgSize, imgSize)
    fill(img, "#fff".parseHtmlColor)
    let tile = decodeVectorTile(readFile(mvtName))
    for feat in tile.features:
        for subpath in feat.geometry:
            var path = newPath()
            for ord, coord in subpath:
                if ord == 0:
                    path.moveTo(coord * imgSize)
                else:
                    path.lineTo(coord * imgSize)
            closePath(path)
            strokePath(img, path, "#ccc".parseHtmlColor, mat3(), 1)
    writeFile(img, destName)
    true


proc testAll() =
    const debugLayerColor = {
        "aerodrome_label": "gray",
        "aeroway": "gray",
        "boundary": "hotpink",
        "building": "purple",
        "housenumber": "purple",
        "landcover": "green",
        "landuse": "green",
        "mountain_peak": "green",
        "park": "green",
        "place": "orange",
        "poi": "orange",
        "transportation": "brown",
        "transportation_name": "brown",
        "water": "blue",
        "water_name": "blue",
        "waterway": "blue"
    }.toTable

    let imgSize = 512

    let img = newImage(imgSize, imgSize)
    fill(img, parseHtmlColor("#fff"))

    echo "OK"
    let testFile = readFile("src/testdata/lux-random2.mvt")
    # TODO - uncompress only when needed
    let tileSrc = uncompress(testFile)
    let tile = readvector_tile_Tile(newStringStream(tileSrc))
    #echo(tile)
    # let resolution :float = 512
    
    for layer in tile.layers:
        echo "layer " & layer.name
        # echo layer.keys
        # echo $(layer.values)
        # echo "len" & $(len(layer.features))
        if len(layer.features) == 0: continue
        for feature in layer.features:
            case feature.ftype:
                of POINT: echo "(point)"
                of LINESTRING: echo "(linesting)"
                of POLYGON: echo "(polygon)"
                else: echo "?"
            
            # tags are somewhat more sane
            # var it = 0
            var oldtag :uint32 = 0
            for it, tag in feature.tags:
                if it mod 2 == 0:
                    # echo layer.keys[tag] & "="
                    oldtag = tag
                else:
                    # echo $(layer.values[tag])
                    echo layer.keys[oldtag] & "=" & $(layer.values[tag])


            # ported from https://github.com/tilezen/mapbox-vector-tile/blob/master/mapbox_vector_tile/decoder.py
            
            echo("geometry = " & $(feature.geometry))

            var i = 0
            # var coords = newSeq[int](0)
            var dx = int32(0)
            var dy = int32(0)

            var path = newPath()

            while i != len(feature.geometry):
                let geom = feature.geometry
                let firstGeomByte = feature.geometry[i]
                let cmd = firstGeomByte and 0x07
                let count = int(firstGeomByte shr 3)
                echo "cmd = " & cmdToStr(cmd) & " count = " & $(count)

                i = i + 1

                var faktor: float32 = float32(imgSize) / float32(layer.extent)

                # echo "chci jet od " & $(i) & " do " & $(count + i)
                if cmd == CMD_SEG_END:
                    echo "Close seg"
                    closePath(path)
                elif cmd == CMD_LINE_TO or cmd == CMD_MOVE_TO:
                    for point in 1 .. count:

                        var rawx = geom[i]
                        var x = zigzagDecode(geom[i])
                        i = i + 1

                        var rawy = geom[i]
                        var y = zigzagDecode(geom[i])
                        i = i + 1

                        x = x + dx
                        y = y + dy

                        dx = x
                        dy = y

                        #if not y_coord_down:
                        #    y = extent - y

                        # let extent = int(layer.extent)
                        echo "x = " & $(x) & " y=" & $(y)
                        # echo "raw x = " & $(rawx) & " y=" & $(rawy)
                        # coords.append([x, y])
                        if cmd == CMD_MOVE_TO:
                            moveTo(path, float32(x) * faktor, float32(y) * faktor)
                        else:
                            lineTo(path, float32(x) * faktor, float32(y) * faktor)
            strokePath(img, path, parseHtmlColor(debugLayerColor[layer.name]), mat3(), 1.5)

    writeFile(img, "test.png")
    echo "Done"    

when isMainModule:
    assert testDecode("src/testdata/lux-world.mvt", "world.png")
    echo "OK"
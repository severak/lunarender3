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
    FeatDrawType* = enum
        dtUnknown = 0, dtPoint = 1, dtLine = 2, dtPolygon = 3

    Feature* = object
        layer*: string
        tags*: Table[string, string]
        geometry*: seq[seq[Vec2]]
        geometryType*: FeatDrawType
    
    Tile* = object 
        features*: seq[Feature]

proc toDrawType*(ftype: vector_tile_Tile_GeomType): FeatDrawType =
    case ftype:
        of UNKNOWN: 
            result = dtUnknown
        of POINT: 
            result = dtPoint
        of LINESTRING: 
            result = dtLine
        of POLYGON: 
            result = dtPolygon 

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

proc cmdToStr(cmd: uint32): string =
    if cmd == CMD_LINE_TO:
        "line"
    elif cmd == CMD_MOVE_TO:
        "move"
    elif cmd == CMD_SEG_END:
        "close"
    else:
        "?"

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

proc closeGeometry(geom: var seq[seq[Vec2]], featOut: var Feature) =
    let pathCount = geom.high
    if pathCount > 0:
        var subpath = geom[pathCount]
        if len(subpath) > 1:
            if subpath[0] != subpath[subpath.high]:
                geom[pathCount].add(subpath[0])
                featOut.geometry = geom

proc transcodeGeometry(layer: vector_tile_Tile_Layer, featIn: vector_tile_Tile_Feature, featOut: var Feature) =
    # ported from https://github.com/tilezen/mapbox-vector-tile/blob/master/mapbox_vector_tile/decoder.py
    var i = 0
    var dx = int32(0)
    var dy = int32(0)
    var subpath : seq[Vec2]
    while i != len(featIn.geometry):
        let geom = featIn.geometry
        let firstGeomByte = featIn.geometry[i]
        let cmd = firstGeomByte and 0x07
        let count = int(firstGeomByte shr 3)

        i = i + 1
        if cmd == CMD_SEG_END:
            closeGeometry(featOut.geometry, featOut)
        elif cmd == CMD_LINE_TO or cmd == CMD_MOVE_TO:
            if cmd == CMD_MOVE_TO:
                subpath = newSeq[Vec2]()
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
    featOut.geometry_type = featIn.ftype.toDrawType

proc decodeVectorTile*(data: string): Tile =
    var tileOut = Tile()
    let tileIn = readvector_tile_Tile(uncompressWhenNeeded(data))
    for layer in tileIn.layers:
        if len(layer.features) > 0:
            for featIn in layer.features:
                var featOut = Feature()
                featOut.layer = layer.name
                decodeTags(layer, featIn, featOut)
                transcodeGeometry(layer, featIn, featOut)
                # todo - if not possible to decode geometry, throw feature out of the window
                tileOut.features.add(featOut)
    return tileOut

proc testDrawTile*(tile: Tile, imgSize: int): Image = 
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

    let img = newImage(imgSize, imgSize)
    fill(img, "#000".parseHtmlColor)
    for feat in tile.features:
        # echo feat.layer, " ", feat.tags
        if len(feat.geometry) > 0:
            var path = newPath()
            for subpath in feat.geometry:
                for ord, coord in subpath:
                    if ord == 0:
                        path.moveTo(coord * float32(imgSize))
                    else:
                        path.lineTo(coord * float32(imgSize))
            try:
                strokePath(img, path, parseHtmlColor(debugLayerColor[feat.layer]), mat3(), 1)
            except IndexDefect:
                # echo feat
                discard
    result = img

proc testDecodeTile(mvtName: string, destName: string): bool = 
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

    const imgSize = 1024
    let img = newImage(imgSize, imgSize)
    fill(img, "#000".parseHtmlColor)
    let tile = decodeVectorTile(readFile(mvtName))
    for feat in tile.features:
        # echo feat.layer, " ", feat.tags
        var path = newPath()
        for subpath in feat.geometry:
            for ord, coord in subpath:
                if ord == 0:
                    path.moveTo(coord * imgSize)
                else:
                    path.lineTo(coord * imgSize)
            strokePath(img, path, parseHtmlColor(debugLayerColor[feat.layer]), mat3(), 1)
    writeFile(img, destName)
    true

when isMainModule:
    assert testDecodeTile("src/testdata/lux-world.mvt", "world.png")
    echo "OK"
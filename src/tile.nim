import streams
import zippy
import nimpb/nimpb
import vector_tile_pb

const CMD_MOVE_TO = 1
const CMD_LINE_TO = 2
const CMD_SEG_END = 7

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

when isMainModule:
    echo "OK"
    let testFile = readFile("src/test.bin")
    # TODO - uncompress only when needed
    let tileSrc = uncompress(testFile)
    let tile = readvector_tile_Tile(newStringStream(tileSrc))
    #echo(tile)
    let resolution :float = 5121
    for layer in tile.layers:
        echo layer.name
        echo layer.keys
        # echo $(layer.values)
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
            while i != len(feature.geometry):
                let geom = feature.geometry
                let firstGeomByte = feature.geometry[i]
                let cmd = firstGeomByte and 0x07
                let count = int(firstGeomByte shr 3)
                echo "cmd = " & cmdToStr(cmd) & " count = " & $(count)

                i = i + 1

                # echo "chci jet od " & $(i) & " do " & $(count + i)
                if cmd == CMD_SEG_END:
                    echo "Close seg"
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
                
    echo "Done"    

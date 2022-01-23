import streams
import zippy
import nimpb/nimpb
import vector_tile_pb

when isMainModule:
    echo "OK"
    let testFile = readFile("src/test.bin")
    # TODO - uncompress only when needed
    let tileSrc = uncompress(testFile)
    let tile = readvector_tile_Tile(newStringStream(tileSrc))
    #echo(tile)
    for layer in tile.layers:
        echo layer.name
        echo layer.keys
        # echo $(layer.values)
        for feature in layer.features:

            # TODO - decode geometry, but it's big mess

            # maybe I can copy some ideas from Paul Mach's Orb
            # see https://github.com/paulmach/orb/tree/master/encoding/mvt

            echo("geometry = " & $(feature.geometry))
            case feature.ftype:
                of POINT: echo "(point)"
                of LINESTRING: echo "(linesting)"
                of POLYGON: echo "(polygon)"
                else: echo "?"
            
            if feature.ftype == POINT:
                var x = float(feature.geometry[1])
                var y = float (feature.geometry[2])
                # this outputs some random garbage instead of GPS or 0-256 
                echo "(" & $(x/float(layer.extent)) & "," & $(y/float(layer.extent)) & ")"
            
            # echo layer.extent
            
            # tags are somewhat more sane
            var i = 0
            for tag in feature.tags:
                if i mod 2 == 0:
                    echo layer.keys[tag] & "="
                else:
                    echo layer.values[tag].stringValue
                i = i + 1
                
    echo "Done"    

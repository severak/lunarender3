import streams
import zippy
import nimpb/nimpb
import vector_tile_pb

when isMainModule:
    echo "OK"
    let testFile = readFile("src/test.bin")
    let tileSrc = uncompress(testFile)
    let tile = readvector_tile_Tile(newStringStream(tileSrc))
    #echo(tile)
    for layer in tile.layers:
        echo layer.name
    echo "Done"    

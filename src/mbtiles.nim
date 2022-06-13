## Logic for opening MBTiles file.
##
## TODO - metadata extraction here.

import std/db_sqlite

proc openTiles*(fileName: string): DbConn =
    result = db_sqlite.open(fileName, "", "", "")

proc getTile*(db: DbConn, x: int, y: int, z: int): string =
    db.getValue(sql"SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?", z, x, y)

proc closeTiles*(db: DbConn): bool =
    db.close()

when isMainModule:
    import std/md5
    import tile
    var testdata = openTiles("src/testdata/lux.mbtiles")
    discard decodeVectorTile(testdata.getTile(0,0,0))
    discard decodeVectorTile(testdata.getTile(1,0,1))
    discard decodeVectorTile(testdata.getTile(1,1,1))
    discard decodeVectorTile(testdata.getTile(2,1,2))
    discard testdata.closeTiles()
    echo "OK"
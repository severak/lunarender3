import std/db_sqlite

proc openTiles*(fileName: string): DbConn =
    result = db_sqlite.open(fileName, "", "", "")

proc getTile*(db: DbConn, z: int, x: int, y: int): string =
    db.getValue(sql"SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?", z, x, y)

proc closeTiles*(db: DbConn): bool =
    db.close()
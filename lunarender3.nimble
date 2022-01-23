# Package

version       = "0.1.0"
author        = "severak"
description   = "experimental openstreetmap renderer"
license       = "MIT"
srcDir        = "src"
bin           = @["lunarender3"]


# Dependencies

requires "nim >= 1.6.2"
requires "jester >= 0.5.0"
requires "pixie >= 3.1.2"
# TODO - requires nimpb
# TODO - required zippy 0.7.4


# TODO - tasky
# nimpb_build -I=src --out=src src/vector_tile.proto
# nim c -r src\tile.nim
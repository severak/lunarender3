# Package

version       = "0.1.0"
author        = "severak"
description   = "experimental openstreetmap renderer"
license       = "MIT"
srcDir        = "src"
bin           = @["lunarender3"]


# Dependencies

# (versions installed on my machine, probably works even with lower versions)

requires "nim >= 1.6.2"
requires "jester >= 0.5.0"
requires "pixie >= 3.1.2"
requires "nimpb >= 0.2.0"
requires "zippy >= 0.7.4"
requires "cligen >= 1.5.20"

task genparser, "Generates MVT parser.":
    exec "nimpb_build -I=src --out=src src/vector_tile.proto"

task testtile, "Test tile reading code.":
    exec "nim c -r src/tile.nim"
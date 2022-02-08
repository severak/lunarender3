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
requires "benchy >= 0.0.1"

task genparser, "Generates MVT parser.":
    exec "nimpb_build -I=src --out=src src/vector_tile.proto"

task testtile, "Test tile reading code.":
    exec "nim c -r src/tile.nim"

task topfive, "Renders top five tiles to test if it works.":
    exec "lunarender3 single -z=0 -x=0 -y=0 --dest=0.0.0.png"
    exec "lunarender3 single -z=1 -x=0 -y=0 --dest=1.0.0.png"
    exec "lunarender3 single -z=1 -x=0 -y=1 --dest=1.0.1.png"
    exec "lunarender3 single -z=1 -x=1 -y=0 --dest=1.1.0.png"
    exec "lunarender3 single -z=1 -x=1 -y=1 --dest=1.1.1.png"

task benchpress, "Compile and run benchmark.":
    exec "nim c -r -d:release src/lunarender3.nim benchmark"
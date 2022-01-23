# Generated by protoc_gen_nim. Do not edit!

import base64
import intsets
import json
import strutils

import nimpb/nimpb
import nimpb/json as nimpb_json

type
    vector_tile_Tile_GeomType* {.pure.} = enum
        UNKNOWN = 0
        POINT = 1
        LINESTRING = 2
        POLYGON = 3
    vector_tile_Tile* = ref vector_tile_TileObj
    vector_tile_TileObj* = object of Message
        layers: seq[vector_tile_Tile_Layer]
    vector_tile_Tile_Layer* = ref vector_tile_Tile_LayerObj
    vector_tile_Tile_LayerObj* = object of Message
        version: uint32
        name: string
        features: seq[vector_tile_Tile_Feature]
        keys: seq[string]
        values: seq[vector_tile_Tile_Value]
        extent: uint32
    vector_tile_Tile_Feature* = ref vector_tile_Tile_FeatureObj
    vector_tile_Tile_FeatureObj* = object of Message
        id: uint64
        tags: seq[uint32]
        ftype: vector_tile_Tile_GeomType
        geometry: seq[uint32]
    vector_tile_Tile_Value* = ref vector_tile_Tile_ValueObj
    vector_tile_Tile_ValueObj* = object of Message
        stringValue: string
        floatValue: float32
        doubleValue: float64
        intValue: int64
        uintValue: uint64
        sintValue: int64
        boolValue: bool

proc newvector_tile_Tile_Value*(): vector_tile_Tile_Value
proc newvector_tile_Tile_Value*(data: string): vector_tile_Tile_Value
proc newvector_tile_Tile_Value*(data: seq[byte]): vector_tile_Tile_Value
proc writevector_tile_Tile_Value*(stream: Stream, message: vector_tile_Tile_Value)
proc readvector_tile_Tile_Value*(stream: Stream): vector_tile_Tile_Value
proc sizeOfvector_tile_Tile_Value*(message: vector_tile_Tile_Value): uint64

proc newvector_tile_Tile_Feature*(): vector_tile_Tile_Feature
proc newvector_tile_Tile_Feature*(data: string): vector_tile_Tile_Feature
proc newvector_tile_Tile_Feature*(data: seq[byte]): vector_tile_Tile_Feature
proc writevector_tile_Tile_Feature*(stream: Stream, message: vector_tile_Tile_Feature)
proc readvector_tile_Tile_Feature*(stream: Stream): vector_tile_Tile_Feature
proc sizeOfvector_tile_Tile_Feature*(message: vector_tile_Tile_Feature): uint64

proc newvector_tile_Tile_Layer*(): vector_tile_Tile_Layer
proc newvector_tile_Tile_Layer*(data: string): vector_tile_Tile_Layer
proc newvector_tile_Tile_Layer*(data: seq[byte]): vector_tile_Tile_Layer
proc writevector_tile_Tile_Layer*(stream: Stream, message: vector_tile_Tile_Layer)
proc readvector_tile_Tile_Layer*(stream: Stream): vector_tile_Tile_Layer
proc sizeOfvector_tile_Tile_Layer*(message: vector_tile_Tile_Layer): uint64

proc newvector_tile_Tile*(): vector_tile_Tile
proc newvector_tile_Tile*(data: string): vector_tile_Tile
proc newvector_tile_Tile*(data: seq[byte]): vector_tile_Tile
proc writevector_tile_Tile*(stream: Stream, message: vector_tile_Tile)
proc readvector_tile_Tile*(stream: Stream): vector_tile_Tile
proc sizeOfvector_tile_Tile*(message: vector_tile_Tile): uint64

proc fullyQualifiedName*(T: typedesc[vector_tile_Tile_Value]): string = "vector_tile.Tile.Value"

proc readvector_tile_Tile_ValueImpl(stream: Stream): Message = readvector_tile_Tile_Value(stream)
proc writevector_tile_Tile_ValueImpl(stream: Stream, msg: Message) = writevector_tile_Tile_Value(stream, vector_tile_Tile_Value(msg))

proc vector_tile_Tile_ValueProcs*(): MessageProcs =
    result.readImpl = readvector_tile_Tile_ValueImpl
    result.writeImpl = writevector_tile_Tile_ValueImpl

proc newvector_tile_Tile_Value*(): vector_tile_Tile_Value =
    new(result)
    initMessage(result[])
    result.procs = vector_tile_Tile_ValueProcs()
    result.stringValue = ""
    result.floatValue = 0
    result.doubleValue = 0
    result.intValue = 0
    result.uintValue = 0
    result.sintValue = 0
    result.boolValue = false

proc clearstringValue*(message: vector_tile_Tile_Value) =
    message.stringValue = ""
    clearFields(message, [1])

proc hasstringValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 1)

proc setstringValue*(message: vector_tile_Tile_Value, value: string) =
    message.stringValue = value
    setField(message, 1)

proc stringValue*(message: vector_tile_Tile_Value): string {.inline.} =
    message.stringValue

proc `stringValue=`*(message: vector_tile_Tile_Value, value: string) {.inline.} =
    setstringValue(message, value)

proc clearfloatValue*(message: vector_tile_Tile_Value) =
    message.floatValue = 0
    clearFields(message, [2])

proc hasfloatValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 2)

proc setfloatValue*(message: vector_tile_Tile_Value, value: float32) =
    message.floatValue = value
    setField(message, 2)

proc floatValue*(message: vector_tile_Tile_Value): float32 {.inline.} =
    message.floatValue

proc `floatValue=`*(message: vector_tile_Tile_Value, value: float32) {.inline.} =
    setfloatValue(message, value)

proc cleardoubleValue*(message: vector_tile_Tile_Value) =
    message.doubleValue = 0
    clearFields(message, [3])

proc hasdoubleValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 3)

proc setdoubleValue*(message: vector_tile_Tile_Value, value: float64) =
    message.doubleValue = value
    setField(message, 3)

proc doubleValue*(message: vector_tile_Tile_Value): float64 {.inline.} =
    message.doubleValue

proc `doubleValue=`*(message: vector_tile_Tile_Value, value: float64) {.inline.} =
    setdoubleValue(message, value)

proc clearintValue*(message: vector_tile_Tile_Value) =
    message.intValue = 0
    clearFields(message, [4])

proc hasintValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 4)

proc setintValue*(message: vector_tile_Tile_Value, value: int64) =
    message.intValue = value
    setField(message, 4)

proc intValue*(message: vector_tile_Tile_Value): int64 {.inline.} =
    message.intValue

proc `intValue=`*(message: vector_tile_Tile_Value, value: int64) {.inline.} =
    setintValue(message, value)

proc clearuintValue*(message: vector_tile_Tile_Value) =
    message.uintValue = 0
    clearFields(message, [5])

proc hasuintValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 5)

proc setuintValue*(message: vector_tile_Tile_Value, value: uint64) =
    message.uintValue = value
    setField(message, 5)

proc uintValue*(message: vector_tile_Tile_Value): uint64 {.inline.} =
    message.uintValue

proc `uintValue=`*(message: vector_tile_Tile_Value, value: uint64) {.inline.} =
    setuintValue(message, value)

proc clearsintValue*(message: vector_tile_Tile_Value) =
    message.sintValue = 0
    clearFields(message, [6])

proc hassintValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 6)

proc setsintValue*(message: vector_tile_Tile_Value, value: int64) =
    message.sintValue = value
    setField(message, 6)

proc sintValue*(message: vector_tile_Tile_Value): int64 {.inline.} =
    message.sintValue

proc `sintValue=`*(message: vector_tile_Tile_Value, value: int64) {.inline.} =
    setsintValue(message, value)

proc clearboolValue*(message: vector_tile_Tile_Value) =
    message.boolValue = false
    clearFields(message, [7])

proc hasboolValue*(message: vector_tile_Tile_Value): bool =
    result = hasField(message, 7)

proc setboolValue*(message: vector_tile_Tile_Value, value: bool) =
    message.boolValue = value
    setField(message, 7)

proc boolValue*(message: vector_tile_Tile_Value): bool {.inline.} =
    message.boolValue

proc `boolValue=`*(message: vector_tile_Tile_Value, value: bool) {.inline.} =
    setboolValue(message, value)

proc sizeOfvector_tile_Tile_Value*(message: vector_tile_Tile_Value): uint64 =
    if hasstringValue(message):
        result = result + sizeOfTag(1, WireType.LengthDelimited)
        result = result + sizeOfString(message.stringValue)
    if hasfloatValue(message):
        result = result + sizeOfTag(2, WireType.Fixed32)
        result = result + sizeOfFloat(message.floatValue)
    if hasdoubleValue(message):
        result = result + sizeOfTag(3, WireType.Fixed64)
        result = result + sizeOfDouble(message.doubleValue)
    if hasintValue(message):
        result = result + sizeOfTag(4, WireType.Varint)
        result = result + sizeOfInt64(message.intValue)
    if hasuintValue(message):
        result = result + sizeOfTag(5, WireType.Varint)
        result = result + sizeOfUInt64(message.uintValue)
    if hassintValue(message):
        result = result + sizeOfTag(6, WireType.Varint)
        result = result + sizeOfSInt64(message.sintValue)
    if hasboolValue(message):
        result = result + sizeOfTag(7, WireType.Varint)
        result = result + sizeOfBool(message.boolValue)
    result = result + sizeOfUnknownFields(message)

proc writevector_tile_Tile_Value*(stream: Stream, message: vector_tile_Tile_Value) =
    if hasstringValue(message):
        protoWriteString(stream, message.stringValue, 1)
    if hasfloatValue(message):
        protoWriteFloat(stream, message.floatValue, 2)
    if hasdoubleValue(message):
        protoWriteDouble(stream, message.doubleValue, 3)
    if hasintValue(message):
        protoWriteInt64(stream, message.intValue, 4)
    if hasuintValue(message):
        protoWriteUInt64(stream, message.uintValue, 5)
    if hassintValue(message):
        protoWriteSInt64(stream, message.sintValue, 6)
    if hasboolValue(message):
        protoWriteBool(stream, message.boolValue, 7)
    writeUnknownFields(stream, message)

proc readvector_tile_Tile_Value*(stream: Stream): vector_tile_Tile_Value =
    result = newvector_tile_Tile_Value()
    while not atEnd(stream):
        let
            tag = readTag(stream)
            wireType = wireType(tag)
        case fieldNumber(tag)
        of 0:
            raise newException(InvalidFieldNumberError, "Invalid field number: 0")
        of 1:
            expectWireType(wireType, WireType.LengthDelimited)
            setstringValue(result, protoReadString(stream))
        of 2:
            expectWireType(wireType, WireType.Fixed32)
            setfloatValue(result, protoReadFloat(stream))
        of 3:
            expectWireType(wireType, WireType.Fixed64)
            setdoubleValue(result, protoReadDouble(stream))
        of 4:
            expectWireType(wireType, WireType.Varint)
            setintValue(result, protoReadInt64(stream))
        of 5:
            expectWireType(wireType, WireType.Varint)
            setuintValue(result, protoReadUInt64(stream))
        of 6:
            expectWireType(wireType, WireType.Varint)
            setsintValue(result, protoReadSInt64(stream))
        of 7:
            expectWireType(wireType, WireType.Varint)
            setboolValue(result, protoReadBool(stream))
        else: readUnknownField(stream, result, tag)

proc serialize*(message: vector_tile_Tile_Value): string =
    let
        ss = newStringStream()
    writevector_tile_Tile_Value(ss, message)
    result = ss.data

proc newvector_tile_Tile_Value*(data: string): vector_tile_Tile_Value =
    let
        ss = newStringStream(data)
    result = readvector_tile_Tile_Value(ss)

proc newvector_tile_Tile_Value*(data: seq[byte]): vector_tile_Tile_Value =
    let
        ss = newStringStream(cast[string](data))
    result = readvector_tile_Tile_Value(ss)


proc fullyQualifiedName*(T: typedesc[vector_tile_Tile_Feature]): string = "vector_tile.Tile.Feature"

proc readvector_tile_Tile_FeatureImpl(stream: Stream): Message = readvector_tile_Tile_Feature(stream)
proc writevector_tile_Tile_FeatureImpl(stream: Stream, msg: Message) = writevector_tile_Tile_Feature(stream, vector_tile_Tile_Feature(msg))

proc vector_tile_Tile_FeatureProcs*(): MessageProcs =
    result.readImpl = readvector_tile_Tile_FeatureImpl
    result.writeImpl = writevector_tile_Tile_FeatureImpl

proc newvector_tile_Tile_Feature*(): vector_tile_Tile_Feature =
    new(result)
    initMessage(result[])
    result.procs = vector_tile_Tile_FeatureProcs()
    result.id = 0
    result.tags = @[]
    result.ftype = vector_tile_Tile_GeomType.UNKNOWN
    result.geometry = @[]

proc clearid*(message: vector_tile_Tile_Feature) =
    message.id = 0
    clearFields(message, [1])

proc hasid*(message: vector_tile_Tile_Feature): bool =
    result = hasField(message, 1)

proc setid*(message: vector_tile_Tile_Feature, value: uint64) =
    message.id = value
    setField(message, 1)

proc id*(message: vector_tile_Tile_Feature): uint64 {.inline.} =
    message.id

proc `id=`*(message: vector_tile_Tile_Feature, value: uint64) {.inline.} =
    setid(message, value)

proc cleartags*(message: vector_tile_Tile_Feature) =
    message.tags = @[]
    clearFields(message, [2])

proc hastags*(message: vector_tile_Tile_Feature): bool =
    result = hasField(message, 2) or (len(message.tags) > 0)

proc settags*(message: vector_tile_Tile_Feature, value: seq[uint32]) =
    message.tags = value
    setField(message, 2)

proc addtags*(message: vector_tile_Tile_Feature, value: uint32) =
    add(message.tags, value)

proc tags*(message: vector_tile_Tile_Feature): seq[uint32] {.inline.} =
    message.tags

proc `tags=`*(message: vector_tile_Tile_Feature, value: seq[uint32]) {.inline.} =
    settags(message, value)

proc clearftype*(message: vector_tile_Tile_Feature) =
    message.ftype = vector_tile_Tile_GeomType.UNKNOWN
    clearFields(message, [3])

proc hasftype*(message: vector_tile_Tile_Feature): bool =
    result = hasField(message, 3)

proc setftype*(message: vector_tile_Tile_Feature, value: vector_tile_Tile_GeomType) =
    message.ftype = value
    setField(message, 3)

proc ftype*(message: vector_tile_Tile_Feature): vector_tile_Tile_GeomType {.inline.} =
    message.ftype

proc `ftype=`*(message: vector_tile_Tile_Feature, value: vector_tile_Tile_GeomType) {.inline.} =
    setftype(message, value)

proc cleargeometry*(message: vector_tile_Tile_Feature) =
    message.geometry = @[]
    clearFields(message, [4])

proc hasgeometry*(message: vector_tile_Tile_Feature): bool =
    result = hasField(message, 4) or (len(message.geometry) > 0)

proc setgeometry*(message: vector_tile_Tile_Feature, value: seq[uint32]) =
    message.geometry = value
    setField(message, 4)

proc addgeometry*(message: vector_tile_Tile_Feature, value: uint32) =
    add(message.geometry, value)

proc geometry*(message: vector_tile_Tile_Feature): seq[uint32] {.inline.} =
    message.geometry

proc `geometry=`*(message: vector_tile_Tile_Feature, value: seq[uint32]) {.inline.} =
    setgeometry(message, value)

proc sizeOfvector_tile_Tile_Feature*(message: vector_tile_Tile_Feature): uint64 =
    if hasid(message):
        result = result + sizeOfTag(1, WireType.Varint)
        result = result + sizeOfUInt64(message.id)
    if len(message.tags) > 0:
        result = result + sizeOfTag(2, WireType.LengthDelimited)
        result = result + sizeOfLengthDelimited(packedFieldSize(message.tags, FieldType.UInt32))
    if hasftype(message):
        result = result + sizeOfTag(3, WireType.Varint)
        result = result + sizeOfEnum[vector_tile_Tile_GeomType](message.ftype)
    if len(message.geometry) > 0:
        result = result + sizeOfTag(4, WireType.LengthDelimited)
        result = result + sizeOfLengthDelimited(packedFieldSize(message.geometry, FieldType.UInt32))
    result = result + sizeOfUnknownFields(message)

proc writevector_tile_Tile_Feature*(stream: Stream, message: vector_tile_Tile_Feature) =
    if hasid(message):
        protoWriteUInt64(stream, message.id, 1)
    if len(message.tags) > 0:
        writeTag(stream, 2, WireType.LengthDelimited)
        writeVarint(stream, packedFieldSize(message.tags, FieldType.UInt32))
        for value in message.tags:
            protoWriteUInt32(stream, value)
    if hasftype(message):
        protoWriteEnum(stream, message.ftype, 3)
    if len(message.geometry) > 0:
        writeTag(stream, 4, WireType.LengthDelimited)
        writeVarint(stream, packedFieldSize(message.geometry, FieldType.UInt32))
        for value in message.geometry:
            protoWriteUInt32(stream, value)
    writeUnknownFields(stream, message)

proc readvector_tile_Tile_Feature*(stream: Stream): vector_tile_Tile_Feature =
    result = newvector_tile_Tile_Feature()
    while not atEnd(stream):
        let
            tag = readTag(stream)
            wireType = wireType(tag)
        case fieldNumber(tag)
        of 0:
            raise newException(InvalidFieldNumberError, "Invalid field number: 0")
        of 1:
            expectWireType(wireType, WireType.Varint)
            setid(result, protoReadUInt64(stream))
        of 2:
            expectWireType(wireType, WireType.Varint, WireType.LengthDelimited)
            if wireType == WireType.LengthDelimited:
                let
                    size = readVarint(stream)
                    start = uint64(getPosition(stream))
                var consumed = 0'u64
                while consumed < size:
                    addtags(result, protoReadUInt32(stream))
                    consumed = uint64(getPosition(stream)) - start
                if consumed != size:
                    raise newException(Exception, "packed field size mismatch")
            else:
                addtags(result, protoReadUInt32(stream))
        of 3:
            expectWireType(wireType, WireType.Varint)
            setftype(result, protoReadEnum[vector_tile_Tile_GeomType](stream))
        of 4:
            expectWireType(wireType, WireType.Varint, WireType.LengthDelimited)
            if wireType == WireType.LengthDelimited:
                let
                    size = readVarint(stream)
                    start = uint64(getPosition(stream))
                var consumed = 0'u64
                while consumed < size:
                    addgeometry(result, protoReadUInt32(stream))
                    consumed = uint64(getPosition(stream)) - start
                if consumed != size:
                    raise newException(Exception, "packed field size mismatch")
            else:
                addgeometry(result, protoReadUInt32(stream))
        else: readUnknownField(stream, result, tag)

proc serialize*(message: vector_tile_Tile_Feature): string =
    let
        ss = newStringStream()
    writevector_tile_Tile_Feature(ss, message)
    result = ss.data

proc newvector_tile_Tile_Feature*(data: string): vector_tile_Tile_Feature =
    let
        ss = newStringStream(data)
    result = readvector_tile_Tile_Feature(ss)

proc newvector_tile_Tile_Feature*(data: seq[byte]): vector_tile_Tile_Feature =
    let
        ss = newStringStream(cast[string](data))
    result = readvector_tile_Tile_Feature(ss)


proc fullyQualifiedName*(T: typedesc[vector_tile_Tile_Layer]): string = "vector_tile.Tile.Layer"

proc readvector_tile_Tile_LayerImpl(stream: Stream): Message = readvector_tile_Tile_Layer(stream)
proc writevector_tile_Tile_LayerImpl(stream: Stream, msg: Message) = writevector_tile_Tile_Layer(stream, vector_tile_Tile_Layer(msg))

proc vector_tile_Tile_LayerProcs*(): MessageProcs =
    result.readImpl = readvector_tile_Tile_LayerImpl
    result.writeImpl = writevector_tile_Tile_LayerImpl

proc newvector_tile_Tile_Layer*(): vector_tile_Tile_Layer =
    new(result)
    initMessage(result[])
    result.procs = vector_tile_Tile_LayerProcs()
    result.version = 1
    result.name = ""
    result.features = @[]
    result.keys = @[]
    result.values = @[]
    result.extent = 4096

proc clearversion*(message: vector_tile_Tile_Layer) =
    message.version = 1
    clearFields(message, [15])

proc hasversion*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 15)

proc setversion*(message: vector_tile_Tile_Layer, value: uint32) =
    message.version = value
    setField(message, 15)

proc version*(message: vector_tile_Tile_Layer): uint32 {.inline.} =
    message.version

proc `version=`*(message: vector_tile_Tile_Layer, value: uint32) {.inline.} =
    setversion(message, value)

proc clearname*(message: vector_tile_Tile_Layer) =
    message.name = ""
    clearFields(message, [1])

proc hasname*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 1)

proc setname*(message: vector_tile_Tile_Layer, value: string) =
    message.name = value
    setField(message, 1)

proc name*(message: vector_tile_Tile_Layer): string {.inline.} =
    message.name

proc `name=`*(message: vector_tile_Tile_Layer, value: string) {.inline.} =
    setname(message, value)

proc clearfeatures*(message: vector_tile_Tile_Layer) =
    message.features = @[]
    clearFields(message, [2])

proc hasfeatures*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 2) or (len(message.features) > 0)

proc setfeatures*(message: vector_tile_Tile_Layer, value: seq[vector_tile_Tile_Feature]) =
    message.features = value
    setField(message, 2)

proc addfeatures*(message: vector_tile_Tile_Layer, value: vector_tile_Tile_Feature) =
    add(message.features, value)

proc features*(message: vector_tile_Tile_Layer): seq[vector_tile_Tile_Feature] {.inline.} =
    message.features

proc `features=`*(message: vector_tile_Tile_Layer, value: seq[vector_tile_Tile_Feature]) {.inline.} =
    setfeatures(message, value)

proc clearkeys*(message: vector_tile_Tile_Layer) =
    message.keys = @[]
    clearFields(message, [3])

proc haskeys*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 3) or (len(message.keys) > 0)

proc setkeys*(message: vector_tile_Tile_Layer, value: seq[string]) =
    message.keys = value
    setField(message, 3)

proc addkeys*(message: vector_tile_Tile_Layer, value: string) =
    add(message.keys, value)

proc keys*(message: vector_tile_Tile_Layer): seq[string] {.inline.} =
    message.keys

proc `keys=`*(message: vector_tile_Tile_Layer, value: seq[string]) {.inline.} =
    setkeys(message, value)

proc clearvalues*(message: vector_tile_Tile_Layer) =
    message.values = @[]
    clearFields(message, [4])

proc hasvalues*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 4) or (len(message.values) > 0)

proc setvalues*(message: vector_tile_Tile_Layer, value: seq[vector_tile_Tile_Value]) =
    message.values = value
    setField(message, 4)

proc addvalues*(message: vector_tile_Tile_Layer, value: vector_tile_Tile_Value) =
    add(message.values, value)

proc values*(message: vector_tile_Tile_Layer): seq[vector_tile_Tile_Value] {.inline.} =
    message.values

proc `values=`*(message: vector_tile_Tile_Layer, value: seq[vector_tile_Tile_Value]) {.inline.} =
    setvalues(message, value)

proc clearextent*(message: vector_tile_Tile_Layer) =
    message.extent = 4096
    clearFields(message, [5])

proc hasextent*(message: vector_tile_Tile_Layer): bool =
    result = hasField(message, 5)

proc setextent*(message: vector_tile_Tile_Layer, value: uint32) =
    message.extent = value
    setField(message, 5)

proc extent*(message: vector_tile_Tile_Layer): uint32 {.inline.} =
    message.extent

proc `extent=`*(message: vector_tile_Tile_Layer, value: uint32) {.inline.} =
    setextent(message, value)

proc sizeOfvector_tile_Tile_Layer*(message: vector_tile_Tile_Layer): uint64 =
    if hasversion(message):
        result = result + sizeOfTag(15, WireType.Varint)
        result = result + sizeOfUInt32(message.version)
    if hasname(message):
        result = result + sizeOfTag(1, WireType.LengthDelimited)
        result = result + sizeOfString(message.name)
    for value in message.features:
        result = result + sizeOfTag(2, WireType.LengthDelimited)
        result = result + sizeOfLengthDelimited(sizeOfvector_tile_Tile_Feature(value))
    for value in message.keys:
        result = result + sizeOfTag(3, WireType.LengthDelimited)
        result = result + sizeOfString(value)
    for value in message.values:
        result = result + sizeOfTag(4, WireType.LengthDelimited)
        result = result + sizeOfLengthDelimited(sizeOfvector_tile_Tile_Value(value))
    if hasextent(message):
        result = result + sizeOfTag(5, WireType.Varint)
        result = result + sizeOfUInt32(message.extent)
    result = result + sizeOfUnknownFields(message)

proc writevector_tile_Tile_Layer*(stream: Stream, message: vector_tile_Tile_Layer) =
    if hasversion(message):
        protoWriteUInt32(stream, message.version, 15)
    if hasname(message):
        protoWriteString(stream, message.name, 1)
    for value in message.features:
        writeMessage(stream, value, 2)
    for value in message.keys:
        protoWriteString(stream, value, 3)
    for value in message.values:
        writeMessage(stream, value, 4)
    if hasextent(message):
        protoWriteUInt32(stream, message.extent, 5)
    writeUnknownFields(stream, message)

proc readvector_tile_Tile_Layer*(stream: Stream): vector_tile_Tile_Layer =
    result = newvector_tile_Tile_Layer()
    while not atEnd(stream):
        let
            tag = readTag(stream)
            wireType = wireType(tag)
        case fieldNumber(tag)
        of 0:
            raise newException(InvalidFieldNumberError, "Invalid field number: 0")
        of 15:
            expectWireType(wireType, WireType.Varint)
            setversion(result, protoReadUInt32(stream))
        of 1:
            expectWireType(wireType, WireType.LengthDelimited)
            setname(result, protoReadString(stream))
        of 2:
            expectWireType(wireType, WireType.LengthDelimited)
            let data = readLengthDelimited(stream)
            addfeatures(result, newvector_tile_Tile_Feature(data))
        of 3:
            expectWireType(wireType, WireType.LengthDelimited)
            addkeys(result, protoReadString(stream))
        of 4:
            expectWireType(wireType, WireType.LengthDelimited)
            let data = readLengthDelimited(stream)
            addvalues(result, newvector_tile_Tile_Value(data))
        of 5:
            expectWireType(wireType, WireType.Varint)
            setextent(result, protoReadUInt32(stream))
        else: readUnknownField(stream, result, tag)

proc serialize*(message: vector_tile_Tile_Layer): string =
    let
        ss = newStringStream()
    writevector_tile_Tile_Layer(ss, message)
    result = ss.data

proc newvector_tile_Tile_Layer*(data: string): vector_tile_Tile_Layer =
    let
        ss = newStringStream(data)
    result = readvector_tile_Tile_Layer(ss)

proc newvector_tile_Tile_Layer*(data: seq[byte]): vector_tile_Tile_Layer =
    let
        ss = newStringStream(cast[string](data))
    result = readvector_tile_Tile_Layer(ss)


proc fullyQualifiedName*(T: typedesc[vector_tile_Tile]): string = "vector_tile.Tile"

proc readvector_tile_TileImpl(stream: Stream): Message = readvector_tile_Tile(stream)
proc writevector_tile_TileImpl(stream: Stream, msg: Message) = writevector_tile_Tile(stream, vector_tile_Tile(msg))

proc vector_tile_TileProcs*(): MessageProcs =
    result.readImpl = readvector_tile_TileImpl
    result.writeImpl = writevector_tile_TileImpl

proc newvector_tile_Tile*(): vector_tile_Tile =
    new(result)
    initMessage(result[])
    result.procs = vector_tile_TileProcs()
    result.layers = @[]

proc clearlayers*(message: vector_tile_Tile) =
    message.layers = @[]
    clearFields(message, [3])

proc haslayers*(message: vector_tile_Tile): bool =
    result = hasField(message, 3) or (len(message.layers) > 0)

proc setlayers*(message: vector_tile_Tile, value: seq[vector_tile_Tile_Layer]) =
    message.layers = value
    setField(message, 3)

proc addlayers*(message: vector_tile_Tile, value: vector_tile_Tile_Layer) =
    add(message.layers, value)

proc layers*(message: vector_tile_Tile): seq[vector_tile_Tile_Layer] {.inline.} =
    message.layers

proc `layers=`*(message: vector_tile_Tile, value: seq[vector_tile_Tile_Layer]) {.inline.} =
    setlayers(message, value)

proc sizeOfvector_tile_Tile*(message: vector_tile_Tile): uint64 =
    for value in message.layers:
        result = result + sizeOfTag(3, WireType.LengthDelimited)
        result = result + sizeOfLengthDelimited(sizeOfvector_tile_Tile_Layer(value))
    result = result + sizeOfUnknownFields(message)

proc writevector_tile_Tile*(stream: Stream, message: vector_tile_Tile) =
    for value in message.layers:
        writeMessage(stream, value, 3)
    writeUnknownFields(stream, message)

proc readvector_tile_Tile*(stream: Stream): vector_tile_Tile =
    result = newvector_tile_Tile()
    while not atEnd(stream):
        let
            tag = readTag(stream)
            wireType = wireType(tag)
        case fieldNumber(tag)
        of 0:
            raise newException(InvalidFieldNumberError, "Invalid field number: 0")
        of 3:
            expectWireType(wireType, WireType.LengthDelimited)
            let data = readLengthDelimited(stream)
            addlayers(result, newvector_tile_Tile_Layer(data))
        else: readUnknownField(stream, result, tag)

proc serialize*(message: vector_tile_Tile): string =
    let
        ss = newStringStream()
    writevector_tile_Tile(ss, message)
    result = ss.data

proc newvector_tile_Tile*(data: string): vector_tile_Tile =
    let
        ss = newStringStream(data)
    result = readvector_tile_Tile(ss)

proc newvector_tile_Tile*(data: seq[byte]): vector_tile_Tile =
    let
        ss = newStringStream(cast[string](data))
    result = readvector_tile_Tile(ss)



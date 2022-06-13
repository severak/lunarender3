## All the logic for rendering and style definition.
## 
## TODO - lua parsing here

import tile 
import pixie
import std/tables
import sugar

type 
    StringsTable = Table[string, string]

    StyleRuleType = enum
        srLine, srArea, srText, srIcon

    StyleRule* = object
        kind*: StyleRuleType 
        minzoom*: int
        maxzoom*: int
        layer*: string
        what*: proc(tags: StringsTable): bool
        color*: Color
        width*: float
        font*: Font
        fontSize*: int
        fontHalo*: Color
        label*: string
        fallback*: string
        # TODO - centering text

    StyleRules* = object
        background*: Color
        rules*: seq[StyleRule]

proc ruleValidForZoom(rule: StyleRule, zoom: int): bool =
    zoom >= rule.minzoom and zoom <= rule.maxzoom

proc ruleValidForFeat(rule: StyleRule, feat: Feature): bool =
    result = feat.layer == rule.layer
    if not isNil(rule.what):
        result = result and rule.what(feat.tags)

proc drawFeat(img: Image, feat: Feature, rule: StyleRule, imgSize: int) =
    if (rule.kind==srLine or rule.kind==srArea)  and feat.geometryType!=FeatDrawType.dtPoint:
        var path = newPath()
        for subpath in feat.geometry:
            for ord, coord in subpath:
                if ord == 0:
                    path.moveTo(coord * float32(imgSize))
                else:
                    path.lineTo(coord * float32(imgSize))
        try:
            if rule.kind==srLine:
                strokePath(img, path, rule.color, mat3(), rule.width)
            if rule.kind==srArea:
                fillPath(img, path, rule.color)
        except IndexDefect:
            # some broken path - probably maritime border
            # TODO - fix this
            discard
    if rule.kind==srText and feat.geometryType==FeatDrawType.dtPoint:
        var toShow = "name"
        if rule.label != "":
            toShow = rule.label
            if rule.fallback != "" and not feat.tags.hasKey(rule.label) and feat.tags.hasKey(rule.fallback):
                toShow = rule.fallback
        if feat.tags.hasKey(toShow):
            try:
                if not isNil(rule.fontHalo):
                    rule.font.paint = parseSomePaint(rule.fontHalo)
                    # echo $(rule.font.paint)
                    # have fontHaloSize or something similar
                    strokeText(img, rule.font, feat.tags[toShow], translate(feat.geometry[0][0] * float32(imgSize)), 3)
                rule.font.paint = parseSomePaint(rule.color)
                fillText(img, rule.font, feat.tags[toShow], translate(feat.geometry[0][0] * float32(imgSize)))
            except IndexDefect:
                # some crap - bad data, broken font or something like that
                # TODO - fix this
                discard
            

proc drawTile*(tile: Tile, ruleset: StyleRules, imgSize: int, zoom: int): Image =
    let img = newImage(imgSize, imgSize)
    fill(img, ruleset.background)
    for rule in ruleset.rules:
        # echo rule
        if ruleValidForZoom(rule, zoom):
            # echo "zoom ok"
            for feat in tile.features:
                # echo feat.layer
                if ruleValidForFeat(rule, feat):
                    # echo "feat OK"
                    drawFeat(img, feat, rule, imgSize)
    result = img

proc makeExampleRuleset*(): StyleRules =
    ## AKA Vincent
    ## very simple map focused on railways
    const background = "#EEE8D5".parseHtmlColor
    const wood = "#CAEDAB".parseHtmlColor
    const water = "#7BAFDE".parseHtmlColor
    const road = "#F6C141".parseHtmlColor
    const rail = "#000000".parseHtmlColor
    const building = "#D6C1DE".parseHtmlColor
    const admin = "#882E72".parseHtmlColor
    const black = "#000000".parseHtmlColor

    var gidole = readFont("Gidole-Regular.ttf")

    var style = StyleRules()
    style.background = background

    proc isWood(tags: StringsTable): bool =
        tags.hasKey("class") and tags["class"] == "wood"

    # woods
    style.rules.add(StyleRule(color: wood, width: 1, minzoom: 0, maxzoom: 14, layer: "landcover", kind: srArea, what: isWood))

    # water
    style.rules.add(StyleRule(color: water, width: 1, minzoom: 0, maxzoom: 14, layer: "water", kind: srArea))
    style.rules.add(StyleRule(color: water, width: 1, minzoom: 0, maxzoom: 14, layer: "waterway", kind: srLine))

    proc isNotRailway(tags: StringsTable): bool =
        tags.hasKey("class") and tags["class"] != "rail"

    # buildings
    style.rules.add(StyleRule(color: building, width: 1, minzoom: 0, maxzoom: 14, layer: "building", kind: srArea))

    # road
    style.rules.add(StyleRule(color: road, width: 1, minzoom: 0, maxzoom: 14, layer: "transportation", kind: srLine, what: isNotRailway))

    proc isRailway(tags: StringsTable): bool =
        # echo tags
        tags.hasKey("class") and tags["class"] == "rail"

    # rail
    style.rules.add(StyleRule(color: rail, width: 1, minzoom: 0, maxzoom: 14, layer: "transportation", kind: srLine, what: isRailway))

    style.rules.add(StyleRule(color: "red".parseHtmlColor, width: 1, minzoom: 0, maxzoom: 14, layer: "transportation", kind: srLine, what: (tags) => tags.hasKey("class") and tags["class"]=="tram"))

    # boundaries
    style.rules.add(StyleRule(color: admin, width: 1, minzoom: 0, maxzoom: 14, layer: "boundary", kind: srLine))

    # place
    # continents
    style.rules.add(StyleRule(color: black, fontHalo: background, width: 1, minzoom: 0, maxzoom: 2, layer: "place", font: gidole, kind: srText, label: "name:latin", fallback:"name", what: (tags) => tags.hasKey("class") and tags["class"]=="continent"))
    # countries
    style.rules.add(StyleRule(color: black, fontHalo: background, width: 1, minzoom: 3, maxzoom: 5, layer: "place", font: gidole, kind: srText, label: "name:latin", fallback:"name", what: (tags) => tags.hasKey("class") and tags["class"]=="country"))
    # everything else
    style.rules.add(StyleRule(color: black, fontHalo: background, width: 1, minzoom: 6, maxzoom: 14, layer: "place", font: gidole, kind: srText, label: "name:latin", fallback:"name"))

    result = style

# TODO - test
#when isMainModule:
    

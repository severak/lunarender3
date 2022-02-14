-- Vincent - very simple style focused on railways
style "Vincent"
by "Severak"

default.font = "Gidole"

background "#EEE8D5"

-- woods
area{
    layer = "landcover",
    what = 'tags.class=="wood"',
    color = "#CAEDAB"
}

-- water
area{
    layer="water",
    color ="#7BAFDE"
}

line{
    layer = "waterway",
    color ="#7BAFDE"
}

-- buildings
area{
    layer = "building",
    color = "#D6C1DE"
}

-- roads
line{
    layer = "transportation",
    what = 'tags.class~="rail"',
    color = "#F6C141"
}

-- rail
line{
    layer = "transportation",
    what = 'tags.class=="rail"',
    color = "#000"
}

-- trams
line{
    layer = "transportation",
    what = 'tags.class=="tram"',
    color = "red"
}

-- places
-- continents
text{
    layer = "place",
    minzoom = 0,
    maxzoom = 2,
    what = "tags.class=='continent'"
}

-- countries
text{
    layer = "place",
    minzoom = 3,
    maxzoom = 5,
    what = "tags.class=='country'"
}

-- everything else
text{
    layer = "place",
    minzoom = 6
}
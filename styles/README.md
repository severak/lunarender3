# style definition

(not implemented yet, just idea)

```lua
line{
    minzoom = 0,
    maxzoom = 14,
    layer = 'transportation',
    what = 'tags.subclass=="rail"',
    color = '#ddd',
    width = 3
}

area{
    minzoom = 0,
    maxzoom = 14,
    layer = 'water',
    color = 'aqua'
}

icon{
    minzoom = 10,
    maxzoom = 14,
    layer = 'poi',
    icon = 'church.png'
    what = 'tags.class=="place_of_worship" and tags.sublass="christian"'
    dx = -16, -- offsets to place icon/text 
    dy  = 0
}

text{ -- name of church
    minzoom = 10,
    maxzoom = 14,
    layer = 'poi',
    what = 'tags.class=="place_of_worship" and tags.sublass="christian"'
    label = 'name:cs',
    fallback = 'name'
    dx = 2,
    font = 'Gidole 12'
}
```

TODO

- implement only basic symbols in Nim, make composite symbols from Lua
- make list of rectangles where symbols were placed, do not overwrite symbols
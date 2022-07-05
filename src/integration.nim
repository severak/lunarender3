## test of lua integration for lunarender. Does not fully work yet.

# lua needs to be modified
import lua

const
  code = """
print "Lua code is loaded."


moo = function(par)
    print "Function moo called."
    if par then
        print("with paramater " .. par)
    end
end

-- set this to true to break program
try_to_set_callback = true

if try_to_set_callback then
    setCallBack(moo)
    callback()
end
"""

# these does not work:

var callbackRef: cint

proc setCallBack(lua: PState): cint {.cdecl} =
    callbackRef = reference(lua, -1)
    echo "Callback set to " & $(callbackRef)
    return 0

proc doCallBack(lua: PState): cint {.cdecl} =
    echo "Calling callback..."
    getref(lua, callbackRef)
    if isfunction(lua, -1):
        var errRef: cint
        let errNo = pcall(lua, 0, 0, errRef)
        echo "Error! " & $(errNo)
        echo $(errRef)
        echo "Function called."
    else:
        echo "Callback is not a function."
    return 0

# these works

proc callLuaByName(lua: PState, name: string) =
    getglobal(lua, name)
    pushnumber(lua, 69)
    discard pcall(lua, 1, 0, 0)

proc callMe(lua: PState): cint {.cdecl} =
    echo "OK from nim"
    pushnumber(lua, 69)
    return 1

# this is never called

proc panika(lua: PState): cint {.cdecl} =
    echo "Panika!"


# starting program
var L = newstate()
openlibs(L)
discard atpanic(L, panika)
register(L, cstring("callNim"), callMe)
register(L, cstring("setCallBack"), setCallBack)
register(L, cstring("callback"), doCallBack)
discard loadbuffer(L, code, code.len, "line") 
discard pcall(L, 0, 0, 0)
callLuaByName(L, "moo")
echo "Program ended."
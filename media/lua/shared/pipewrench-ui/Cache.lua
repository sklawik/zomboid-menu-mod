local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____RGBA = require('pipewrench-ui/css/color/RGBA')
local asRGBA = ____RGBA.asRGBA
____exports.CachedValue = __TS__Class()
local CachedValue = ____exports.CachedValue
CachedValue.name = "CachedValue"
function CachedValue.prototype.____constructor(self, value)
    self.value = value
    self.dirty = true
end
____exports.CachedRectangle = __TS__Class()
local CachedRectangle = ____exports.CachedRectangle
CachedRectangle.name = "CachedRectangle"
function CachedRectangle.prototype.____constructor(self, x1, y1, x2, y2)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
end
____exports.ElementCache = __TS__Class()
local ElementCache = ____exports.ElementCache
ElementCache.name = "ElementCache"
function ElementCache.prototype.____constructor(self, element)
    self.inner = __TS__New(
        ____exports.CachedRectangle,
        0,
        0,
        0,
        0
    )
    self.outer = __TS__New(
        ____exports.CachedRectangle,
        0,
        0,
        0,
        0
    )
    self.width = __TS__New(____exports.CachedValue, 0)
    self.height = __TS__New(____exports.CachedValue, 0)
    self.backgroundColor = __TS__New(
        ____exports.CachedValue,
        asRGBA(
            0,
            0,
            0,
            0,
            "1"
        )
    )
    self.backgroundImage = __TS__New(____exports.CachedValue, nil)
    self.element = element
end
return ____exports

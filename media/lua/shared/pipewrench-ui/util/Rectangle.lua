local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
____exports.Rectangle = __TS__Class()
local Rectangle = ____exports.Rectangle
Rectangle.name = "Rectangle"
function Rectangle.prototype.____constructor(self)
end
function Rectangle.testPoint(self, x1, y1, x2, y2, px, py)
    return x1 <= px and px <= x2 and y1 <= py and py <= y2
end
return ____exports

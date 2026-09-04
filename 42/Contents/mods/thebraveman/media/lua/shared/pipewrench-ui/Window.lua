local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____html = require('pipewrench-ui/html/elements/html')
local document = ____html.document
local ____HTMLMouse = require('pipewrench-ui/input/HTMLMouse')
local HTMLMouse = ____HTMLMouse.HTMLMouse
____exports.Window = __TS__Class()
local Window = ____exports.Window
Window.name = "Window"
function Window.prototype.____constructor(self)
    self.mouse = __TS__New(HTMLMouse)
end
function Window.prototype.update(self)
    self.mouse:update()
    if self.mouse.moved then
        self:triggerEvent(self.mouse:newMoveEvent(document))
    end
end
function Window.prototype.triggerEvent(self, event)
    document:dispatchEvent(event)
end
____exports.window = __TS__New(____exports.Window)
return ____exports

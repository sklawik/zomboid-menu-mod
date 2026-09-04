local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____MouseEvent = require('pipewrench-ui/event/mouse/MouseEvent')
local MouseEvent = ____MouseEvent.MouseEvent
____exports.MouseEnterEvent = __TS__Class()
local MouseEnterEvent = ____exports.MouseEnterEvent
MouseEnterEvent.name = "MouseEnterEvent"
__TS__ClassExtends(MouseEnterEvent, MouseEvent)
function MouseEnterEvent.prototype.____constructor(self, mouse, target)
    MouseEvent.prototype.____constructor(self, "mouseenter", mouse, target)
end
function MouseEnterEvent.prototype.cloneEvent(self, target)
    return __TS__New(
        ____exports.MouseEnterEvent,
        __TS__ObjectAssign({}, self, {dx = self.movementX, dy = self.movementY}),
        target
    )
end
function MouseEnterEvent.prototype.test(self, target)
    return false
end
return ____exports

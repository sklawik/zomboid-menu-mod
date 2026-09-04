local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____Rectangle = require('pipewrench-ui/util/Rectangle')
local Rectangle = ____Rectangle.Rectangle
local ____MouseEvent = require('pipewrench-ui/event/mouse/MouseEvent')
local MouseEvent = ____MouseEvent.MouseEvent
--- The **MouseMoveEvent** is fired at an element when a pointing device (usually a mouse) is moved
-- while the cursor's hotspot is inside it.
-- 
-- @author mozilla.org, asledgehammer
____exports.MouseMoveEvent = __TS__Class()
local MouseMoveEvent = ____exports.MouseMoveEvent
MouseMoveEvent.name = "MouseMoveEvent"
__TS__ClassExtends(MouseMoveEvent, MouseEvent)
function MouseMoveEvent.prototype.____constructor(self, mouse, target)
    MouseEvent.prototype.____constructor(self, "mousemove", mouse, target)
end
function MouseMoveEvent.prototype.cloneEvent(self, target)
    return __TS__New(
        ____exports.MouseMoveEvent,
        __TS__ObjectAssign({}, self, {dx = self.movementX, dy = self.movementY}),
        target
    )
end
function MouseMoveEvent.prototype.test(self, target)
    local ____target_cache_outer_0 = target.cache.outer
    local x1 = ____target_cache_outer_0.x1
    local y1 = ____target_cache_outer_0.y1
    local x2 = ____target_cache_outer_0.x2
    local y2 = ____target_cache_outer_0.y2
    local result = Rectangle:testPoint(
        x1,
        y1,
        x2,
        y2,
        self.screenX,
        self.screenY
    )
    return result
end
return ____exports

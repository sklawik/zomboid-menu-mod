local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local getMouseX = ____pipewrench.getMouseX
local getMouseY = ____pipewrench.getMouseY
local isMouseButtonDown = ____pipewrench.isMouseButtonDown
local ____MouseMoveEvent = require('pipewrench-ui/event/mouse/MouseMoveEvent')
local MouseMoveEvent = ____MouseMoveEvent.MouseMoveEvent
____exports.MOUSE_BUTTON_LEFT = 0
____exports.MOUSE_BUTTON_RIGHT = 1
____exports.MOUSE_BUTTON_WHEEL = 2
____exports.HTMLMouse = __TS__Class()
local HTMLMouse = ____exports.HTMLMouse
HTMLMouse.name = "HTMLMouse"
function HTMLMouse.prototype.____constructor(self)
    self.buttons = {false, false, false}
    self.buttonsLast = {false, false, false}
    self.screenX = -1
    self.screenY = -1
    self.dx = 0
    self.dy = 0
end
__TS__SetDescriptor(
    HTMLMouse.prototype,
    "moved",
    {get = function(self)
        return self.dx ~= 0 or self.dy ~= 0
    end},
    true
)
function HTMLMouse.prototype.update(self)
    local mx = getMouseX()
    local my = getMouseY()
    self.dx = mx - self.screenX
    self.dy = my - self.screenY
    self.screenX = mx
    self.screenY = my
    do
        local index = 0
        while index < #self.buttons do
            self.buttons[index + 1] = isMouseButtonDown(index)
            index = index + 1
        end
    end
    do
        local index = 0
        while index < #self.buttons do
            if self.buttons[index + 1] ~= self.buttonsLast[index + 1] then
                local pressOrRelease = self.buttons[index + 1]
                if pressOrRelease then
                    print("mousedown = " .. tostring(index))
                else
                    print("mouseup = " .. tostring(index))
                end
            end
            index = index + 1
        end
    end
    do
        local index = 0
        while index < #self.buttons do
            self.buttonsLast[index + 1] = self.buttons[index + 1]
            index = index + 1
        end
    end
end
function HTMLMouse.prototype.newMoveEvent(self, target)
    local event = __TS__New(MouseMoveEvent, self, target)
    return event
end

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  getMouseX = ____pipewrench.getMouseX
getMouseY = ____pipewrench.getMouseY
isMouseButtonDown = ____pipewrench.isMouseButtonDown
end)
----------------

return ____exports

local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local Keyboard = ____pipewrench.Keyboard
local ____Event = require('pipewrench-ui/event/Event')
local Event = ____Event.Event
____exports.MouseEvent = __TS__Class()
local MouseEvent = ____exports.MouseEvent
MouseEvent.name = "MouseEvent"
__TS__ClassExtends(MouseEvent, Event)
function MouseEvent.prototype.____constructor(self, _type, data, target)
    Event.prototype.____constructor(self, _type)
    local ____data_0 = data
    local buttons = ____data_0.buttons
    local dx = ____data_0.dx
    local dy = ____data_0.dy
    local screenX = ____data_0.screenX
    local screenY = ____data_0.screenY
    self.offsetX = target and screenX - target.cache.inner.x1 or screenX
    self.offsetY = target and screenY - target.cache.inner.y1 or screenY
    local ____screenX_1 = screenX
    self.screenX = ____screenX_1
    self.pageX = ____screenX_1
    self.clientX = ____screenX_1
    local ____screenY_2 = screenY
    self.screenY = ____screenY_2
    self.pageY = ____screenY_2
    self.clientY = ____screenY_2
    self.movementX = dx
    self.movementY = dy
    if __TS__ArrayIsArray(buttons) then
        local btns = 0
        do
            local index = 0
            while index < #buttons do
                if buttons[index + 1] then
                    btns = btns + 1
                end
                index = index + 1
            end
        end
        self.buttons = btns
    else
        self.buttons = buttons
    end
    self.altKey = Keyboard.isKeyDown(Keyboard.KEY_LMENU) or Keyboard.isKeyDown(Keyboard.KEY_RMENU)
    self.ctrlKey = Keyboard.isKeyDown(Keyboard.KEY_LCONTROL) or Keyboard.isKeyDown(Keyboard.KEY_RCONTROL)
    self.metaKey = Keyboard.isKeyDown(Keyboard.KEY_LMETA) or Keyboard.isKeyDown(Keyboard.KEY_RMETA)
    self.shiftKey = Keyboard.isKeyDown(Keyboard.KEY_LSHIFT) or Keyboard.isKeyDown(Keyboard.KEY_RSHIFT)
end
__TS__SetDescriptor(
    MouseEvent.prototype,
    "x",
    {get = function(self)
        return self.clientX
    end},
    true
)
__TS__SetDescriptor(
    MouseEvent.prototype,
    "y",
    {get = function(self)
        return self.clientY
    end},
    true
)

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  Keyboard = ____pipewrench.Keyboard
end)
----------------

return ____exports

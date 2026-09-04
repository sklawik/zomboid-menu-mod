local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local RadialMenu = ____pipewrench.RadialMenu
local UIElement = ____pipewrench.UIElement
local UIManager = ____pipewrench.UIManager
local javaObject
local radialMenu
function ____exports.initPZ(self, ____table)
    javaObject = UIElement.new(____table)
    UIManager.AddUI(javaObject)
    radialMenu = RadialMenu.new(0, 0, 0, 0)
    radialMenu:setTable(____table)
    UIManager.AddUI(radialMenu)
end
function ____exports.getUIElement(self)
    return javaObject
end
function ____exports.getRadialMenu(self)
    return radialMenu
end

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  RadialMenu = ____pipewrench.RadialMenu
UIElement = ____pipewrench.UIElement
UIManager = ____pipewrench.UIManager
end)
----------------

return ____exports

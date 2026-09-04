local ____lualib = require('lualib_bundle')
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringReplace = ____lualib.__TS__StringReplace
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local Core = ____pipewrench.Core
local ____CMYK = require('pipewrench-ui/css/color/CMYK')
local CMYK_2_RGB = ____CMYK.CMYK_2_RGB
local parseCMYK = ____CMYK.parseCMYK
local ____Color = require('pipewrench-ui/css/color/Color')
local transparent = ____Color.transparent
local ____HEX = require('pipewrench-ui/css/color/HEX')
local parseHEX = ____HEX.parseHEX
local ____HSL = require('pipewrench-ui/css/color/HSL')
local HSL_2_RGB = ____HSL.HSL_2_RGB
local parseHSL = ____HSL.parseHSL
local ____RGB = require('pipewrench-ui/css/color/RGB')
local parseRGB = ____RGB.parseRGB
local ____RGBA = require('pipewrench-ui/css/color/RGBA')
local parseRGBA = ____RGBA.parseRGBA
____exports.formatColor = function(____, element, value)
    value = __TS__StringTrim(string.lower(value))
    if (string.find(value, "#", nil, true) or 0) - 1 == 0 then
        return parseHEX(value, "1")
    elseif (string.find(value, "cmyk(", nil, true) or 0) - 1 ~= -1 then
        return __TS__ObjectAssign(
            {},
            CMYK_2_RGB(
                parseCMYK(value),
                "1"
            ),
            {a = 1}
        )
    elseif (string.find(value, "rgb(", nil, true) or 0) - 1 ~= -1 then
        return __TS__ObjectAssign(
            {},
            parseRGB(value, "1"),
            {a = 1}
        )
    elseif (string.find(value, "rgba(", nil, true) or 0) - 1 ~= -1 then
        return parseRGBA(value, "1")
    elseif (string.find(value, "hsl(", nil, true) or 0) - 1 ~= -1 then
        return __TS__ObjectAssign(
            {},
            HSL_2_RGB(
                parseHSL(value),
                "1"
            ),
            {a = 1}
        )
    elseif (string.find(value, "inherit", nil, true) or 0) - 1 ~= -1 then
        if element.parent ~= nil then
            return __TS__ObjectAssign({}, element.parent.cache.backgroundColor.value)
        else
            return transparent()
        end
    elseif (string.find(value, "transparent", nil, true) or 0) - 1 ~= -1 or (string.find(value, "initial", nil, true) or 0) - 1 ~= -1 or (string.find(value, "none", nil, true) or 0) - 1 ~= -1 or (string.find(value, "unset", nil, true) or 0) - 1 ~= -1 then
        return transparent()
    end
end
____exports.formatNumValue = function(____, element, property, value)
    if __TS__StringEndsWith(value, "px") then
        local calcVal = tonumber(__TS__StringReplace(value, "px", ""))
        if element.parent ~= nil then
            if property == "left" then
                calcVal = calcVal + element.parent.cache.outer.x1
            elseif property == "right" then
                calcVal = element.parent.cache.outer.x2 - (calcVal - element.cache.width.value)
            elseif property == "top" then
                calcVal = calcVal + element.parent.cache.outer.y1
            elseif property == "bottom" then
                calcVal = element.parent.cache.outer.y2 - (calcVal - element.cache.height.value)
            end
        end
        return calcVal
    elseif __TS__StringEndsWith(value, "%") then
        local compare = 0
        if property == "left" or property == "right" or property == "width" or property == "min-width" or property == "max-width" then
            compare = element.parent ~= nil and element.parent.cache.width.value or Core.getInstance():getScreenWidth()
        elseif property == "top" or property == "bottom" or property == "height" or property == "min-height" or property == "max-height" then
            compare = element.parent ~= nil and element.parent.cache.height.value or Core.getInstance():getScreenHeight()
        else
            return 0
        end
        return compare * tonumber(__TS__StringReplace(value, "%", "")) / 100
    end
end

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  Core = ____pipewrench.Core
end)
----------------

return ____exports

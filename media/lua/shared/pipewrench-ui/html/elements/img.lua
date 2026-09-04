local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local UIFont = ____pipewrench.UIFont
local toInt = ____pipewrench.toInt
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
local ____RGBA = require('pipewrench-ui/css/color/RGBA')
local asRGBA = ____RGBA.asRGBA
local ____TextureCache = require('pipewrench-ui/TextureCache')
local TextureCache = ____TextureCache.TextureCache
local ____PZ = require('pipewrench-ui/html/PZ')
local getUIElement = ____PZ.getUIElement
local COLOR_WHITE = asRGBA(
    1,
    1,
    1,
    1,
    "1"
)
local COLOR_TRANSPARENT = asRGBA(
    1,
    1,
    1,
    0,
    "1"
)
local TEX_BROKEN_IMG = nil
____exports.CSS_DEFAULT_IMG = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT, {["background-color"] = "rgba(255,255,255,1)", display = "inline-block"})
____exports.HTMLImageElement = __TS__Class()
local HTMLImageElement = ____exports.HTMLImageElement
HTMLImageElement.name = "HTMLImageElement"
__TS__ClassExtends(HTMLImageElement, HTMLElement)
function HTMLImageElement.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "img",
        ____exports.CSS_DEFAULT_IMG,
        props,
        children
    )
    if TEX_BROKEN_IMG == nil then
        TEX_BROKEN_IMG = TextureCache:getOrLoad("media/textures/broken_image.png")
    end
    if props.src ~= nil then
        self.src = tostring(props.src)
    end
    if props.alt ~= nil then
        self.alt = tostring(props.alt)
    elseif self.src ~= nil then
        self.alt = self.src
    end
    if props.width ~= nil then
        self.width = toInt(tonumber(props.width))
    end
    if props.height ~= nil then
        self.height = toInt(tonumber(props.height))
    end
end
function HTMLImageElement.prototype.renderBackground(self, x, y, w, h)
    local javaObject = getUIElement(nil)
    local ____self_cache_backgroundColor_0 = self.cache.backgroundColor
    local backgroundColor = ____self_cache_backgroundColor_0.value
    local ____self_cache_backgroundImage_1 = self.cache.backgroundImage
    local texture = ____self_cache_backgroundImage_1.value
    if texture ~= nil then
        if backgroundColor == nil then
            backgroundColor = COLOR_WHITE
        end
        local ____backgroundColor_2 = backgroundColor
        local r = ____backgroundColor_2.r
        local g = ____backgroundColor_2.g
        local b = ____backgroundColor_2.b
        local a = ____backgroundColor_2.a
        if a ~= 0 then
            javaObject:DrawTextureScaledColor(
                texture,
                x,
                y,
                w,
                h,
                r,
                g,
                b,
                a
            )
        end
    else
        local ____backgroundColor_3 = backgroundColor
        local r = ____backgroundColor_3.r
        local g = ____backgroundColor_3.g
        local b = ____backgroundColor_3.b
        local a = ____backgroundColor_3.a
        if backgroundColor ~= nil and a ~= 0 then
            javaObject:DrawTextureScaledColor(
                nil,
                x,
                y,
                w,
                h,
                r,
                g,
                b,
                a
            )
        end
    end
end
function HTMLImageElement.prototype.renderText(self, text, x, y, w, h)
    local alt = self.alt
    local ____self_cache_backgroundImage_4 = self.cache.backgroundImage
    local texture = ____self_cache_backgroundImage_4.value
    local javaObject = getUIElement(nil)
    if texture == nil and alt ~= nil and #alt ~= 0 then
        javaObject:DrawTextureScaled(
            TEX_BROKEN_IMG,
            x + 1,
            y,
            21,
            24,
            1
        )
        javaObject:DrawText(
            UIFont.Large,
            alt,
            x + 26,
            y,
            0,
            0,
            0,
            1
        )
    end
end

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  UIFont = ____pipewrench.UIFont
toInt = ____pipewrench.toInt
end)
----------------

return ____exports

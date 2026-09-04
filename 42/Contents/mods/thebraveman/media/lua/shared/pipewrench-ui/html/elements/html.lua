local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local Core = ____pipewrench.Core
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
local ____body = require('pipewrench-ui/html/elements/body')
local HTMLBodyElement = ____body.HTMLBodyElement
local ____Format = require('pipewrench-ui/util/Format')
local formatNumValue = ____Format.formatNumValue
local ____PZ = require('pipewrench-ui/html/PZ')
local getUIElement = ____PZ.getUIElement
local initPZ = ____PZ.initPZ
____exports.CSS_DEFAULT_HTML = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT, {width = "100%", height = "100%"})
____exports.HTMLDocument = __TS__Class()
local HTMLDocument = ____exports.HTMLDocument
HTMLDocument.name = "HTMLDocument"
__TS__ClassExtends(HTMLDocument, HTMLElement)
function HTMLDocument.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "html",
        ____exports.CSS_DEFAULT_HTML,
        props,
        children
    )
    self.debug = false
    self.body = __TS__New(HTMLBodyElement, {}, {})
    local ____self_children_0 = self.children
    ____self_children_0[#____self_children_0 + 1] = self.body
end
function HTMLDocument.prototype.updateInternal(self)
    local javaObject = getUIElement(nil)
    if javaObject == nil then
        initPZ(nil, self)
    end
end
function HTMLDocument.prototype.prerender(self)
    local javaObject = getUIElement(nil)
    javaObject:setTable(self)
    javaObject:setX(0)
    javaObject:setY(0)
    javaObject:setWidth(Core.getInstance():getScreenWidth())
    javaObject:setHeight(Core.getInstance():getScreenHeight())
end
function HTMLDocument.prototype.calculateDimensions(self, force)
    local element = self
    local cache = self.cache
    local style = self.cssRuleset
    local tag = self.tag
    local width = formatNumValue(nil, element, "width", style.width)
    if width == nil then
        width = Core.getInstance():getScreenWidth()
    end
    local height = formatNumValue(nil, element, "height", style.height)
    if height == nil then
        height = Core.getInstance():getScreenHeight()
    end
    cache.outer.x2 = cache.outer.x1 + width
    cache.outer.y2 = cache.outer.y1 + height
    cache.width.value = width
    cache.height.value = height
    cache.outer.x1 = formatNumValue(nil, element, "left", style.left)
    if cache.outer.x1 == nil then
        if element.parent ~= nil then
            cache.outer.x1 = element.parent.cache.outer.x1
        else
            cache.outer.x1 = 0
        end
    end
    cache.outer.y1 = formatNumValue(nil, element, "top", style.top)
    if cache.outer.y1 == nil then
        if element.parent ~= nil then
            cache.outer.y1 = element.parent.cache.outer.y1
        else
            cache.outer.y1 = 0
        end
    end
end
function HTMLDocument.prototype.getElementsByClassName(self)
    error(
        __TS__New(Error, "Method not implemented."),
        0
    )
end
function HTMLDocument.prototype.getElementById(self, id)
    local found = nil
    local recurse
    recurse = function(self, children)
        do
            local index = 0
            while index < #children do
                if found ~= nil then
                    break
                end
                local child = children[index + 1]
                if child ~= nil and child.id == id then
                    found = child
                    break
                end
                if child.children ~= nil then
                    recurse(nil, child.children)
                end
                index = index + 1
            end
        end
    end
    recurse(nil, self.children)
    return found
end
____exports.document = __TS__New(____exports.HTMLDocument, {}, {})

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

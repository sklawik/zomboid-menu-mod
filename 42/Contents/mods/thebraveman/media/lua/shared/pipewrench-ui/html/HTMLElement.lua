local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__Delete = ____lualib.__TS__Delete
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local UIFont = ____pipewrench.UIFont
local ____CSS = require('pipewrench-ui/css/CSS')
local CSSRuleset = ____CSS.CSSRuleset
local ____CSSParser = require('pipewrench-ui/css/CSSParser')
local CSSReader = ____CSSParser.CSSReader
local ____TextureCache = require('pipewrench-ui/TextureCache')
local TextureCache = ____TextureCache.TextureCache
local ____Format = require('pipewrench-ui/util/Format')
local formatColor = ____Format.formatColor
local formatNumValue = ____Format.formatNumValue
local ____Cache = require('pipewrench-ui/Cache')
local ElementCache = ____Cache.ElementCache
local ____PZ = require('pipewrench-ui/html/PZ')
local getUIElement = ____PZ.getUIElement
local ____table = require('pipewrench-ui/util/table')
local tPrint = ____table.tPrint
____exports.CSS_DEFAULT_ELEMENT = {["background-color"] = "transparent", color = "rgba(0, 0, 0, 1)"}
____exports.HTMLElement = __TS__Class()
local HTMLElement = ____exports.HTMLElement
HTMLElement.name = "HTMLElement"
function HTMLElement.prototype.____constructor(self, tag, defaultCSS, props, children)
    self.id = nil
    self.children = {}
    self._dirty = true
    self.flagToRemove = false
    self.listeners = {}
    self.tag = tag
    self.cssRulesetDefault = defaultCSS
    self.cache = __TS__New(ElementCache, self)
    if props.id ~= nil then
        self.id = props.id
    end
    if props.class ~= nil then
        self.class = props.class
    end
    if props.style ~= nil then
        self.style = props.style
        self.cssRuleset = CSSReader:parseInline(defaultCSS, self.style)
    else
        self.style = nil
        self.cssRuleset = __TS__New(CSSRuleset, defaultCSS)
    end
    if props.onupdate ~= nil then
        self.onupdate = props.onupdate
    end
    if props.onprerender ~= nil then
        self.onprerender = props.onprerender
    end
    if props.onrender ~= nil then
        self.onrender = props.onrender
    end
    if children and #children then
        if tag == "script" then
            if #children == 1 then
                local firstChild = children[1]
                self.innerText = firstChild.innerText
            end
        else
            do
                local index = 0
                while index < #children do
                    local child = children[index + 1]
                    self:appendChild(child)
                    index = index + 1
                end
            end
        end
    end
end
function HTMLElement.prototype.update2(self)
    if self:checkRemovalFlag() then
        return
    end
    self:updateInternal()
    self:calculate(true)
    if self.onupdate then
        self:onupdate(self)
    end
    self:updateChildren()
end
function HTMLElement.prototype.updateInternal(self)
end
function HTMLElement.prototype.checkRemovalFlag(self)
    if self.flagToRemove then
        if self.parent and #self.parent.children then
            local indexOf = __TS__ArrayIndexOf(self.parent.children, self)
            if indexOf ~= -1 then
                __TS__ArraySplice(self.parent.children, indexOf, 1)
            end
            self.parent = nil
        end
        self.flagToRemove = false
        return true
    end
    return false
end
function HTMLElement.prototype.updateChildren(self)
    if #self.children ~= 0 then
        do
            local index = 0
            while index < #self.children do
                local child = self.children[index + 1]
                if child ~= nil then
                    if child.parent ~= self then
                        child.parent = self
                    end
                    if child.update2 ~= nil then
                        child:update2()
                    end
                end
                index = index + 1
            end
        end
    end
end
function HTMLElement.prototype.calculate(self, force)
    self:calculateBackgroundColor(force)
    self:calculateBackgroundImage(force)
    self:calculateDimensions(force)
end
function HTMLElement.prototype.calculateDimensions(self, force)
    local element = self
    local cache = self.cache
    local style = self.cssRuleset
    local tag = self.tag
    local width = formatNumValue(nil, element, "width", style.width)
    if width == nil then
        if tag == "img" then
            local img = element
            if img.width ~= nil then
                width = img.width
            elseif cache.backgroundImage.value ~= nil then
                width = cache.backgroundImage.value:getWidth()
            else
                width = 0
            end
        else
            width = 0
        end
    end
    local height = formatNumValue(nil, element, "height", style.height)
    if height == nil then
        if tag == "img" then
            local img = element
            if img.height ~= nil then
                height = img.height
            elseif cache.backgroundImage.value ~= nil then
                height = cache.backgroundImage.value:getHeight()
            else
                height = 0
            end
        else
            height = 0
        end
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
function HTMLElement.prototype.calculateBackgroundColor(self, force)
    local element = self
    local cache = self.cache
    local cssRuleset = self.cssRuleset
    if not cache.backgroundColor.dirty and not force then
        return
    end
    if force or cache.backgroundColor.dirty then
        cache.backgroundColor.value = formatColor(nil, element, cssRuleset["background-color"])
        cache.backgroundColor.dirty = false
    end
end
function HTMLElement.prototype.calculateBackgroundImage(self, force)
    local element = self
    local cache = self.cache
    local cssRuleset = self.cssRuleset
    local tag = self.tag
    if not cache.backgroundColor.dirty and not force then
        return
    end
    local backgroundImage = cssRuleset["background-image"]
    if backgroundImage ~= nil and (string.find(backgroundImage, "url(", nil, true) or 0) - 1 ~= -1 then
        backgroundImage = __TS__StringReplace(
            __TS__StringReplace(backgroundImage, "url(", ""),
            ")",
            ""
        )
        cache.backgroundImage.value = TextureCache:getOrLoad(backgroundImage)
    elseif tag == "img" then
        local img = element
        if img.src ~= nil and #img.src ~= 0 then
            cache.backgroundImage.value = TextureCache:getOrLoad(img.src)
        else
            cache.backgroundImage.value = nil
        end
    else
        cache.backgroundImage.value = nil
    end
    cache.backgroundImage.dirty = false
end
function HTMLElement.prototype.prerender(self)
    self:prerenderInternal()
    if self.onprerender then
        self:onprerender(self)
    end
    self:prerenderChildren()
    self._dirty = false
end
function HTMLElement.prototype.prerenderInternal(self)
end
function HTMLElement.prototype.prerenderChildren(self)
    if #self.children ~= 0 then
        do
            local index = 0
            while index < #self.children do
                local child = self.children[index + 1]
                if child ~= nil and child.prerender ~= nil then
                    child:prerender()
                end
                index = index + 1
            end
        end
    end
end
function HTMLElement.prototype.render(self)
    local x = self.cache.outer.x1
    local y = self.cache.outer.y1
    local w = self.cache.width.value
    local h = self.cache.height.value
    if x == nil or y == nil or w == nil or w == 0 or h == nil or h == 0 then
    else
        self:renderBackground(x, y, w, h)
        self:renderText(
            self.innerText,
            x,
            y,
            w,
            h
        )
    end
    self:renderInternal()
    if self.onrender then
        self:onrender(self)
    end
    self:renderChildren()
end
function HTMLElement.prototype.renderInternal(self)
end
function HTMLElement.prototype.renderChildren(self)
    if #self.children ~= 0 then
        do
            local index = 0
            while index < #self.children do
                local child = self.children[index + 1]
                if child ~= nil and child.render ~= nil then
                    child:render()
                end
                index = index + 1
            end
        end
    end
end
function HTMLElement.prototype.renderBackground(self, x, y, w, h)
    local javaObject = getUIElement(nil)
    local ____self_cache_backgroundColor_0 = self.cache.backgroundColor
    local backgroundColor = ____self_cache_backgroundColor_0.value
    local ____self_cache_backgroundImage_1 = self.cache.backgroundImage
    local texture = ____self_cache_backgroundImage_1.value
    if texture ~= nil then
        if backgroundColor == nil or backgroundColor.a ~= 0 then
            local ____backgroundColor_2 = backgroundColor
            local r = ____backgroundColor_2.r
            local g = ____backgroundColor_2.g
            local b = ____backgroundColor_2.b
            local a = ____backgroundColor_2.a
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
        if backgroundColor == nil or backgroundColor.a ~= 0 then
            local ____backgroundColor_3 = backgroundColor
            local r = ____backgroundColor_3.r
            local g = ____backgroundColor_3.g
            local b = ____backgroundColor_3.b
            local a = ____backgroundColor_3.a
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
function HTMLElement.prototype.renderText(self, text, x, y, w, h)
    local javaObject = getUIElement(nil)
    if text ~= nil and #text ~= 0 then
        javaObject:DrawText(
            UIFont.Large,
            text,
            x,
            y,
            1,
            1,
            1,
            1
        )
    end
end
function HTMLElement.prototype.dispatchEvent(self, event)
    local listeners = self.listeners[event._type]
    if listeners == nil or #listeners == 0 then
        self:dispatchEventToChildren(event)
        return
    end
    do
        local index = 0
        while index < #listeners do
            if event:test(self) then
                listeners[index + 1](
                    listeners,
                    event:cloneEvent(self)
                )
            end
            index = index + 1
        end
    end
    self:dispatchEventToChildren(event)
end
function HTMLElement.prototype.dispatchEventToChildren(self, event)
    if #self.children == 0 then
        return
    end
    do
        local index = 0
        while index < #self.children do
            local child = self.children[index + 1]
            if child ~= nil then
                if child.dispatchEvent ~= nil then
                    child:dispatchEvent(event)
                else
                    print("NO dispatchEvent() for child !!!")
                    print(child)
                    print(tPrint(child, 0, 1))
                end
            end
            index = index + 1
        end
    end
end
function HTMLElement.prototype.addEventListener(self, ____type, listener, options)
    local listeners = self.listeners[____type]
    if not listeners then
        listeners = {}
        self.listeners[____type] = listeners
    elseif #listeners ~= 0 then
        local index = __TS__ArrayIndexOf(listeners, listener)
        if index ~= -1 then
            __TS__ArraySplice(listeners, index, 1)
        end
    end
    listeners[#listeners + 1] = listener
end
function HTMLElement.prototype.removeEventListener(self, ____type, listener, options)
    local listeners = self.listeners[____type]
    if not listeners then
        return
    end
    local index = __TS__ArrayIndexOf(listeners, listener)
    if index ~= -1 then
        __TS__ArraySplice(listeners, index, 1)
    end
    if #listeners == 0 then
        __TS__Delete(self.listeners, ____type)
    end
end
function HTMLElement.prototype.onResize(self)
    self._dirty = true
end
function HTMLElement.prototype.appendChild(self, aChild)
    if aChild == nil then
        return
    end
    if aChild.parent == self then
        local index = __TS__ArrayIndexOf(self.children, aChild)
        if index ~= -1 then
            __TS__ArraySplice(self.children, index, 1)
        end
    end
    if aChild.parent ~= nil then
        aChild.parent:removeChild(aChild)
    end
    aChild.parent = self
    local ____self_children_4 = self.children
    ____self_children_4[#____self_children_4 + 1] = aChild
end
function HTMLElement.prototype.removeChild(self, child)
    local index = __TS__ArrayIndexOf(self.children, child)
    if index == -1 then
        error(
            __TS__New(Error, "Element is not a child."),
            0
        )
    end
    child.parent = nil
    __TS__ArraySplice(self.children, index, 1)
end
function HTMLElement.prototype.setStyle(self, style)
    if __TS__InstanceOf(style, CSSRuleset) then
        self.cssRuleset = style
    else
        self.cssRuleset = CSSReader:parseInline(self.cssRulesetDefault, style)
    end
    self:setDirty()
end
function HTMLElement.prototype.isDirty(self)
    return self._dirty
end
function HTMLElement.prototype.setDirty(self)
    self._dirty = true
end
function HTMLElement.prototype.hasParent(self)
    return self.parent ~= nil
end
function HTMLElement.prototype.hasChildren(self)
    return #self.children ~= 0
end
function HTMLElement.prototype.printTree(self, indent)
    local s = ((string.rep(
        " ",
        math.floor(indent * 4)
    ) .. "[") .. self.tag) .. "]\n"
    for ____, child in ipairs(self.children) do
        if child.tag then
            s = s .. child:printTree(indent + 1)
        else
            s = s .. string.rep(
                " ",
                math.floor((indent + 1) * 4)
            ) .. "[???]\n"
        end
    end
    return s
end

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  UIFont = ____pipewrench.UIFont
end)
----------------

return ____exports

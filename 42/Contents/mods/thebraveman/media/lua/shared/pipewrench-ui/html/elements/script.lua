local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.CSS_DEFAULT_SCRIPT = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT, {display = "none"})
____exports.HTMLScriptElement = __TS__Class()
local HTMLScriptElement = ____exports.HTMLScriptElement
HTMLScriptElement.name = "HTMLScriptElement"
__TS__ClassExtends(HTMLScriptElement, HTMLElement)
function HTMLScriptElement.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "script",
        CSS_DEFAULT_ELEMENT,
        props,
        children
    )
    self._firstUpdate = true
    if props.src ~= nil then
        self.src = props.src
    end
    if props.type ~= nil then
        self.type = props.type
    end
    print((("[script type=" .. tostring(self.type)) .. "] => innerText = ") .. tostring(self.innerText))
end
function HTMLScriptElement.prototype.updateInternal(self)
    if self._firstUpdate then
        if self.innerText ~= nil and #self.innerText then
            if self.type == "text/x-lua" then
                loadstring(self.innerText)()
            end
        end
        self._firstUpdate = false
    end
end
return ____exports

local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.CSS_DEFAULT_SPAN = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT)
____exports.HTMLSpanElement = __TS__Class()
local HTMLSpanElement = ____exports.HTMLSpanElement
HTMLSpanElement.name = "HTMLSpanElement"
__TS__ClassExtends(HTMLSpanElement, HTMLElement)
function HTMLSpanElement.prototype.____constructor(self, props, children, text)
    HTMLElement.prototype.____constructor(
        self,
        "span",
        ____exports.CSS_DEFAULT_SPAN,
        props,
        children
    )
    self.innerText = text
end
return ____exports

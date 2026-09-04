local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.CSS_DEFAULT_BODY = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT, {width = "100%", height = "100%"})
____exports.HTMLBodyElement = __TS__Class()
local HTMLBodyElement = ____exports.HTMLBodyElement
HTMLBodyElement.name = "HTMLBodyElement"
__TS__ClassExtends(HTMLBodyElement, HTMLElement)
function HTMLBodyElement.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "body",
        ____exports.CSS_DEFAULT_BODY,
        props,
        children
    )
end
return ____exports

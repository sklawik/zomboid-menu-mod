local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.CSS_DEFAULT_DIV = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT)
____exports.HTMLDivElement = __TS__Class()
local HTMLDivElement = ____exports.HTMLDivElement
HTMLDivElement.name = "HTMLDivElement"
__TS__ClassExtends(HTMLDivElement, HTMLElement)
function HTMLDivElement.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "div",
        ____exports.CSS_DEFAULT_DIV,
        props,
        children
    )
end
return ____exports

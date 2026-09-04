local ____lualib = require('lualib_bundle')
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.CSS_DEFAULT_RADIALMENU = __TS__ObjectAssign({}, CSS_DEFAULT_ELEMENT)
____exports.HTMLRadialMenu = __TS__Class()
local HTMLRadialMenu = ____exports.HTMLRadialMenu
HTMLRadialMenu.name = "HTMLRadialMenu"
__TS__ClassExtends(HTMLRadialMenu, HTMLElement)
function HTMLRadialMenu.prototype.____constructor(self, props, children)
    HTMLElement.prototype.____constructor(
        self,
        "radialmenu",
        ____exports.CSS_DEFAULT_RADIALMENU,
        props,
        children
    )
end
return ____exports

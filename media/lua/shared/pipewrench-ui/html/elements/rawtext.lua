local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____HTMLElement = require('pipewrench-ui/html/HTMLElement')
local HTMLElement = ____HTMLElement.HTMLElement
local CSS_DEFAULT_ELEMENT = ____HTMLElement.CSS_DEFAULT_ELEMENT
____exports.HTMLRawText = __TS__Class()
local HTMLRawText = ____exports.HTMLRawText
HTMLRawText.name = "HTMLRawText"
__TS__ClassExtends(HTMLRawText, HTMLElement)
function HTMLRawText.prototype.____constructor(self, text)
    HTMLElement.prototype.____constructor(
        self,
        "",
        CSS_DEFAULT_ELEMENT,
        {},
        {}
    )
    self.innerText = text
end
return ____exports

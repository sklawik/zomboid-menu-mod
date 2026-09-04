local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__New = ____lualib.__TS__New
local ____exports = {}
____exports.CSSRuleset = __TS__Class()
local CSSRuleset = ____exports.CSSRuleset
CSSRuleset.name = "CSSRuleset"
function CSSRuleset.prototype.____constructor(self, ...)
    local rawBlocks = {...}
    self.position = "relative"
    self.display = "block"
    self.top = "auto"
    self.left = "auto"
    self.width = "auto"
    self.height = "auto"
    self["min-width"] = "0"
    self["min-height"] = "0"
    self["max-width"] = "none"
    self["max-height"] = "none"
    self["background-color"] = "rgba(255,255,255,1)"
    self["background-image"] = "none"
    if #rawBlocks ~= 0 then
        for ____, raw in ipairs(rawBlocks) do
            if raw ~= nil then
                for ____, property in ipairs(__TS__ObjectKeys(raw)) do
                    self[property] = raw[property]
                end
            end
        end
    end
end
function CSSRuleset.prototype.asInline(self)
    local copy = __TS__New(____exports.CSSRuleset)
    copy.position = self.position
    copy.display = self.display
    copy.top = self.top
    copy.left = self.left
    copy.width = self.width
    copy.height = self.height
    copy["min-width"] = self["min-width"]
    copy["min-height"] = self["min-height"]
    copy["max-width"] = self["max-width"]
    copy["max-height"] = self["max-height"]
    copy["background-color"] = self["background-color"]
    return copy
end
function CSSRuleset.prototype.setRules(self, other)
    self.position = other.position
    self.display = other.display
    self.top = other.top
    self.left = other.left
    self.width = other.width
    self.height = other.height
    self["min-width"] = other["min-width"]
    self["min-height"] = other["min-height"]
    self["max-width"] = other["max-width"]
    self["max-height"] = other["max-height"]
    self["background-color"] = other["background-color"]
end
return ____exports

local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local ____exports = {}
local ____CSS = require('pipewrench-ui/css/CSS')
local CSSRuleset = ____CSS.CSSRuleset
____exports.CSSChain = __TS__Class()
local CSSChain = ____exports.CSSChain
CSSChain.name = "CSSChain"
function CSSChain.prototype.____constructor(self)
    self.links = {}
end
function CSSChain.prototype.addBlocks(self, css)
    for ____, selector in ipairs(__TS__ObjectKeys(css)) do
        self:getOrCreateLink(
            selector,
            __TS__New(CSSRuleset, css[selector])
        )
    end
end
function CSSChain.prototype.getOrCreateLink(self, selector, ruleset)
    local rules = self.links[selector]
    if rules ~= nil then
        return rules
    end
    rules = __TS__New(____exports.CSSChainLink, selector, ruleset)
    self.links[selector] = rules
    return rules
end
____exports.CSSChainLink = __TS__Class()
local CSSChainLink = ____exports.CSSChainLink
CSSChainLink.name = "CSSChainLink"
function CSSChainLink.prototype.____constructor(self, id, rules)
    self.subLinks = {}
    self.superLink = nil
    self.id = id
    self.rules = __TS__New(CSSRuleset)
    if rules ~= nil then
        self.rules:setRules(rules)
    end
end
function CSSChainLink.prototype.hasSubLink(self, selector)
    return false
end
function CSSChainLink.prototype.addSubLinks(self, ...)
    local subLinks = {...}
    if #subLinks == 0 then
        return
    end
    for ____, link in ipairs(subLinks) do
        if self:isSuperLink(link) then
            error(
                __TS__New(Error, ((("CyclicChainLinkError: Tried to set the parent ChainLink '" .. link.id) .. "' as the child of '") .. self.id) .. ".'"),
                0
            )
        end
        self.subLinks[link.id] = link
        link.superLink = self
    end
end
function CSSChainLink.prototype.removeSubLinks(self, ...)
    local subLinks = {...}
    if #subLinks == 0 then
        return
    end
    for ____, link in ipairs(subLinks) do
        if self:isSubLink(link) then
            __TS__Delete(self.subLinks, link.id)
            link.superLink = nil
        end
    end
end
function CSSChainLink.prototype.setSuperLink(self, superLink)
    if self.superLink ~= nil then
        self.superLink:removeSubLinks(self)
    end
    self.superLink = superLink
    if self.superLink ~= nil then
        self.superLink.subLinks[self.id] = self
    end
end
function CSSChainLink.prototype.isSubLink(self, link)
    return __TS__ArrayIndexOf(
        __TS__ObjectKeys(self.subLinks),
        link.id
    ) ~= -1
end
function CSSChainLink.prototype.isSuperLink(self, link)
    if self.superLink == nil then
        return false
    end
    return self.superLink == link or self.superLink:isSuperLink(link)
end
function CSSChainLink.prototype.isRootLink(self)
    return self.superLink == nil
end
return ____exports

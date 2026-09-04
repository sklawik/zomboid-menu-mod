local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local ____exports = {}
local ____CSSChain = require('pipewrench-ui/css/CSSChain')
local CSSChain = ____CSSChain.CSSChain
local ____CSS = require('pipewrench-ui/css/CSS')
local CSSRuleset = ____CSS.CSSRuleset
--- **CSSReader** is a singleton utility for parsing CSS text as objects.
-- 
-- @author JabDoesThings
____exports.CSSReader = __TS__Class()
local CSSReader = ____exports.CSSReader
CSSReader.name = "CSSReader"
function CSSReader.prototype.____constructor(self)
    error(
        __TS__New(Error, "Cannot instantiate CSSReader."),
        0
    )
end
function CSSReader.parseInline(self, raw, css)
    return __TS__New(
        CSSRuleset,
        raw,
        self:readInlineSelectorBlock(css)
    )
end
function CSSReader.parse(self, css)
    if css == nil then
        error(
            __TS__New(Error, "The CSS string is null."),
            0
        )
    end
    local group = __TS__New(CSSChain)
    group:addBlocks(self:read(css))
    return group
end
function CSSReader.read(self, raw)
    local css = {}
    local inSelector = false
    local selectorBlock = ""
    local selector = ""
    local char = 1
    local line = 0
    local function parseError(____, message)
        self:parseError(line, char, selector, message)
    end
    do
        local index = 0
        while index < #raw do
            local currChar = __TS__StringCharAt(raw, index)
            local lineBreak = false
            if __TS__StringReplace(
                __TS__StringReplace(currChar, "\r", ""),
                "\n",
                ""
            ) == "" then
                char = 1
                line = line + 1
                lineBreak = true
            else
                char = char + 1
            end
            if inSelector then
                if currChar == "{" then
                    parseError(nil, "A '{' inside of the selector block.")
                end
                if currChar == "}" then
                    if not inSelector then
                        parseError(nil, "A '}' outside of the selector block.")
                    end
                    if #selectorBlock ~= 0 then
                        css[__TS__StringTrim(selector)] = self:readInlineSelectorBlock(selectorBlock)
                    end
                    inSelector = false
                    selector = ""
                    selectorBlock = ""
                else
                    if not lineBreak then
                        selectorBlock = selectorBlock .. currChar
                    end
                end
            else
                if currChar == "{" then
                    if inSelector then
                        parseError(nil, "A '{' inside of the selector block.")
                    end
                    inSelector = true
                else
                    if not lineBreak then
                        selector = selector .. currChar
                    end
                end
            end
            index = index + 1
        end
    end
    if #selector ~= 0 then
        parseError(nil, "No {} block for selector.")
    end
    return css
end
function CSSReader.readInlineSelectorBlock(self, css)
    local charOffset = 1
    local function ____error(____, message)
        error(
            __TS__New(
                Error,
                (("[line 1:" .. tostring(charOffset)) .. "]: Invalid CSS Syntax in inline selector block: ") .. message
            ),
            0
        )
    end
    local selection = {}
    for ____, block in ipairs(__TS__StringSplit(css, ";")) do
        if block ~= "" then
            local split = __TS__StringSplit(block, ":")
            if #split ~= 2 then
                ____error(
                    nil,
                    "Invalid rule: " .. __TS__StringTrim(block)
                )
            end
            selection[__TS__StringTrim(split[1])] = __TS__StringTrim(split[2])
        end
    end
    return selection
end
function CSSReader.parseError(self, line, char, selector, message)
    error(
        __TS__New(
            Error,
            (((((("[line " .. tostring(line)) .. ":") .. tostring(char)) .. "]: Invalid CSS Syntax near selector '") .. selector) .. "': ") .. message
        ),
        0
    )
end
return ____exports

local ____lualib = require('lualib_bundle')
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____body = require('pipewrench-ui/html/elements/body')
local HTMLBodyElement = ____body.HTMLBodyElement
local ____div = require('pipewrench-ui/html/elements/div')
local HTMLDivElement = ____div.HTMLDivElement
local ____img = require('pipewrench-ui/html/elements/img')
local HTMLImageElement = ____img.HTMLImageElement
local ____radialmenu = require('pipewrench-ui/html/elements/radialmenu')
local HTMLRadialMenu = ____radialmenu.HTMLRadialMenu
local ____rawtext = require('pipewrench-ui/html/elements/rawtext')
local HTMLRawText = ____rawtext.HTMLRawText
local ____script = require('pipewrench-ui/html/elements/script')
local HTMLScriptElement = ____script.HTMLScriptElement
local ____span = require('pipewrench-ui/html/elements/span')
local HTMLSpanElement = ____span.HTMLSpanElement
____exports.primitives = {
    body = HTMLBodyElement,
    div = HTMLDivElement,
    script = HTMLScriptElement,
    span = HTMLSpanElement,
    img = HTMLImageElement,
    radialmenu = HTMLRadialMenu
}
____exports.PipeWrenchUI = {}
local PipeWrenchUI = ____exports.PipeWrenchUI
do
    local recursiveFlattenChildren, flattenChildren, isActualFunction
    function recursiveFlattenChildren(self, children, target)
        if type(children) == "string" then
            target[#target + 1] = __TS__New(HTMLRawText, children)
        elseif type(children) == "table" then
            if type(children) == "table" and children[1] ~= nil then
                for ____, child in ipairs(children) do
                    recursiveFlattenChildren(nil, child, target)
                end
            else
                if children.tag ~= nil then
                    target[#target + 1] = children
                end
            end
        else
            for ____, child in ipairs(children) do
                recursiveFlattenChildren(nil, child, target)
            end
        end
    end
    function flattenChildren(self, children)
        local result = {}
        recursiveFlattenChildren(nil, children, result)
        return result
    end
    function isActualFunction(self, f)
        return type(f) == "function"
    end
    PipeWrenchUI.createElement = function(____, t, props, ...)
        local children = {...}
        props = props or ({})
        local flatChildren = flattenChildren(nil, children)
        if type(t) == "string" then
            if ____exports.primitives[t] == nil then
                print(("No base element [" .. t) .. "]!")
                return nil
            end
            return __TS__New(____exports.primitives[t], props, flatChildren)
        elseif isActualFunction(nil, t) then
            return t(nil, props, flatChildren)
        else
            return __TS__New(t, props, flatChildren)
        end
    end
end
return ____exports

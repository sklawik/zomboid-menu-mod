local ____lualib = require('lualib_bundle')
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local ____exports = {}
____exports.parseHEX = function(hex, format)
    hex = __TS__StringReplace(hex, "#", "")
    local r = 0
    local g = 0
    local b = 0
    local a = 1
    if #hex == 8 then
        r = tonumber(
            __TS__StringSubstring(hex, 0, 2),
            16
        )
        g = tonumber(
            __TS__StringSubstring(hex, 2, 4),
            16
        )
        b = tonumber(
            __TS__StringSubstring(hex, 4, 6),
            16
        )
        a = tonumber(
            __TS__StringSubstring(hex, 6, 8),
            16
        ) / 255
    elseif #hex == 6 then
        r = tonumber(
            __TS__StringSubstring(hex, 0, 2),
            16
        )
        g = tonumber(
            __TS__StringSubstring(hex, 2, 4),
            16
        )
        b = tonumber(
            __TS__StringSubstring(hex, 4, 6),
            16
        )
    elseif #hex == 4 then
        r = tonumber(
            string.sub(hex, 1, 1),
            16
        )
        g = tonumber(
            string.sub(hex, 2, 2),
            16
        )
        b = tonumber(
            string.sub(hex, 3, 3),
            16
        )
        a = tonumber(
            string.sub(hex, 4, 4),
            16
        ) / 255
    elseif #hex == 3 then
        r = tonumber(
            string.sub(hex, 1, 1),
            16
        )
        g = tonumber(
            string.sub(hex, 2, 2),
            16
        )
        b = tonumber(
            string.sub(hex, 3, 3),
            16
        )
    end
    if format == "1" then
        r = r / 255
        g = g / 255
        b = b / 255
    end
    return {
        r = r,
        g = g,
        b = b,
        a = a,
        format = format
    }
end
return ____exports

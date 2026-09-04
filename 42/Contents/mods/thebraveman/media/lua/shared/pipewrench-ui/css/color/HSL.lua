local ____lualib = require('lualib_bundle')
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__StringTrim = ____lualib.__TS__StringTrim
local ____exports = {}
local ____Math = require('pipewrench-ui/css/math/Math')
local clamp = ____Math.clamp
local RANGE_1 = ____Math.RANGE_1
local RANGE_255 = ____Math.RANGE_255
____exports.parseHSL = function(raw)
    if (string.find(raw, "hsl(", nil, true) or 0) - 1 == -1 or not __TS__StringEndsWith(raw, ")") then
        error(
            __TS__New(Error, "Invalid hsl() rule: " .. raw),
            0
        )
    end
    local values = __TS__StringSplit(
        __TS__StringReplace(
            __TS__StringReplace(raw, "hsl(", ""),
            ")",
            ""
        ),
        ","
    )
    if #values ~= 3 then
        error(
            __TS__New(Error, ("Invalid hsl() rule: " .. raw) .. " (Not 3 values.)"),
            0
        )
    end
    local h = tonumber(__TS__StringTrim(values[1]))
    local s = tonumber(__TS__StringTrim(values[2]))
    local l = tonumber(__TS__StringTrim(values[3]))
    if h == 360 then
        h = 0
    end
    h = h / 360
    s = s / 100
    l = l / 100
    return {
        h = clamp(h, RANGE_1),
        s = clamp(s, RANGE_1),
        l = clamp(l, RANGE_1)
    }
end
---
-- @param color The hsl color values.
-- @return The calculated rgb color values.
____exports.HSL_2_RGB = function(color, format)
    local ____color_0 = color
    local h = ____color_0.h
    local s = ____color_0.s
    local l = ____color_0.l
    local function k(n)
        return (n + h / 30) % 12
    end
    local a = s * math.min(l, 1 - l)
    local function f(n)
        return 1 - (l - a * math.max(
            -1,
            math.min(
                k(n) - 3,
                math.min(
                    9 - k(n),
                    1
                )
            )
        ))
    end
    if format == "1" then
        return {
            r = clamp(
                f(0),
                RANGE_1
            ),
            g = clamp(
                f(8),
                RANGE_1
            ),
            b = clamp(
                f(4),
                RANGE_1
            ),
            format = format
        }
    else
        return {
            r = math.floor(clamp(
                255 * f(0),
                RANGE_255
            ) + 0.5),
            g = math.floor(clamp(
                255 * f(8),
                RANGE_255
            ) + 0.5),
            b = math.floor(clamp(
                255 * f(4),
                RANGE_255
            ) + 0.5),
            format = format
        }
    end
end
return ____exports

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
____exports.RANGE_100 = {min = 0, max = 100}
____exports.parseCMYK = function(raw)
    if (string.find(raw, "cmyk(", nil, true) or 0) - 1 == -1 or not __TS__StringEndsWith(raw, ")") then
        error(
            __TS__New(Error, "Invalid cmyk() rule: " .. raw),
            0
        )
    end
    local values = __TS__StringSplit(
        __TS__StringReplace(
            __TS__StringReplace(raw, "cmyk(", ""),
            ")",
            ""
        ),
        ","
    )
    if #values ~= 4 then
        error(
            __TS__New(Error, ("Invalid cmyk() rule: " .. raw) .. " (Not 4 values)"),
            0
        )
    end
    return {
        c = clamp(
            tonumber(__TS__StringTrim(values[1])),
            ____exports.RANGE_100
        ),
        m = clamp(
            tonumber(__TS__StringTrim(values[2])),
            ____exports.RANGE_100
        ),
        y = clamp(
            tonumber(__TS__StringTrim(values[3])),
            ____exports.RANGE_100
        ),
        k = clamp(
            tonumber(__TS__StringTrim(values[4])),
            ____exports.RANGE_100
        )
    }
end
____exports.CMYK_2_RGB = function(color, format)
    local c = color.c / 100
    local m = color.m / 100
    local y = color.y / 100
    local k = color.k / 100
    c = c * (1 - k) + k
    m = m * (1 - k) + k
    y = y * (1 - k) + k
    local r = 1 - c
    local g = 1 - m
    local b = 1 - y
    if format == "255" then
        r = r * 255
        g = g * 255
        b = b * 255
        return {
            r = clamp(r, RANGE_255),
            g = clamp(g, RANGE_255),
            b = clamp(b, RANGE_255),
            format = format
        }
    else
        return {
            r = clamp(r, RANGE_1),
            g = clamp(g, RANGE_1),
            b = clamp(b, RANGE_1),
            format = format
        }
    end
end
return ____exports

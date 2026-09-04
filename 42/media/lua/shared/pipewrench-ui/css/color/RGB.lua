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
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local ____Math = require('pipewrench-ui/css/math/Math')
local clamp = ____Math.clamp
local RANGE_1 = ____Math.RANGE_1
local RANGE_255 = ____Math.RANGE_255
local ____CMYK = require('pipewrench-ui/css/color/CMYK')
local RANGE_100 = ____CMYK.RANGE_100
____exports.parseRGB = function(raw, format)
    if (string.find(raw, "rgb(", nil, true) or 0) - 1 == -1 or not __TS__StringEndsWith(raw, ")") then
        error(
            __TS__New(Error, "Invalid rgb() rule: " .. raw),
            0
        )
    end
    local values = __TS__StringSplit(
        __TS__StringReplace(
            __TS__StringReplace(raw, "rgba(", ""),
            ")",
            ""
        ),
        ","
    )
    if #values ~= 3 then
        error(
            __TS__New(Error, ("Invalid rgb() rule: " .. raw) .. " (Not 3 values)"),
            0
        )
    end
    local result = {
        r = clamp(
            math.floor(tonumber(__TS__StringTrim(values[1])) + 0.5),
            RANGE_255
        ),
        g = clamp(
            math.floor(tonumber(__TS__StringTrim(values[2])) + 0.5),
            RANGE_255
        ),
        b = clamp(
            math.floor(tonumber(__TS__StringTrim(values[3])) + 0.5),
            RANGE_255
        ),
        format = format
    }
    if format == "1" then
        result.r = result.r / 255
        result.g = result.g / 255
        result.b = result.b / 255
    end
    return result
end
____exports.RGB_2_HEX = function(color)
    local r = color.r
    local g = color.g
    local b = color.b
    if color.format == "1" then
        r = r * 255
        g = g * 255
        b = b * 255
    end
    local rgb = {
        __TS__NumberToString(color.r, 16),
        __TS__NumberToString(color.g, 16),
        __TS__NumberToString(color.b, 16)
    }
    do
        local i = 0
        while i < 3 do
            if #rgb[i + 1] == 1 then
                rgb[i + 1] = rgb[i + 1] .. rgb[i + 1]
            end
            i = i + 1
        end
    end
    if __TS__StringAccess(rgb[1], 0) == __TS__StringAccess(rgb[1], 1) and __TS__StringAccess(rgb[2], 0) == __TS__StringAccess(rgb[2], 1) and __TS__StringAccess(rgb[3], 0) == __TS__StringAccess(rgb[3], 1) then
        return (("#" .. __TS__StringAccess(rgb[1], 0)) .. __TS__StringAccess(rgb[2], 0)) .. __TS__StringAccess(rgb[3], 0)
    else
        return (("#" .. rgb[1]) .. rgb[2]) .. rgb[3]
    end
end
---
-- @param color The rgb color values.
-- @return The calculated HSL color values.
____exports.RGB_2_HSL = function(color)
    local ____color_0 = color
    local format = ____color_0.format
    local ____color_1 = color
    local r = ____color_1.r
    local g = ____color_1.g
    local b = ____color_1.b
    if format == "255" then
        r = r / 255
        g = g / 255
        b = b / 255
    end
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h
    local s
    local l = (max + min) / 2
    if max == min then
        s = 0
        h = s
    else
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        repeat
            local ____switch16 = max
            local ____cond16 = ____switch16 == r
            if ____cond16 then
                h = (g - b) / d + (g < b and 6 or 0)
                break
            end
            ____cond16 = ____cond16 or ____switch16 == g
            if ____cond16 then
                h = (b - r) / d + 2
                break
            end
            ____cond16 = ____cond16 or ____switch16 == b
            if ____cond16 then
                h = (r - g) / d + 4
                break
            end
        until true
        h = h / 6
    end
    return {
        h = clamp(h, RANGE_1),
        s = clamp(s, RANGE_1),
        l = clamp(l, RANGE_1)
    }
end
____exports.RGB_2_CMYK = function(color)
    local ____color_2 = color
    local format = ____color_2.format
    local ____color_3 = color
    local r = ____color_3.r
    local g = ____color_3.g
    local b = ____color_3.b
    if format == "255" then
        r = r / 255
        g = g / 255
        b = b / 255
    end
    local c = 1 - r
    local m = 1 - g
    local y = 1 - b
    local k = math.min(
        c,
        math.min(m, y)
    )
    c = (c - k) / (1 - k)
    m = (m - k) / (1 - k)
    y = (y - k) / (1 - k)
    c = math.floor(c * 10000 + 0.5) / 100
    m = math.floor(m * 10000 + 0.5) / 100
    y = math.floor(y * 10000 + 0.5) / 100
    k = math.floor(k * 10000 + 0.5) / 100
    return {
        c = clamp(
            __TS__NumberIsNaN(__TS__Number(c)) and 0 or c,
            RANGE_100
        ),
        m = clamp(
            __TS__NumberIsNaN(__TS__Number(m)) and 0 or m,
            RANGE_100
        ),
        y = clamp(
            __TS__NumberIsNaN(__TS__Number(y)) and 0 or y,
            RANGE_100
        ),
        k = clamp(
            __TS__NumberIsNaN(__TS__Number(k)) and 0 or k,
            RANGE_100
        )
    }
end
____exports.formatRGB = function(color, format)
    if format == "1" then
        if color.format == "1" then
            return __TS__ObjectAssign({}, color)
        end
        return {
            r = math.floor(clamp(color.r, RANGE_255) / 255 + 0.5),
            g = math.floor(clamp(color.g, RANGE_255) / 255 + 0.5),
            b = math.floor(clamp(color.b, RANGE_255) / 255 + 0.5),
            format = "1"
        }
    else
        if color.format == "255" then
            return __TS__ObjectAssign({}, color)
        end
        return {
            r = math.floor(clamp(color.r, RANGE_1) * 255 + 0.5),
            g = math.floor(clamp(color.g, RANGE_1) * 255 + 0.5),
            b = math.floor(clamp(color.b, RANGE_1) * 255 + 0.5),
            format = "255"
        }
    end
end
____exports.asRGB = function(red, green, blue, format)
    return {r = red, g = green, b = blue, format = format}
end
return ____exports

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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__NumberToString = ____lualib.__TS__NumberToString
local __TS__StringAccess = ____lualib.__TS__StringAccess
local ____exports = {}
local ____Math = require('pipewrench-ui/css/math/Math')
local clamp = ____Math.clamp
local RANGE_1 = ____Math.RANGE_1
local RANGE_255 = ____Math.RANGE_255
____exports.parseRGBA = function(raw, format)
    if (string.find(raw, "rgba(", nil, true) or 0) - 1 == -1 or not __TS__StringEndsWith(raw, ")") then
        error(
            __TS__New(Error, "Invalid rgba() rule: " .. raw),
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
    if #values ~= 4 then
        error(
            __TS__New(Error, ("Invalid rgba() rule: " .. raw) .. " (Not 4 values)"),
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
        a = clamp(
            tonumber(__TS__StringTrim(values[4])),
            RANGE_1
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
____exports.formatRGBA = function(color, format)
    if format == "1" then
        if color.format == "1" then
            return __TS__ObjectAssign({}, color)
        end
        return {
            r = math.floor(clamp(color.r, RANGE_255) / 255 + 0.5),
            g = math.floor(clamp(color.g, RANGE_255) / 255 + 0.5),
            b = math.floor(clamp(color.b, RANGE_255) / 255 + 0.5),
            a = clamp(color.a, RANGE_1),
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
            a = clamp(color.a, RANGE_1),
            format = "255"
        }
    end
end
____exports.asRGBA = function(red, green, blue, alpha, format)
    if alpha == nil then
        alpha = 1
    end
    return {
        r = red,
        g = green,
        b = blue,
        a = alpha,
        format = format
    }
end
____exports.RGBA_2_HEX = function(color)
    local ____color_0 = color
    local format = ____color_0.format
    local ____color_1 = color
    local r = ____color_1.r
    local g = ____color_1.g
    local b = ____color_1.b
    local a = ____color_1.a
    if format == "1" then
        r = r * 255
        g = g * 255
        b = b * 255
        a = a * 255
    end
    local rgba = {
        __TS__NumberToString(r, 16),
        __TS__NumberToString(g, 16),
        __TS__NumberToString(b, 16),
        __TS__NumberToString(a, 16)
    }
    do
        local i = 0
        while i < 4 do
            if #rgba[i + 1] == 1 then
                rgba[i + 1] = rgba[i + 1] .. rgba[i + 1]
            end
            i = i + 1
        end
    end
    if __TS__StringAccess(rgba[1], 0) == __TS__StringAccess(rgba[1], 1) and __TS__StringAccess(rgba[2], 0) == __TS__StringAccess(rgba[2], 1) and __TS__StringAccess(rgba[3], 0) == __TS__StringAccess(rgba[3], 1) and __TS__StringAccess(rgba[4], 0) == __TS__StringAccess(rgba[4], 1) then
        return ((("#" .. __TS__StringAccess(rgba[1], 0)) .. __TS__StringAccess(rgba[2], 0)) .. __TS__StringAccess(rgba[3], 0)) .. __TS__StringAccess(rgba[4], 0)
    else
        return ((("#" .. rgba[1]) .. rgba[2]) .. rgba[3]) .. rgba[4]
    end
end
return ____exports

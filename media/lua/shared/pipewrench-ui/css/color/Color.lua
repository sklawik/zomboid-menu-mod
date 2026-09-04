local ____exports = {}
local ____RGBA = require('pipewrench-ui/css/color/RGBA')
local parseRGBA = ____RGBA.parseRGBA
local asRGBA = ____RGBA.asRGBA
local formatRGBA = ____RGBA.formatRGBA
local ____RGB = require('pipewrench-ui/css/color/RGB')
local parseRGB = ____RGB.parseRGB
local asRGB = ____RGB.asRGB
local formatRGB = ____RGB.formatRGB
local RGB_2_CMYK = ____RGB.RGB_2_CMYK
local RGB_2_HEX = ____RGB.RGB_2_HEX
local RGB_2_HSL = ____RGB.RGB_2_HSL
local ____CMYK = require('pipewrench-ui/css/color/CMYK')
local parseCMYK = ____CMYK.parseCMYK
local CMYK_2_RGB = ____CMYK.CMYK_2_RGB
local ____HEX = require('pipewrench-ui/css/color/HEX')
local parseHEX = ____HEX.parseHEX
local ____HSL = require('pipewrench-ui/css/color/HSL')
local parseHSL = ____HSL.parseHSL
local HSL_2_RGB = ____HSL.HSL_2_RGB
____exports.transparent = function(format)
    if format == nil then
        format = "1"
    end
    return {
        r = 0,
        g = 0,
        b = 0,
        a = 0,
        format = format
    }
end
____exports.parseCMYK = parseCMYK
____exports.CMYK_2_RGB = CMYK_2_RGB
____exports.parseHEX = parseHEX
____exports.parseHSL = parseHSL
____exports.HSL_2_RGB = HSL_2_RGB
____exports.parseRGB = parseRGB
____exports.asRGB = asRGB
____exports.formatRGB = formatRGB
____exports.RGB_2_CMYK = RGB_2_CMYK
____exports.RGB_2_HEX = RGB_2_HEX
____exports.RGB_2_HSL = RGB_2_HSL
____exports.parseRGBA = parseRGBA
____exports.asRGBA = asRGBA
____exports.formatRGBA = formatRGBA
return ____exports

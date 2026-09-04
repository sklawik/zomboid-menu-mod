local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local ____RGB = require('pipewrench-ui/css/color/RGB')
local RGB_2_CMYK = ____RGB.RGB_2_CMYK
local RGB_2_HSL = ____RGB.RGB_2_HSL
local ____HSL = require('pipewrench-ui/css/color/HSL')
local readHSL = ____HSL.parseHSL
local HSL_2_RGB = ____HSL.HSL_2_RGB
local ____CMYK = require('pipewrench-ui/css/color/CMYK')
local CMYK_2_RGB = ____CMYK.CMYK_2_RGB
local readCMYK = ____CMYK.parseCMYK
____exports.CSSTests = __TS__Class()
local CSSTests = ____exports.CSSTests
CSSTests.name = "CSSTests"
function CSSTests.prototype.____constructor(self)
end
function CSSTests.prototype.test(self)
    self:testHSL()
    self:testCMYK()
end
function CSSTests.prototype.testHSL(self)
    local orig = "hsl(180, 50, 50)"
    local hsl = readHSL(orig)
    local hsl2rgb = HSL_2_RGB(hsl, "1")
    local rgb2hsl = RGB_2_HSL(hsl2rgb)
end
function CSSTests.prototype.testCMYK(self)
    local orig = "cmyk(100%, 0%, 0%, 0%)"
    local cmyk = readCMYK(orig)
    local cmyk2rgb = CMYK_2_RGB(cmyk, "1")
    local rgb2cmyk = RGB_2_CMYK(cmyk2rgb)
end
return ____exports

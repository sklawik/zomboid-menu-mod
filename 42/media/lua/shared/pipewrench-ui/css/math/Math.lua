local ____lualib = require('lualib_bundle')
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
____exports.RANGE_360 = {min = 0, max = 360}
____exports.RANGE_255 = {min = 0, max = 255}
____exports.RANGE_100 = {min = 0, max = 100}
____exports.RANGE_1 = {min = 0, max = 1}
--- Tests values with assigned names, ensuring that all values passed are not null, undefined, NaN, and infinite.
-- 
-- @param namedValues The values to test.
-- @throws Error - Thrown when a value is null, undefined, NaN, or infinite.
____exports.checkValues = function(...)
    local namedValues = {...}
    for ____, namedValue in ipairs(namedValues) do
        local name = namedValue.name
        local value = namedValue.value
        if value == nil or __TS__NumberIsNaN(__TS__Number(value)) or not __TS__NumberIsFinite(__TS__Number(value)) then
            error(
                __TS__New(
                    Error,
                    (("The value '" .. name) .. "' as null, NaN, or Infinite: ") .. tostring(value)
                ),
                0
            )
        end
    end
end
--- A simple clamp where a value is limited to a range.
-- 
-- @param value The value to clamp.
-- @param min The minimum accepted value.
-- @param max The maximum accepted value.
-- @returns The clamped value.
____exports.clamp = function(value, range)
    return math.min(
        math.max(range.min, value),
        range.max
    )
end
--- Calculates a value between a range of values from a percentage value of 0.0 to 1.0.
-- 
-- @param percent The percentage to calculate between the range.
-- @param range The range to calculate from min to max.
-- @param clampValue If true, values below range.min or exceeding range.max are clamped to their respective value.
-- @returns The calculated value between the range based on the percent.
____exports.lerp = function(percent, range, clampValue)
    if range == nil then
        range = {min = 0, max = 1}
    end
    if clampValue == nil then
        clampValue = true
    end
    local val = range.min + percent * (range.max - range.min)
    return clampValue and ____exports.clamp(val, range) or val
end
____exports.unlerp = function(start, stop, value)
    ____exports.checkValues({name = "start", value = start}, {name = "stop", value = stop}, {name = "value", value = value})
    if value == stop or start == stop then
        return 1
    end
    local swap = start > stop
    if swap then
        local temp = start
        start = stop
        stop = temp
    end
    if swap then
        return 1 - (value - start) / (stop - start)
    else
        return (value - start) / (stop - start)
    end
end
____exports.easeInOut = function(t)
    ____exports.checkValues({name = "t", value = t})
    return t > 0.5 and 4 * (t - 1) ^ 3 + 1 or 4 * t ^ 3
end
____exports.easeIn = function(t)
    ____exports.checkValues({name = "t", value = t})
    return 1 - math.cos(t * math.pi * 0.5)
end
____exports.easeOut = function(t)
    ____exports.checkValues({name = "t", value = t})
    return math.sin(t * math.pi * 0.5)
end
return ____exports

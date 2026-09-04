local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsNaN = ____lualib.__TS__NumberIsNaN
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local ____exports = {}
local ____Math = require('pipewrench-ui/css/math/Math')
local easeIn = ____Math.easeIn
local easeInOut = ____Math.easeInOut
local easeOut = ____Math.easeOut
local lerp = ____Math.lerp
____exports.Path = __TS__Class()
local Path = ____exports.Path
Path.name = "Path"
function Path.prototype.____constructor(self)
    self._callbacks = {}
    self._ticks = 1
    self._tick = 0
    self._x = 0
    self._y = 0
    self._scale = 1
end
__TS__SetDescriptor(
    Path.prototype,
    "from",
    {get = function(self)
        return __TS__ObjectAssign({}, self._from)
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "to",
    {get = function(self)
        return __TS__ObjectAssign({}, self._to)
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "mode",
    {get = function(self)
        return self._mode
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "ticks",
    {get = function(self)
        return self._ticks
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "tick",
    {get = function(self)
        return self._tick
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "x",
    {get = function(self)
        return self._x
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "y",
    {get = function(self)
        return self._y
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "scale",
    {get = function(self)
        return self._scale
    end},
    true
)
__TS__SetDescriptor(
    Path.prototype,
    "running",
    {get = function(self)
        return self._to ~= nil
    end},
    true
)
function Path.prototype.reset(self, coords)
    if coords.x ~= nil then
        self._x = coords.x
    end
    if coords.y ~= nil then
        self._y = coords.y
    end
    if coords.scale ~= nil then
        self._scale = coords.scale
    end
    local callbacks = self._callbacks
    local x = self._x
    local y = self._y
    local scale = self._scale
    if callbacks ~= nil and #callbacks ~= 0 then
        local step = {x = x, y = y, scale = scale}
        for ____, callback in ipairs(callbacks) do
            callback(nil, step, 1)
        end
    end
    self._from = nil
    self._to = nil
    self._callbacks = nil
    self._mode = nil
    self._tick = 0
    self._ticks = 0
end
function Path.prototype.start(self, to, callbacks, ticks, mode)
    if callbacks == nil then
        callbacks = nil
    end
    if ticks == nil then
        ticks = 60
    end
    if mode == nil then
        mode = "linear"
    end
    local x = self._x
    local y = self._y
    local scale = self._scale
    if to.x == x and to.y == y and to.scale == scale then
        return
    end
    local ____TS__ObjectAssign_result_0 = __TS__ObjectAssign({}, to)
    self._to = ____TS__ObjectAssign_result_0
    local _to = ____TS__ObjectAssign_result_0
    if to.x == x then
        _to.x = nil
    end
    if to.y == y then
        _to.y = nil
    end
    if to.scale == scale then
        _to.scale = nil
    end
    if ticks == 0 then
        ticks = 1
    end
    self._callbacks = callbacks
    self._from = {x = x, y = y, scale = scale}
    self._tick = 0
    self._ticks = ticks
    self._mode = mode
end
function Path.prototype.update(self)
    local from = self._from
    local to = self._to
    local callbacks = self._callbacks
    local mode = self._mode
    if to == nil then
        return
    end
    self._tick = self._tick + 1
    local tick = self._tick
    local ticks = self._ticks
    local tLerp = tick / ticks
    if not __TS__NumberIsNaN(__TS__Number(tLerp)) and __TS__NumberIsFinite(__TS__Number(tLerp)) then
        local step
        if mode == "ease-in" then
            step = easeIn(tLerp)
        elseif mode == "ease-out" then
            step = easeOut(tLerp)
        elseif mode == "ease-in-out" then
            step = easeInOut(tLerp)
        elseif mode == "linear" then
            step = tLerp
        end
        local ____from_1 = from
        local x1 = ____from_1.x
        local y1 = ____from_1.y
        local s1 = ____from_1.scale
        local ____to_2 = to
        local x2 = ____to_2.x
        local y2 = ____to_2.y
        local s2 = ____to_2.scale
        local ____temp_3 = x2 ~= nil and lerp(step, {min = x1, max = x2}) or nil
        self._x = ____temp_3
        local x = ____temp_3
        local ____temp_4 = y2 ~= nil and lerp(step, {min = y1, max = y2}) or nil
        self._y = ____temp_4
        local y = ____temp_4
        local ____temp_5 = s2 ~= nil and lerp(step, {min = s1, max = s2}) or nil
        self._scale = ____temp_5
        local scale = ____temp_5
        if callbacks ~= nil and #callbacks ~= 0 then
            local step = {x = x, y = y, scale = scale}
            for ____, callback in ipairs(callbacks) do
                callback(nil, step, tLerp)
            end
        end
    end
    if tick >= ticks then
        self:reset(to)
    end
end
function Path.prototype.cancel(self, x, y, scale)
    if x == nil then
        x = true
    end
    if y == nil then
        y = true
    end
    if scale == nil then
        scale = true
    end
    local to = self._to
    if to == nil then
        return
    end
    if type(x) == "boolean" and x or type(x) == "number" then
        if type(x) == "number" then
            self._x = x
        end
        to.x = nil
    end
    if type(y) == "boolean" and y or type(y) == "number" then
        if type(y) == "number" then
            self._y = y
        end
        to.y = nil
    end
    if type(scale) == "boolean" and scale or type(scale) == "number" then
        if type(scale) == "number" then
            self._scale = scale
        end
        to.scale = nil
    end
end
return ____exports

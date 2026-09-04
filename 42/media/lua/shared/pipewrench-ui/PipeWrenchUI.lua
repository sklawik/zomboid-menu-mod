local ____exports = {}
local ____pipewrench_2Devents = require('lua_modules/@asledgehammer/pipewrench-events/PipeWrench-Events')
local onFrontEndTick = ____pipewrench_2Devents.onFrontEndTick
local onMainMenuEnter = ____pipewrench_2Devents.onMainMenuEnter
local onTickEvenPaused = ____pipewrench_2Devents.onTickEvenPaused
local ____Window = require('pipewrench-ui/Window')
local window = ____Window.window
local ____html = require('pipewrench-ui/html/elements/html')
local document = ____html.document
onMainMenuEnter:addListener(function()
    local function update(self)
        window:update()
        document:update2()
    end
    onFrontEndTick:addListener(update)
    onTickEvenPaused:addListener(update)
end)
return ____exports

local ____exports = {}
local Events = require('lua_modules/@asledgehammer/pipewrench-events/PipeWrench-Events')
local ____React = require('pipewrench-ui/React')
local PipeWrenchUI = ____React.PipeWrenchUI
local ____html = require('pipewrench-ui/html/elements/html')
local document = ____html.document
local JSON = require('pipewrench-ui/util/JSON')
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local getWorld = ____pipewrench.getWorld
Events.onMainMenuEnter:addListener(function()
    local element = PipeWrenchUI:createElement(
        "div",
        {style = ""},
        PipeWrenchUI:createElement("img", {
            id = "image-1",
            src = "media/textures/kutas_pic.png",
            style = "top: 0px; left: 0px; width:100vw;",
            width = "100vw",
            height = "100vh"
        })
    )
    document:appendChild(element)
    local img1 = document:getElementById("image-1")
    img1:addEventListener(
        "mousemove",
        function(____, event)
            print(JSON.stringify(event))
        end
    )
end)
Events.onHitZombie:addListener(function(zombie, player)
    local world = getWorld()
    local zombies = world:getCell():getZombieList()
    do
        local i = 0
        while i < zombies:size() - 1 do
            local zombi = zombies:get(i)
            zombi:Say("I wish you were Rick Grimes")
            zombi:update()
            player:Say("I'm not Rick Grimes ")
            i = i + 1
        end
    end
end)
Events.onPlayerUpdate:addListener(function(player)
    local element = PipeWrenchUI:createElement(
        "div",
        {id = "divek", style = ""},
        PipeWrenchUI:createElement("img", {
            id = "image-1",
            src = "media/textures/kutas_pic.png",
            style = "top: 0px; left: 0px; width:100vw;",
            width = "100vw",
            height = "100vh"
        })
    )
    document:appendChild(element)
    local img1 = document:getElementById("image-1")
    local divek = document:getElementById("divek")
    divek:setStyle("bottom: 0px; backgroundImage: url(\"media/textures/kutas_pic.png\"); padding: 5rem; width: 100%; height: 100%; backgroundColor: \"blue\";")
    local world = getWorld()
    local zombies = world:getCell():getZombieList()
end)

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  getWorld = ____pipewrench.getWorld
end)
----------------

return ____exports

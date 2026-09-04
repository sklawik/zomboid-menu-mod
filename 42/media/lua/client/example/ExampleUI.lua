local function changeMainMenuBackground()
    print("Hello test from function")
    local texture = getTexture("media/textures/background.png")

    if texture then
        MainScreen.instance.background = texture
    end
end

Events.OnMainMenuEnter.Add(changeMainMenuBackground)

print("Hello test from mod")
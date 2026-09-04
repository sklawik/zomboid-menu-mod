local oldPrerender = MainScreen.prerender

function MainScreen:prerender()
    oldPrerender(self)

    local texture = getTexture("media/textures/background.png")

    if texture then
        self:drawTextureScaled(
            texture,
            0,
            0,
            self:getWidth(),
            self:getHeight(),
            1
        )
    end
end

print("CUSTOM MAIN MENU MOD LOADED")
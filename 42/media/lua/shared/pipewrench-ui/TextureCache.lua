local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____pipewrench = require('lua_modules/@asledgehammer/pipewrench/PipeWrench')
local getTexture = ____pipewrench.getTexture
--- **TextureCache** handles caching and a lookup-table for the HTML engine.
-- 
-- @author JabDoesThings
____exports.TextureCache = __TS__Class()
local TextureCache = ____exports.TextureCache
TextureCache.name = "TextureCache"
function TextureCache.prototype.____constructor(self)
    error(
        __TS__New(Error, "Cannot instantiate TextureCache."),
        0
    )
end
function TextureCache.getOrLoad(self, path)
    path = self:formatPath(path)
    local texture = self:get(path)
    if texture ~= nil then
        return texture
    end
    texture = getTexture(path)
    if texture ~= nil then
        self._textures[path] = texture
    end
    return texture
end
function TextureCache.get(self, path)
    return self._textures[self:formatPath(path)]
end
function TextureCache.isLoaded(self, path)
    return self._textures[self:formatPath(path)] ~= nil
end
function TextureCache.formatPath(self, path)
    return string.lower(path)
end
TextureCache._textures = {}

-- PIPEWRENCH --
if _G.Events.OnPipeWrenchBoot == nil then
  _G.triggerEvent('OnPipeWrenchBoot', false)
end
_G.Events.OnPipeWrenchBoot.Add(function(____flag____)
  if ____flag____ ~= true then return end
  getTexture = ____pipewrench.getTexture
end)
----------------

return ____exports

local ____lualib = require('lualib_bundle')
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
____exports.Event = __TS__Class()
local Event = ____exports.Event
Event.name = "Event"
function Event.prototype.____constructor(self, _type)
    self._type = _type
end
return ____exports

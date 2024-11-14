local _G = _G
local include, require = _G.include, _G.require

include( "util.lua" )
include( "util/sql.lua" )
include( "extensions/net.lua" )

require( "baseclass" )
require( "concommand" )
require( "saverestore" )
require( "hook" )
require( "gamemode" )
require( "weapons" )
require( "scripted_ents" )
require( "duplicator" )

require( "usermessage" )
_G.SendUserMessage = nil -- fuck off

require( "list" )
require( "cvars" )
require( "http" )

if _G.CLIENT then
	require( "effects" )
	require( "matproxy" )
end

do

	local string_lower = _G.string.lower

	local type2value = {
		["vector"] = _G.Vector,
		["angle"] = _G.Angle,
		["float"] = _G.tonumber,
		["number"] = _G.tonumber,
		["int"] = _G.tonumber,
		["bool"] = _G.tobool,
		["boolean"] = _G.tobool,
		["string"] = _G.tostring,
		["entity"] = _G.Entity
	}

	function util.StringToType( str, typename )
		return type2value[ string_lower( typename ) ]
	end

end

include( "extensions/file.lua" )
include( "extensions/entity.lua" )
include( "extensions/ents.lua" )
_G.ents.FindByClassAndParent = nil -- fuck off

include( "extensions/math.lua" )
include( "extensions/player.lua" )
include( "extensions/table.lua" )

include( "extensions/string.lua" )
include( "extensions/table.lua" )

include( "extensions/game.lua" )
include( "extensions/weapon.lua" )
include( "extensions/coroutine.lua" )

if _G.CLIENT then
	include( "extensions/client/entity.lua" )
	include( "extensions/client/panel.lua" )
end

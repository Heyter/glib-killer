local _G = _G
local include, require = _G.include, _G.require

include ( "util.lua" )
include ( "util/sql.lua" )
include( "extensions/net.lua" )

require ( "baseclass" )
require ( "concommand" )
require ( "saverestore" )
require ( "hook" )
require ( "gamemode" )
require ( "weapons" )
require ( "scripted_ents" )
require ( "player_manager" )
require ( "numpad" )
require ( "team" )
require ( "undo" )
require ( "cleanup" )
require ( "duplicator" )
require ( "constraint" )
require ( "construct" )
require ( "usermessage" )
_G.SendUserMessage = nil
require ( "list" )
require ( "cvars" )
require ( "http" )
require ( "properties" )
require ( "cookie" )
require ( "utf8" )
require ( "drive" )
include ( "drive/drive_base.lua" )
include ( "drive/drive_noclip.lua" )

if _G.SERVER then
	require( "ai_task" )
	require( "ai_schedule" )
else
	require ( "draw" )
	require ( "markup" )
	require ( "effects" )
	require ( "halo" )
	require ( "killicon" )
	require ( "spawnmenu" )
	require ( "controlpanel" )
	require ( "presets" )
	require ( "menubar" )
	require ( "matproxy" )

	include( "util/model_database.lua" )
	include( "util/tooltips.lua" )
	include( "util/client.lua" )
	include( "gui/icon_progress.lua" )
end

include ( "extensions/file.lua" )
include ( "extensions/angle.lua" )
include ( "extensions/debug.lua" )
include ( "extensions/entity.lua" )
include ( "extensions/ents.lua" )
include ( "extensions/math.lua" )
include ( "extensions/player.lua" )
include ( "extensions/string.lua" )
include ( "extensions/table.lua" )
include ( "extensions/util.lua" )

do
	local string_lower = _G.string.lower
	local type2value = {
		["vector"] = _G.Vector, ["angle"] = _G.Angle, ["float"] = _G.tonumber,
		["number"] = _G.tonumber, ["int"] = _G.tonumber, ["bool"] = _G.tobool,
		["boolean"] = _G.tobool, ["string"] = _G.tostring, ["entity"] = _G.Entity
	}

	function util.StringToType( str, typename )
		return type2value[ string_lower( typename ) ](str)
	end
end

include ( "extensions/vector.lua" )
include ( "extensions/game.lua" )
include ( "extensions/weapon.lua" )
include ( "extensions/coroutine.lua" )

if _G.CLIENT then
	include ( "extensions/client/entity.lua" )
	include ( "extensions/client/globals.lua" )
	include ( "extensions/client/panel.lua" )
	include ( "extensions/client/player.lua" )
	include ( "extensions/client/render.lua" )

	require ( "search" )
end
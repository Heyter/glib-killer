local _G = _G

local CLIENT, SERVER = _G.CLIENT, _G.SERVER
local getmetatable = _G.getmetatable
local fempty = function() end

_G.AddCSLuaFile()

ENT.Type = "point"
ENT.DisableDuplicator = true

function ENT:UpdateTransmitState() return 0 end

function ENT:SetupDataTables()

    self:NetworkVar( "Vector", 0, "TopColor", { KeyName = "topcolor", Edit = { type = "VectorColor", category = "Main", order = 1 } } )
    self:NetworkVar( "Vector", 1, "BottomColor", { KeyName = "bottomcolor", Edit = { type = "VectorColor", category = "Main", title = "Color Bottom", order = 2 } } )
    self:NetworkVar( "Float", 0, "FadeBias", { KeyName = "fadebias", Edit = { type = "Float", category = "Main", min = 0, max = 1, order = 3 } } )

    self:NetworkVar( "Float", 4, "SunSize", { KeyName = "sunsize", Edit = { type = "Float", min = 0, max = 10, category = "Sun" } } )
    self:NetworkVar( "Vector", 2, "SunNormal", { KeyName = "sunnormal" } ) -- No editing this - it's for coders only
    self:NetworkVar( "Vector", 3, "SunColor", { KeyName = "suncolor", Edit = { type = "VectorColor", category = "Sun" } } )

    self:NetworkVar( "Float", 2, "DuskScale", { KeyName = "duskscale", Edit = { type = "Float", min = 0, max = 1, category = "Dusk" } } )
    self:NetworkVar( "Float", 3, "DuskIntensity", { KeyName = "duskintensity", Edit = { type = "Float", min = 0, max = 10, category = "Dusk" } } )
    self:NetworkVar( "Vector", 4, "DuskColor", { KeyName = "duskcolor", Edit = { type = "VectorColor", category = "Dusk" } } )

    self:NetworkVar( "Bool", 0, "DrawStars", { KeyName = "drawstars", Edit = { type = "Boolean", category = "Stars", order = 10 } } )
    self:NetworkVar( "String", 0, "StarTexture", { KeyName = "startexture", Edit = { type = "Texture", group = "Stars", category = "Stars", order = 11 } } )

    self:NetworkVar( "Int", 0, "StarLayers", { KeyName = "starlayers", Edit = { type = "Int", min = 1, max = 3, category = "Stars", order = 12 } } )
    self:NetworkVarElement( "Angle", 0, 'p', "StarScale", { KeyName = "starscale", Edit = { type = "Float", min = 0, max = 5, category = "Stars", order = 13 } } )
    self:NetworkVarElement( "Angle", 0, 'y', "StarFade", { KeyName = "starfade", Edit = { type = "Float", min = 0, max = 5, category = "Stars", order = 14 } } )
    self:NetworkVarElement( "Angle", 0, 'r', "StarSpeed", { KeyName = "starspeed", Edit = { type = "Float", min = 0, max = 2, category = "Stars", order = 15 } } )

    self:NetworkVar( "Float", 1, "HDRScale", { KeyName = "hdrscale", Edit = { type = "Float", category = "Main", min = 0, max = 1, order = 4 } } )

    if ( SERVER ) then
        self:SetTopColor( Vector( 0.2, 0.5, 1.0 ) )
        self:SetBottomColor( Vector( 0.8, 1.0, 1.0 ) )
        self:SetFadeBias( 1 )

        self:SetSunNormal( Vector( 0.4, 0.0, 0.01 ) )
        self:SetSunColor( Vector( 0.2, 0.1, 0.0 ) )
        self:SetSunSize( 2.0 )

        self:SetDuskColor( Vector( 1.0, 0.2, 0.0 ) )
        self:SetDuskScale( 1 )
        self:SetDuskIntensity( 1 )

        self:SetDrawStars( true )
        self:SetStarLayers( 1 )
        self:SetStarSpeed( 0.01 )
        self:SetStarScale( 0.5 )
        self:SetStarFade( 1.5 )
        self:SetStarTexture( "skybox/starfield" )

        self:SetHDRScale( 0.66 )
    end

end

ENT.CanEditVariables = fempty
ENT.Initialize = fempty
ENT.KeyValue = fempty

local VECTOR = FindMetaTable( "Vector" )
local ENTITY = FindMetaTable( "Entity" )
local ENTITY_GetInternalVariable, ENTITY_IsValid = ENTITY.GetInternalVariable, ENTITY.IsValid

function ENT:Think()
    if SERVER then
        local entity = self.EnvSun
        if entity == nil then
            self.EnvSun = _G.ents.FindByClass( "env_sun" )[ 1 ] or false
        elseif ENTITY_IsValid( entity) then
            local vector = ENTITY_GetInternalVariable( entity, "m_vDirection" )
            if getmetatable( vector ) == VECTOR then
                self:SetSunNormal( vector )
            end
        end

        return
    elseif CLIENT then
        local g_SkyPaint = _G.g_SkyPaint
        if g_SkyPaint == self then return end
        if g_SkyPaint and ENTITY_IsValid( g_SkyPaint ) then return end
        _G.g_SkyPaint = self
    end
end

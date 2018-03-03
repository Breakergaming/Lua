AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
-- Hier Änderst du das Leben des Gravity Generator's1
health = 2000

self:SetModel("models/props_combine/combine_interface001.mdl")
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)
self:SetUseType(SIMPLE_USE)


local phys = self:GetPhysicsObject()

if phys:IsValid() then

        phys:Wake()

    end

end 


hook.Add( "PlayerSay", "Killurself", function( ply, text, public, pPlayer)
text = string.lower( text ) 
if ( text == "/repair" ) then -- Der Chat Command                                                                    
        if (ply:Team() == TEAM_BEISPIEL1 and ply:Alive() or ply:Team() == TEAM_BEISPIEL2 ) then -- Tausche TEAM_* Mit dem Jobs aus den du erlauben Möchtest /Repair Benutzen zu dürfen. ~ Jobs.Lua
            health = 2000
            game.ConsoleCommand("sv_gravity 600\n") -- Standard Gravity
            BroadcastMsg(Color(0,255,0),"[Erfolg] ".."Der Gravity Generator Wurde repariert von "..ply:Nick())
            return ""
            else
            ply:PlayerMsg(Color(255,0,0),"[Warnung] ".."Du bist kein EOD")
            return ""
end
    end
end )


function ENT:Use(a, ply)
    if IsValid( ply ) then
        ply:PlayerMsg(Color(255,255,0),"[INFO] ".."Der Gravity Generator hat noch "..health.." %")
        
    end
end



function ENT:OnTakeDamage(AddDamage)

local ply = AddDamage:GetAttacker()
local dmg = AddDamage:GetDamage()

     health=health-math.Round( dmg )
    if health <= 0 then
    health = 0
    BroadcastMsg(Color(255,0,0),ply:Nick().." Hat den Gravity Generator Zerstört!")
    game.ConsoleCommand( "sv_gravity 200\n" ) -- Benutzerdefinierte Gravity
end


end

-- Die ganzen Texte sind Editierbar

-- By Luca00711 und Corrupted.rom
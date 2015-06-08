AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

resource.AddFile("resource/Lato-Light.ttf")

include("shared.lua")
include("/player_classes/prop_class.lua")

function GM:PlayerInitialSpawn(ply)
	ply:ConCommand("team_menu")
	ply:SetTeam(3)
end

function GM:PlayerSpawn(ply)
	if ply:Team() == 1 then
		MsgN("On Humans")
		ply:UnSpectate()
		player_manager.SetPlayerClass(ply, "Human")
		player_manager.OnPlayerSpawn(ply)
		player_manager.RunClass(ply, "WeaponLoadout");
	end
	if ply:Team() == 2 then
		ply.prop = ents.Create("prop_physics")
		MsgN("On Props")
		--local prop = ents.Create("prop_physics")
		if(!IsValid(ply.prop)) then return end
		ply.prop:SetModel("models/props/cs_office/Chair_office.mdl")
		ply.prop:SetPos(ply:GetPos())
		ply.prop:Spawn()
		ply.prop.playerID = ply:EntIndex()
		ply:Spectate(OBS_MODE_CHASE)
		ply:SpectateEntity(ply.prop)
		player_manager.SetPlayerClass(ply, "Prop")
		player_manager.OnPlayerSpawn(ply)
		ply:StripWeapons()
	end
	if ply:Team() == 3 then
		GAMEMODE:PlayerSpawnAsSpectator(ply)
		ply:StripWeapons()
	end
end	

function GM:PlayerSelectSpawn(ply)
	if(ply:Team() == 1) then
		local spawns = ents.FindByClass("info_player_terrorist")
		local random = math.random(#spawns)
		return spawns[random]
	end
	if(ply:Team() == 2) then
		local spawns = ents.FindByClass("info_player_counterterrorist")
		local random = math.random(#spawns)
		return spawns[random]
	end
end

function GM:KeyPress(ply, key)
	if (IsValid(ply.prop)) then
		return PropControl.Key(ply, key)
	end
	return false
end

function GM:EntityTakeDamage(target, dmg)
	if(target.playerID) and (player.GetByID(target.playerID):IsPlayer()) then
		local ply = player.GetByID(target.playerID)
	end
end

hook.Add('PlayerSay', 'playerChatCommands', function(ply, txt, isTeam)
	txt = string.lower(txt)
	if(string.sub(txt, 3) == "!suicide") then
		ply:Kill()
		ply:ChatPrint(ply:Nick() .. " decided they couldn't handle it anymore")
	end
end)

hook.Add( "Tick", "KeyDown_Test", function()
	local players = player.GetAll()
	for _, ply in ipairs(players) do
		if(ply:Team() == 2) then
			PropControl.Key(ply)
		end
	end
end)

function team_1(ply)
	ply:SetTeam(1)
	ply:Spawn()
end

function team_2(ply)
	ply:SetTeam(2)
	ply:Spawn()
end

function team_3(ply)
	ply:SetTeam(3)
	ply:Spawn()
end

concommand.Add("team_1", team_1)
concommand.Add("team_2", team_2)
concommand.Add("team_3", team_3)
AddCSLuaFile("/player_class/prop_class.lua")

GM.Name = "That Chair Tried to Kill Me"
GM.Author = "EdwardJFox"
GM.Email = "edwardjfox@outlook.com"
GM.Website = "edwardjfox.co.uk"

DeriveGamemode("base")

function GM:Initialize()
	-- Do stuff
end

team.SetUp(1, 'Humans', Color(89, 32, 247), true)
team.SetUp(2, 'Props', Color(247, 32, 89), true)
team.SetUp(3, 'Spec', Color(100, 100, 100), true)


local HumanClass = {}
	HumanClass.WalkSpeed = 350
	HumanClass.RunSpeed = 550
	HumanClass.MaxHealth = 150
	HumanClass.StartHealth = 150
	HumanClass.TeammateNoCollide = false
	HumanClass.JumpPower = 200
	HumanClass.WeaponLoadout = function(info)
		info.Player:Give("weapon_crowbar")
		info.Player:GiveAmmo( 128, "Pistol", true)
		info.Player:Give("weapon_pistol")
		info.Player:SetArmor(0);
	end

player_manager.RegisterClass("Human", HumanClass, "player_default")

local PropClass = {}
	PropClass.MaxHealth = 1000
	PropClass.StartHealth = 1000
	PropClass.TeammateNoCollide = false

player_manager.RegisterClass("Prop", PropClass, "player_default")

-- Timers
timer.Create("round", 10, 0, function()

end)
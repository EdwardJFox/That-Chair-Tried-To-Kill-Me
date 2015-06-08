include("shared.lua")

-- Local Variables
local hide = {
	CHudHealth = true,
	CHudBattery = true
}

local topInfoBox = {
	{ x = (ScrW()/2)-200, y = 0},
	{ x = (ScrW()/2)+200, y = 0},
	{ x = (ScrW()/2)+180, y = 40},
	{ x = (ScrW()/2)-180, y = 40}
}

--Fonts
surface.CreateFont("kp_info_font", {
	font = "Arial",
	size = 40,
	weight = 400	
})
surface.CreateFont("kp_score_font", {
	font = "Arial",
	size = 40,
	weight = 400	
})
surface.CreateFont("kp_menu_font", {
	font = "Lato Light",
	size = 24,
	weight = 400	
})

hook.Add('HUDPaint', 'yoorofl', function()
	local ply = LocalPlayer()
	
	-- Info background
	surface.SetDrawColor(Color(30, 30, 30))
	surface.DrawRect(0, ScrH()-58, (ScrW()/4) + 8, 58)
	-- Health Bar
	surface.SetDrawColor(Color(253, 51, 51))
	surface.DrawRect(4, ScrH()-54, (ply:Health()/ply:GetMaxHealth()) * (ScrW()/4), 50)
	-- Health Bar Text
	surface.SetFont("kp_info_font")
	surface.SetTextColor(Color(255, 255, 255))
	surface.SetTextPos(8, ScrH()-49)
	surface.DrawText(ply:Health())

	-- Time Limit and lives remaining
	surface.SetDrawColor(Color(30, 30, 30))
	draw.NoTexture()
	surface.DrawPoly(topInfoBox)
	surface.SetFont("kp_info_font")
	surface.SetTextColor(Color(255, 255, 255))
	surface.SetTextPos(8, ScrH()-49)
	surface.DrawText(ply:Health())
end)

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )

function chooseTeam()
	local frame = vgui.Create("DFrame");
		frame:SetPos(ScrW()/2-200, ScrH()/2 - 175)
		frame:SetSize(400, 350)
		frame:SetTitle("")
		frame:SetVisible(true)
		frame:SetDraggable(false)
		frame:ShowCloseButton(false)
		frame:MakePopup()
		function frame:Paint(w, h)
			surface.SetDrawColor(Color(30, 30, 30))
			surface.DrawRect(0, 0, w, h)
		end


	local propsIcon = vgui.Create("DModelPanel", frame)
        propsIcon:SetSize(155, 155)
        propsIcon:SetPos(215, 100)
        propsIcon:SetModel("models/props_c17/oildrum001.mdl")

	local humansButton = vgui.Create("DButton", frame)
		humansButton:SetText("Join Humans")
		humansButton:SetFont("kp_menu_font")
		humansButton:SetTextColor(Color(255, 255, 255))
		humansButton:SetPos(30, 280)
		humansButton:SetSize(155, 40)
		function humansButton:Paint(w, h)
			surface.SetDrawColor(Color(89, 32, 247))
			surface.DrawRect(0, 0, w, h)
		end
		function humansButton:DoClick()
			RunConsoleCommand("team_1")
			frame:Close()
	end

	local propsButton = vgui.Create("DButton", frame)
		propsButton:SetText("Join Props")
		propsButton:SetFont("kp_menu_font")
		propsButton:SetTextColor(Color(255, 255, 255))
		propsButton:SetPos(215, 280)
		propsButton:SetSize(155, 40)
		function propsButton:Paint(w, h)
			surface.SetDrawColor(Color(247, 32, 89))
			surface.DrawRect(0, 0, w, h)
		end
		function propsButton:DoClick()
			RunConsoleCommand("team_2")
			frame:Close()
		end

	local helpButton = vgui.Create("DButton", frame)
		helpButton:SetText("?")
		helpButton:SetFont("kp_menu_font")
		helpButton:SetTextColor(Color(255, 255, 255))
		helpButton:SetPos(30, 30)
		helpButton:SetSize(40, 40)
		function helpButton:Paint(w, h)
			surface.SetDrawColor(Color(30, 246, 73))
			surface.DrawRect(0, 0, w, h)
		end
		function helpButton:DoClick()
			frame:Close()
			RunConsoleCommand("howto")
		end

	local spectateButton = vgui.Create("DButton", frame)
		spectateButton:SetText("Spectate")
		spectateButton:SetFont("kp_menu_font")
		spectateButton:SetTextColor(Color(0, 0, 0))
		spectateButton:SetPos(215, 30)
		spectateButton:SetSize(155, 40)
		function spectateButton:Paint(w, h)
			surface.SetDrawColor(Color(218, 216, 208))
			surface.DrawRect(0, 0, w, h)
		end
		function spectateButton:DoClick()
			RunConsoleCommand("team_3")
			frame:Close()
		end
end

concommand.Add("team_menu", chooseTeam)

function helpMenu()
	local helpFrame = vgui.Create("DFrame");
		helpFrame:SetPos(ScrW()/2-300, ScrH()/2 - 250)
		helpFrame:SetSize(600, 500)
		helpFrame:SetTitle("Help")
		helpFrame:SetVisible(true)
		helpFrame:SetDraggable(false)
		helpFrame:ShowCloseButton(false)
		helpFrame:MakePopup()
		function helpFrame:Paint(w, h)
			surface.SetDrawColor(Color(30, 30, 30))
			surface.DrawRect(0, 0, w, h)
		end

	local helpHtml = vgui.Create("DHTML", helpFrame)
		helpHtml:OpenURL("http://edwardjfox.co.uk/gmod/propKillersHelp.html")
		helpHtml:SetSize(540, 370)
		helpHtml:SetPos(30, 30)

	local helpCloseButton = vgui.Create("DButton", helpFrame)
		helpCloseButton:SetText("Close")
		helpCloseButton:SetFont("kp_menu_font")
		helpCloseButton:SetTextColor(Color(0, 0, 0))
		helpCloseButton:SetPos(215, 430)
		helpCloseButton:SetSize(155, 40)
		function helpCloseButton:Paint(w, h)
			surface.SetDrawColor(Color(218, 216, 208))
			surface.DrawRect(0, 0, w, h)
		end
		function helpCloseButton:DoClick()
			helpFrame:Close()
		end
end

concommand.Add("howto", helpMenu)
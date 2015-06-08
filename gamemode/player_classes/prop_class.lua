-- Prop controller, thanks to the TTT Github for something to follow (ish)

PropControl = {}

function PropControl.Key(ply)
	local ent = ply.prop
	local phys = IsValid(ent) and ent:GetPhysicsObject()
	if(not IsValid(ent) or (not IsValid(phys))) then
		return false
	end

	local dir = ply:GetAimVector()
	if ply:KeyDown(IN_JUMP) then
		phys:ApplyForceCenter(Vector(0, 0, 300))
	end
	if ply:KeyDown(IN_FORWARD) then
		phys:ApplyForceCenter(dir * 500)
	end
	if ply:KeyDown(IN_BACK) then
		phys:ApplyForceCenter(dir * -500)
	end
	if ply:KeyDown(IN_MOVELEFT) then
		local temp = dir
		temp:Rotate(Angle(0, 90, 0))
		phys:ApplyForceCenter(temp * 200)
	end
	if ply:KeyDown(IN_MOVERIGHT) then
		local temp = dir
		temp:Rotate(Angle(0, -90, 0))
		phys:ApplyForceCenter(temp * 200)
	end
	if ply:KeyDown(IN_DUCK) then
		phys:SetVelocityInstantaneous(Vector(0, 0, 0))
	end
	return true
end
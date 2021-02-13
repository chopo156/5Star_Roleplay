local smoker = 0.0
local smokeg = 0.0
local smokeb = 0.0
local size = 0.3

Citizen.CreateThread(function()
	DecorRegister("smoke_trail", 2)
	DecorRegister("smoke_trail_r", 3)
	DecorRegister("smoke_trail_b", 3)
	DecorRegister("smoke_trail_g", 3)
	DecorRegister("smoke_trail_size", 1)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsUsing(ped)
		if IsPedInAnyPlane(ped) and IsControlJustPressed(0, 20) then
			DecorSetBool(veh, "smoke_trail", not DecorGetBool(veh, "smoke_trail"))
			DecorSetInt(veh, "smoke_trail_r", smoker)
			DecorSetInt(veh, "smoke_trail_g", smokeg)
			DecorSetInt(veh, "smoke_trail_b", smokeb)
			DecorSetFloat(veh, "smoke_trail_size", size)
		end
	end
end)

function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return pairs(players)
end

Citizen.CreateThread(function()
	local particleDictionary = "scr_carsteal4"
	local particleName = "scr_carsteal4_wheel_burnout"
	RequestNamedPtfxAsset(particleDictionary)
	while not HasNamedPtfxAssetLoaded(particleDictionary) do
		Citizen.Wait(0)
	end
	local p1 = nil
	while true do
		Citizen.Wait(0)
		for ply in GetPlayers() do
			local player = ply-1
			local ped = GetPlayerPed(player)
			local veh = GetVehiclePedIsUsing(ped)
			if IsPedInAnyPlane(ped) and DecorGetBool(veh, "smoke_trail") then
				local r = DecorGetInt(veh, "smoke_trail_r")
				local g = DecorGetInt(veh, "smoke_trail_g")
				local b = DecorGetInt(veh, "smoke_trail_b")
				local size = DecorGetFloat(veh, "smoke_trail_size")

				SetParticleFxNonLoopedColour(r + 0.0, g + 0.0, b + 0.0)
				UseParticleFxAssetNextCall(particleDictionary)
				p1 = StartParticleFxNonLoopedOnEntity("scr_carsteal4_wheel_burnout", veh, -0.15, -5.0, 0.3, 0, 0, 0, size + 0.0, 0, 1, 0)
			end
		end
	end
end)

RegisterCommand("smokecolour", function(source, args, raw)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyPlane(ped) then
		smoker = tonumber(args[1])
		smokeg = tonumber(args[2])
		smokeb = tonumber(args[3])
		DecorSetInt(veh, "smoke_trail_r", smoker)
		DecorSetInt(veh, "smoke_trail_g", smokeg)
		DecorSetInt(veh, "smoke_trail_b", smokeb)
	end
end)

RegisterCommand("smokesize", function(source, args, raw)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyPlane(ped) then
		size = tonumber(args[1])
		DecorSetFloat(veh, "smoke_trail_size", size)
	end
end)

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------Made by PERP Gamer AKA Tyler--------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------Config-------
DisableBikeWings = true --Change to false if you would like to deploy the wings on like the oppressor
DisableVehicleRocket = true --Change to false if you would like to turn on the vehicle rocket boost
DisableVehicleJump = true --Change to false if would like to turn on vehicle jump
DisableVehicleTransform = true --Change to false if you would like to enable vehicle transform
DisableVehicleWeapons = true --Change to false if you would like to enable vehicle weapons
----END OF CONFIG---

Citizen.CreateThread(function()
	while true do
		local playerped = GetPlayerPed(-1)		
		if IsPedInAnyVehicle(playerped, false) then	
			if DisableBikeWings then
				DisableControlAction(0, 354, true)
			end
			if DisableVehicleRocket then
				DisableControlAction(0, 351, true)
			end
			if DisableVehicleJump then
				DisableControlAction(0, 350, true)
			end
			if DisableVehicleTransform then
				DisableControlAction(0, 357, true)
			end
			
			local veh = GetVehiclePedIsUsing(playerped)
			if DoesVehicleHaveWeapons(veh) == 1 and DisableVehicleWeapons and vehicleweaponhash ~= 1422046295 then
				vehicleweapon, vehicleweaponhash = GetCurrentPedVehicleWeapon(playerped)
				if vehicleweapon == 1 then
					DisableVehicleWeapon(true, vehicleweaponhash, veh, playerped)
					SetCurrentPedWeapon(playerped, GetHashKey("weapon_unarmed"))
				end
			end	
		end
		Citizen.Wait(0)
	end
end)

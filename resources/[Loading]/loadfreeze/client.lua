local frozen = true
local unfrozen = false


AddEventHandler('playerSpawned', function()

        TriggerServerEvent('Spawn:LF')
    end)



RegisterNetEvent('vRPlf:Unfreeze')
AddEventHandler('vRPlf:Unfreeze', function()
	unfrozen = true
end)


Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				Wait(1)
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				frozen = false
			else
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1),false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
		end
		Citizen.Wait(1)
	end
end)

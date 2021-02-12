RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "LOCAL | " .. name, {0, 255, 0}, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "LOCAL | " .. name, {0, 255, 0}, message)
	end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .."  ".."^6 " .. message .. ".")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .."  ".."^6 " .. message .. ".")
	end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 2, 217}, " " .. message .." ".."^5  (( " .. name .. "))")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 2, 217}, " " .. message .."  ".."^5 ((" .. name .. "))")
	end
end)

RegisterNetEvent('sendProximityMessageOOC')
AddEventHandler('sendProximityMessageOOC', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {0, 0, 0}, "OOC | " .. name .."  ".."^7  :" .. message .. ".")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {0, 0, 0}, "OOC | " .. name .."  ".."^7  :" .. message .. ".")
	end
end)

-- RegisterNetEvent('sendMessageHelp')
-- AddEventHandler('sendMessageHelp', function(id, name, message)
	-- local monid = PlayerId()
	-- local sonid = GetPlayerFromServerId(id)
	-- if sonid == monid then
		-- TriggerEvent('chatMessage', "", {128, 128, 128}, " ^9 Help| " .. name .."  ".."  :" .. message .. ".")
	-- end
-- end)



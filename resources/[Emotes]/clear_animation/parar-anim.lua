Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
			if IsControlJustPressed(1, 47) then
			ClearPedTasks(GetPlayerPed(-1))
		end
	end
end)
Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local lock = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 303) then ---Klawisz U 
            if not lock then
                TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                StopAnimTask = true

            end
        end
    end
end)
	

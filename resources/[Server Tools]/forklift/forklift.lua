--
-- Orginal code by roto / mozy
-- https://pastebin.com/RKpcmXw7
--
-- Rewrite/port to FiveM API 
-- by TheIndra
--

isAttached = false
attachedEntity = nil

Citizen.CreateThread(function()
    while true do
        Wait(0)

        -- E to attach/detach
        if IsControlJustPressed(0, 86) then
			-- if already attached detach
			if isAttached then
				DetachEntity(attachedEntity, true, true)
				
				attachedEntity = nil
				isAttached = false
			else	
				-- get vehicle infront
				local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
				local veh = GetClosestVehicle(pos, 2.0, 0, 70)
				
				-- if vehicle is found
				if veh ~= 0 and IsPedInAnyVehicle(PlayerPedId(), false) then
					local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					
					-- check if player is in forklift
					if GetEntityModel(currentVehicle) == GetHashKey("forklift") then 
						isAttached = true
						attachedEntity = veh
						
						-- attach vehicle to forklift, you can change some values
						AttachEntityToEntity(veh, currentVehicle, 3, 0.0, 1.3, -0.09, 0.0, 0, 90.0, false, false, false, false, 2, true)
					end
				end
			end
        end        
    end
end)
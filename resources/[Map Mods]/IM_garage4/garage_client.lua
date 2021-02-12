-- PARAMETERS
local GARAGE_MARKER_SIZE = 2.5
local GARAGE_COORDS_IN = { x = -801.12, y = 308.57, z = 41.05, heading = 1.11 }
local GARAGE_COORDS_OUT = { x = -796.26, y = 323.36, z = 85.18, heading = 180.37 }

-- Create preRace thread
Citizen.CreateThread(function()
   

    -- Loop forever and update every frame
    while true do
        Citizen.Wait(0)

        -- Get player and vehicle
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsUsing(player)

        -- Only allow travel when in vehicle and drivers seat
        if (IsPedInAnyVehicle(player, false)) and (GetPedInVehicleSeat(vehicle, -1) == player) then
            -- Docks location, draw marker and when close enough prompt player to teleport
            DrawMarker(1, GARAGE_COORDS_OUT.x, GARAGE_COORDS_OUT.y, GARAGE_COORDS_OUT.z - 1.0, 0, 0, 0, 0, 0, 0, GARAGE_MARKER_SIZE, GARAGE_MARKER_SIZE, 1.0, 255, 165, 0, 96, 0, 0, 0, 0, 0, 0, 0)
            if (GetDistanceBetweenCoords(GARAGE_COORDS_OUT.x, GARAGE_COORDS_OUT.y, GARAGE_COORDS_OUT.z, GetEntityCoords(player)) < GARAGE_MARKER_SIZE) then
                helpMessage("Press ~INPUT_CONTEXT~ to enter garage")
                if (IsControlJustReleased(1, 51)) then
                    teleportToLocation(player, vehicle, GARAGE_COORDS_IN.x, GARAGE_COORDS_IN.y, GARAGE_COORDS_IN.z, GARAGE_COORDS_IN.heading)
                end
            end

            -- IN location, draw marker and when close enough prompt player to teleport
            DrawMarker(1, GARAGE_COORDS_IN.x, GARAGE_COORDS_IN.y, GARAGE_COORDS_IN.z - 1.0, 0, 0, 0, 0, 0, 0, GARAGE_MARKER_SIZE, GARAGE_MARKER_SIZE, 1.0, 255, 165, 0, 96, 0, 0, 0, 0, 0, 0, 0)
            if (GetDistanceBetweenCoords(GARAGE_COORDS_IN.x, GARAGE_COORDS_IN.y, GARAGE_COORDS_IN.z, GetEntityCoords(player)) < GARAGE_MARKER_SIZE) then
                helpMessage("Press ~INPUT_CONTEXT~ to exit garage")
                if (IsControlJustReleased(1, 51)) then
                    teleportToLocation(player, vehicle, GARAGE_COORDS_OUT.x, GARAGE_COORDS_OUT.y, GARAGE_COORDS_OUT.z, GARAGE_COORDS_OUT.heading)
                end
            end
        end
    end
end)

-- Utility function to display help message
function helpMessage(text, duration)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end


-- Utility function to teleport vehicle to location
function teleportToLocation(player, vehicle, x, y, z, heading)
    -- Freeze vehicle position, disable collisions and fade screen out
    FreezeEntityPosition(vehicle, true)
    SetEntityCollision(vehicle, false, false)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)

    -- Teleport vehicle to location, unfreeze and enable collisions/physics
    SetEntityCoordsNoOffset(vehicle, x, y, z, false, false, false)
    SetEntityHeading(vehicle, heading)
    FreezeEntityPosition(vehicle, false)
    SetEntityCollision(vehicle, true, true)
    ActivatePhysics(vehicle)
    Citizen.Wait(3000)

    -- Fade screen back in
    DoScreenFadeIn(1000)
    Citizen.Wait(1000)
end
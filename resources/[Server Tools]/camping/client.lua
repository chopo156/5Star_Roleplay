-- Camping created by Vespura (Contributor: SPJESTER)
local prevtent = 0
RegisterCommand('tent', function(source, args, rawCommand)
    if prevtent ~= 0 then
        SetEntityAsMissionEntity(prevtent)
        DeleteObject(prevtent)
        prevtent = 0
    end
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -2.0))
    local tents = {
        'prop_skid_tent_01',
        'prop_skid_tent_01b',
        'prop_skid_tent_03',
    }
    local randomint = math.random(1,3)
    local tent = GetHashKey(tents[randomint])
    local prop = CreateObject(tent, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    prevtent = prop
end, false)

RegisterCommand('rtent', function(source, args, rawCommand)
    if prevtent == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous tent spawned, or your previous tent has already been deleted.')
    else
        SetEntityAsMissionEntity(prevtent)
        DeleteObject(prevtent)
        prevtent = 0
    end
end, false)

local prevfire = 0
RegisterCommand('campfire', function(source, args, rawCommand)
    if prevfire ~= 0 then
        SetEntityAsMissionEntity(prevfire)
        DeleteObject(prevfire)
        prevfire = 0
    end
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.65))
    local prop = CreateObject(GetHashKey("prop_beach_fire"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    prevfire = prop
end, false)

RegisterCommand('rcampfire', function(source, args, rawCommand)
    if prevfire == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous campfire spawned, or your previous campfire has already been deleted.')
    else
        SetEntityAsMissionEntity(prevfire)
        DeleteObject(prevfire)
        prevfire = 0
    end
end, false)

local prevchair = 0
RegisterCommand('chair', function(source, args, rawCommand)
    if prevchair ~= 0 then
        SetEntityAsMissionEntity(prevchair)
        DeleteObject(prevchair)
        prevchair = 0
    end
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.02))
    local chair = {
        'prop_chair_02',
        'prop_chair_05',
		'prop_chair_10'
    }
    local randomint = math.random(1,3)
    local chair = GetHashKey(chair[randomint])
    local prop = CreateObject(chair, x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    prevchair = prop
end, false)

RegisterCommand('rchair', function(source, args, rawCommand)
    if prevchair == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0no previous chair spawned, or your previous chair has already been deleted.')
    else
        SetEntityAsMissionEntity(prevchair)
        DeleteObject(prevchair)
        prevchair = 0
    end
end, false)

RegisterCommand('robject', function(source, args, rawCommand)
    local prop = 0
    local deelz = 10
    local deelxy = 2
    for offsety=-2,2 do
        for offsetx=-2,2 do
            for offsetz=-8,8 do
                local CoordFrom = GetEntityCoords(PlayerPedId(), true)
                local CoordTo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
                local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z-(offsetz/deelz), CoordTo.x+(offsetx/deelxy), CoordTo.y+(offsety/deelxy), CoordTo.z-(offsetz/deelz), 16, PlayerPedId(), 0)
                local _, _, _, _, object = GetShapeTestResult(RayHandle)
                if object ~= 0 then
                    prop = object
                    break
                end
            end
        end
    end
    if prop == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0could not detect object.')
    else
        SetEntityAsMissionEntity(prop)
        DeleteObject(prop)
    end
end, false)

-- Citizen.CreateThread(function()
    -- TriggerEvent('chat:addSuggestion', '/tent', 'Spawn a tent in front of you. If you already have a tent then this will override your old tent.')
    -- TriggerEvent('chat:addSuggestion', '/rtent', 'Deletes your tent.')
    -- TriggerEvent('chat:addSuggestion', '/campfire', 'Spawn a campfire in front of you. If you already have a campfire then this will override your old campfire.')
    -- TriggerEvent('chat:addSuggestion', '/rcampfire', 'Deletes your campfire.')
    -- TriggerEvent('chat:addSuggestion', '/chair', 'Spawn a chair in front of you. If you already have a chair then this will override your old chair.')
    -- TriggerEvent('chat:addSuggestion', '/rchair', 'Deletes your chair.')
    -- TriggerEvent('chat:addSuggestion', '/robject', 'Deletes any object/prop in front of you.')
-- end)

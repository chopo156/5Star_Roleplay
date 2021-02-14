local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local cfg = module("vrp2_doors", "config")

local Idoors = class("Idoors",vRP.Extension)

local doors = cfg.doors
--local owned = {}

Idoors.event = {}

function Idoors.event:playerSpawn(user, first_spawn)
  if first_spawn then
    TriggerClientEvent('vrp2_doors:load', user.source, doors)
  end
end


Citizen.CreateThread(function()
  Citizen.Wait(500)
  TriggerClientEvent('vrp2_doors:load', -1, doors)
end)


RegisterServerEvent('vrp2_doors:status')
AddEventHandler('vrp2_doors:status', function(id, status)
    local user = vRP.users_by_source[source]
	if user:hasPermission("!item."..doors[id].key..".>0") or user:hasPermission(doors[id].permission) then
	--if user:hasPermission("!item."..doors[id].key..".>0") or user:hasPermission(doors[id].permission) or (doors[id].name ~= nil and doors[id].number ~= nil and owned[doors[id].name] ~= nil and owned[doors[id].name][doors[id].number] ~= nil and owned[doors[id].name][doors[id].number] == user) then
        if doors[id].pairs ~= nil then
            doors[doors[id].pairs].locked=status
            TriggerClientEvent('vrp2_doors:statusSend', -1, doors[id].pairs, status)
        end
        doors[id].locked=status
        TriggerClientEvent('vrp2_doors:statusSend', -1, id, status)
    end
end)

--[[
RegisterServerEvent('vrp2_doors:owneddoor')
AddEventHandler('vrp2_doors:owneddoor', function(user,home,number)
    owned[home][tonumber(number)] = user
end)		
]]--

vRP:registerExtension(Idoors)
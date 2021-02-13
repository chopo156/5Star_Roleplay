
local cfg = module("vrp_showroom", "cfg/showroom")
local vRPShowroom = class("vRPShowroom", vRP.Extension)
local vehgarage = cfg

function vRPShowroom:__construct()
    vRP.Extension.__construct(self)
end

local function getPrice( category, model )
    for i,v in ipairs(vehshop.menu[category].buttons) do
      if v.model == model then
          return v.costs
      end
    end
    return nil 
end

RegisterServerEvent('veh_SR:CheckMoneyForVeh')
AddEventHandler('veh_SR:CheckMoneyForVeh', function(category, vehicle, price, veh_type, isXZ, isDM)
	local user = vRP.users_by_source[source]
	local player = source
	local user_id = user.id
	
    local vehicles = user:getVehicles()

        local actual_price = getPrice( category, vehicle)
        if actual_price == nil then
            print("[ error ] Vehicle "..vehicle.." from the category "..category.." doesn't have aprice set in cfg/showroom.lua")
            vRP.EXT.Base.remote._notify(source, "~r~This car is out of stock")
            return
        end
        if vehicles[vehicle] then
            vRP.EXT.Base.remote._notify(source, "~r~Vehicle already owned.")
        else
        if  actual_price ~= price then
            print( "Player with ID "..user_id.. " is suspected of Cheat Engine.")
        end
        if user:tryFullPayment(actual_price, false) then
		    vehicles[vehicle] = 1
		    TriggerClientEvent('veh_SR:CloseMenu', player)
            vRP.EXT.Base.remote._notify(source, "You paid ~r~$"..actual_price)
			vRP.EXT.Base.remote._notify(source, "To pickup your vehicle please visit any garage.")
			user:actualizeMenu()
        else
            vRP.EXT.Base.remote._notify(source, "~r~Not enough money.")
        end
    end
end)

vRP:registerExtension(vRPShowroom)	

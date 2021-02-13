local inventoryHud = class("inventoryHud", vRP.Extension)

local ActionDelay = module("vrp", "lib/ActionDelay")
local edible_action = ActionDelay()

RegisterServerEvent("inventoryHud:giveItem")
AddEventHandler("inventoryHud:giveItem", function(nplayer, name, count)
    local user = vRP.users_by_source[source]
	local citem = vRP.EXT.Inventory:computeItem(name)
	
    if nplayer then
        nuser = vRP.users_by_source[nplayer]
    end
	
	if count > 0 then
    if nuser:tryGiveItem(name, count, true) then
        if user:tryTakeItem(name, count, true) then
            user:tryTakeItem(name, count)
            nuser:tryGiveItem(name, count)
            vRP.EXT.Base.remote._playAnim(user.source, true, {{"mp_common", "givetake1_a"}}, false)
            vRP.EXT.Base.remote._playAnim(nuser.source, true, {{"mp_common", "givetake1_a"}}, false)

        else
            vRP.EXT.Base.remote._notify(user.source, "~r~You dont have that much to give.")
			TriggerClientEvent("inventoryHud:closeMenu", user.source)
        end
    else
        vRP.EXT.Base.remote._notify(user.source, "~y~They have no inventory space.")
		vRP.EXT.Base.remote._notify(nuser.source, "~y~You have no inventory space to recieve a item.")
		TriggerClientEvent("inventoryHud:closeMenu", user.source)
    end
    else
        vRP.EXT.Base.remote._notify(user.source, "~r~Not a valid amount.")
		TriggerClientEvent("inventoryHud:closeMenu", user.source)
    end	
end)

RegisterServerEvent("inventoryHud:getNearPlayer")
AddEventHandler("inventoryHud:getNearPlayer", function(data)
    local user = vRP.users_by_source[source]
    local elements = {}
    local data = data.item
    local players = vRP.EXT.Base.remote.getNearestPlayers(user.source, 5)

	if players then
        for k, v in pairs(players) do
		local nuser = vRP.users_by_source[k]
            found = true
            table.insert(elements, {
                label = nuser.name,
                psource = nuser.source,
                pid = nuser.id
            })
			end
    else
        found = false
        vRP.EXT.Base.remote._notify(user.source, "~y~No Player Near.")
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
    end
TriggerClientEvent("inventoryHud:returnNear", user.source, found, elements, data)				
end)


RegisterServerEvent("inventoryHud:loadPlayerInventory")
AddEventHandler("inventoryHud:loadPlayerInventory", function()
	local user = vRP.users_by_source[source]
	
	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		loadout = {},
		playerName = "Player Name",
		coords = nil
    }
	
		local data = user:getInventory()
	
		if data then
        for fullid, amount in pairs(user:getInventory()) do
				local citem = vRP.EXT.Inventory:computeItem(fullid)
					if citem then
					
					local usable = false
					if citem.usable == "yes" then
					usable = true
					else
					usable = false
					end
					
                        table.insert(userData.inventory, {
						label = citem.name, 
						count = amount, 
						name = fullid, 
						icon = citem.icon,
						--weight = string.format("%.2f",citem.weight),	--Coming soon, aswell as cash, and bank
						usable = usable,
						rare = false, 
						canRemove = true}) 
	
                    end
					table.sort(userData.inventory, function(a,b) return a.label < b.label end)
        end
	
		local weight = user:getInventoryWeight()
		local max_weight = user:getInventoryMaxWeight()
		
        TriggerClientEvent("inventoryHud:loadPlayerInventory", user.source, userData)
    end
end)


RegisterServerEvent("inventoryHud:useItem")
AddEventHandler("inventoryHud:useItem", function(fullid, count)
    local user = vRP.users_by_source[source]
    local citem = vRP.EXT.Inventory:computeItem(fullid)

    if citem.itype == "edible" then
        vRP.EXT.Edible:eatEdible(user.source, fullid)
		
		
    elseif citem.itype == "weapon" then
        local weapons = vRP.EXT.PlayerState.remote.getWeapons(user.source)
        if not weapons[citem.args[2]] then
            if user:tryTakeItem(fullid, 1) then
                local weapons = {}
                weapons[citem.args[2]] = {ammo = 0}
                vRP.EXT.PlayerState.remote._giveWeapons(user.source, weapons)
            end
        else
            vRP.EXT.Base.remote._notify(user.source, "~y~This weapon is already equipped.")
            TriggerClientEvent("inventoryHud:closeMenu", user.source)
        end
		
    elseif citem.itype == "ammo" then
        local ammoid = citem.args[1] .. "|" .. citem.args[2]
        local weapons = vRP.EXT.PlayerState.remote.getWeapons(user.source)
        local amount = tonumber(citem.args[3]) or parseInt(count)

        if weapons[citem.args[2]] then
            if user:tryTakeItem(fullid, amount) then
                local weapons = {}

                weapons[citem.args[2]] = { ammo = amount}
                vRP.EXT.PlayerState.remote._giveWeapons(user.source, weapons)
            else
                vRP.EXT.Base.remote._notify(user.source, "~r~Not a valid amount")
            end
        else
            vRP.EXT.Base.remote._notify(user.source, "~y~Cannot find the weapon for this type of ammo.")
            TriggerClientEvent("inventoryHud:closeMenu", user.source)
        end
		
    elseif citem.itype == "special" then
        vRP.EXT.Functions:specialFunction(user.source, fullid, count)
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
		
    elseif citem.itype == "tint" then
        vRP.EXT.PlayerState:setTint(user.source, fullid)
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
		
    elseif citem.itype == "comp" then
        vRP.EXT.PlayerState:setComp(user.source, fullid)
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
		
    end
end)


RegisterServerEvent("inventoryHud:dropItem")
AddEventHandler("inventoryHud:dropItem",function(idname, amount)
	local user = vRP.users_by_source[source]	
    local amount = parseInt(amount)
	local dead = vRP.EXT.Survival.remote.isInComa(user.source)
	local citem = vRP.EXT.Inventory:computeItem(idname)
	if not dead then
    if user:tryTakeItem(idname, amount,nil,true) then
		
      vRP.EXT.Base.remote._notify(user.source,"Trashed ~r~"..citem.name.." ~w~"..amount)
      vRP.EXT.Base.remote._playAnim(user.source,true,{{"pickup_object","pickup_low",1}},false)
    else
      vRP.EXT.Base.remote._notify(user.source, "~r~Not a valid amount")
	  TriggerClientEvent("inventoryHud:closeMenu", user.source)
    end
	else
	  vRP.EXT.Base.remote._notify(user.source, "You cannot Trash while in Coma, Call EMS!")	
	  TriggerClientEvent("inventoryHud:closeMenu", user.source)
  end
end)

function play_eat(ruser)
	local user = vRP.users_by_source[ruser] 
    local seq = {
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
    }
		
	vRP.EXT.Base.remote._playAnim(user.source, true,seq,false)
end


function play_drink(ruser)
	local user = vRP.users_by_source[ruser] 
    local seq = {
        {"mp_player_intdrink","intro_bottle",1},
        {"mp_player_intdrink","loop_bottle",1},
        {"mp_player_intdrink","outro_bottle",1}
    }
	vRP.EXT.Base.remote._playAnim(user.source, true,seq,false)
end


inventoryHud.tunnel = {}
inventoryHud.tunnel.getInventory = inventoryHud.getInventory
inventoryHud.tunnel.getMoney = inventoryHud.getMoney

vRP:registerExtension(inventoryHud)
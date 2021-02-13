local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPin = {}
Tunnel.bindInterface("vrp_hud_inventory",vRPin)
Proxy.addInterface("vrp_hud_inventory",vRPin)
INclient = Tunnel.getInterface("vrp_hud_inventory","vrp_hud_inventory")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hud_inventory")
vRPca = Proxy.getInterface("vRP_cards")

local openInventories = {}

function vRPin.requestItemsTable()
	local _source = source
	INclient.setClientItems(_source, {vRPin.getInventoryItems(_source)})
end

function vRPin.removeItem(tipo, nome, numero)
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRP.trash({user_id,nome,numero})
	INclient.loadPlayerInventory(_source)
end

function vRPin.requestTrunkItems(user_id, chestname)
	local _source = source
	vRPin.getTrunkItems(_source, user_id, chestname, function(tabella)
		INclient.setSecondInventoryItems(_source, {tabella})
	end)
end

function vRPin.requestItemGive(nome, numero)
	local _source = source
	vRP.giveItemHud({_source, nome, numero})
	INclient.loadPlayerInventory(_source)
end

function vRPin.requestItemUse(nome)
	local _source = source
	local choice = vRP.getItemChoiceHud({nome})
	for key,value in pairs(choice) do 
		local cb = value[1]
		cb(_source,k,1)
		INclient.loadPlayerInventory(_source)
	end
end

function vRPin.openChest(player, name, chestname, max_weight, cb, items_in, items_out)
	Citizen.CreateThread(function()
		local user_id = vRP.getUserId({player})
		INclient.loadPlayerInventory(player)
		INclient.setTrunkInventoryData(player, {user_id, name, chestname, max_weight})
		INclient.openChestInventory(player)
		openInventories[user_id] = { items_in, items_out }
		while openInventories[user_id] do
			Citizen.Wait(1)
		end
		if cb then cb() end
	end)
end

function vRPin.closeInventory()
	openInventories[vRP.getUserId({source})] = nil
end

function vRPin.requestTrunkUpdate(chestname)
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRPin.getTrunkItems(_source, user_id, chestname, function(tabella)
		INclient.setSecondInventoryItems(_source, {tabella})
	end)
end

function vRPin.fromInvToTrunk(tipoitem, nomeitem, count, idlabel, source, user_id, max_weight, chestname, cb)
	local oggetti = {}
	vRP.getSData({"chest:"..chestname, function(cdata)
		if string.find(chestname, nomeitem) then
			vRPclient.notify(source, {Config.Lang.CannotMove})
			cb(true)
		else
			oggetti = json.decode(cdata) or {}
			local new_weight = vRP.computeItemsWeight({oggetti})+vRP.getItemWeight({nomeitem})*count
			if new_weight <= max_weight then
				if count >= 0 and vRP.tryGetInventoryItem({user_id, nomeitem, count, false}) then
					local citem = oggetti[nomeitem]
					if citem ~= nil then
						citem.amount = citem.amount+count
					else
						oggetti[nomeitem] = {amount=count}
					end
					vRP.setSData({"chest:"..chestname, json.encode(oggetti)})
					if openInventories[user_id][1] then coroutine.resume(coroutine.create(openInventories[user_id][1](nomeitem, count))) end
					cb(true)
				end
			else
				vRPclient.notify(source,{Config.Lang.Full})
				cb(true)
			end
		end
	end})
end

function vRPin.requestVehicleFITT(data)
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRPin.fromInvToTrunk(data.item.type, data.item.name, tonumber(data.number), data.item.label, _source, user_id, data.max_weight, data.chestname, function(ok) 
		if ok then
			INclient.syncVehTrunk(_source, {data.chestname})
		end
	end)
end

function vRPin.fromTrunkToInv(tipoitem, nomeitem, count, idlabel, source, user_id, max_weight, chestname, cb)
	local inventario = vRP.getInventoryMaxWeight({user_id})
	local oggetti = {}
	vRP.getSData({"chest:"..chestname, function(cdata)
		oggetti = json.decode(cdata) or {}
		local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({nomeitem})*count
		if new_weight <= inventario then
				local citem = oggetti[nomeitem]
				if citem ~= nil then
					if count >= 0 and count <= citem.amount then
					  citem.amount = citem.amount-count
						if citem.amount <= 0 then
						  oggetti[nomeitem] = nil 
						end
					vRP.giveInventoryItem({user_id, nomeitem, count, false}) 
				end
				vRP.setSData({"chest:"..chestname, json.encode(oggetti)})
				if openInventories[user_id][2] then coroutine.resume(coroutine.create(openInventories[user_id][2](nomeitem, count))) end
				cb(true)
			end
		else
			vRPclient.notify(source,{Config.Lang.Full})
			cb(false)
		end
	end})	
end

function vRPin.requestVehicleFTTI(data)
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRPin.fromTrunkToInv(data.item.type, data.item.name, tonumber(data.number), data.item.label, _source, user_id, data.max_weight, data.chestname, function(ok) 
		if ok then
			INclient.syncVehTrunk(_source, {data.chestname})
		end
	end)
end

function vRPin.getTrunkItems(source, user_id, chestname, cbr)
	local cfg_inventory = vRP.getCfgInventoryHud({})
	items = {}
	vRP.getSData({"chest:"..chestname, function(cdata)
		local oggetti = json.decode(cdata) or {}
		for k,v in pairs(items) do
			items[k] = nil
		  end
		for k,v in pairs(oggetti) do
			local naim,description,weight = vRP.getItemDefinition({k})
			local choice = vRP.getItemChoiceHud({k})
			local ch_text = ""
			for key,value in pairs(choice) do ch_text = key end		
			if naim ~= nil then
				table.insert(items, {
					label = ('%s x%s'):format(naim, v.amount),
					count = v.amount,
					type = 'item_standard',
					name = k,
					usable = true,
					rare = false,
					canRemove = true,
					usetxt = ch_text
				})
			end
		end
		cbr(items)
	end})
end

function vRPin.getInventoryItems(source)
	local user_id = vRP.getUserId({source})
	local data = vRP.getUserDataTable({user_id})
	items = {}
	for k,v in pairs(data.inventory) do 
        local naim,description,weight = vRP.getItemDefinition({k})
		local choice = vRP.getItemChoiceHud({k})
		local ch_text = ""
		for key,value in pairs(choice) do ch_text = key end		
        if naim ~= nil then
			table.insert(items, {
				label = ('%s x%s'):format(naim, v.amount),
				count = v.amount,
				type = 'item_standard',
				name = k,
				usable = true,
				rare = false,
				canRemove = true,
				usetxt = ch_text
			})
        end
    end
	return items
end

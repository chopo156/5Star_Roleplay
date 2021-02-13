vRPin = {}
Tunnel.bindInterface("vrp_hud_inventory",vRPin)
vRPserver = Tunnel.getInterface("vRP","vrp_hud_inventory")
INserver = Tunnel.getInterface("vrp_hud_inventory","vrp_hud_inventory")
vRP = Proxy.getInterface("vRP")

local trunkData = nil
local isInInventory = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
            end
        end
    end
)

function openInventory()
    vRPin.loadPlayerInventory()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end

function vRPin.openChestInventory()
    isInInventory = true
    SendNUIMessage({
        action = "display",
        type = "trunk"
    })
    SetNuiFocus(true, true)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
    INserver.closeInventory()
end

RegisterNUICallback("NUIFocusOff", function()
    closeInventory()
end)

RegisterNUICallback("PutIntoTrunk", function(data, cb)		
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        INserver.requestVehicleFITT({data})
        cb("ok")
    end
end)

RegisterNUICallback("TakeFromTrunk", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        INserver.requestVehicleFTTI({data})
        cb("ok")
    end
end)

function vRPin.syncVehTrunk(chestname)
    INserver.requestTrunkUpdate({chestname})
    vRPin.loadPlayerInventory()
end

RegisterNUICallback("UseItem", function(data, cb)
    INserver.requestItemUse({data.item.name})
    cb("ok")
end)

RegisterNUICallback("DropItem", function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then return end
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        INserver.removeItem({data.item.type, data.item.name, data.number})
    end
    cb("ok")
end)

RegisterNUICallback("GiveItem", function(data, cb)
    INserver.requestItemGive({data.item.name, tonumber(data.number)})
    cb("ok")
end)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function vRPin.loadPlayerInventory()
    INserver.requestItemsTable({})
end

function vRPin.setClientItems(tabella)
    SendNUIMessage({
            action = "setItems",
            itemList = tabella
    })
end

function vRPin.setTrunkInventoryData(user_id, name, chestname, max_weight)
    SendNUIMessage({
        action = "setInfoText",
        text = name,
        chestname = chestname,
        max_weight = max_weight
    })
    INserver.requestTrunkItems({user_id, chestname})
end

function vRPin.setSecondInventoryItems(tabella)
    SendNUIMessage({
        action = "setSecondInventoryItems",
        itemList = tabella
    })
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Config.Keys["W"], true) -- W
                DisableControlAction(0, Config.Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Config.Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Config.Keys table!)

                DisableControlAction(0, Config.Keys["R"], true) -- Reload
                DisableControlAction(0, Config.Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Config.Keys["Q"], true) -- Cover
                DisableControlAction(0, Config.Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Config.Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Config.Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Config.Keys["F2"], true) -- Inventory
                DisableControlAction(0, Config.Keys["F3"], true) -- Animations
                DisableControlAction(0, Config.Keys["F6"], true) -- Job

                DisableControlAction(0, Config.Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Config.Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Config.Keys["X"], true) -- Disable clearing animation

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Config.Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end
)

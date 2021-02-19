local keys = {
	["E"] = 38,
}

--###############################################
--#########  Atm Ui Toggles ##############
RegisterNetEvent('Banking:openAtm')						--open on entering the marker
AddEventHandler('Banking:openAtm', function()
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openAtm'})
	TriggerServerEvent('Banking:balance')
end)

--###############################################
--#########  Bank Ui Toggles ##############
RegisterNetEvent('Banking:openBank')					--open on entering the marker
AddEventHandler('Banking:openBank', function()
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openBank'})
	TriggerServerEvent('Banking:balance')
end)

--###############################################
--#########  Close Ui ##############
RegisterNetEvent('Banking:closeUI')
AddEventHandler('Banking:closeUI', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
	SendNUIMessage({type = 'stopHoliday'})
end)
--###############################################
--#########  Adds Commas to user money ##############
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end
--###############################################
--#########  User Balance ##############
RegisterNetEvent('Banking:Bal')
AddEventHandler('Banking:Bal', function(info)
	local formatted
	formatted = comma_value(info.balance)
	
	local bal = {}
	table.insert(bal, formatted)
	
	local player = {}
	table.insert(player, info.name)
	
	SendNUIMessage({ 								--player Balance
		type = "balance", 
		text = table.concat(bal) 
	}) 	
	SendNUIMessage({ 								--player name
		type = "name", 
		text = table.concat(player) 
	}) 

end)
--###############################################
--============= Deposit Event  ==================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('Banking:deposit', tonumber(data.amountd))
	TriggerServerEvent('Banking:balance')
end)
--###############################################
--============= Withdraw Even ====================
RegisterNUICallback('withdraw', function(data)
	TriggerServerEvent('Banking:withdraw', tonumber(data.amountw))
	TriggerServerEvent('Banking:balance')
end)
--###############################################
--============= Balance Event =====================
RegisterNUICallback('balance', function()
	TriggerServerEvent('Banking:balance')
end)
--###############################################
--============= Transfer Event =====================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('Banking:transfer', data.to, data.amountt)
	TriggerServerEvent('Banking:balance')
end)
--###############################################
--============= Close Event =====================
RegisterNUICallback("NUIFocusOff", function() --close function for when mouse is active
    SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	SendNUIMessage({type = 'stopHoliday'})
	
	Citizen.Wait(500)
	uiActive = false
end)
--###############################################
--============= Holiday Event =====================
RegisterNetEvent('Banking:startHoliday')
AddEventHandler('Banking:startHoliday', function()
	SendNUIMessage({type = 'snow'})
end)
--###############################################
RegisterNetEvent('Banking:stopHoliday')
AddEventHandler('Banking:stopHoliday', function()
	SendNUIMessage({type = 'stopHoliday'})
end)
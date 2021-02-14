local DoorInfo	= {}

RegisterServerEvent('vrp_doorlock:updateState')
AddEventHandler('vrp_doorlock:updateState', function(doorID, state)

	if type(doorID) ~= 'number' then
		print(('vrp_doorlock: %s didn\'t send a number!'))
		return
	end

	DoorInfo[doorID] = {}

	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('vrp_doorlock:setState', -1, doorID, state)
end)

RegisterServerEvent('vrp_doorlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)
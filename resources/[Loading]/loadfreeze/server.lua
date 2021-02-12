

RegisterServerEvent('Spawn:LF')
AddEventHandler('Spawn:LF', function()
	local player = source
	SetTimeout(25250,function() 
		TriggerClientEvent('vRPlf:Unfreeze',player,false)
end)
end)

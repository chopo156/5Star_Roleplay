-- 2018 Henric 'Kekke' Johansson

RegisterServerEvent('esx_kekke_tackle:tryTackle')
AddEventHandler('esx_kekke_tackle:tryTackle', function(target)
	TriggerClientEvent('esx_kekke_tackle:getTackled', target, source)
	TriggerClientEvent('esx_kekke_tackle:playTackle', source)
end)
--[[
This script was originally created by Jack D. for San Andreas Legacy Roleplay.
http://salrp.x10.mx/

Publicly released by Jack D.

-]]

-- DO NOT EDIT THESE!!!!!!
prisonAlarm = false
fortzancudoAlarm = false
paletobaybankAlarm = false
humainelabsAlarm = false
uniondepositoryAlarm = false
chickfacAlarm = false

--------------------------------------------------------------------------------------------------------------------



-- Toggle Prison Alarm
RegisterCommand('prisonalarm', function(source, args)
		if prisonAlarm == false then
	prisonAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Prison Alarm Activated!' } })
    TriggerEvent("prisonalarm:startalarmSV", -1)
		else prisonAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Prison Alarm Deactivated!' } })
	TriggerEvent("prisonalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("prisonalarm:startalarmSV")
AddEventHandler('prisonalarm:startalarmSV', function()
TriggerClientEvent("prisonalarm:startalarmCL", -1)
end)
RegisterServerEvent("prisonalarm:stopalarmSV")
AddEventHandler('prisonalarm:stopalarmSV', function()
TriggerClientEvent("prisonalarm:stopalarmCL", -1)
end)
--------------------------------------------------------------------------------------------------------------------

-- Toggle FZ Alarm
RegisterCommand('fzalarm', function(source, args)
		if fortzancudoAlarm == false then
	fortzancudoAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Fort Zancudo Alarm Activated!' } })
    TriggerEvent("fortzalarm:startalarmSV", -1)
		else fortzancudoAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Fort Zancudo Alarm Deactivated!' } })
	TriggerEvent("fortzalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("fortzalarm:startalarmSV")
AddEventHandler('fortzalarm:startalarmSV', function()
TriggerClientEvent("fortzalarm:startalarmCL", -1)
end)

RegisterServerEvent("fortzalarm:stopalarmSV")
AddEventHandler('fortzalarm:stopalarmSV', function()
TriggerClientEvent("fortzalarm:stopalarmCL", -1)
end)
--------------------------------------------------------------------------------------------------------------------

-- Toggle Paleto Bank Alarm
RegisterCommand('pbbalarm', function(source, args)
		if paletobaybankAlarm == false then
	paletobaybankAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Paleto Bay Bank Alarm Activated!' } })
    TriggerEvent("pbalarm:startalarmSV", -1)
		else paletobaybankAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Paleto Bay Bank Alarm Deactivated!' } })
	TriggerEvent("pbalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("pbalarm:startalarmSV")
AddEventHandler('pbalarm:startalarmSV', function()
TriggerClientEvent("pbalarm:startalarmCL", -1)
end)

RegisterServerEvent("pbalarm:stopalarmSV")
AddEventHandler('pbalarm:stopalarmSV', function()
TriggerClientEvent("pbalarm:stopalarmCL", -1)
end)

--------------------------------------------------------------------------------------------------------------------

-- Toggle Humaine Labs Alarm
RegisterCommand('hlalarm', function(source, args)
		if humainelabsAlarm == false then
	humainelabsAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Humane Labs  Alarm Activated!' } })
    TriggerEvent("hlalarm:startalarmSV", -1)
		else humainelabsAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Humane Labs Alarm Deactivated!' } })
	TriggerEvent("hlalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("hlalarm:startalarmSV")
AddEventHandler('hlalarm:startalarmSV', function()
TriggerClientEvent("hlalarm:startalarmCL", -1)
end)

RegisterServerEvent("hlalarm:stopalarmSV")
AddEventHandler('hlalarm:stopalarmSV', function()
TriggerClientEvent("hlalarm:stopalarmCL", -1)
end)

--------------------------------------------------------------------------------------------------------------------

-- Toggle Union Depository Alarm
RegisterCommand('udalarm', function(source, args)
		if uniondepositoryAlarm == false then
	uniondepositoryAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Union Depository Alarm Activated!' } })
    TriggerEvent("udalarm:startalarmSV", -1)
		else uniondepositoryAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Union Depository Alarm Deactivated!' } })
	TriggerEvent("udalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("udalarm:startalarmSV")
AddEventHandler('udalarm:startalarmSV', function()
TriggerClientEvent("udalarm:startalarmCL", -1)
end)

RegisterServerEvent("udalarm:stopalarmSV")
AddEventHandler('udalarm:stopalarmSV', function()
TriggerClientEvent("udalarm:stopalarmCL", -1)
end)

--------------------------------------------------------------------------------------------------------------------

-- Toggle Chicken Factory Alarm
RegisterCommand('cfalarm', function(source, args)
		if chickfacAlarm == false then
	chickfacAlarm = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Chicken Factory Alarm Activated!' } })
    TriggerEvent("chfalarm:startalarmSV", -1)
		else chickfacAlarm = false
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Chicken Factory Alarm Deactivated!' } })
	TriggerEvent("chfalarm:stopalarmSV",-1)
		end
end, false)

RegisterServerEvent("chfalarm:startalarmSV")
AddEventHandler('chfalarm:startalarmSV', function()
TriggerClientEvent("chfalarm:startalarmCL", -1)
end)

RegisterServerEvent("chfalarm:stopalarmSV")
AddEventHandler('chfalarm:stopalarmSV', function()
TriggerClientEvent("chfalarm:stopalarmCL", -1)
end)


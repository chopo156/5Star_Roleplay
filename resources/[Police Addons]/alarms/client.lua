--[[
This script was originally created by Jack D. for San Andreas Legacy Roleplay.
http://salrp.x10.mx/

Publicly released by Jack D.

-]]

-- PRISON ALARM
RegisterNetEvent("prisonalarm:startalarmCL")
AddEventHandler('prisonalarm:startalarmCL', function()
while not PrepareAlarm("PRISON_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("PRISON_ALARMS", 1)
end)

RegisterNetEvent("prisonalarm:stopalarmCL")
AddEventHandler('prisonalarm:stopalarmCL', function()
StopAlarm("PRISON_ALARMS", -1)
end)


-------------------------------------------------------------------


-- Fort Zancudo ALARM
RegisterNetEvent("fortzalarm:startalarmCL")
AddEventHandler('fortzalarm:startalarmCL', function()
while not PrepareAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", 1)
end)

RegisterNetEvent("fortzalarm:stopalarmCL")
AddEventHandler('fortzalarm:stopalarmCL', function()
StopAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", -1)
end)


-------------------------------------------------------------------


-- Paleto Bay Fleeca ALARM
RegisterNetEvent("pbalarm:startalarmCL")
AddEventHandler('pbalarm:startalarmCL', function()
while not PrepareAlarm("PALETO_BAY_SCORE_ALARM") do
		Citizen.Wait(0)
	end
	StartAlarm("PALETO_BAY_SCORE_ALARM", 1)
end)

RegisterNetEvent("pbalarm:stopalarmCL")
AddEventHandler('pbalarm:stopalarmCL', function()
StopAlarm("PALETO_BAY_SCORE_ALARM", -1)
end)

-------------------------------------------------------------------


-- Humaine Labs ALARM
RegisterNetEvent("hlalarm:startalarmCL")
AddEventHandler('hlalarm:startalarmCL', function()
while not PrepareAlarm("FIB_05_BIOTECH_LAB_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("FIB_05_BIOTECH_LAB_ALARMS", 1)
end)

RegisterNetEvent("hlalarm:stopalarmCL")
AddEventHandler('hlalarm:stopalarmCL', function()
StopAlarm("FIB_05_BIOTECH_LAB_ALARMS", -1)
end)

-------------------------------------------------------------------


-- Union Depository ALARM
RegisterNetEvent("udalarm:startalarmCL")
AddEventHandler('udalarm:startalarmCL', function()
while not PrepareAlarm("BIG_SCORE_HEIST_VAULT_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", 1)
end)

RegisterNetEvent("udalarm:stopalarmCL")
AddEventHandler('udalarm:stopalarmCL', function()
StopAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", -1)
end)

-------------------------------------------------------------------


-- Chicken Factory ALARM
RegisterNetEvent("chfalarm:startalarmCL")
AddEventHandler('chfalarm:startalarmCL', function()
while not PrepareAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM") do
		Citizen.Wait(0)
	end
	StartAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM", 1)
end)

RegisterNetEvent("chfalarm:stopalarmCL")
AddEventHandler('chfalarm:stopalarmCL', function()
StopAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM", -1)
end)

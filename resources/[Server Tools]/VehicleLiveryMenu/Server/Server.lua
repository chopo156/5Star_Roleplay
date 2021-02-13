--[[ --Update Check

local LatestVersion = ''; CurrentVersion = '2.0.2'
local GithubResourceName = 'VehicleLiveryMenu'

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
		LatestVersion = NewestVersion
		print('\n')
		print('##############')
		print('## ' .. GetCurrentResourceName())
		print('##')
		print('## Current Version: ' .. CurrentVersion)
		print('## Newest Version: ' .. NewestVersion)
		print('##')
		if CurrentVersion ~= NewestVersion then
			print('## Outdated')
			print('## Check the Topic (type DownloadVLM and press enter)')
			print('## For the newest Version!')
			print('##############')
			print('CHANGES:\n' .. Changes)
		else
			print('## Up to date!')
			print('##############')
		end
		print('\n')
	end)
end)

AddEventHandler('rconCommand', function(Name, Arguments)
	if Name == 'DownloadVLM' and CurrentVersion ~= LatestVersion then
		if os.getenv('HOME') then
			os.execute('open https://forum.fivem.net/t/release-vehicle-livery-menu/40524')
		else
			os.execute('start https://forum.fivem.net/t/release-vehicle-livery-menu/40524')
		end
	end
end) ]]

--Admin Check

RegisterServerEvent('VLM:CheckAdminStatus') --Just Don't Edit!
AddEventHandler('VLM:CheckAdminStatus', function()
	local IDs = GetPlayerIdentifiers(source)
	local Admins = LoadResourceFile(GetCurrentResourceName(), 'Admins.txt')
	local AdminsSplitted = stringsplit(Admins, '\n')
	for k, AdminID in pairs(AdminsSplitted) do
		local AdminID = AdminID:gsub(' ', '')
		local SingleAdminsSplitted = stringsplit(AdminID, ',')
		for _, ID in pairs(IDs) do
			if ID:lower() == SingleAdminsSplitted[1]:lower() or ID:lower() == SingleAdminsSplitted[2]:lower() or ID:lower() == SingleAdminsSplitted[3]:lower() then
				TriggerClientEvent('VLM:AdminStatusChecked', source, true); return
			end
		end
	end
end)

AddEventHandler('es:playerLoaded', function(Source, user) --Checks if Player is a ESMode Admin
	if user.getGroup() == 'admin' or user.getGroup() == 'superadmin' then
		TriggerClientEvent('VLM:AdminStatusChecked', Source, true)
	end
end)

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end


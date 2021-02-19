local vrpchat = class("vrpchat", vRP.Extension)

function vrpchat:__construct()
    vRP.Extension.__construct(self)
end

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)



    if not WasEventCanceled() then
    local user = vRP.users_by_source[source]



		if user:hasPermission("owner.title") then
			TriggerClientEvent('chatMessage', -1, "Owner | " .. author,  { 255, 100, 20 }, message)
--- IF YOU WANT TO MAKE MORE TITLES, COPY BETWEEN THESE LINES AND THEN PASTE UNDER THE LINE, AND YOU NEED TO MAKE
--- YOUR OWN PERMISSION IF YOU MAKE ANOTHER ONE SINCE THESE ARE JUST EXAMPLES
		elseif user:hasPermission("admin.title") then
			TriggerClientEvent('chatMessage', -1, "Admin | " .. author,  { 10, 255, 0 }, message)
---
		elseif user:hasPermission("mod.title") then
			TriggerClientEvent('chatMessage', -1, "Moderator | " .. author,  { 255, 0, 255 }, message)
		elseif user:hasGroup("LSPD") then
			TriggerClientEvent('chatMessage', -1, "Police Officer | " .. author,{ 20, 20, 250 }, message)
		elseif user:hasGroup("lspd cheif") then
			TriggerClientEvent('chatMessage', -1, "LSPD Chief | " .. author,{ 20, 20, 250 }, message)	
		elseif user:hasGroup("emergency") then
			TriggerClientEvent('chatMessage', -1, "EMS | " .. author,{ 50, 0, 200 }, message)
		else
			TriggerClientEvent('chatMessage', -1, "OOC | " .. author,  { 128, 128, 128 }, message)
		end
    end

    print(author .. ': ' .. message)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    local user = vRP.users_by_source[source]

    TriggerEvent('chatMessage', source, name, '/' .. command)

	if not WasEventCanceled() then


    if user:hasPermission("owner.title") then
			TriggerClientEvent('chatMessage', -1, "Owner | " .. author,  { 255, 0, 0 }, message)
		elseif user:hasPermission("admin.title") then
			TriggerClientEvent('chatMessage', -1, "Admin | " .. author,  { 10, 255, 0 }, message)
		elseif user:hasPermission("mod.title") then
			TriggerClientEvent('chatMessage', -1, "Moderator | " .. author,  { 255, 0, 255 }, message)
		elseif user:hasGroup("cop") then
			TriggerClientEvent('chatMessage', -1, "^4COP ^7| " .. author .. ": ^4" ..  message)
		elseif user:hasGroup("ems") then
			TriggerClientEvent('chatMessage', -1, "^9EMS ^7| " .. author .. ": ^9" ..  message)
		elseif user:hasGroup("Firefighter") then
			TriggerClientEvent('chatMessage', -1, "^3FIREFIGHTER ^7| " .. author .. ": ^3" ..  message)
		else
			TriggerClientEvent('chatMessage', -1, "OOC | " .. author,  { 128, 128, 128 }, message)
		end
    end


    CancelEvent()
end)

-- player join messages
-- AddEventHandler('playerConnecting', function()
    -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
-- end)

-- AddEventHandler('playerDropped', function(reason)
    -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
-- end)

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
end)

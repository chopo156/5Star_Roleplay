function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname, sex, dateofbirth, height FROM characters WHERE identifier = @identifier", {
			['@identifier'] = identifier
    })
  if result[1] ~= nil then
    local user = result[1]
  
  return {
    firstname = user['firstname'],
    lastname = user['lastname'],
    dateofbirth = user['dateofbirth'],
    sex = user['sex'],
    height = user['height'],
    name = user['name']
  }
  else
    return nil
    end
end)


AddEventHandler('chatMessage', function(source, firstname, message)
	if string.sub(message,1,string.len("/"))=="/" then
		--ne doit rien se passer c'est une commande
	else
		TriggerClientEvent("sendProximityMessage", -1, source, firstname, message)
	end
	CancelEvent()
end)

--ME COMMAND
AddEventHandler('chatMessage', function(source, firstname, message)
	sm = stringsplit(message, " ");
	if sm[1] == "/me" then
	--if string.sub(message,1,string.len("/me"))=="/me" then
	    TriggerClientEvent("sendProximityMessageMe", -1, source, firstname, string.sub(message,4))
	end
	CancelEvent()
end)

--DO COMMAND
AddEventHandler('chatMessage', function(source, name, message)
	sm = stringsplit(message, " ");
	if sm[1] == "/do" then
	--if string.sub(message,1,string.len("/do"))=="/do" then
		TriggerClientEvent("sendProximityMessageDo", -1, source, name, string.sub(message,4))
	end
	CancelEvent()
end)

--OOC COMMAND
AddEventHandler('chatMessage', function(source, name, message)
	sm = stringsplit(message, " ");	
	if sm[1] == "/ooc" then
	--if string.sub(message,1,string.len("/ooc"))=="/ooc" then
		TriggerClientEvent("sendProximityMessageOOC", -1, source, name, string.sub(message,5))
	end
	CancelEvent()
end)

--TWITTER COMMAND
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/tweet" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^5 Twitter | @" .. name, source,  string.sub(msg,7))
	end
end)

--NEWS COMMAND
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/news" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^3 Weazel News |^7 Reporter: " .. name, source,  string.sub(msg,7))
	end
end)

--HELP COMMAND
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/help" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^1 Help  -  " .. name, source,  string.sub(msg,7))
	end
end)
--AddEventHandler('chatMessage', function(source, name, message)
	--sm = stringsplit(message, " ");	
	--if sm[1] == "/help" then
	--CancelEvent()
	--if string.sub(message,1,string.len("/ooc"))=="/ooc" then
		--TriggerClientEvent('chatMessage', -1, "^9 Help| " .. name, string.sub(message,6))
	--end
	--CancelEvent()
--end)

-- AddEventHandler('chatMessage', function(source, name, message)
	-- sm = stringsplit(message, " ");	
	-- if sm[1] == "/help" then
	-- --if string.sub(message,1,string.len("/ooc"))=="/ooc" then
		-- TriggerClientEvent('sendMessageHelp', -1, source, name, string.sub(message,6))
	-- end
	-- CancelEvent()
-- end)

-- -- ME COMMAND (/me [Message]) Outcomes: Name Message (All in purple)
-- TriggerEvent('es:addCommand', 'me', function(source, args, user)
    -- table.remove(args, 1)
    -- local pname = GetPlayerName(source)
    -- TriggerClientEvent("sendProximityMessageMe", -1, source, pname, table.concat(args, " "))
-- end, function(source, args, user)
    -- TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
-- end)

-- -- DO COMMAND (/do [Message]) Outcomes: Action: *Name Message
-- TriggerEvent('es:addCommand', 'do', function(source, args, user)
	-- table.remove(args, 1)
	-- local pname = GetPlayerName(source)
	-- TriggerClientEvent("sendProximityMessageDo", -1, source, pname, table.concat(args, " "))
-- end, function(source, args, user)
	-- TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
-- end)

-- TriggerEvent('es:addCommand', 'g', function(source, args, user)
	-- table.remove(args, 1)
	-- local message = table.concat(args, " ")
	-- TriggerClientEvent('chatMessage', -1, "^1(( ^0Global", {100, 100, 100}, tag .. "^4 " .. GetPlayerName(source) .. " ^4(^0"..source.."^4): ^0" .. message .. "^1))")
-- end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
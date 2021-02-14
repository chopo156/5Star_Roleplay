-- Inferno Collection Fire/EMS Pager + Fire Siren Version 4.54 Beta
--
-- Copyright (c) 2019, Christopher M, Inferno Collection. All rights reserved.
--
-- This project is licensed under the following:
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, and merge the software, under the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THE SOFTWARE MAY NOT BE SOLD.
--

--
-- Resource Configuration
-- PLEASE RESTART SERVER AFTER MAKING CHANGES TO THIS CONFIGURATION
--
local Config = {} -- Do not edit this line
-- Whether or not to disable all on-screen messages, exect call details
Config.DisableAllMessages = false
-- Whether or not to enable chat suggestions
Config.ChatSuggestions = true
-- Whether or not to enable a reminder for whitelisted people to enable their pagers shortly
-- after they join the server, if they have not done so already
Config.Reminder = true
-- Whether or not to enable command whitelist.
-- "ace" to use Ace permissions, "json" to use whitelist.json file, or false to disable.
Config.WhitelistEnabled = false
-- Separator character, goes between tones and details in /page command
Config.PageSep = "-"
-- Default fire department name, used in /page command
Config.DeptName = "Los Santos Fire"
-- Default text shown when page details are not provided
Config.DefaultDetails = "Rapporter til stationen"
-- Time in ms between the beginning of each tone played.
-- 7.5 seconds by default, do not edit unless you need to
Config.WaitTime = 7500
-- List of tones that can be paged, read the wiki page below to learn how to add more
-- https://github.com/inferno-collection/Fire-EMS-Pager/wiki/Adding-custom-tones
Config.Tones = {"medical", "rescue", "fire", "other"}
-- List of stations fire sirens can be played at, read the wiki page below to learn how to add more
-- https://github.com/inferno-collection/Fire-EMS-Pager/wiki/Adding-custom-stations
Config.Stations = {} -- Do not edit this line
table.insert(Config.Stations, {Name = "pb", Loc = vector3(-379.53, 6118.32, 31.85), Radius = 800, Siren = "siren1"}) -- Paleto Bay
table.insert(Config.Stations, {Name = "fz", Loc = vector3(-2095.92, 2830.22, 32.96), Radius = 1000, Siren = "siren2"}) -- Fort Zancudo
table.insert(Config.Stations, {Name = "ss", Loc = vector3(1691.24, 3585.83, 35.62), Radius = 500, Siren = "siren1"}) -- Sandy Shores
table.insert(Config.Stations, {Name = "rh", Loc = vector3(-635.09, -124.29, 39.01), Radius = 400, Siren = "siren1"}) -- Rockford Hills
table.insert(Config.Stations, {Name = "els", Loc = vector3(1193.42, -1473.72, 34.86), Radius = 400, Siren = "siren1"}) -- East Los Santos
table.insert(Config.Stations, {Name = "sls", Loc = vector3(199.83, -1643.38, 29.8), Radius = 400, Siren = "siren1"}) -- South Los Santos
table.insert(Config.Stations, {Name = "dpb", Loc = vector3(-1183.13, -1773.91, 4.05), Radius = 400, Siren = "siren1"}) -- Del Perro Beach
table.insert(Config.Stations, {Name = "lsia", Loc = vector3(-1068.74, -2379.96, 14.05), Radius = 500, Siren = "siren2"}) -- LSIA

--
--		Nothing past this point needs to be edited, all the settings for the resource are found ABOVE this line.
--		Do not make changes below this line unless you know what you are doing!
--

-- Local Pager Variables
local Pager = {}
-- Is the client's local pager enabled
Pager.Enabled = false
-- Are all clients currently being paged
Pager.Paging = false
-- What the client's local pager is tuned to
Pager.TunedTo = {}
-- How long to wait between tones being played
Pager.WaitTime = Config.WaitTime
-- List of tones that can be paged
Pager.Tones = Config.Tones

-- Local Fire Siren Variables
local FireSiren = {}
-- Stations that currently have a fire siren being played
FireSiren.EnabledStations = {}
-- Fire Station Variables
FireSiren.Stations = Config.Stations

-- Local whitelist variable
local Whitelist = {}
-- Boolean for whether the whitelist is enabled
Whitelist.Enabled = Config.WhitelistEnabled
-- Whitelist variable for commands
Whitelist.Command = {}
-- Boolean for whether player is whitelisted for pager command
Whitelist.Command.pager = false
-- Boolean for whether player is whitelisted for page command
Whitelist.Command.page = false
-- Boolean for whether player is whitelisted for firesiren command
Whitelist.Command.firesiren = false
-- Boolean for whether player is whitelisted for cancelpage command
Whitelist.Command.cancelpage = false
-- Boolean for whether player is whitelisted for pagerwhitelist command
Whitelist.Command.pagerwhitelist = false

AddEventHandler("onClientResourceStart", function (ResourceName)
	if(GetCurrentResourceName() == ResourceName) then
		if Whitelist.Enabled then
			TriggerServerEvent("Fire-EMS-Pager:WhitelistCheck", Whitelist)
		else
			for i in pairs(Whitelist.Command) do
				Whitelist.Command[i] = true
			end

			Whitelist.Command.pagerwhitelist = false
		end
	end
end)

-- On client join server
AddEventHandler("onClientMapStart", function()
	if Config.ChatSuggestions then
		-- Create a temporary variables to add more text to
		local ValidTones = "Gyldige toner:"
		local ValidStations = "Gyldige stationer:"

		-- Loop though all the tones
		for _, Tone in ipairs(Pager.Tones) do
			-- Add a tone to temporary string
			ValidTones = ValidTones .. " " .. Tone
		end

		-- Loop though all the stations
		for _, Station in ipairs(FireSiren.Stations) do
			-- Add a station to temporary string
			ValidStations = ValidStations .. " " .. Station.Name
		end

		TriggerEvent("chat:addSuggestion", "/pager", "Fra at allerede er indstillet, slukker for personsøger. Fra personsøgeren er slået, skal du indtaste toner, der skal indstilles til, eller hvis de allerede er indstillet, toner, der skal indstilles til. Sæt et mellemrum mellem hver tone.", {
			{ name = "tone", help = ValidTones }
		})

		TriggerEvent("chat:addSuggestion", "/page", "Hvis der ikke i øjeblikket er nogen andre toner, der indtastes toner. Sæt et mellemrum mellem hver tone.", {
			{ name = "tones", help = ValidTones },
			{ name = "- call details", help = "For at tilføje valgfrie detaljer skal du tilføje et mellemrum efter den sidste tone, derefter en '-', derefter en anden plads og derefter dine detaljer. For eksempel: /page fire medical - Dine detaljer går her" }
		})

		TriggerEvent("chat:addSuggestion", "/cancelpage", "Afspiller annulleringstone for valgte toner og viser ignorering af anmeldelse.", {
			{ name = "tones", help = ValidTones },
			{ name = "- disregard details", help = "Hvis du vil tilføje valgfri ignorering af detaljer, skal du tilføje et mellemrum efter den sidste tone, derefter et '-', derefter et andet mellemrum og derefter dine detaljer. For eksempel: /cancelpage fire medical - Din ignorering Detaljer Gå her" }
		})

		TriggerEvent("chat:addSuggestion", "/firesiren", "Hvis der i øjeblikket ikke lyder andre sirener, vil der ske ildsiren på indtastede stationer. Sæt et mellemrum mellem hver station.", {
			{ name = "stations", help = ValidStations }
		})

		TriggerEvent("chat:addSuggestion", "/pagerwhitelist", "Føj til eller genindlæs kommandoen whitelist.", {
			{ name = "{reload} or {player hex/server id}", help = "Type 'reload' for at genindlæse whitelist, eller hvis du tilføjer til whitelist, skriv player's steam hex, eller sætte player's server ID fra player list." },
			{ name = "commands", help = "Liste over alle de kommandoer, du vil have denne person til at få adgang til."}
		})
	end

	if Whitelist.Enabled then
		TriggerServerEvent("Fire-EMS-Pager:WhitelistCheck", Whitelist)
	else
		for i in pairs(Whitelist.Command) do
			Whitelist.Command[i] = true
		end

		Whitelist.Command.pagerwhitelist = false
	end

	-- Adds page command chat template, including pager icon
	TriggerEvent("chat:addTemplate", "page", "<img src='data:image/gif;base64,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' height='16'> <b>{0}</b>: {1}")
end)

-- Return from whitelist check
RegisterNetEvent("Fire-EMS-Pager:return:WhitelistCheck")
AddEventHandler("Fire-EMS-Pager:return:WhitelistCheck", function(NewWhitelist)
	-- Update local whitelist values with server ones
	Whitelist = NewWhitelist

	-- If reminder is enabled and the client is whitelisted to use the /pager command
	if Config.Reminder and Whitelist.Command.pager then
		-- Wait two minutes after they join the server
		Citizen.Wait(120000)
		-- If their pager is still not enabled
		if not Pager.Enabled then
			-- Send reminder
			NewNoti("~y~Glem ikke at indstille din personsøger!", true)
		end
	end
end)

-- Forces a whitelist reload on the client
RegisterNetEvent("Fire-EMS-Pager:WhitelistRecheck")
AddEventHandler("Fire-EMS-Pager:WhitelistRecheck", function()
	TriggerServerEvent("Fire-EMS-Pager:WhitelistCheck", Whitelist)
end)

-- /pager command
-- Used to enable and disable pager, and set tones to be tuned to
RegisterCommand("pager", function(Source, Args)
	if Whitelist.Command.pager then
		function EnablePager()
			-- Loop though all the tones provided by the client
			for _, ProvidedTone in ipairs(Args) do
				-- Loop through all the valid tones
				for _, ValidTone in ipairs(Pager.Tones) do
					-- If a provided tone matches a valid tone
					if ProvidedTone:lower() == ValidTone then
						-- Add it to the list of tones to be tuned to
						table.insert(Pager.TunedTo, ValidTone)
					end
				end
			end

			-- If the number of originally provided tones matches the
			-- number of tones, and there where tones acutally provided
			-- in the first place
			if not #Args ~= #Pager.TunedTo and #Args ~= 0 then
				-- Create a temporary variable to add more text to
				local NotificationText = "~g~personsøger indstillet til:~y~"
				-- Loop though all the tones that the client will be tuned to
				for _, Tone in ipairs(Pager.TunedTo) do
					-- Add them to the temporary variable
					NotificationText = NotificationText .. " " .. Tone:upper()
				end
				NewNoti(NotificationText, false)
				-- Locally anable the client's pager
				Pager.Enabled = true
			-- If there is a mismatch, i.e. invalid/no tone/s provided
			else
				NewNoti("~r~~h~Ugyldige toner, tjek venligst dine personsøger.", true)
				-- Ensure the client's pager is locally disabled
				Pager.Enabled = false
				Pager.TunedTo = {}
			end
		end

		if not Pager.Enabled then
			EnablePager()
		else
			-- If there are tones provided
			if #Args ~= 0 then
				-- Clear list of currently tuned tones to avoid duplicates
				Pager.TunedTo = {}
				EnablePager()
			-- If no tones where provided, and they just want it turned off
			else
				NewNoti("~g~personsøger blev slukket.", false)
				-- Ensure the client's pager is locally disabled
				Pager.Enabled = false
				Pager.TunedTo = {}
			end
		end
	-- If player is not whitelisted
	else
		NewNoti("~r~Du er ikke whitelisted til denne kommando.", true)
	end
end)

-- /page command
-- Used to page out a tone/s
RegisterCommand("page", function(Source, Args)
	PagePagers(Args)
end)

-- Base fire siren command
-- Used to play a fire siren at a specific station/s
RegisterCommand("firesiren", function(Source, Args)
	SoundFireSiren(Args)
end)

-- /cancelpage command
-- Used to play a sound to signal a canceled call
RegisterCommand("cancelpage", function(Source, Args)
	local ToneCount = 0
	local HasDetails = false
	local ToBeCanceled = {}

	if Whitelist.Command.cancelpage then
		if not Pager.Paging then
			-- Loop though all the tones provided in the command
			for _, ProvidedTone in ipairs(Args) do
				-- Loop through all the valid tones
				for _, ValidTone in ipairs(Pager.Tones) do
					-- If a provided tone matches a valid tone
					if ProvidedTone:lower() == ValidTone then
						-- Add it to the list of tones to be paged
						table.insert(ToBeCanceled, ValidTone)
						break
					-- Checks for the separator character
					elseif ProvidedTone:lower() == Config.PageSep then
						HasDetails = true
						-- Counts up to the number of valid tones provided
						-- plus 1, to include the separator
						for _ = ToneCount + 1, 1, -1 do
							-- Remove tones from arguments to leave details
							table.remove(Args, 1)
						end

						break
					end
				end

				if HasDetails then
					break
				end

				ToneCount = ToneCount + 1
			end

			-- If the number of originally provided tones matches the
			-- number of tones, and there where tones acutally provided
			-- in the first place
			if not ToneCount ~= #ToBeCanceled and ToneCount ~= 0 then
				-- Create a temporary variable to add more text to
				local NotificationText = "~g~Annullering:~y~"
				-- Loop though all the tones
				for _, Tone in ipairs(ToBeCanceled) do
					-- Add a tone to temporary string
					NotificationText = NotificationText .. " " .. Tone:upper()
				end
					NewNoti(NotificationText, false)
				-- Bounces tones off of server
				TriggerServerEvent("Fire-EMS-Pager:CancelPage", ToBeCanceled, HasDetails, Args)
			-- If there is a mismatch, i.e. invalid/no tone/s provided
			else
				NewNoti("~r~~h~Ugyldige toner, tjek venligst dine kommando.", true)
			end
		-- If tones are already being paged
		else
			NewNoti("~r~~h~Der undersøges toner, vent venligst.", true)
		end
	-- If player is not whitelisted
	else
		NewNoti("~r~Du er ikke hvidlistet til denne kommando.", true)
	end
end)

-- /pagerwhitelist
-- Reload, and/or add someone to the whitelist
RegisterCommand("pagerwhitelist", function(Source, Args)
	if Whitelist.Command.pagerwhitelist then
		-- If the first argument is defined and is equal to "reload"
		if Args[1] and Args[1]:lower() == "reload" then
			-- Tell server to reload the whitelist on all clients
			TriggerServerEvent("Fire-EMS-Pager:WhitelistReload")
			NewNoti("~g~Genindlæs whitelist fuldført.", true)
		elseif Args[1] then
			-- Temporary variable for steam hex
			local ID
			-- Temporary whitelist entry variables
			local Entry = {}
			-- Declaring valid commands
			Entry.pager = "pending"
			Entry.page = "pending"
			Entry.firesiren = "pending"
			Entry.cancelpage = "pending"
			Entry.pagerwhitelist = "pending"

			-- If the first argument is a number
			if tonumber(Args[1]) then
				-- Set the steam hex to the number, assuming a server ID has been provided
				ID = Args[1]
			-- Else if the first part of the string contains "steam:"
			elseif string.sub(Args[1]:lower(), 1, string.len("steam:")) == "steam:" then
				-- Set the steam hex to the string
				ID = Args[1]
			-- In all other cases
			else
				-- Set the steam hex to the string, adding "steam:" to the front
				ID = "steam:" .. Args[1]
			end

			-- Loop though all command arguments
			for i in pairs(Args) do
				-- If the argument is a valid command
				if Entry[Args[i]:lower()] then
					-- Allow the player access to the command
					Entry[Args[i]] = true
				end
			end

			-- Loop though all commands
			for i in pairs(Entry) do
				-- If the command is still pending
				if Entry[i] == "pending" then
					-- Disallow the player access to the command
					Entry[i] = false
				end
			end

			-- Tell the server to add the new entry to the whitelist and reload
			TriggerServerEvent("Fire-EMS-Pager:WhitelistAdd", ID, Entry)
			NewNoti("~g~" .. ID .. " Føjet til whitelist med succes.", true)
		-- If first argument not set
		else
			NewNoti("~r~Fejl, ikke nok argumenter.", true)
		end
	-- If player is not whitelisted
	else
		NewNoti("~r~Du er ikke hvidlistet til denne kommando.", true)
	end
end)

-- Plays tones on the client
RegisterNetEvent("Fire-EMS-Pager:PlayTones")
AddEventHandler("Fire-EMS-Pager:PlayTones", function(Tones, HasDetails, Details)
	local NeedToPlay = false
	local Tuned
	Pager.Paging = true

	if Pager.Enabled then
		-- Loop though all tones that need to be paged
		for _, Tone in ipairs(Tones) do
			-- Loop through all the tones the player is tuned to
			for _, TunedTone in ipairs(Pager.TunedTo) do
				-- If player is tuned to this tone
				if Tone == TunedTone then
					-- Set temporary variable
					NeedToPlay = true
				end
			end
		end

		-- If the player is tuned to one or more of the tones being paged
		if NeedToPlay then
			NewNoti("~g~~h~Din personsøger aktiveres!", true)
			Citizen.Wait(1500)
			-- Loop though all tones that need to be paged
			for _, Tone in ipairs(Tones) do
				-- Reset to false
				Tuned = false
				-- Loop through all the tones the player is tuned to
				for _, TunedTone in ipairs(Pager.TunedTo) do
					-- If player is tuned to this specific tone
					if Tone == TunedTone then
						-- Set temporary variable
						Tuned = true
					end
				end

				-- If player is tuned to this tone
				if Tuned then
					TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "PlayTone", "vibrate")
					NewNoti("~h~~y~" .. Tone:upper() ..  " opkald!", true)
				-- If player is not tuned to it
				else
					TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "PlayTone", Tone)
				end
				Citizen.Wait(Pager.WaitTime)
			end

			TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "PlayTone", "end")

			local Hours = GetClockHours()
			local Minutes = GetClockMinutes()

			if Hours <= 9 then
				-- Add a 0 infront
				Hours = "0" .. tostring(Hours)
			end

			if Minutes <= 9 then
				-- Add a 0 infront
				Minutes = "0" .. tostring(Minutes)
			end

			if HasDetails then
				local NewDetails = ""
				local NewTones = ""

				-- Loop though details (each word is an element)
				for _, l in ipairs(Details) do
					-- Add word to temporary variable
					NewDetails = NewDetails .. " " .. l
				end
				-- Capitalise first letter
				NewDetails = NewDetails:gsub("^%l", string.upper)

				-- Loop though all tones
				for _, Tone in ipairs(Tones) do
					-- Add tone to string and capitalise
					NewTones = NewTones .. Tone:gsub("^%l", string.upper) .. " "
				end

				-- Send message to chat, only people tuned to specified tones can see the message
				TriggerEvent("chat:addMessage", {
					templateId = "page",
					-- Red
					color = { 255, 0, 0},
					multiline = true,
					args = {"Brand kontrol", "\nOpmærksomhed " .. Config.DeptName .. " - " .. NewDetails .. " - " .. NewTones .. "Emergency.\n\nTiden er gået " .. Hours .. Minutes.. "."}
				})
			-- If no details provided
			else
				-- Send message to chat, only people tuned to specified tones can see the message
				TriggerEvent("chat:addMessage", {
					templateId = "page",
					-- Red
					color = { 255, 0, 0},
					multiline = true,
					args = {"Brand kontrol", "\nOpmærksomhed " .. Config.DeptName .. " - " .. Config.DefaultDetails .. ".\n\nTiden er gået " .. Hours .. Minutes.. "."}
				})
			end
		else
			for _, _ in ipairs(Tones) do
				Citizen.Wait(Pager.WaitTime)
			end

			Citizen.Wait(1500)
		end
	else
		for _, _ in ipairs(Tones) do
			Citizen.Wait(Pager.WaitTime)
		end
	end

	Citizen.Wait(3000)
	Pager.Paging = false
end)

-- Play fire sirens
RegisterNetEvent("Fire-EMS-Pager:PlaySirens")
AddEventHandler("Fire-EMS-Pager:PlaySirens", function()
	for _, Station in pairs(FireSiren.EnabledStations) do
		TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "PlaySiren", {Station.Name, Station.ID, Station.Siren})
	end
end)

-- Plays cancelpage sound on the client
RegisterNetEvent("Fire-EMS-Pager:CancelPage")
AddEventHandler("Fire-EMS-Pager:CancelPage", function(Tones, HasDetails, Details)
	local NeedToPlay = false
	Pager.Paging = true

	if Pager.Enabled then
		-- Loop though all tones that need to be paged
		for _, Tone in ipairs(Tones) do
			-- Loop through all the tones the player is tuned to
			for _, TunedTone in ipairs(Pager.TunedTo) do
				-- If player is tuned to this tone
				if Tone == TunedTone then
					-- Set temporary variable
					NeedToPlay = true
				end
			end
		end

		-- If the player is tuned to one or more of the tones being paged
		if NeedToPlay then
			NewNoti("~g~~h~Din personsøger aktiveres!", true)
			Citizen.Wait(1500)

			TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "PlayTone", "cancel")

			if HasDetails then
				local NewDetails = ""

				-- Loop though details (each word is an element)
				for _, l in ipairs(Details) do
					-- Add word to temporary variable
					NewDetails = NewDetails .. " " .. l
				end
				-- Capitalise first letter
				NewDetails = NewDetails:gsub("^%l", string.upper)

				-- Send message to chat, only people tuned to specified tones can see the message
				TriggerEvent("chat:addMessage", {
					templateId = "page",
					-- Red
					color = { 255, 0, 0},
					multiline = true,
					args = {"Brand kontrol", "\nOpmærksomhed " .. Config.DeptName .. " - Opkald annulleret, se bort fra svaret - " .. NewDetails}
				})
			-- If no details provided
			else
				-- Send message to chat, only people tuned to specified tones can see the message
				TriggerEvent("chat:addMessage", {
					templateId = "page",
					-- Red
					color = { 255, 0, 0},
					multiline = true,
					args = {"Brand kontrol", "\nOpmærksomhed " .. Config.DeptName .. " - Opkald annulleret, se bort fra svaret."}
				})
			end
		else
			Citizen.Wait(1500)
		end
	else
		Citizen.Wait(1500)
	end

	Citizen.Wait(3500)
	Pager.Paging = false
end)

RegisterNUICallback("RemoveSiren", function(Station)
	-- If the client is the owner of this fire siren, remove fire siren
	-- This check is done so only one event is sent to the server instead of 32+
	if GetPlayerServerId(PlayerId()) == Station.ID then
		TriggerServerEvent("Fire-EMS-Pager:RemoveSiren", Station.Name)
	end

	FireSiren.EnabledStations[Station.Name] = nil
end)

-- Bounce between server script and client script
RegisterNetEvent("Fire-EMS-Pager:Bounce:ServerValues")
AddEventHandler("Fire-EMS-Pager:Bounce:ServerValues", function(Sirens) FireSiren.EnabledStations = Sirens end)

-- Bounce between server & client script and client NUI
RegisterNetEvent("Fire-EMS-Pager:Bounce:NUI")
AddEventHandler("Fire-EMS-Pager:Bounce:NUI", function(Type, Load)
	SendNUIMessage({
		PayloadType	= Type,
		Payload		= Load
	})
end)

-- Used to page out a tone/s
function PagePagers(Args)
    -- Number of provided tones
    local ToneCount = 0
    -- Whether the arguments has details or not
    local HasDetails = false
    -- Local array to store tones to be paged
    local ToBePaged = {}

    -- Check if the player is whitelisted to use this command
    if Whitelist.Command.page then
        -- If tones are not already being paged
        if not Pager.Paging then
            -- Loop though all the tones provided in the command
            for _, ProvidedTone in ipairs(Args) do
                -- Loop through all the valid tones
                for _, ValidTone in ipairs(Pager.Tones) do
                    -- If a provided tone matches a valid tone
                    if ProvidedTone:lower() == ValidTone then
                        -- Add it to the list of tones to be paged
                        table.insert(ToBePaged, ValidTone)
                        -- No need to keep searching for this tone
                        break
                    -- Checks for the separator character
                    elseif ProvidedTone:lower() == Config.PageSep then
                        -- Set true, used for checking and loop breaking
                        HasDetails = true
                        -- Counts up to the number of valid tones provided
                        -- plus 1, to include the separator
                        for _ = ToneCount + 1, 1, -1 do
                            -- Remove tones from arguments to leave only details
                            table.remove(Args, 1)
                        end
                        -- Break from loop
                        break
                    end
                end
                -- If a break is needed
                if HasDetails then
                    -- Break from loop
                    break
                end
                -- Increase count
                ToneCount = ToneCount + 1
            end

            -- If the number of originally provided tones matches the
            -- number of tones, and there where tones acutally provided
            -- in the first place
            if not ToneCount ~= #ToBePaged and ToneCount ~= 0 then
                -- Create a temporary variable to add more text to
                local NotificationText = "~g~søgning:~y~"
                -- Loop though all the tones
                for _, Tone in ipairs(ToBePaged) do
                    -- Add a tone to temporary string
                    NotificationText = NotificationText .. " " .. Tone:upper()
                end
                -- Draw new notification on client's screen
                    NewNoti(NotificationText, false)
                -- Bounces tones off of server
                TriggerServerEvent("Fire-EMS-Pager:PageTones", ToBePaged, HasDetails, Args)
            -- If there is a mismatch, i.e. invalid/no tone/s provided
            else
                -- Draw new notification on client's screen
                NewNoti("~r~~h~Ugyldige toner, tjek venligst dine kommando argumenter.", true)
            end
        -- If tones are already being paged
        else
            -- Draw new notification on client's screen
            NewNoti("~r~~h~Toner er allerede blevet søget.", true)
        end
    -- If player is not whitelisted
    else
        -- Draw error message on player screen
        NewNoti("~r~Du er ikke whitelisted til denne kommando.", true)
    end
end

-- Sounds fire siren
-- Check if the player is whitelisted to use this command
function soundFireSiren(Args)
	-- Check if the player is whitelisted to use this command
	if Whitelist.Command.firesiren then
		-- If fire sirens are not already being sounded
		if not FireSiren.Enabled then
			-- Local array to store stations to be sounded
			local ToBeSirened = {}
			-- Loop though all the stations provided in the command
			for _, ProvidedStation in ipairs(Args) do
				-- Loop through all the valid stations
				for _, ValidStation in ipairs(FireSiren.Stations) do
					-- If a provided station matches a valid station
					if ProvidedStation:lower() == ValidStation.Name then
						ValidStation.x, ValidStation.y, ValidStation.z = table.unpack(ValidStation.Loc)
						table.insert(ToBeSirened, ValidStation)
					end
				end
			end

			-- If the number of originally provided stations matches
			-- the number of stations, and there where stations acutally
			-- provided in the first place
			if not #Args ~= #ToBeSirened and #Args ~= 0 then
				-- Create a temporary variable to add more text to
				local NotificationText = "~g~Sounding:~y~"
				-- Loop though all stations
				for _, Station in ipairs(ToBeSirened) do
					-- Add station to temporary variable
					NotificationText = NotificationText .. " " .. Station.Name:upper()
				end
				-- Draw new notification on client's screen
				NewNoti(NotificationText, false)
				-- Bounces stations off of server
				TriggerServerEvent("Fire-EMS-Pager:SoundSirens", ToBeSirened)
			-- If there is a mismatch, i.e. invalid/no stations/s provided
			else
				-- Draw new notification on client's screen
				NewNoti("~r~~h~Ugyldige stationer til lyd, tjek venligst dine kommando argumenter.", true)
			end
		-- If sirens are already being sounded
		else
			-- Draw new notification on client's screen
			NewNoti("~r~~h~Sirener lyder allerede!", true)
		end
	-- If player is not whitelisted
	else
		-- Draw error message on player screen
		NewNoti("~r~Du er ikke whitelisted til denne kommando.", true)
	end
end

-- Draws notification on client's screen
function NewNoti(Text, Flash)
	if not Config.DisableAllMessages then
		-- Tell GTA that a string will be passed
		SetNotificationTextEntry("STRING")
		-- Pass temporary variable to notification
		AddTextComponentString(Text)
		-- Draw new notification on client's screen
		DrawNotification(Flash, true)
	end
end

-- Volume loop
-- Sets the volumes of all active fire sirens
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local FireSirenCount = 0
		for _, _ in pairs(FireSiren.EnabledStations) do FireSirenCount = FireSirenCount + 1 end

		if FireSirenCount >= 1 then
			local PlayerPed = PlayerPedId()
			local PlayerCoords = GetEntityCoords(PlayerPed, false)

			for _, Station in pairs(FireSiren.EnabledStations) do
				local Distance = Vdist(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Station.x, Station.y, Station.z) + 0.01 -- Stops divide by 0 errors
				if (Distance <= Station.Radius) then

					local SirenVolume = 1 - (Distance / Station.Radius)
					if IsPedInAnyVehicle(PlayerPedId(), false) then
						local VC = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()), false)
						-- If vehicle is not a motobike or a bicycle
						if VC ~= 8 or VC ~= 13 then
							-- Lower the alarm volume by 45%
							SirenVolume = SirenVolume * 0.45
						end
					end

					TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "SetSirenVolume", {Station.Name, SirenVolume})
				else
					TriggerEvent("Fire-EMS-Pager:Bounce:NUI", "SetSirenVolume", {Station.Name, 0})
				end
			end
		end

	end
end)
--[[ Need Help? Join my discord @ discord.gg/yWddFpQ ]]

local nui = false

Citizen.CreateThread(function()
    --[[ If you want to change the key, go to https://docs.fivem.net/game-references/controls/ and change the '20' value below]]
    local key = 243 -- Change this to your key value
    nui = false
    while true do
        Citizen.Wait(1)

        if IsControlPressed(0, key) then 
            if not nui then
                local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    r, g, b = GetPlayerRgbColour(i)
                    table.insert(players,
                    '<tr style=\"color: #fff"><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td></tr>'
                    )
                end

                SendNUIMessage({ text = table.concat(players) })

                nui = true
                while nui do
                    Wait(0)
                    if(IsControlPressed(0, key) == false) then
                        nui = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

htmlEntities = module("vrp", "lib/htmlEntities")


local lcfg = module("vrp", "cfg/base")
Luang = module("vrp", "lib/Luang")
Lang = Luang()

Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})

Lang:loadLocale(lcfg.lang, module("vrp2_functions", "lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

local Functions = class("Functions", vRP.Extension)

function Functions:specialFunction(source, data, value)
    local user = vRP.users_by_source[source]
    local dead = vRP.EXT.Survival.remote.isInComa(user.source)

    if data == "money" then
        vRP.EXT.Money:unPack(user.source, value) 

    elseif data == "money_binder" then
        vRP.EXT.Money:bindMoney(user.source, value)


    elseif data == "repairkit" then
	    if not self:isMechAllowed() or user:hasPermission("mech.chest") then	
            if user:tryTakeItem("repairkit",1) then
                vRP.EXT.Base.remote._playAnim(user.source,false,{task="WORLD_HUMAN_WELDING"},false) --planning on changing the animation later
                SetTimeout(7000, function()
                    vRP.EXT.Garage.remote._fixNearestVehicle(user.source,10)
                    vRP.EXT.Base.remote._stopAnim(user.source,false)	
                end)
			end
		else
		    vRP.EXT.Base.remote._notify(user.source,"~b~There is a mechanic online")
        end

    elseif data == "bandage" then
        local revive_seq = {
            {"amb@medic@standing@kneel@idle_a","idle_a",1},
        }
        if user:hasPermission("ems.items") or user:hasPermission("police.askid") or user:hasPermission("admin.extras") and not dead then

            local nuser
            local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 10)

            if nplayer then
                nuser = vRP.users_by_source[nplayer]
            end

            if nuser then
                if not vRP.EXT.Survival.remote.isInComa(nuser.source) then
                    if user:tryTakeItem("bandage", 1) then
                        vRP.EXT.Base.remote._notify(user.source,"~g~Applying a bandage.")
					    vRP.EXT.Base.remote._playAnim(user.source,false,{{"mp_arresting", "a_uncuff",5}},true) -- anim
                        Wait(15000)
                        vRP.EXT.Survival.remote._varyHealth(nuser.source, 10)
					    vRP.EXT.Base.remote._stopAnim(user.source,true) -- upper
						vRP.EXT.Base.remote._stopAnim(user.source,false) -- full
					end
                else
                    vRP.EXT.Base.remote._notify(user.source, "~r~A bandage won't help this person.")
                end
            else
                vRP.EXT.Base.remote._notify(user.source, "~r~No Person near you.")
			end
        else
            vRP.EXT.Base.remote._notify(user.source, "~r~You currently don't have permission to use this item.")
        end

    elseif data == "medkit" then	

        local revive_seq = {
            {"amb@medic@standing@kneel@enter","enter",1},
            {"amb@medic@standing@kneel@idle_a","idle_a",1},
	        {"missheistfbi3b_ig8_2", "cpr_loop_paramedic", 6},
            {"amb@medic@standing@kneel@exit","exit",1}
        }


        if user:hasPermission("ems.items") or user:hasPermission("police.askid") or user:hasPermission("admin.extras") and not dead then
  
            local nuser
            local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source,10)
            if nplayer then 
                nuser = vRP.users_by_source[nplayer] 
            end
            if nuser then
                if vRP.EXT.Survival.remote.isInComa(nuser.source) then
	                if user:tryTakeItem("medkit",1, true) then
	                    vRP.EXT.Base.remote._notify(user.source,"Asking for consent to administer first aid...")
	                    if nuser:request("Do you want to receive first aid?", 15) then
	  
                            if user:tryTakeItem("medkit",1) then
                                vRP.EXT.Base.remote._playAnim(user.source,false,{{"amb@medic@standing@kneel@idle_a","idle_a",1}},true) -- anim
		                        Wait(500)
		                        vRP.EXT.Base.remote._playAnim(user.source, true, {{"missheistfbi3b_ig8_2", "cpr_loop_paramedic", 3}}, false)
                                SetTimeout(16000, function()
                                    vRP.EXT.Survival.remote._varyHealth(nuser.source,25) -- heal 50
			                        vRP.EXT.Base.remote._stopAnim(user.source,true) -- upper
			                        vRP.EXT.Base.remote._stopAnim(user.source,false) -- full
                                end)
                            end
                        else
                            vRP.EXT.Base.remote._notify(user.source,"~r~This person refused first aid.")
		                    vRP.EXT.Base.remote._notify(nuser.source,"~r~You refused first aid.")
                        end
	                else
                        vRP.EXT.Base.remote._notify(user.source,"~r~Missing Medkit")
	                end
                else
                    vRP.EXT.Base.remote._notify(user.source,lang.emergency.menu.revive.not_in_coma())
	            end
	        else
                vRP.EXT.Base.remote._notify(user.source,lang.common.no_player_near())
            end
	    else
            vRP.EXT.Base.remote._notify(user.source, "~r~You currently don't have permission to use this item.")
        end
 
	
    elseif data == "lockpick" then
        if user:tryTakeItem("lockpick", 1, true) or user:hasPermission("item.bypass") then
            self.remote.lockpickVehicle(user.source, 20, true)
		else
		    vRP.EXT.Base.remote._notify(user.source, "~r~No lockpick in inventory")
        end
	end
end

function Functions:isMechAllowed()
    for _, user in pairs(vRP.users) do
        if user:isReady() and user:hasPermission("mech.chest") then
            return true
		else 
			return false
        end
    end	
end	

--Mobile Police Computer
local function menu_computer(self)

  local function m_msearchreg(menu)
    local user = menu.user
    local reg = user:prompt(lang.police.pc.searchreg.prompt(),"")
    local cid = vRP.EXT.Identity:getByRegistration(reg)
    if cid then
      local identity = vRP.EXT.Identity:getIdentity(cid)
      if identity then
        local smenu = user:openMenu("identity", {cid = cid})
        menu:listen("remove", function(menu) menu.user:closeMenu(smenu) end)
      else
        vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
      end
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
    end
  end

  local function m_records(menu)
    local user = menu.user
    local reg = user:prompt(lang.police.pc.searchreg.prompt(),"")
    local tuser
    local cid = vRP.EXT.Identity:getByRegistration(reg)
    if cid then tuser = vRP.users_by_cid[cid] end
    if tuser then
      -- check vehicle
      local smenu = user:openMenu("police_pc.records", {tuser = tuser})
      menu:listen("remove", function(menu) menu.user:closeMenu(smenu) end)
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.not_found())
    end
  end

  vRP.EXT.GUI:registerMenuBuilder("computer", function(menu)
    local user = menu.user
    menu.title = "Police Computer"
    menu.css.header_color = "rgba(0,125,255,0.75)"
      menu:addOption(lang.police.veh_searchreg.title(), m_msearchreg, lang.police.veh_searchreg.description())
      menu:addOption(lang.police.veh_records.title(), m_records, lang.police.veh_records.description())
  end)

end

-- police computer while near PV
local function m_computer(menu)
    local user = menu.user
    -- check vehicle
    local model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 7)
    if model then
        local menu = user:openMenu("computer")
        local running = true
        menu:listen("remove", function(menu)
            running = false
        end)

        -- task: close menu if not next to the vehicle
        Citizen.CreateThread(function()
            while running do
                Citizen.Wait(8000)
                local check_model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 7)
                if model ~= check_model then
                    user:closeMenu(menu)
                end
            end
        end)
    else
        vRP.EXT.Base.remote._notify(user.source, lang.police.connection())
    end
end

vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
    menu:addOption(lang.police.veh_searchtitle.title(), m_computer)
end)

-- dynamic Fine
local function m_fine(menu)
    local user = menu.user
    local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 5)

    if nplayer then
        nuser = vRP.users_by_source[nplayer]
    end

    if nuser then
        local fine = user:prompt(lang.fine.prompt.amount(), "")

        if fine ~= nil and fine ~= "" then
            local reason = user:prompt(lang.fine.prompt.reason(), "")

            if reason ~= nil and reason ~= "" then
                    -- if tonumber(fine) > 10000 then
                    --     fine = 10000
                    -- end

                    if tonumber(fine) < 0 then
                        fine = 0
                    end

                    if fine ~= nil then
                        nuser:giveDebt(tonumber(fine))
                        nuser:insertPoliceRecord(lang.police.menu.fine.record({reason,fine}))
                        vRP.EXT.Base.remote._notify(user.source, lang.police.menu.fine.fined({reason,fine}))
                        vRP.EXT.Base.remote._notify(nuser.source, lang.police.menu.fine.notify_fined({reason,fine}))
						

                        user:closeMenu()
						
                        -- local text = "**Police Event**\n**Type:** `User was Fined` \n**Officer ID: ** `"..user.id.."`\n**Citizen ID: ** `"..nuser.id.. "`\n**Total Amount:** `$"..fine.."`\n**Offense:** `$"..reason.."` ```ini\n" ..maindate.."```"
                        
                        -- setLog(text)
                    else
                        vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
                    end
                else
                    vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
                end
            else
                vRP.EXT.Base.remote._notify(user.source, lang.common.invalid_value())
        end
    else
        vRP.EXT.Base.remote._notify(user.source, lang.common.no_player_near())
    end
end

function setLog(text)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(user.source)
	local identifier = GetPlayerIdentifiers(user.source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end

function Functions:__construct()
    vRP.Extension.__construct(self)
  
    menu_computer(self)
	
	--- toggle blips
	local function m_delveh(menu)
    local user = menu.user
	self.remote._deleteVehicleInFrontOrInside(user.source, 5.0)
	end

    -- spawn vehicle
    local function m_spawnveh(menu)
        local user = menu.user
        local model = user:prompt("Vehicle Spawn", "")
        if model ~= nil and model ~= "" then 
            self.remote._spawnVehicle(user.source,model)
        else
            vRP.EXT.Base.remote._notify(user.source,"Invalid")
        end
    end
	
	local function m_tp(menu)
		local user = menu.user
		self.remote._tpToWaypoint(user.source)
	end

    vRP.EXT.GUI:registerMenuBuilder("admin", function(menu)
        local user = menu.user
        if user:hasPermission("admin.extras") then
			menu:addOption("TP to Waypoint", m_tp)
            menu:addOption("Spawn Vehicle", m_spawnveh)
			menu:addOption("Delete Vehicle", m_delveh)	
        end
    end)

    --Fines
    vRP.EXT.GUI:registerMenuBuilder("police", function(menu)
	    local user = menu.user
        menu:addOption("Dynamic Fine", m_fine)
    end)
end


vRP:registerExtension(Functions)
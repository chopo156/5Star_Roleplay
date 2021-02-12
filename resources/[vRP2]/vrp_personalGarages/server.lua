local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local personalGarages = class("personalGarages", vRP.Extension)

local function menu_pg_vehicles(self)
	
	local function m_sub(menu, model)
		local user = menu.user

		local vehicles = user:getVehicles()

		if vehicles[model] == 1 then -- in
			local vstate = user:getVehicleState(model)
			local state = {
				customization = vstate.customization,
				condition = vstate.condition,
				locked = vstate.locked
			}

			vehicles[model] = 0 -- mark as out
			vRP.EXT.Garage.remote._spawnVehicle(user.source, model, state)
			vRP.EXT.Garage.remote._setOutVehicles(user.source, {[model] = {}})
			user:closeMenu(menu)
		elseif vehicles[model] == 0 then -- out
			vRP.EXT.Base.remote._notify(user.source, lang.garage.owned.already_out())
			-- force out request
			if user:request(lang.garage.owned.force_out.request({self.cfg.force_out_fee}), 15) then
				if user:tryPayment(self.cfg.force_out_fee) then
					local vstate = user:getVehicleState(model)
					local state = {
						customization = vstate.customization,
						condition = vstate.condition,
						locked = vstate.locked
					}

					vehicles[model] = 0 -- mark as out
					vRP.EXT.Garage.remote._spawnVehicle(user.source, model, state)
					vRP.EXT.Garage.remote._setOutVehicles(user.source, {[model] = {state, vstate.position, vstate.rotation}})
					user:closeMenu(menu)
				else
					vRP.EXT.Base.remote._notify(user.source, lang.money.not_enough())
				end
			end
		end
	end
	
	vRP.EXT.GUI:registerMenuBuilder("pg.vehicles", function(menu)
		menu.title = self.lang.titles.sub()
		menu.css.header_color = "rgba(0,125,200,0.75)"
		local user = menu.user
		
		for model in pairs(user:getVehicles()) do
			local veh = menu.data.vehicles[model]
			if veh then
				menu:addOption(veh[1], m_sub, veh[2], model)
			end
		end
	end)
end

local function menu_pg(self)
	
	local function m_owned(menu)
		local smenu = menu.user:openMenu("pg.vehicles", menu.data)

		menu:listen("remove", function(menu)
			menu.user:closeMenu(smenu)
		end)
	end
  
	local function m_store(menu)
		local user = menu.user
		
		local model = vRP.EXT.Garage.remote.getNearestOwnedVehicle(user.source, 15)
		if model then
			if menu.data.vehicles[model] then -- model in this garage

				local vstate = user:getVehicleState(model)
				local state = {
					customization = vstate.customization,
					condition = vstate.condition,
					locked = vstate.locked
				}
				
				vRP.EXT.Garage.remote._removeOutVehicles(user.source, {[model] = {true, state, vstate.position, vstate.rotation}})

				if vRP.EXT.Garage.remote.despawnVehicle(user.source, model, state) then
					local vehicles = user:getVehicles()
					if vehicles[model] then 
						vehicles[model] = 1 -- mark as in garage
					end
					
					local veh = menu.data.vehicles[model]
					vRP.EXT.Base.remote._notify(user.source, self.lang.store.stored({veh[1]}))
				end
			end
		else
			vRP.EXT.Base.remote._notify(user.source, self.lang.store.too_far())
		end
	end
	
	local function m_fix(menu)
		local user = menu.user
		if self.cfg.repair == true then
			vRP.EXT.Garage.remote._fixNearestVehicle(user.source,self.cfg.radius)
			vRP.EXT.Base.remote._notify(user.source, self.lang.fix.fixed({model}))
		else
			vRP.EXT.Base.remote._notify(user.source, self.lang.fix.error({model}))
		end
	end
	
	vRP.EXT.GUI:registerMenuBuilder("pg", function(menu)
		menu.title = self.lang.titles.title({menu.data.type})
		menu.css.header_color = "rgba(255,125,0,0.75)"

		menu:addOption(self.lang.titles.main(), m_owned, nil)
		menu:addOption(self.lang.titles.store(), m_store, nil)
		if self.cfg.repair == true then
			menu:addOption(self.lang.titles.repair(), m_fix, nil)
		end
	end)
end

function personalGarages:__construct()
	vRP.Extension.__construct(self)
	
	self.cfg = module("vrp_personalGarages", "cfg/cfg")
	self:log(#self.cfg.garages.." personalGarages")
	
	self.models = {} -- map of all garage defined models

	-- register models
	for gtype, vehicles in pairs(self.cfg.garage_types) do
		for model in pairs(vehicles) do
			self.models[model] = true
		end
	end
  
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_personalGarages", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
	menu_pg(self)
	menu_pg_vehicles(self)
	
end

personalGarages.event = {}

function personalGarages.event:playerSpawn(user, first_spawn)
	if first_spawn then
	
		for k, v in pairs(self.cfg.garages) do
			local ptype, x, y, z = table.unpack(v)
			local group = self.cfg.garage_types[ptype]

			if group then
				local gcfg = group._config
				
				local menu
				local function enter(user)
					menu = user:openMenu("pg", {type = gtype, vehicles = group})
				end
				
				-- leave
				local function leave(user)
					if menu then
						user:closeMenu(menu)
					end
				end
				
				local ment = clone(gcfg.map_entity)
				ment[2].title = self.lang.titles.title()
				ment[2].pos = {x,y,z-1}
				vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])

				user:setArea("vRP:Person Garage:"..k,x,y,z,1,1.5,enter,leave)
			end
		end
	end
end

vRP:registerExtension(personalGarages)
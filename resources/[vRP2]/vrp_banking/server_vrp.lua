local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")

local Banking = class("Banking", vRP.Extension)
local info = {}
local h_info = {}

function Banking:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_banking", "cfg/cfg")
	
	self:log(#self.cfg.banks.." banks")
	self:log(#self.cfg.atms.." atms")
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_banking", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
end
--################################################
--              CLIENT HANDLERS                 
--################################################
--============= Deposit ==================
RegisterServerEvent('Banking:deposit')
AddEventHandler('Banking:deposit', function(source, amountd)
	vRP:triggerEvent("deposit", source, amountd)
end)
--============= Withdraw ====================
RegisterServerEvent('Banking:withdraw')
AddEventHandler('Banking:withdraw', function(source, amountw)
	vRP:triggerEvent("withdraw", source, amountw)
end)
--============= Balance =====================
RegisterServerEvent('Banking:balance')
AddEventHandler('Banking:balance', function()
	vRP:triggerEvent("balance")
end)
--============= Transfer =====================
RegisterServerEvent('Banking:transfer')
AddEventHandler('Banking:transfer', function(to, amountt)
	vRP:triggerEvent("transfer", to, amountt)
end)

--################################################
--              SERVER EVENTS                 
--################################################
Banking.event = {}
--============= Player Spawn/Map =====================
function Banking.event:playerSpawn(user, first_spawn)
	if first_spawn then
		for k,v in pairs(self.cfg.atms) do
			local x,y,z = table.unpack(v)
		
			local function enter(user)
				local in_vehicle = vRP.EXT.Garage.remote.isInVehicle(user.source)
				if in_vehicle then
					vRP.EXT.Base.remote._notify(user.source, self.lang.main.veh.error())
				else
					vRP:triggerEvent("startHoliday")
					TriggerClientEvent('Banking:openAtm', source)
				end
			end
			
			local function leave(user)
				vRP:triggerEvent("stopHoliday")
				TriggerClientEvent('Banking:closeUI', source)
			end
			
			local ment = clone(self.cfg.atm_map_entity)
			ment[2].title = self.lang.main.atm.title()
			ment[2].pos = {x,y,z-1}
			vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])

			user:setArea("vRP:ATM:"..k,x,y,z,1,1.5,enter,leave)
		end
		
		for k,v in pairs(self.cfg.banks) do
			local x,y,z = table.unpack(v)
			
			local function enter(user)
				vRP:triggerEvent("startHoliday")
				TriggerClientEvent('Banking:openBank', source)
			end
			
			local function leave(user)
				vRP:triggerEvent("stopHoliday")
				TriggerClientEvent('Banking:closeUI', source)
			end
			
			local ment1 = clone(self.cfg.bank_map_entity)
			ment1[2].title = self.lang.main.bank.title()
			ment1[2].pos = {x,y,z-1}
			vRP.EXT.Map.remote._addEntity(user.source, ment1[1], ment1[2])

			user:setArea("vRP:Bank:"..k,x,y,z,1,1.5,enter,leave)
		end
	end
end
--============= Deposit ==================
function Banking.event:deposit(amountd)
	local user = vRP.users_by_source[source]
	
	if user ~= nil then
		amount = tonumber(amountd)
		local wallet = user:getWallet()
		if amount == nil or amount <= 0 or amount > wallet then
			vRP.EXT.Base.remote._notify(user.source,self.lang.error.invalid_value())
		else
			if user:tryPayment(amount) then
				user:giveBank(amount)
				vRP.EXT.Base.remote._notify(user.source,self.lang.atm.deposit({amount}))
			else
				vRP.EXT.Base.remote._notify(user.source,self.lang.atm.w_not_enough())
			end
		end
	end
end
--============= Withdraw ====================
function Banking.event:withdraw(amountw)
	local user = vRP.users_by_source[source]
	local balance = user:getBank()
	if user ~= nil then
		amount = tonumber(amountw)
		local bank = user:getBank()
		if amount == nil or amount <= 0 or amount > bank then
			vRP.EXT.Base.remote._notify(user.source,self.lang.error.invalid_value())
		else
			if user:tryWithdraw(amount) then
				vRP.EXT.Base.remote._notify(user.source,self.lang.atm.withdraw({amount}))
			else
				vRP.EXT.Base.remote._notify(user.source,self.lang.atm.b_not_enough())
			end
		end
	end
end
--============= Balance =====================
function Banking.event:balance()
	local user = vRP.users_by_source[source]

	if user ~= nil then
		local identity = vRP.EXT.Identity:getIdentity(user.cid)
		local firstName = identity.firstname
		local lastName = identity.name
		local content = ""
		
		info.name = content..""..firstName.." "..lastName..""
		info.balance = user:getBank()
		
		TriggerClientEvent('Banking:Bal', source, info)
	end
end
--============= Transfer =====================
function Banking.event:transfer(to, amountt)
	local user = vRP.users_by_source[source]
	local tuser = vRP.users_by_source[target_id]
	if tuser ~= nil then
		balance = user:getBank()
		target_balance = tuser:getBank()

		if tonumber(user_id) == tonumber(target_id) then
			vRP.EXT.Base.remote._notify(user.source,self.lang.transfer.error())
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				vRP.EXT.Base.remote._notify(user.source,self.lang.transfer.not_enough())
			else
				local user_bank = user:getBank()
				user_bank = user_bank - amountt
				user:takeBank(amountt)

				local target_bank = user:getBank(target_id)
				target_bank = target_bank + amountt
				tuser.giveBank(amountt)
				vRP.EXT.Base.remote._notify(user.source,self.lang.transfer.sent({amountt, tuser.source}))
				vRP.EXT.Base.remote._notify(tuser.source,self.lang.transfer.recieved({amountt, user.source}))
			end

		end
	else
		vRP.EXT.Base.remote._notify(user.source,self.lang.transfer.no_player())
	end
end

--============= Holiday =====================
function Banking.event:startHoliday()
	if self.cfg.snow then
		TriggerClientEvent('Banking:startHoliday', source)
	end
end

function Banking.event:stopHoliday()
	TriggerClientEvent('Banking:stopHoliday', source)
end

vRP:registerExtension(Banking)

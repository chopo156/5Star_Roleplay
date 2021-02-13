local Items = {['Vehicle'] = {['Native'] = {}, ['Mod'] = {}}, ['Trailer'] = {['Native'] = {}, ['Mod'] = {}}}
local Menupool = MenuPool.New()
local MainMenu = UIMenu.New(GetLabelText('VEH_LIVERY'):gsub('%(', ''):gsub('%)', ''), '~b~' .. GetLabelText('collision_3esfcr'))
local TrailerMenu, MenuExists, Vehicle, GotTrailer, TrailerHandle, DeletingMenu
local Vehicle = 0; GotTrailer = false; TrailerHandle = 0;
Menupool:Add(MainMenu)

-- Actual Menu [

local IsAdmin

RegisterNetEvent('VLM:AdminStatusChecked')
AddEventHandler('VLM:AdminStatusChecked', function(State) --Just Don't Edit!
	IsAdmin = State
end)


Citizen.CreateThread(function() --Controls
	VLM.CheckStuff()

	while true do
		Citizen.Wait(0)

		if not DeletingMenu then
			Menupool:ProcessMenus()
		end
		
		local IsInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)

		if (GetIsControlJustPressed(VLM.KBKey) and GetLastInputMethod(2)) and ((VLM.OnlyForAdmins and IsAdmin) or not VLM.OnlyForAdmins) and MenuExists then
			MainMenu:Visible(not MainMenu:Visible())
		end
		
		local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local Got, Handle = GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
		
		if IsInVehicle and not MenuExists then
			Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			VLM.CreateMenu(Got, Handle)
		elseif MenuExists and (not IsInVehicle or (TrailerMenu and not Got) or Handle ~= TrailerHandle or Vehicle ~= CurrentVehicle) then
			VLM.DeleteMenu()
		end
	end
end)

-- ] Actual Menu

-- Functions [

function VLM.CreateMenu(Got, Handle)
	GotTrailer = Got
	TrailerHandle = Handle
	
	SetVehicleModKit(Vehicle, 0)

	-- Vehicle Liveries
			for LiveryID = 0, GetVehicleLiveryCount(Vehicle) - 1 do
				local Item = UIMenuItem.New(GetLabelText(GetLiveryName(Vehicle, LiveryID)), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText(GetLiveryName(Vehicle, LiveryID)))
				MainMenu:AddItem(Item)
				Items.Vehicle.Native[LiveryID] = Item
			end

			for LiveryID = 0, GetNumVehicleMods(Vehicle, 48) - 1 do
				if LiveryID == 0 then
					local Item = UIMenuItem.New(GetLabelText('NONE'), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText('NONE'))
					MainMenu:AddItem(Item)
					Items.Vehicle.Mod[-1] = Item
				end
				local Item = UIMenuItem.New(GetLabelText(GetModTextLabel(Vehicle, 48, LiveryID)), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText(GetModTextLabel(Vehicle, 48, LiveryID)))
				MainMenu:AddItem(Item)
				Items.Vehicle.Mod[LiveryID] = Item
			end

			MainMenu.OnItemSelect = function(Sender, Item, Index)
				for Key, Value in pairs(Items.Vehicle.Native) do
					if Item == Value then
						SetVehicleLivery(Vehicle, Key)
					end
				end
				for Key, Value in pairs(Items.Vehicle.Mod) do
					if Item == Value then
						SetVehicleMod(Vehicle, 48, Key, false)
					end
				end
			end
			
	-- Trailer Liveries
			if GotTrailer then
				SetVehicleModKit(TrailerHandle, 0)

				for LiveryID = 0, GetVehicleLiveryCount(TrailerHandle) - 1 do
					if not TrailerMenu then
						TrailerMenu = Menupool:AddSubMenu(MainMenu, GetLabelText('TRAILER'), '~b~' .. GetLabelText('collision_3esfcr') .. ' - ' .. GetLabelText('TRAILER'))
					end
					
					local Item = UIMenuItem.New(GetLabelText(GetLiveryName(TrailerHandle, LiveryID)), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText(GetLiveryName(TrailerHandle, LiveryID)))
					TrailerMenu:AddItem(Item)
					Items.Trailer.Native[LiveryID] = Item
				end
				
				for LiveryID = 0, GetNumVehicleMods(TrailerHandle, 48) - 1 do
					if not TrailerMenu then
						TrailerMenu = Menupool:AddSubMenu(MainMenu, GetLabelText('TRAILER'), '~b~' .. GetLabelText('collision_3esfcr') .. ' - ' .. GetLabelText('TRAILER'))
					end
					
					if LiveryID == 0 then
						local Item = UIMenuItem.New(GetLabelText('NONE'), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText('NONE'))
						TrailerMenu:AddItem(Item)
						Items.Trailer.Mod[-1] = Item
					end
					
					local Item = UIMenuItem.New(GetLabelText(GetModTextLabel(TrailerHandle, 48, LiveryID)), GetLabelText('collision_wcy30') .. ' ' .. GetLabelText(GetModTextLabel(TrailerHandle, 48, LiveryID)))
					TrailerMenu:AddItem(Item)
					Items.Trailer.Mod[LiveryID] = Item
				end
				
				if TrailerMenu then
					TrailerMenu.OnItemSelect = function(Sender, Item, Index)
						if GetVehicleLiveryCount(TrailerHandle) > 0 then
							for Key, Value in pairs(Items.Trailer.Native) do
								if Item == Value then
									SetVehicleMod(TrailerHandle, 48, Key, false)
								end
							end
						end
						if GetNumVehicleMods(TrailerHandle, 48) > 0 then
							for Key, Value in pairs(Items.Trailer.Mod) do
								if Item == Value then
									SetVehicleMod(TrailerHandle, 48, Key, false)
								end
							end
						end
					end
				end
			end
			
	if GetVehicleLiveryCount(Vehicle) > 0 or GetNumVehicleMods(Vehicle, 48) > 0 or GetVehicleLiveryCount(TrailerHandle) > 0 or GetNumVehicleMods(TrailerHandle, 48) > 0 then
		Menupool:RefreshIndex()
		MenuExists = true
	end
end

function VLM.DeleteMenu()
	DeletingMenu = true
	Vehicle = 0
	GotTrailer = false
	TrailerHandle = 0
	Items = {['Vehicle'] = {['Native'] = {}, ['Mod'] = {}}, ['Trailer'] = {['Native'] = {}, ['Mod'] = {}}}
	
	Menupool = MenuPool.New()
	MainMenu = UIMenu.New(GetLabelText('VEH_LIVERY'):gsub('%(', ''):gsub('%)', ''), '~b~' .. GetLabelText('collision_3esfcr'))
	Menupool:Add(MainMenu)
	MenuExists = false
	DeletingMenu = false
end

function VLM.CheckStuff()
	IsAdmin = nil
	if VLM.OnlyForAdmins then
		TriggerServerEvent('VLM:CheckAdminStatus')
		while (IsAdmin == nil) do
			Citizen.Wait(0)
		end
	end
end

function GetIsControlPressed(Control)
	if IsControlPressed(1, Control) or IsDisabledControlPressed(1, Control) then
		return true
	end
	return false
end

function GetIsControlJustPressed(Control)
	if IsControlJustPressed(1, Control) or IsDisabledControlJustPressed(1, Control) then
		return true
	end
	return false
end


local Functions = class("Functions", vRP.Extension)

-- MOVEMENT CLIPSET
function Functions:playMovement(clipset,blur,drunk,fade,clear)
    --request anim
    RequestAnimSet(clipset)
    while not HasAnimSetLoaded(clipset) do
      Citizen.Wait(0)
    end
    -- fade out
    if fade then
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
    end
    -- clear tasks
    if clear then
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    -- set timecycle
    SetTimecycleModifier("spectator5")
    -- set blur
    if blur then 
      SetPedMotionBlur(GetPlayerPed(-1), true) 
    end
    -- set movement
    SetPedMovementClipset(GetPlayerPed(-1), clipset, true)
    -- set drunk
    if drunk then
      SetPedIsDrunk(GetPlayerPed(-1), true)
    end
    -- fade in
    if fade then
      DoScreenFadeIn(1000)
    end
end

-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function Functions:playScreenEffect(name, duration)
    if duration < 0 then -- loop
        StartScreenEffect(name, 0, true)
    else
        StartScreenEffect(name, 0, true)
  
        Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
            Citizen.Wait(math.floor((duration+1)*1000))
            StopScreenEffect(name)
        end)
    end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function Functions:stopScreenEffect(name)
  StopScreenEffect(name)
end

function Functions:playerSpeed(speed)
    self.speed = not self.speed
    self.playerspeed = speed
end

function Functions:resetMovement(fade)
    -- fade
    if fade then
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      DoScreenFadeIn(1000)
    end
    -- reset all
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
end

--LOCK PICK MENU
function Functions:lockpickVehicle(wait,any)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    if DoesEntityExist(vehicleHandle) then
        if GetVehicleDoorsLockedForPlayer(vehicleHandle,PlayerId()) or any then
            local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)
            if(IsEntityAnObject(prevObj)) then
                SetEntityAsMissionEntity(prevObj)
                DeleteObject(prevObj)
            end
            self.remote._takePick()
            StartVehicleAlarm(vehicleHandle)
            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)

            Citizen.Wait(wait*1000)
            SetVehicleDoorsLocked(vehicleHandle, 1)
            for i = 1,64 do 
                SetVehicleDoorsLockedForPlayer(vehicleHandle, GetPlayerFromServerId(i), false)
            end 
            ClearPedTasksImmediately(GetPlayerPed(-1))
        
            vRP.EXT.Base:notify("Success") 
        
        else
            vRP.EXT.Base:notify("Unlocked") 
        end
    else
        vRP.EXT.Base:notify("Not close enough") 
    end
end

--rp radio exports police on and off duty
function Functions:onDuty()
  exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4)
end

function Functions:offDuty()
  exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 4)
end

function Functions:getVehicleInDirection( coordFrom, coordTo )
  local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
  local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
  return vehicle
end

function Functions:getNearestVehicle(radius)
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  local ped = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ped) then
    return GetVehiclePedIsIn(ped, true)
  else
    -- flags used:
    --- 8192: boat
    --- 4096: helicos
    --- 4,2,1: cars (with police)

    local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+5.0001, 0, 8192+4096+4+2+1)  -- boats, helicos
    if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+5.0001, 0, 4+2+1) end -- cars
    return veh
  end
end

function Functions:deleteVehicleInFrontOrInside(offset)
  local ped = GetPlayerPed(-1)
  local veh = nil
  if (IsPedSittingInAnyVehicle(ped)) then 
    veh = GetVehiclePedIsIn(ped, false)
  else
    veh = self:getVehicleInDirection(GetEntityCoords(ped, 1), GetOffsetFromEntityInWorldCoords(ped, 0.0, offset, 0.0))
  end
  
  if IsEntityAVehicle(veh) then
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    vRP.EXT.Base:notify("Success")
  else
    vRP.EXT.Base:notify("Too far")
  end
end

function Functions:deleteNearestVehicle(radius)
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  local veh = self:getNearestVehicle(radius)
  
  if IsEntityAVehicle(veh) then
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    vRP.EXT.Base:notify("Success")
  else
    vRP.EXT.Base:notify("Too far")
  end
end

function Functions:spawnVehicle(model) 
    local i = 0
    local mhash = GetHashKey(model)
    while not HasModelLoaded(mhash) and i < 1000 do
	  if math.fmod(i,100) == 0 then
	    vRP.EXT.Base:notify("loading") -- lang.spawnveh.invalid()
	  end
      RequestModel(mhash)
      Citizen.Wait(30)
	  i = i + 1
    end

    -- spawn car if model is loaded
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.EXT.Base:getPosition()
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  
	  SetVehicleDoorsLocked(nveh, 1)
		for i = 1,64 do 
		SetVehicleDoorsLockedForPlayer(nveh, GetPlayerFromServerId(i), false)
	end 
	  
      SetModelAsNoLongerNeeded(mhash)
	  vRP.EXT.Base:notify("Success") -- lang.spawnveh.invalid()
	else
	  vRP.EXT.Base:notify("invalid") -- lang.spawnveh.invalid()
	end
end

function Functions:isPlayerNearModel(model,radius)
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  local v = GetClosestVehicle( x+0.0001, y+0.0001, z+0.0001,radius+0.0001,GetHashKey(model),70)
  if IsVehicleModel(v, GetHashKey(model)) then
	  return true
  else
    return false
  end
end  

function Functions:IsPedInAnyHeli()
  if IsPedInAnyHeli(GetPlayerPed(-1)) then
	  return true
  else
    return false
  end
end

function Functions:IsPedInAnyPlane()
  if IsPedInAnyPlane(GetPlayerPed(-1)) then
	  return true
  else
    return false
  end
end

function Functions:freezePed(flag)
  FreezeEntityPosition(GetPlayerPed(-1),flag)
end

function Functions:pedVisiblity(flag)
  SetEntityVisible(GetPlayerPed(-1),flag)
end

function Functions:lockPedVehicle(flag)
  SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end

function Functions:freezePedVehicle(flag)
  FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1),false),flag)
end

function Functions:isPlayerInVehicleModel(model)
  if (IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey(model))) then -- just a function you can use to see if your player is in a taxi or any other car model (use the tunnel)
    return true
  else
    return false
  end
end

function Functions:isInAnyVehicle()
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
	  return true
  else
    return false
  end
end

function Functions:DoAcid()
  exports["acidtrip"]:DoAcid(600000)
end

Functions.tunnel = {}

Functions.tunnel.playMovement = Functions.playMovement
Functions.tunnel.playScreenEffect = Functions.playScreenEffect
Functions.tunnel.stopScreenEffect = Functions.stopScreenEffect
Functions.tunnel.playerSpeed = Functions.playerSpeed
Functions.tunnel.resetMovement = Functions.resetMovement
Functions.tunnel.lockpickVehicle = Functions.lockpickVehicle
Functions.tunnel.onDuty = Functions.onDuty
Functions.tunnel.offDuty = Functions.offDuty

Functions.tunnel.getVehicleInDirection = Functions.getVehicleInDirection
Functions.tunnel.getNearestVehicle = Functions.getNearestVehicle
Functions.tunnel.deleteVehicleInFrontOrInside = Functions.deleteVehicleInFrontOrInside
Functions.tunnel.deleteNearestVehicle = Functions.deleteNearestVehicle
Functions.tunnel.spawnVehicle = Functions.spawnVehicle
Functions.tunnel.isPlayerNearModel = Functions.isPlayerNearModel
Functions.tunnel.IsPedInAnyHeli = Functions.IsPedInAnyHeli
Functions.tunnel.IsPedInAnyPlane = Functions.IsPedInAnyPlane
Functions.tunnel.freezePed = Functions.freezePed
Functions.tunnel.pedVisiblity = Functions.pedVisiblity
Functions.tunnel.lockPedVehicle = Functions.lockPedVehicle
Functions.tunnel.freezePedVehicle = Functions.freezePedVehicle
Functions.tunnel.isPlayerInVehicleModel = Functions.isPlayerInVehicleModel
Functions.tunnel.isInAnyVehicle = Functions.isInAnyVehicle
Functions.tunnel.DoAcid = Functions.DoAcid

vRP:registerExtension(Functions)	
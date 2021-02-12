function setBleedingOn(ped)

    SetEntityHealth(ped,GetEntityHealth(ped)-1)
    StartScreenEffect('RampageOut', 0, true)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
    InfoRanny("~r~You are bleeding! Get medical attention immediately!")
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    Wait(20000)
 
 end
 
 function setBleedingOff(ped)
    StopScreenEffect('RampageOut')
    SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
 end
 
 Citizen.CreateThread(function()
 while true do
 Wait(0)
 local player = GetPlayerPed(-1)
 local Health = GetEntityHealth(player)
 
  if Health <= 139  then
     setBleedingOn(player)
      
  elseif Health > 140 then
    setBleedingOff(player)
  end
 end
 end)
  
 function InfoRanny(text)
 SetNotificationTextEntry("STRING")
 AddTextComponentString(text)
 DrawNotification(false, false)
 end

--  Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)
-- 		if (GetEntityHealth(GetPlayerPed(-1)) < 139) then
-- 			RequestAnimSet("move_injured_generic")
-- 			while not HasAnimSetLoaded("move_injured_generic") do
-- 				Citizen.Wait(0)
-- 			end
-- 			SetPedMovementClipset(GetPlayerPed(-1), "move_injured_generic", 1 )
-- 		else
-- 			ResetPedMovementClipset(GetPlayerPed(-1), 0)
-- 		end
-- 	end
-- end)
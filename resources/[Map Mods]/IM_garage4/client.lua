local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

local function setupScaleform(scaleform, itemString, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
	if button ~= nil then
		Button(GetControlInstructionalButton(2, 38, true))
	end
    ButtonMessage(itemString)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local intLocG4 = vec3(-763.74, 321.74, 43.72)
local extLocG4 = vec3(-770.36, 312.67, 85.70)

function EnterGarage4 ()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), intLocG4)
	SetEntityHeading(PlayerPedId(), 0.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
end

function ExitGarage4()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), extLocG4)
	SetEntityHeading(PlayerPedId(), 180.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
end

Citizen.CreateThread(function()
	
	while true do Citizen.Wait(0)
		if Vdist(GetEntityCoords(PlayerPedId()), extLocG4) < 100.0 then
			DrawMarker(21, extLocG4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.0, 1.0, 247, 255, 28, 100, true, true, 2, false, false, false, false)
			if not IsPedInAnyVehicle(PlayerPedId(), true) then
				if Vdist(GetEntityCoords(PlayerPedId()), extLocG4) < 1.0 then
					enterForm = setupScaleform("instructional_buttons", "Enter Garage 4", 38)
					DrawScaleformMovieFullscreen(enterForm, 255, 255, 255, 255, 0)
					if IsControlJustReleased(2, 38) then
						EnterGarage4()
					end
				end
			end
		end
		if Vdist(GetEntityCoords(PlayerPedId()), intLocG4) < 50.0 then
			DrawMarker(21, intLocG4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.0, 1.0, 247, 255, 28, 100, true, true, 2, false, false, false, false)
			if not IsPedInAnyVehicle(PlayerPedId(), true) then
				if Vdist(GetEntityCoords(PlayerPedId()), intLocG4) < 1.0 then
					exitForm = setupScaleform("instructional_buttons", "Exit Garage 4", 38)
					DrawScaleformMovieFullscreen(exitForm, 255, 255, 255, 255, 0)
					if IsControlJustReleased(2, 38) then
						ExitGarage4()
					end
				end
			end
		end
	end
end)

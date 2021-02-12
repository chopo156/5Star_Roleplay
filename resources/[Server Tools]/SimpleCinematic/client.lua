--==--==--==--==--
--Info--
--==--==--==--==--
-- Simple Cinematic by Pegi 16 AKA Antwanr942
-- Feel free to edit this script as you wish however do **NOT** make a re-release without permission from yours truly
-- Enjoy!
--==--==--==--==--
--Config--
--==--==--==--==--

CinematicCamCommand = "CinematicCam" -- [[The name of the command called to toggle the cinematic cam]]

CinematicCamMaxHeight = 0.4 -- [[The height of the rects. Keep below 1 and keep as a float however I recommend you keep it as it is as this is the best height I could find]]


--DO NOT CHANGE BELOW THIS LINE--


--==--==--==--==--
--Variables--
--==--==--==--==--

CinematicCamBool = false

w = 0

--==--==--==--==--
--Command--
--==--==--==--==--

RegisterCommand(CinematicCamCommand, function()
    CinematicCamBool = not CinematicCamBool
    CinematicCamDisplay(CinematicCamBool)
end)

--==--==--==--==--
--Main Thread--
--==--==--==--==--

Citizen.CreateThread(function() -- [[Requests the minimap scaleform and actually calls the rect function allong with the hud components function.]]

    minimap = RequestScaleformMovie("minimap")

    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do 
            Wait(1)
        end
    end

    while true do
        Citizen.Wait(1)
        if w > 0 then
            DrawRects()
        end
        if CinematicCamBool then
            DESTROYHudComponents()
        end
    end
end)

--==--==--==--==--
--Functions--
--==--==--==--==--

function DESTROYHudComponents() -- [[Get rid of all active hud components.]]
    for i = 0, 22, 1 do
        if IsHudComponentActive(i) then
            HideHudComponentThisFrame(i)
        end
    end
end

function DrawRects() -- [[Draw the Black Rects]]
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

function DisplayHealthArmour(int) -- [[Thanks to GlitchDetector for this function.]]
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(int)
    EndScaleformMovieMethod()
end

function CinematicCamDisplay(bool) -- [[Handles Displaying Radar, Body Armour and the rects themselves.]]
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        DisplayRadar(false)
        DisplayHealthArmour(3)
        for i = 0, CinematicCamMaxHeight, 0.01 do 
            Wait(10)
            w = i
        end
    else
        DisplayRadar(true)
        DisplayHealthArmour(0)
        for i = CinematicCamMaxHeight, 0, -0.01 do
            Wait(10)
            w = i
        end 
    end
end    

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

--==--==--==--==--
--END :(--
--==--==--==--==--
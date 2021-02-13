
exports('GetFranklinAuntObject', function()
    return FranklinAunt2
end)

FranklinAunt2 = {
    interiorId = GetInteriorAtCoords(786.78283691406,5591.994140625,11.692055702209),
    Style = {
        empty = "", franklinStuff = "V_57_FranklinStuff", franklinLeft = "V_57_Franklin_LEFT",
        Set = function(style, refresh)
            FranklinAunt2.Style.Clear(false)
            if style ~= "" then
                SetIplPropState(FranklinAunt2.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(FranklinAunt2.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(FranklinAunt2.interiorId, {FranklinAunt2.Style.franklinStuff, FranklinAunt2.Style.franklinLeft}, true, refresh) end
    },
    Details = {
        bandana = "V_57_GangBandana",				-- Bandana on the bed
        bag = "V_57_Safari",						-- Bag in the closet
        Enable = function (details, state, refresh) SetIplPropState(FranklinAunt2.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        FranklinAunt2.Style.Set(FranklinAunt2.Style.empty)
        FranklinAunt2.Details.Enable(FranklinAunt2.Details.bandana, true)
        FranklinAunt2.Details.Enable(FranklinAunt2.Details.bag, true)
        RefreshInterior(FranklinAunt2.interiorId)
    end
}

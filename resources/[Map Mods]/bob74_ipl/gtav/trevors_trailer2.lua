
exports('GetTrevorsTrailerObject', function()
    return TrevorsTrailer2
end)

TrevorsTrailer2 = {
    interiorId = GetInteriorAtCoords(772.17030000,5568.05900000,11.03168000),
    Interior = {
        tidy = "trevorstrailertidy", trash = "TrevorsTrailerTrash",
        Set = function(interior)
            TrevorsTrailer2.Interior.Clear()
            EnableIpl(interior, true)
        end,
        Clear = function() EnableIpl({TrevorsTrailer2.Interior.tidy, TrevorsTrailer2.Interior.trash}, false) end
    },
    Details = {
        copHelmet = "V_26_Trevor_Helmet3",			-- Cop helmet in the closet
        briefcase = "V_24_Trevor_Briefcase3",		-- Briefcase in the main room
        michaelStuff = "V_26_Michael_Stay3",		-- Michael's suit hanging on the window
        Enable = function (details, state, refresh) SetIplPropState(TrevorsTrailer2.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        TrevorsTrailer2.Interior.Set(TrevorsTrailer2.Interior.trash)
        TrevorsTrailer2.Details.Enable(TrevorsTrailer2.Details.copHelmet, false, false)
        TrevorsTrailer2.Details.Enable(TrevorsTrailer2.Details.briefcase, false, false)
        TrevorsTrailer2.Details.Enable(TrevorsTrailer2.Details.michaelStuff, false, false)
        RefreshInterior(TrevorsTrailer2.interiorId)
    end
}

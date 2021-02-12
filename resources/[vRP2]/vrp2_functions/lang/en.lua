

local lang = {

	fine = {
		button = "Fine",
		perm = "police.bmfine",
		desc = "Fines a nearby player.",
		prompt = {
			amount = "Fine Value:",
			reason = "Fine Reason:",
		},
		file = "fine.lua",
		log = "{1} fined {2} for ${3} - {4}",
	},

	police = {
	  connection = "No connection... You must be near your PV to access the Network.",
      veh_searchtitle = {
        title = "Police Computer",
        description = "Access the mobile police computer."
      },	
      veh_searchreg = {
        title = "Registration search",
        description = "Search identity by registration."
      },
      veh_records = {
        title = "Record Search",
        description = "Manage police records by registration number."
	  }
	},
		
}

return lang

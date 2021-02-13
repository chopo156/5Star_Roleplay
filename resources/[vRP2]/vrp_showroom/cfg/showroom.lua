vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.1,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "Showroom",
			name = "main",
			buttons = {
				{name = "cars", description = ""},
				--{name = "suv-offroad", description = ""},
				--{name = "gang-cars", description = ""},
				--{name = "hitman", description = ""},
				--{name = "truck", description = ""},
				--{name = "thelostmc", description = ""},
				--{name = "motociclete", description = ""},
				--{name = "job", description = ""},
				--{name = "vip", description = ""},
				--{name = "dmd-cars", description = ""},
				--{name = "bikes", description = ""},
				--{name = "aviation", description = ""},
			}
		},
		["cars"] = {
			title = "cars",
			name = "cars",
			buttons = {
				{name = "Dealership", description = ''},
				--{name = "bmw", description = ''},
				--{name = "mercedesbenz", description = ''},
				--{name = "ferrari", description = ''},
				--{name = "fast-and-furios", description = ''},
				--{name = "dacia", description = ''},
				--{name = "lamborghini", description = ''},
				--{name = "Aston Martin", description = ''},
				--{name = "Porche", description = ''},
				--{name = "Toyota", description = ''},
				--{name = "cars5", description = ''},
				--{name = "altele", description = ''},
				--{name = "cycles", description = ''},
			}
		},
		["Dealership"] = {
			title = "Dealership",
			name = "Dealership",
			buttons = {
				{name = "minivan", costs = 500, speed = 40, acce = 50, brake = 60, trac = 30, description = {}, model = "minivan2"},
				{name = "mamba", costs = 6000, speed = 45, acce = 60, brake = 60, trac = 40, description = {}, model = "mamba"},
				{name = "Impaler", costs = 5345, speed = 40, acce = 30, brake = 50, trac = 30, description = {}, model = "Impaler"},
			}
		},
		
	}
}

return vehshop
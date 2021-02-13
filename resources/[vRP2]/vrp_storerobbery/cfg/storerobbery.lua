--[[
ROBBERY FORMAT:
	["id"] = { 
	  name = "Name",
	  pos = {x, y, z}, 
	  dist = radius, rob = seconds,	wait = seconds,	cops = minimum, stars = wanted, min = min_reward, max = max_reward
	},
	- id: unique id of the robbery used to identify it in the code
	- name: name of the robbery that will go on chat
	- pos: x, y, z - the pos of the robbery
	- dist: how far you can get from the robbery
	- rob: time in seconds to rob
	- wait: time in seconds to wait before it can be robbed again
	- cops: minimum amount of cops online necessary to rob
	- stars: stars aquired for robbing
	- min: minimum amount it can give as a reward
	- max: maximum amount it can give as a reward
]]
cfg = {}
cfg.lang = "en" -- set your lang (file must exist on cfg/lang)
cfg.key = 38 -- INPUT_RELOAD
cfg.cops = "police.menu"	 -- permission given to cops

cfg.storerobbery = { -- list of robberies
	["Lindsay Circus"] = { 
	 _config = {x = -705.94110107422, y = -915.48120117188, z = 18.215589523315, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Lindsay Circus LTD Gas Station", 
	  pos = {-705.94110107422, -915.48120117188, 18.215589523315}, 
	  dist = 15.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000 --100-200
	},
	["Prosperity St"] = { 
 	_config = {x = -1487.1322021484, y = -375.54638671875, z = 39.163433074951, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Prosperity St Robs Liquor", 
	  pos = {-1487.1322021484, -375.54638671875, 39.163433074951}, 
	  dist = 15.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Barbareno Road Great Ocean"] = { 
 	_config = {x = -3241.7280273438, y = 999.95611572266, z = 11.830716133118, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Barbareno Road(Great Ocean) 24/7 Supermarket", 
	  pos = {-3241.7280273438, 999.95611572266, 11.830716133118}, 
	  dist = 15.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["North Rockford Dr"] = { 
 	_config = {x = -1828.9028320313, y = 798.63702392578, z = 137.18780517578, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "North Rockford Dr LTD Gas Station", 
	  pos = {-1828.9028320313, 798.63702392578, 137.18780517578}, 
	  dist = 15.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Great Ocean Hway East"] = { 
 	_config = {x = 1727.6282958984, y = 6414.7607421875, z = 34.037220001221, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Great Ocean Hway East 24/7 Supermarket", 
	  pos = {1727.6282958984, 6414.7607421875, 34.037220001221}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Alhambra Dr Sandy"] = { 
 	_config = {x = 1960.3529052734, y = 3739.4997558594, z = 31.343742370605, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Alhambra Dr Sandy 24/7 Supermarket", 
	  pos = {1960.3529052734, 3739.4997558594, 31.343742370605}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Palomino Fwy Reststop"] = { 
 	_config = {x = 2549.2858886719, y = 384.96740722656, z = 107.62294769287, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Palomino Fwy Reststop 24/7 Supermarket", 
	  pos = {2549.2858886719, 384.96740722656, 107.62294769287}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Clinton Ave"] = { 
 	_config = {x = 372.36227416992, y = 325.90933227539, z = 102.56638336182, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Clinton Ave 24/7 Supermarket", 
	  pos = {372.36227416992, 325.90933227539, 102.56638336182}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Grove St/Davis St"] = { 
 	_config = {x = -47.860702514648, y = -1759.3477783203, z = 28.421016693115, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Grove St/Davis St LTD Gas Station", 
	  pos = {-47.860702514648, -1759.3477783203, 28.421016693115}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Innocence Blvd"] = { 
 	_config = {x = 24.360492706299, y = -1347.8098144531, z = 28.497026443481, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Innocence Blvd 24/7 Supermarket", 
	  pos = {24.360492706299, -1347.8098144531, 28.497026443481}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["San Andreas Ave"] = { 
 	_config = {x = -1220.7747802734, y = -915.93646240234, z = 10.326335906982, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "San Andreas Ave Robs Liquor", 
	  pos = {-1220.7747802734, -915.93646240234, 10.326335906982}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Route 68 Outside Sandy"] = { 
 	_config = {x = 1169.2320556641, y = 2717.8083496094, z = 36.157665252686, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Route 68 Outside Sandy 24/7 Supermarket", 
	  pos = {1169.2320556641, 2717.8083496094, 36.157665252686}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Great Ocean Hway"] = { 
 	_config = {x = -2959.6359863281, y = 387.15356445313, z = 13.043292999268, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Great Ocean Hway Robs Liquor", 
	  pos = {-2959.6359863281, 387.15356445313, 13.043292999268}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Inseno Rd Great Ocean"] = { 
 	_config = {x = -3038.9475097656, y = 584.53924560547, z = 6.9089307785034, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Inseno Rd Great Ocean 24/7 Supermarket", 
	  pos = {-3038.9475097656, 584.53924560547, 6.9089307785034}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Grapeseed Main St"] = { 
 	_config = {x = 1707.8717041016, y = 4920.2475585938, z = 41.063678741455, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Grapeseed Main St 24/7 Supermarket", 
	  pos = {1707.8717041016, 4920.2475585938, 41.063678741455}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Algonquin Blvd"] = { 
 	_config = {x = 1392.9791259766, y = 3606.5573730469, z = 33.980918884277, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Algonquin Blvd Ace Liquors", 
	  pos = {1392.9791259766, 3606.5573730469, 33.980918884277}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Panorama Dr"] = { 
 	_config = {x = 1982.5057373047, y = 3053.4697265625, z = 46.215065002441, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Panorama Dr Yellow Jack Inn", 
	  pos = {1982.5057373047, 3053.4697265625, 46.215065002441}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Senora Fwy Sandy"] = { 
 	_config = {x = 2678.1394042969, y = 3279.3344726563, z = 54.241130828857, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Senora Fwy Sandy 24/7 Supermarket", 
	  pos = {2678.1394042969, 3279.3344726563, 54.241130828857}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["Mirror Park Blvd"] = { 
 	_config = {x = 1159.5697021484, y = -314.11761474609, z = 68.205139160156, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "Mirror Park Blvd LTD Gas Station", 
	  pos = {1159.5697021484, -314.11761474609, 68.205139160156}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	},
	["El Rancho Blvd"] = { 
 	_config = {x = 1134.2387695313, y = -982.76049804688, z = 45.415843963623, map_entity = {"PoI", {blip_id = 466, blip_color = 1, marker_id = 1, scale = {1.0,1.0,1.0},color={255, 0, 0,125}}}},
	  name = "El Rancho Blvd Robs Liquor", 
	  pos = {1134.2387695313, -982.76049804688, 45.415843963623}, 
	  dist = 30.0, rob = 360, wait = 2700, cops = 1, min = 10000, max = 16000
	}
}


return cfg


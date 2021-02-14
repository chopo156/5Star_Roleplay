
local cfg = {}

-- exp notes:
-- levels are defined by the amount of xp
-- with a step of 5: 5|15|30|50|75 (by default)
-- total exp for a specific level, exp = step*lvl*(lvl+1)/2
-- level for a specific exp amount, lvl = (sqrt(1+8*exp/step)-1)/2

-- define groups of aptitudes
--- _title: title of the group
--- map of aptitude => {title,init_exp,max_exp}
---- max_exp: -1 for infinite exp
cfg.gaptitudes = {
  ["physical"] = {
    _title = "Physical",
    ["strength"] = {"Strength", 30, 275}, -- required, level 3 to 10 (by default, can carry 10kg per level)
    ["nicotine_addiction"] = {"Nicotine Dependence", 0, 6375},
    ["alcohol_addiction"] = {"Alcohol Dependence", 0, 6375},
    ["cocaine_addiction"] = {"Cocaine Dependence", 0, 6375},
    ["methamphetamine_addiction"] = {"Meth Dependence", 0, 6375},
    ["cardio"] = {"Cardio", 0, 275},
  },
  ["science"] = {
    _title = "Science",
    ["chemicals"] = {"Chemistry", 0, 6375},
    ["mathematics"] = {"Mathematics", 0, 6375},
  },
  ["generic"] = {
    _title = "Generic",
    ["cooking"] = {"Cooking", 0, 6375},
    ["farming"] = {"Farming", 0, 6375},
    ["mixology"] = {"Mixology", 0, 6375},
  },
  ["job"] = {
    _title = "Job",
    ["bus"] = {"Bus Driver", 0, 1050},
    ["taxi"] = {"Taxi Driver", 0, 1050},
    ["truck"] = {"Truck Driver", 0, 1050},
    ["police"] = {"Law Enforcement", 0, 275},
    ["ems"] = {"Fire Department", 0, 30},
  },
  ["criminal"] = {
    _title = "Criminal",
    ["hacking"] = {"Hacking", 0, 6375},
    -- ["money"] = {"Money Laundry", 0, 6375},
    ["gunsmith"] = {"Gunsmithing", 0, 6375},
    ["locksmith"] = {"Lockpicking", 0, 6375}
  },
}

cfg.lose_aptitudes_on_death = false

return cfg

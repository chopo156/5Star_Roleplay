
local cfg = {}

-- {ent,cfg} will fill cfg.pos, cfg.title
cfg.pc_map_entity = {"PoI", {marker_id = 1}}

-- PCs positions
cfg.pcs = {
  {459.79330444336,-988.86315917969,24.914716720581}, --Mission Row PD
  {441.9267578125,-978.76965332031,30.689336776733}, --Mission Row PD
  {-434.43103027344,5997.0390625,31.716194152832}, --Paleto SO
  {-449.66744995117,6012.3471679688,31.716329574585}, --Paleto SO
}

-- vehicle tracking configuration
cfg.trackveh = {
  min_time = 300, -- min time in seconds
  max_time = 600, -- max time in seconds
  service = "911" -- service to alert when the tracking is successful
}

-- wanted display
-- map_entity: {ent,cfg} will fill cfg.player (server id), cfg.title
cfg.wanted = {
  map_entity = {"PlayerMark", {blip_id = 458, blip_color = 38}},
  service = "911"
}

-- illegal items (seize)
-- specify list of "idname" or "*idname" to seize all parametric items
cfg.seizable_items = {
  "dirty_money",
  "weed",
  "*wbody",
  "*wammo",
  "stolen_credit",
  "bank_money",
  "weed_processed",
  "edible|meth",
  "edible|cocaine",
  "methpipe",
  "lockpick",
  "upperR",
  "lowerR",
}

-- jails {x,y,z,radius}
cfg.jails = {
  {459.485870361328,-1001.61560058594,24.914867401123,2.1},
  {459.305603027344,-997.873718261719,24.914867401123,2.1},
  {459.999938964844,-994.331298828125,24.9148578643799,1.6}
}

-- fines
-- map of name -> money
cfg.fines = {
  ["Insult"] = 100,
  ["Speeding"] = 250,
  ["Stealing"] = 1000,
  ["Organized crime (low)"] = 10000,
  ["Organized crime (medium)"] = 25000,
  ["Organized crime (high)"] = 50000
}

return cfg

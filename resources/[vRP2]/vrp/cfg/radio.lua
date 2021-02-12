
local cfg = {}

cfg.on_sound = "sounds/radio_on.ogg" 
cfg.off_sound = "sounds/radio_off.ogg" 

-- radio voice config (see Audio:registerVoiceChannel)
cfg.radio_voice = {
  effects = {
    biquad = { type = "bandpass", frequency = 1700, Q = 2},
    gain = { gain = 2}
  }
}

-- list of list of groups (each list define a channel of speaker/listener groups, an ensemble)
cfg.channels = {
  { --police/fire/tow
    "cadet",
    "police1",
    "police2",
    "lspd_corporal",
    "lspd_sgt",
    "lspd_lt",
    "lspd_cpt",
    "lspd_ltmjr",
    "lspd_mjr",
    "lspd_cmdr",
    "lspd_asscheif",
    "lspd_cheif",
    "cadet2",
    "deputy1",
    "deputy2",
    "lssd_corporal",
    "lssd_sgt",
    "lssd_lt",
    "lssd_cpt",
    "lssd_ltmjr",
    "lssd_mjr",
    "lssd_cmdr",
    "lspd_undersheriff",
    "lssd_sheriff",
    "cadet3",
    "trooper",
    "trooper2",
    "sahp_corporal",
    "sahp_sgt",
    "sahp_lt",
    "sahp_cpt",
    "sahp_ltmjr",
    "sahp_mjr",
    "sahp_cmdr",
    "sahp_depdirector",
    "sahp_director",
  }
}

-- radio additional CSS
cfg.css = [[
.radio_display > div[data-group="police"] > .group{
  color: #1971ff;
}

.radio_display > div[data-group="police"]{
  background-image: linear-gradient(to bottom, rgb(25, 58, 112, 0.75), rgba(0,0,0,0.75));
}
]]

-- map entities used to display player radio GPS signal per group
-- map of group => map_entity (with PlayerMark behavior)
--- map_entity: {ent, cfg} will fill cfg.player, cfg.title
-- _default: default map entity for undefined groups
cfg.group_map_entities = {
  _default = {"PlayerMark", {blip_id = 1, blip_color = 4}},
  cadet = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  police1 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  police2 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_corporal = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_sgt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_lt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_cpt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_ltmjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_mjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_cmdr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_asscheif = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_cheif = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  cadet2 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  deputy1 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  deputy2 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_corporal = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_sgt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_lt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_cpt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_ltmjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_mjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_cmdr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lspd_undersheriff = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  lssd_sheriff = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  cadet3 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  trooper = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  trooper2 = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_corporal = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_sgt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_lt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_cpt = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_ltmjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_mjr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_cmdr = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_depdirector = {"PlayerMark", {blip_id = 1, blip_color = 38}},
  sahp_director = {"PlayerMark", {blip_id = 1, blip_color = 38}},
}

return cfg

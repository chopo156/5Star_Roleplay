fx_version "adamant"

game "gta5"

description "vRP2 GHMattiMySQL db driver bridge"

dependencies{
  "vrp",
  "GHMattiMySQL"
}

-- server scripts
server_scripts{ 
  "@vrp/lib/utils.lua",
  "init.lua"
}


description 'vrp2_showroom by Palacios'

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server_vrp.lua"
}

client_scripts{ 
  "@vrp/lib/utils.lua",
  "client_vrp.lua"
}

files{
  "cfg/config.lua",
  "client.lua"
}
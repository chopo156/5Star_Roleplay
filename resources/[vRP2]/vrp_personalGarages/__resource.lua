description "vRP Sell Vehicles"

--ui_page 'cfg/html/index.html'

dependency "vrp"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server_vrp.lua"
}

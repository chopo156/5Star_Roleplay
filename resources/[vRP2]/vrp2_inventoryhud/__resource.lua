resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "vRP2 Inventory HUD" 
-- I adapted this from ESX inventory HUD, it still runs a few ESX functions and in time we will edit those out to make this a pure vRP2 script

dependencies{
  "vrp",
  "es_extended"
}

version "1.0"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "@vrp/lib/utils.lua",  
  "inventory/client.lua",
  "cfg/config.lua",
  "locales/en.lua",
}

server_scripts {
  "@es_extended/locale.lua",
  "@vrp/lib/utils.lua",
  "server_vrp.lua",
  "cfg/config.lua",
  "locales/en.lua",
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/*.png",
  "html/img/items/*.png",
}

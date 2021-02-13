fx_version "bodacious"
games { 'gta5' }

ui_page 'html/ui.html'

client_scripts {
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  'client/main.lua',
  'config.lua'
}

server_scripts {
  "@vrp/lib/utils.lua",
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'config.lua'	
}

files {
    'html/ui.html',
    'html/css/ui.css',
    'html/css/jquery-ui.css',
    'html/js/inventory.js',
    'html/js/config.js',
    -- JS LOCALES
    'html/locales/cs.js',
    'html/locales/en.js',
    'html/locales/fr.js',
    -- ICONS
    'html/img/items/*.png'
} --'html/img/items/.png',

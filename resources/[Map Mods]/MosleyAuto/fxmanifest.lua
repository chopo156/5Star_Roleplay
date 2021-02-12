fx_version 'adamant'
games { 'gta5' }

description 'Mosleys, with working carlifts'
made_by 'honeynutt, icethedev, sanhje'
discord 'https://discord.gg/FXx6Myn'

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/props.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'config.lua'
}

ui_page 'ui/index.html'

data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"

files {
	'ui/index.html',
	'ui/libraries/*.js',
	'ui/libraries/*.css',
	'ui/script.js',
	'ui/style.css',
	'ui/sounds/*.ogg',
	"interiorproxies.meta",
}

this_is_a_map 'yes'

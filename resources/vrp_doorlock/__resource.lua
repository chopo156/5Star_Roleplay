resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'vRP door lock'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

ui_page('ui/ui.html')

files {
    'ui/ui.html',
    'ui/numField.css',
	'ui/numField.js',
	'ui/numField.mp3',
	'ui/numField.png'
}

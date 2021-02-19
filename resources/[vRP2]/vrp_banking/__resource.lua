description "vrp_banking"

ui_page 'cfg/html/index.html'

dependency "vrp"

server_script { 
	"@vrp/lib/utils.lua",
	"server.lua"
}

client_script {
	'client_vrp.lua'
}

files {
	'cfg.lua',
	'cfg/html/index.html',
    'cfg/html/css/style.css',
	'cfg/html/js/listener.js',
	'cfg/html/js/config.js',
	--images
    'cfg/html/images/bg.png',
    'cfg/html/images/circle.png',
    'cfg/html/images/curve.png',
    'cfg/html/images/fingerprint.png',
    'cfg/html/images/fingerprint.jpg',
    'cfg/html/images/graph.png',
    'cfg/html/images/logo-big.png',
    'cfg/html/images/logo-top.png',
	'cfg/html/images/background.png',
	'cfg/html/images/construction.png',
	--custom image
	'cfg/html/images/boss_logo.png'
}

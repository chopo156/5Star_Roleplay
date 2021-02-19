
ui_page 'html/index.html'

files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',

	'html/static/config/config.json',
	
	-- Coque
	'html/static/img/coque/s8.png',
	'html/static/img/coque/iphonex.png',
	'html/static/img/coque/base.png',
	'html/static/img/coque/transparent.png',
	
	-- Background
	'html/static/img/background/back001.jpg',
	'html/static/img/background/back002.jpg',
	'html/static/img/background/back003.jpg',
	'html/static/img/background/back004.jpg',
	'html/static/img/background/back005.jpg',
	'html/static/img/background/back006.jpg',
	'html/static/img/background/back007.jpg',
	'html/static/img/background/back008.jpg',
	'html/static/img/background/back009.jpg',
	'html/static/img/background/back010.jpg',

	
	'html/static/img/icons_app/call.png',
	'html/static/img/icons_app/contacts.png',
	'html/static/img/icons_app/sms.png',
	'html/static/img/icons_app/settings.png',
	'html/static/img/icons_app/menu.png',
	'html/static/img/icons_app/bourse.png',
	'html/static/img/icons_app/tchat.png',
	'html/static/img/icons_app/photo.png',
	'html/static/img/icons_app/bank.png',
	'html/static/img/icons_app/policier.png',
	'html/static/img/icons_app/ambulancier.png',
	'html/static/img/icons_app/mecano.png',
	'html/static/img/icons_app/brinks.png',
	'html/static/img/icons_app/avocat.png',
	'html/static/img/icons_app/taxi.png',
	'html/static/img/icons_app/agent.png',
	'html/static/img/icons_app/army.png',
	'html/static/img/icons_app/bahama.png',
	'html/static/img/icons_app/epicerie.png',
	'html/static/img/icons_app/fib.png',
	'html/static/img/icons_app/journaliste.png',
	'html/static/img/icons_app/pilot.png',
	'html/static/img/icons_app/state.png',
	'html/static/img/icons_app/unicorn.png',
	'html/static/img/icons_app/conces.png',
	'html/static/img/icons_app/9gag.png',
	'html/static/img/icons_app/twitter.png',
	
	'html/static/img/app_bank/logo_mazebank.jpg',

	'html/static/img/app_tchat/splashtchat.png',

	'html/static/img/twitter/bird.png',
	'html/static/img/twitter/bird.svg',
	'html/static/img/twitter/default_profile.png',


	'html/static/img/courbure.png',
	'html/static/fonts/fontawesome-webfont.ttf',

	'html/static/sound/ring.ogg',
	'html/static/sound/ring2.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg',

}
description "vRP2 gcphone - FoxOak"


client_script {
	'@vrp/lib/utils.lua',
	"config.lua",
	"client/animation.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/bank.lua"
}

server_script {
  	'@vrp/lib/utils.lua',
	"config.lua",
	"vrp.lua"
}

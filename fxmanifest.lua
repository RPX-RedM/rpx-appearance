fx_version "adamant"
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'html/dist/index.html'

shared_script '@ox_lib/init.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'init.lua',
}

client_scripts {
	'init.lua',
}

files {
	'html/dist/index.html',
	'html/dist/*.png',
	'html/dist/app.js',
	'html/dist/*.eot',
	'html/dist/*.woff2',
	'html/dist/*.woff',
	'html/dist/*.ttf',

	'client/*.lua',
	'server/*.lua',
	'data/*.lua',
	'shared/*.lua',
}


lua54 'yes'

dependencies { 'rpx-core', 'ox_lib' }

use_experimental_fxv2_oal 'yes'
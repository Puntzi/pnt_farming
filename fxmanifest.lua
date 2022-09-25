fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Puntzi'
description 'Simple farming script'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
    'config.lua',
	'@ox_lib/init.lua',
}
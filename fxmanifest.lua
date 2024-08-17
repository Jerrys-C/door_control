-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Jerry'
description 'ox_doorlock remote control'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'locales/*.json',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@oxmysql/lib/MySQL.lua'
}

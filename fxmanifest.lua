fx_version 'cerulean'
game 'gta5'

description 'dc-skills'
version '1.0.0'
author 'davide.cab'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client/main.lua',

server_script 'server/main.lua',

files {
    'html/index.html',
    'html/index.js'
}

lua54 'yes'
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Jake'
description 'OB Jobs Framework'
version '1.0.0'

shared_scripts {
    'shared/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
    'client/*.lua'
}

exports {
    'RegisterJob',
    'GetJob'
}
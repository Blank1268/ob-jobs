fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Jake'
description 'OB Jobs Framework'
version '1.0.0'

shared_scripts {
    'shared/init.lua',
    'shared/config.lua',
    'shared/config/*.lua',
    'shared/constants.lua',
    'shared/logger.lua',

    'shared/core/*.lua',
    'shared/adapters/*.lua',
    'shared/classes/*.lua',
    'shared/managers/*.lua',
    'shared/services/*.lua'
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'server/dev/*.lua',
    'exports/server.lua'
}

client_scripts {
    'client/*.lua',

    'exports/client.lua'
}

server_exports {
    'RegisterJob',
    'GetJob',
    'GetJobs',
    'JobExists'
}
fx_version 'cerulean'
game 'gta5'

author 'Drewno <kontakt@drewno.me>'
description 'Simple hud for qb-core'
version '1.0.0'

ui_page 'nui/index.html'

client_script {
    'client/main.lua',
    'client/minimap.lua'
}

files {
    '*.*',
    'nui/*.*'
}


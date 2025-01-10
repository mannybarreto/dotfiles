local Config = require('config')

local config = Config:init()
    :append(require('config.appearance'))
    :append(require('config.keymaps'))
    :append(require('config.options')).options

return config

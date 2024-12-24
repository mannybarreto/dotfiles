local Config = require('config')

-- and finally, return the configuration to wezterm
return Config:init()
    :append(require('config.appearance'))
    :append(require('config.options')).options

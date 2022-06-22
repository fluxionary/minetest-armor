local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

armor = {
    modname = modname,
    modpath = modpath,
    S = minetest.get_translator(modname),

    log = function(level, messagefmt, ...)
        minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
    end,
    version = 5.0,

    last_punch_time = {},

    has = {
        bones = minetest.get_modpath("bones"),
        default = minetest.get_modpath("default"),
        fire = minetest.get_modpath("fire"),
    },
}

dofile(modpath .. "/settings.lua")
dofile(modpath .. "/api/init.lua")
dofile(modpath .. "/compat/init.lua")
dofile(modpath .. "/armor.lua")
dofile(modpath .. "/aliases.lua")

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

armor = {
    version = 5.0,
	fork = "fluxionary",

    modname = modname,
    modpath = modpath,

    S = S,

    has = {
        bones = minetest.get_modpath("bones"),
        default = minetest.get_modpath("default"),
        fire = minetest.get_modpath("fire"),
    },

    log = function(level, messagefmt, ...)
        minetest.log(level, ("[%s] %s"):format(modname, messagefmt:format(...)))
    end,

	dofile = function(...)
		return dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

armor.dofile("settings")
armor.dofile("api", "init")
armor.dofile("compat", "init")
armor.dofile("armor")
armor.dofile("aliases")

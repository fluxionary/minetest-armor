

-- Mod Compatibility

local skin_mods = {"skins", "u_skins", "simple_skins", "wardrobe"}
for _, mod in pairs(skin_mods) do
    local path = minetest.get_modpath(mod)
    if path then
        local dir_list = minetest.get_dir_list(path .. "/textures")
        for _, fn in pairs(dir_list) do
            if fn:find("_preview.png$") then
                armor.add_preview(fn)
            end
        end
        armor.set_skin_mod(mod)
    end
end

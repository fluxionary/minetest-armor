
local F = minetest.formspec_escape
local S = armor.S


armor.formspec = "image[2.5,0;2,4;armor_preview]" ..
        default.gui_bg ..
        default.gui_bg_img ..
        default.gui_slots ..
        default.get_hotbar_bg(0, 4.7) ..
        "list[current_player;main;0,4.7;8,1;]" ..
        "list[current_player;main;0,5.85;8,3;8]"


armor.formspec = armor.formspec ..
    "label[5,1;" .. F(S("Level")) .. ": armor_level]" ..
    "label[5,1.5;" .. F(S("Heal")) .. ": armor_attr_heal]"
if armor.config.fire_protect then
    armor.formspec = armor.formspec .. "label[5,2;" .. F(S("Fire")) .. ": armor_attr_fire]"
end



minetest.register_on_player_receive_fields(function(player, formname, fields)
    local name = armor:get_valid_player(player, "[on_player_receive_fields]")
    if not name then
        return
    end
    local player_name = player:get_player_name()
    for field, _ in pairs(fields) do
        if string.find(field, "skins_set") then
            armor:update_skin(player_name)
        end
    end
end)

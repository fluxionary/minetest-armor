--- Registers a new armor item.
--
--  @function armor:register_armor
--  @tparam string name Armor item technical name (ex: "3d\_armor:helmet\_gold").
--  @tparam ArmorDef def Armor definition table.
--  @usage armor:register_armor("3d_armor:helmet_wood", {
--    description = "Wood Helmet",
--    inventory_image = "3d_armor_inv_helmet_wood.png",
--    groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
--    armor_groups = {fleshy=5},
--    damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
--  })
function armor:register_armor(name, def)
    def.on_secondary_use = def.on_secondary_use or function(...) armor:equip(...) end

    def.on_place = def.on_place or function(itemstack, player, pointed_thing)
        if pointed_thing.type == "node" and player and not player:get_player_control().sneak then
            local node = minetest.get_node(pointed_thing.under)
            local def = minetest.registered_nodes[node.name]
            if def and def.on_rightclick then
                return def.on_rightclick(pointed_thing.under, node, player, itemstack, pointed_thing)
            end
        end
        return self:equip(player, itemstack)
    end

    -- The below is a very basic check to try and see if a material name exists as part
    -- of the item name. However this check is very simple and just checks theres "_something"
    -- at the end of the item name and logging an error to debug if not.
    local mat_exists = string.match(name, "%:.+_(.+)$")
    if not mat_exists then
        armor.log("warning", "Registered armor %s does not have a material specified in the name")
    end

    minetest.register_tool(name, def)
end


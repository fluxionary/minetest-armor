
--- Crystal
--
--  Requires `armor_material_crystal`.
--
--  @section crystal

if armor.materials.crystal then
    --- Crystal Helmet
    --
    --  @helmet 3d_armor:helmet_crystal
    --  @img 3d_armor_inv_helmet_crystal.png
    --  @grp armor_head 1
    --  @grp armor_heal 12
    --  @grp armor_use 100
    --  @grp armor_fire 1
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp level 3
    armor:register_armor("3d_armor:helmet_crystal", {
        description = S("Crystal Helmet"),
        inventory_image = "3d_armor_inv_helmet_crystal.png",
        groups = {armor_head = 1, armor_heal = 12, armor_use = 100, armor_fire = 1},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 1, level = 3},
    })
    --- Crystal Chestplate
    --
    --  @chestplate 3d_armor:chestplate_crystal
    --  @img 3d_armor_inv_chestplate_crystal.png
    --  @grp armor_torso 1
    --  @grp armor_heal 12
    --  @grp armor_use 100
    --  @grp armor_fire 1
    --  @armorgrp fleshy 20
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp level 3
    armor:register_armor("3d_armor:chestplate_crystal", {
        description = S("Crystal Chestplate"),
        inventory_image = "3d_armor_inv_chestplate_crystal.png",
        groups = {armor_torso = 1, armor_heal = 12, armor_use = 100, armor_fire = 1},
        armor_groups = {fleshy = 20},
        damage_groups = {cracky = 2, snappy = 1, level = 3},
    })
    --- Crystal Leggings
    --
    --  @leggings 3d_armor:leggings_crystal
    --  @img 3d_armor_inv_leggings_crystal.png
    --  @grp armor_legs 1
    --  @grp armor_heal 12
    --  @grp armor_use 100
    --  @grp armor_fire 1
    --  @armorgrp fleshy 20
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp level 3
    armor:register_armor("3d_armor:leggings_crystal", {
        description = S("Crystal Leggings"),
        inventory_image = "3d_armor_inv_leggings_crystal.png",
        groups = {armor_legs = 1, armor_heal = 12, armor_use = 100, armor_fire = 1},
        armor_groups = {fleshy = 20},
        damage_groups = {cracky = 2, snappy = 1, level = 3},
    })
    --- Crystal Boots
    --
    --  @boots 3d_armor:boots_crystal
    --  @img 3d_armor_inv_boots_crystal.png
    --  @grp armor_feet 1
    --  @grp armor_heal 12
    --  @grp armor_use 100
    --  @grp physics_speed 1
    --  @grp physics_jump 0.5
    --  @grp armor_fire 1
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp level 3
    armor:register_armor("3d_armor:boots_crystal", {
        description = S("Crystal Boots"),
        inventory_image = "3d_armor_inv_boots_crystal.png",
        groups = {armor_feet = 1, armor_heal = 12, armor_use = 100, physics_speed = 1,
                  physics_jump = 0.5, armor_fire = 1},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 1, level = 3},
    })
end


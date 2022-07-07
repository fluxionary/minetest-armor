
local S = armor.get_translator

if armor.materials.wood then
    armor:register_armor("armor:helmet_wood", {
        description = S("Wood Helmet"),
        inventory_image = "armor_inv_helmet_wood.png",
        groups = {armor_head = 1, armor_heal = 0, armor_use = 2000, flammable = 1},
        armor_groups = {fleshy = 5},
        damage_groups = {cracky = 3, snappy = 2, choppy = 3, crumbly = 2, level = 1},
    })

    armor:register_armor("armor:chestplate_wood", {
        description = S("Wood Chestplate"),
        inventory_image = "armor_inv_chestplate_wood.png",
        groups = {armor_torso = 1, armor_heal = 0, armor_use = 2000, flammable = 1},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 2, choppy = 3, crumbly = 2, level = 1},
    })

    armor:register_armor("armor:leggings_wood", {
        description = S("Wood Leggings"),
        inventory_image = "armor_inv_leggings_wood.png",
        groups = {armor_legs = 1, armor_heal = 0, armor_use = 2000, flammable = 1},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 2, choppy = 3, crumbly = 2, level = 1},
    })

    armor:register_armor("armor:boots_wood", {
        description = S("Wood Boots"),
        inventory_image = "armor_inv_boots_wood.png",
        armor_groups = {fleshy = 5},
        damage_groups = {cracky = 3, snappy = 2, choppy = 3, crumbly = 2, level = 1},
        groups = {armor_feet = 1, armor_heal = 0, armor_use = 2000, flammable = 1},
    })

    local wood_armor_fuel = {
        helmet = 6,
        chestplate = 8,
        leggings = 7,
        boots = 5
    }
    for armor, burn in pairs(wood_armor_fuel) do
        minetest.register_craft({
            type = "fuel",
            recipe = "armor:" .. armor .. "_wood",
            burntime = burn,
        })
    end
end


--- Cactus
--
--  Requires setting `armor_material_cactus`.
--
--  @section cactus

if armor.materials.cactus then
    --- Cactus Helmet
    --
    --  @helmet armor:helmet_cactus
    --  @img armor_inv_helmet_cactus.png
    --  @grp armor_head 1
    --  @grp armor_heal 0
    --  @grp armor_use 1000
    --  @armorgrp fleshy 5
    --  @damagegrp cracky 3
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 2
    --  @damagegrp level 1
    armor:register_armor("armor:helmet_cactus", {
        description = S("Cactus Helmet"),
        inventory_image = "armor_inv_helmet_cactus.png",
        groups = {armor_head = 1, armor_heal = 0, armor_use = 1000},
        armor_groups = {fleshy = 5},
        damage_groups = {cracky = 3, snappy = 3, choppy = 2, crumbly = 2, level = 1},
    })
    --- Cactus Chestplate
    --
    --  @chestplate armor:chestplate_cactus
    --  @img armor_inv_chestplate_cactus.png
    --  @grp armor_torso 1
    --  @grp armor_heal 0
    --  @grp armor_use 1000
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 3
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 2
    --  @damagegrp level 1
    armor:register_armor("armor:chestplate_cactus", {
        description = S("Cactus Chestplate"),
        inventory_image = "armor_inv_chestplate_cactus.png",
        groups = {armor_torso = 1, armor_heal = 0, armor_use = 1000},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 3, choppy = 2, crumbly = 2, level = 1},
    })
    --- Cactus Leggings
    --
    --  @leggings armor:leggings_cactus
    --  @img armor_inv_leggings_cactus.png
    --  @grp armor_legs 1
    --  @grp armor_heal 0
    --  @grp armor_use 1000
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 3
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 2
    --  @damagegrp level 1
    armor:register_armor("armor:leggings_cactus", {
        description = S("Cactus Leggings"),
        inventory_image = "armor_inv_leggings_cactus.png",
        groups = {armor_legs = 1, armor_heal = 0, armor_use = 1000},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 3, choppy = 2, crumbly = 2, level = 1},
    })
    --- Cactus Boots
    --
    --  @boots armor:boots_cactus
    --  @img armor_inv_boots_cactus.png
    --  @grp armor_feet 1
    --  @grp armor_heal 0
    --  @grp armor_use 1000
    --  @armorgrp fleshy 5
    --  @damagegrp cracky 3
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 2
    --  @damagegrp level 1
    armor:register_armor("armor:boots_cactus", {
        description = S("Cactus Boots"),
        inventory_image = "armor_inv_boots_cactus.png",
        groups = {armor_feet = 1, armor_heal = 0, armor_use = 1000},
        armor_groups = {fleshy = 5},
        damage_groups = {cracky = 3, snappy = 3, choppy = 2, crumbly = 2, level = 1},
    })
    local cactus_armor_fuel = {
        helmet = 14,
        chestplate = 16,
        leggings = 15,
        boots = 13
    }
    for armor, burn in pairs(cactus_armor_fuel) do
        minetest.register_craft({
            type = "fuel",
            recipe = "armor:" .. armor .. "_cactus",
            burntime = burn,
        })
    end
end


--- Steel
--
--  Requires setting `armor_material_steel`.
--
--  @section steel

if armor.materials.steel then
    --- Steel Helmet
    --
    --  @helmet armor:helmet_steel
    --  @img armor_inv_helmet_steel.png
    --  @grp armor_head 1
    --  @grp armor_heal 0
    --  @grp armor_use 800
    --  @grp physics_speed -0.01
    --  @grp physica_gravity 0.01
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 2
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:helmet_steel", {
        description = S("Steel Helmet"),
        inventory_image = "armor_inv_helmet_steel.png",
        groups = {armor_head = 1, armor_heal = 0, armor_use = 800,
                  physics_speed = -0.01, physics_gravity = 0.01},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 2, snappy = 3, choppy = 2, crumbly = 1, level = 2},
    })
    --- Steel Chestplate
    --
    --  @chestplate armor:chestplate_steel
    --  @img armor_inv_chestplate_steel.png
    --  @grp armor_torso 1
    --  @grp armor_heal 0
    --  @grp armor_use 800
    --  @grp physics_speed
    --  @grp physics_gravity
    --  @armorgrp fleshy
    --  @damagegrp cracky 2
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:chestplate_steel", {
        description = S("Steel Chestplate"),
        inventory_image = "armor_inv_chestplate_steel.png",
        groups = {armor_torso = 1, armor_heal = 0, armor_use = 800,
                  physics_speed = -0.04, physics_gravity = 0.04},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 3, choppy = 2, crumbly = 1, level = 2},
    })
    --- Steel Leggings
    --
    --  @leggings armor:leggings_steel
    --  @img armor_inv_leggings_steel.png
    --  @grp armor_legs 1
    --  @grp armor_heal 0
    --  @grp armor_use 800
    --  @grp physics_speed -0.03
    --  @grp physics_gravity 0.03
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 2
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:leggings_steel", {
        description = S("Steel Leggings"),
        inventory_image = "armor_inv_leggings_steel.png",
        groups = {armor_legs = 1, armor_heal = 0, armor_use = 800,
                  physics_speed = -0.03, physics_gravity = 0.03},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 3, choppy = 2, crumbly = 1, level = 2},
    })
    --- Steel Boots
    --
    --  @boots armor:boots_steel
    --  @img armor_inv_boots_steel.png
    --  @grp armor_feet 1
    --  @grp armor_heal 0
    --  @grp armor_use 800
    --  @grp physics_speed -0.01
    --  @grp physics_gravity 0.01
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 2
    --  @damagegrp snappy 3
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:boots_steel", {
        description = S("Steel Boots"),
        inventory_image = "armor_inv_boots_steel.png",
        groups = {armor_feet = 1, armor_heal = 0, armor_use = 800,
                  physics_speed = -0.01, physics_gravity = 0.01},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 2, snappy = 3, choppy = 2, crumbly = 1, level = 2},
    })
end


--- Bronze
--
--  Requires setting `armor_material_bronze`.
--
--  @section bronze

if armor.materials.bronze then
    --- Bronze Helmet
    --
    --  @helmet armor:helmet_bronze
    --  @img armor_inv_helmet_bronze.png
    --  @grp armor_head 1
    --  @grp armor_heal 6
    --  @grp armor_use 400
    --  @grp physics_speed -0.01
    --  @grp physics_gravity 0.01
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 3
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:helmet_bronze", {
        description = S("Bronze Helmet"),
        inventory_image = "armor_inv_helmet_bronze.png",
        groups = {armor_head = 1, armor_heal = 6, armor_use = 400,
                  physics_speed = -0.01, physics_gravity = 0.01},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 2, choppy = 2, crumbly = 1, level = 2},
    })
    --- Bronze Chestplate
    --
    --  @chestplate armor:chestplate_bronze
    --  @img armor_inv_chestplate_bronze.png
    --  @grp armor_torso 1
    --  @grp armor_heal 6
    --  @grp armor_use 400
    --  @grp physics_speed -0.04
    --  @grp physics_gravity 0.04
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 3
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:chestplate_bronze", {
        description = S("Bronze Chestplate"),
        inventory_image = "armor_inv_chestplate_bronze.png",
        groups = {armor_torso = 1, armor_heal = 6, armor_use = 400,
                  physics_speed = -0.04, physics_gravity = 0.04},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 3, snappy = 2, choppy = 2, crumbly = 1, level = 2},
    })
    --- Bronze Leggings
    --
    --  @leggings armor:leggings_bronze
    --  @img armor_inv_leggings_bronze.png
    --  @grp armor_legs 1
    --  @grp armor_heal 6
    --  @grp armor_use 400
    --  @grp physics_speed -0.03
    --  @grp physics_gravity 0.03
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 3
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:leggings_bronze", {
        description = S("Bronze Leggings"),
        inventory_image = "armor_inv_leggings_bronze.png",
        groups = {armor_legs = 1, armor_heal = 6, armor_use = 400,
                  physics_speed = -0.03, physics_gravity = 0.03},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 3, snappy = 2, choppy = 2, crumbly = 1, level = 2},
    })
    --- Bronze Boots
    --
    --  @boots armor:boots_bronze
    --  @img armor_inv_boots_bronze.png
    --  @grp armor_feet 1
    --  @grp armor_heal 6
    --  @grp armor_use 400
    --  @grp physics_speed -0.01
    --  @grp physics_gravity 0.01
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 3
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 1
    --  @damagegrp level 2
    armor:register_armor("armor:boots_bronze", {
        description = S("Bronze Boots"),
        inventory_image = "armor_inv_boots_bronze.png",
        groups = {armor_feet = 1, armor_heal = 6, armor_use = 400,
                  physics_speed = -0.01, physics_gravity = 0.01},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 3, snappy = 2, choppy = 2, crumbly = 1, level = 2},
    })
end


--- Diamond
--
--  Requires setting `armor_material_diamond`.
--
--  @section diamond

if armor.materials.diamond then
    --- Diamond Helmet
    --
    --  @helmet armor:helmet_diamond
    --  @img armor_inv_helmet_diamond.png
    --  @grp armor_head 1
    --  @grp armor_heal 12
    --  @grp armor_use 200
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp choppy 1
    --  @damagegrp level 3
    armor:register_armor("armor:helmet_diamond", {
        description = S("Diamond Helmet"),
        inventory_image = "armor_inv_helmet_diamond.png",
        groups = {armor_head = 1, armor_heal = 12, armor_use = 200},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 1, choppy = 1, level = 3},
    })
    --- Diamond Chestplate
    --
    --  @chestplate armor:chestplate_diamond
    --  @img armor_inv_chestplate_diamond.png
    --  @grp armor_torso 1
    --  @grp armor_heal 12
    --  @grp armor_use 200
    --  @armorgrp fleshy 20
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp choppy 1
    --  @damagegrp level 3
    armor:register_armor("armor:chestplate_diamond", {
        description = S("Diamond Chestplate"),
        inventory_image = "armor_inv_chestplate_diamond.png",
        groups = {armor_torso = 1, armor_heal = 12, armor_use = 200},
        armor_groups = {fleshy = 20},
        damage_groups = {cracky = 2, snappy = 1, choppy = 1, level = 3},
    })
    --- Diamond Leggings
    --
    --  @leggings armor:leggings_diamond
    --  @img armor_inv_leggings_diamond.png
    --  @grp armor_legs 1
    --  @grp armor_heal 12
    --  @grp armor_use 200
    --  @armorgrp fleshy 20
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp choppy 1
    --  @damagegrp level 3
    armor:register_armor("armor:leggings_diamond", {
        description = S("Diamond Leggings"),
        inventory_image = "armor_inv_leggings_diamond.png",
        groups = {armor_legs = 1, armor_heal = 12, armor_use = 200},
        armor_groups = {fleshy = 20},
        damage_groups = {cracky = 2, snappy = 1, choppy = 1, level = 3},
    })
    --- Diamond Boots
    --
    --  @boots armor:boots_diamond
    --  @img armor_inv_boots_diamond.png
    --  @grp armor_feet 1
    --  @grp armor_heal 12
    --  @grp armor_use 200
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 2
    --  @damagegrp snappy 1
    --  @damagegrp choppy 1
    --  @damagegrp level 3
    armor:register_armor("armor:boots_diamond", {
        description = S("Diamond Boots"),
        inventory_image = "armor_inv_boots_diamond.png",
        groups = {armor_feet = 1, armor_heal = 12, armor_use = 200},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 2, snappy = 1, choppy = 1, level = 3},
    })
end


--- Gold
--
--  Requires `armor_material_gold`.
--
--  @section gold

if armor.materials.gold then
    --- Gold Helmet
    --
    --  @helmet armor:helmet_gold
    --  @img armor_inv_helmet_gold.png
    --  @grp armor_head 1
    --  @grp armor_heal 6
    --  @grp armor_use 300
    --  @grp physics_speed -0.02
    --  @grp physics_gravity 0.02
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 1
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 3
    --  @damagegrp level 2
    armor:register_armor("armor:helmet_gold", {
        description = S("Gold Helmet"),
        inventory_image = "armor_inv_helmet_gold.png",
        groups = {armor_head = 1, armor_heal = 6, armor_use = 300,
                  physics_speed = -0.02, physics_gravity = 0.02},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 1, snappy = 2, choppy = 2, crumbly = 3, level = 2},
    })
    --- Gold Chestplate
    --
    --  @chestplate armor:chestplate_gold
    --  @img armor_inv_chestplate_gold.png
    --  @grp armor_torso 1
    --  @grp armor_heal 6
    --  @grp armor_use 300
    --  @grp physics_speed -0.05
    --  @grp physics_gravity 0.05
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 1
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 3
    --  @damagegrp level 2
    armor:register_armor("armor:chestplate_gold", {
        description = S("Gold Chestplate"),
        inventory_image = "armor_inv_chestplate_gold.png",
        groups = {armor_torso = 1, armor_heal = 6, armor_use = 300,
                  physics_speed = -0.05, physics_gravity = 0.05},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 1, snappy = 2, choppy = 2, crumbly = 3, level = 2},
    })
    --- Gold Leggings
    --
    --  @leggings armor:leggings_gold
    --  @img armor_inv_leggings_gold.png
    --  @grp armor_legs 1
    --  @grp armor_heal 6
    --  @grp armor_use 300
    --  @grp physics_speed -0.04
    --  @grp physics_gravity 0.04
    --  @armorgrp fleshy 15
    --  @damagegrp cracky 1
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 3
    --  @damagegrp level 2
    armor:register_armor("armor:leggings_gold", {
        description = S("Gold Leggings"),
        inventory_image = "armor_inv_leggings_gold.png",
        groups = {armor_legs = 1, armor_heal = 6, armor_use = 300,
                  physics_speed = -0.04, physics_gravity = 0.04},
        armor_groups = {fleshy = 15},
        damage_groups = {cracky = 1, snappy = 2, choppy = 2, crumbly = 3, level = 2},
    })
    --- Gold Boots
    --
    --  @boots armor:boots_gold
    --  @img armor_inv_boots_gold.png
    --  @grp armor_feet 1
    --  @grp armor_heal 6
    --  @grp armor_use 300
    --  @grp physics_speed -0.02
    --  @grp physics_gravity 0.02
    --  @armorgrp fleshy 10
    --  @damagegrp cracky 1
    --  @damagegrp snappy 2
    --  @damagegrp choppy 2
    --  @damagegrp crumbly 3
    --  @damagegrp level 2
    armor:register_armor("armor:boots_gold", {
        description = S("Gold Boots"),
        inventory_image = "armor_inv_boots_gold.png",
        groups = {armor_feet = 1, armor_heal = 6, armor_use = 300,
                  physics_speed = -0.02, physics_gravity = 0.02},
        armor_groups = {fleshy = 10},
        damage_groups = {cracky = 1, snappy = 2, choppy = 2, crumbly = 3, level = 2},
    })
end

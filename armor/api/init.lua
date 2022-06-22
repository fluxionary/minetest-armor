--- 3D Armor API
--
--  @topic api


--- Tables
--
--  @section tables

--- Armor definition table used for registering armor.
--
--  @table ArmorDef
--  @tfield string description Human-readable name/description.
--  @tfield string inventory_image Image filename used for icon.
--  @tfield table groups See: `ArmorDef.groups`
--  @tfield table armor_groups See: `ArmorDef.armor_groups`
--  @tfield table damage_groups See: `ArmorDef.damage_groups`
--  @see ItemDef
--  @usage local def = {
--    description = "Wood Helmet",
--    inventory_image = "3d_armor_inv_helmet_wood.png",
--    groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
--    armor_groups = {fleshy=5},
--    damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
--  }

--- Groups table.
--
--  General groups defining item behavior.
--
--  Some commonly used groups: ***armor\_&lt;type&gt;***, ***armor\_heal***, ***armor\_use***
--
--  @table ArmorDef.groups
--  @tfield int armor_type The armor type. "head", "torso", "hands", "shield", etc.
--  (**Note:** replace "type" with actual type).
--  @tfield int armor_heal Healing value of armor when equipped.
--  @tfield int armor_use Amount of uses/damage before armor "breaks".
--  @see groups
--  @usage groups = {
--    armor_head = 1,
--    armor_heal = 5,
--    armor_use = 2000,
--    flammable = 1,
--  }

--- Armor groups table.
--
--  Groups that this item is effective against when taking damage.
--
--  Some commonly used groups: ***fleshy***
--
--  @table ArmorDef.armor_groups
--  @usage armor_groups = {
--    fleshy = 5,
--  }

--- Damage groups table.
--
--  Groups that this item is effective on when used as a weapon/tool.
--
--  Some commonly used groups: ***cracky***, ***snappy***, ***choppy***, ***crumbly***, ***level***
--
--  @table ArmorDef.damage_groups
--  @see entity_damage_mechanism
--  @usage damage_groups = {
--    cracky = 3,
--    snappy = 2,
--    choppy = 3,
--    crumbly = 2,
--    level = 1,
--  }

--- @section end

local default_armor_def = setmetatable({}, {
    __index = function()
        return setmetatable({
            groups = setmetatable({}, {
                __index = function()
                    return 0
                end})
        }, {
            __index = function()
                return 0
            end
        })
    end,
})

local default_armor_textures = setmetatable({}, {
    __index = function()
        return setmetatable({}, {
            __index = function()
                return "blank.png"
            end
        })
    end
})

armor.def = default_armor_def
armor.textures = default_armor_textures


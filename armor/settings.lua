local s = minetest.settings

armor.settings = {
    init_delay = tonumber(s:get("armor.init_delay")) or 2,
    init_times = tonumber(s:get("armor.init_times")) or 10,
    bones_delay = tonumber(s:get("armor.bones_delay")) or 1,
    update_time = tonumber(s:get("armor.update_time")) or 1,

    level_multiplier = tonumber(s:get("armor.level_multiplier")) or 1,
    heal_multiplier = tonumber(s:get("armor.heal_multiplier")) or 1,
    set_multiplier = tonumber(s:get("armor.set_multiplier")) or 1.1,

    default_skin = s:get("armor.default_skin") or "character",
    inv_size = tonumber(s:get("armor.inv_size")) or 6,

    -- bones, drop, destroy, keep
    on_death = s:get("armor.on_death") or (armor.has.bones and "bones") or "drop",

    transparent = s:get_bool("armor.transparent", false),
    integration_test = s:get_bool("armor.integration_test", false),
    elements = string.split(
        s:get("armor.elements") or
        "head,torso,legs,feet,shield"
    ),
    physics = split_string(
        s:get("armor.physics") or
        "jump,speed,gravity"
    ),
    attributes = split_string(
        s:get("armor.attributes") or
        "heal,fire,water,fall"
    ),
}

-- TODO look for all references to config
-- armor.config = {}



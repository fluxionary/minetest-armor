local s = minetest.settings

local function split_string(list)
    if not list then return end
    local values = {}
    for value in list:gmatch("[^,%s]+") do
        table.insert(values, value)
    end
    return values
end

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

    on_death = s:get("armor.on_death") or (armor.has.bones and "bones") or "drop",  -- bones, drop, destroy, keep

    transparent = s:get_bool("armor.transparent", false),
    integration_test = s:get_bool("armor.integration_test", false),
    elements = split_string(
        s:get("armor.elements") or
        "head, torso, legs, feet, shield"
    ),
    physics = split_string(
        s:get("armor.materials") or
        "jump, speed, gravity"
    ),
    attributes = split_string(
        s:get("armor.materials") or
        "heal, fire, water, fall"
    ),
}

-- TODO look for all references to config
-- armor.config = {}



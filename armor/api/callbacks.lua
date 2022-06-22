local S = armor.S

local callbacks = {}

local function make_callbacks(name)
    callbacks[name] = {}
    return callbacks[name], function(self, callback)
        table.insert(callbacks[name], callback)
    end
end

--- Methods
--
--  @section methods

--- Armor Callbacks Registration
--
--  @section callbacks

--- Registers a callback for when player visuals are update.
--
--  @function armor:register_on_update
--  @tparam function func Function to be executed.
--  @see armor:update_player_visuals
--  @usage armor:register_on_update(function(player, index, stack)
--    -- code to execute
--  end)
armor.registered_on_updates, armor.register_on_update = make_callbacks()

--- Registers a callback for when armor is equipped.
--
--  @function armor:register_on_equip
--  @tparam function func Function to be executed.
--  @usage armor:register_on_equip(function(player, index, stack)
--    -- code to execute
--  end)
armor.registered_on_equips, armor.register_on_equip = make_callbacks()

--- Registers a callback for when armor is unequipped.
--
--  @function armor:register_on_unequip
--  @tparam function func Function to be executed.
--  @usage armor:register_on_unequip(function(player, index, stack)
--    -- code to execute
--  end)
armor.registered_on_unequips, armor.register_on_unequip = make_callbacks()

--- Registers a callback for when armor is damaged.
--
--  @function armor:register_on_damage
--  @tparam function func Function to be executed.
--  @see armor:damage
--  @usage armor:register_on_damage(function(player, index, stack)
--    -- code to execute
--  end)
armor.registered_on_damage, armor.register_on_damage = make_callbacks()

--- Registers a callback for when armor is destroyed.
--
--  @function armor:register_on_destroy
--  @tparam function func Function to be executed.
--  @see armor:damage
--  @usage armor:register_on_destroy(function(player, index, stack)
--    -- code to execute
--  end)
armor.registered_on_destroy, armor.register_on_destroy = make_callbacks()

--- @section end


--- Methods
--
--  @section methods

--- Runs callbacks.
--
--  @function armor:run_callbacks
--  @tparam function callback Function to execute.
--  @tparam ObjectRef player First parameter passed to callback.
--  @tparam int index Second parameter passed to callback.
--  @tparam ItemStack stack Callback owner.
function armor:run_callbacks(callback_name, player, index, stack)
    local def = stack and stack:get_definition() or {}
    local callback = def[callback_name]
    if type(callback) == "function" then
        callback(player, index, stack)
    end

    for _, callback in ipairs(callbacks[callback_name] or {}) do
        callback(player, index, stack)
    end
end


-- Armor Initialization
armor:register_on_damage(function(player, index, stack)
    local name = player:get_player_name()
    local def = stack:get_definition()
    -- TODO get wear via toolcaps etc.
    if name and def and def.description and stack:get_wear() > 60100 then
        minetest.chat_send_player(name, S("Your @1 is almost broken!", def.description))
        minetest.sound_play("default_tool_breaks", {to_player = name, gain = 2.0})
    end
end)

armor:register_on_destroy(function(player, index, stack)
    local name = player:get_player_name()
    local def = stack:get_definition()
    if name and def and def.description then
        minetest.chat_send_player(name, S("Your @1 got destroyed!", def.description))
        minetest.sound_play("default_tool_breaks", {to_player = name, gain = 2.0})
    end
end)

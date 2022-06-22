
local transparent_armor = armor.settings.transparent_armor

local S = armor.S

local skin_previews = {}

--- Updates visuals.
--
--  @function armor:update_player_visuals
--  @tparam ObjectRef player
function armor:update_player_visuals(player)
    if not player then
        return
    end
    local name = player:get_player_name()
    local textures = self.textures[name]
    if textures then
        player_api.set_textures(player, {
            textures.skin,
            textures.armor,
            textures.wielditem,
        })
    end
    self:run_callbacks("on_update", player)
end

--- Sets player's armor attributes.
--
--  @function armor:set_player_armor
--  @tparam ObjectRef player
function armor:set_player_armor(player)
    local name, armor_inv = self:get_valid_player(player, "[set_player_armor]")
    if not name then
        return
    end
    local state = 0
    local count = 0
    local preview = self:get_preview(name)
    local texture = "3d_armor_trans.png"
    local physics = {}
    local attributes = {}
    local groups = {}
    local set_worn = {}
    local armor_multi = 0
    local worn_armor = self:get_worn_armor_elements(player)
    for _, phys in pairs(self.settings.physics) do
        physics[phys] = 1
    end
    for _, attr in pairs(self.settings.attributes) do
        attributes[attr] = 0
    end
    local list = armor_inv:get_list("armor")
    if type(list) ~= "table" then
        return
    end
    for _, stack in pairs(list) do
        if stack:get_count() > 0 then
            local def = stack:get_definition()
            for _, element in pairs(self.elements) do
                if def.groups["armor_" .. element] then
                    if def.armor_groups then
                        for group, level in pairs(def.armor_groups) do
                            if levels[group] then
                                levels[group] = levels[group] + level
                            end
                        end
                    else
                        local level = def.groups["armor_" .. element]
                        levels["fleshy"] = levels["fleshy"] + level
                    end
                    break
                end
                -- DEPRECATED, use armor_groups instead
                if def.groups["armor_radiation"] and levels["radiation"] then
                    levels["radiation"] = def.groups["armor_radiation"]
                end
            end
            local item = stack:get_name()
            local tex = def.texture or item:gsub("%:", "_")
            tex = tex:gsub(".png$", "")
            local prev = def.preview or tex .. "_preview"
            prev = prev:gsub(".png$", "")
            if not transparent_armor then
                texture = texture .. "^" .. tex .. ".png"
            end
            preview = preview .. "^" .. prev .. ".png"
            state = state + stack:get_wear()
            count = count + 1
            for _, phys in pairs(self.physics) do
                local value = def.groups["physics_" .. phys] or 0
                physics[phys] = physics[phys] + value
            end
            for _, attr in pairs(self.attributes) do
                local value = def.groups["armor_" .. attr] or 0
                attributes[attr] = attributes[attr] + value
            end
        end
    end
    -- The following code compares player worn armor items against requirements
    -- of which armor pieces are needed to be worn to meet set bonus requirements
    for loc, item in pairs(worn_armor) do
        local item_mat = string.match(item, "%:.+_(.+)$")
        local worn_key = item_mat or "unknown"

        -- Perform location checks to ensure the armor is worn correctly
        for k, set_loc in pairs(armor.config.set_elements) do
            if set_loc == loc then
                if set_worn[worn_key] == nil then
                    set_worn[worn_key] = 0
                    set_worn[worn_key] = set_worn[worn_key] + 1
                else
                    set_worn[worn_key] = set_worn[worn_key] + 1
                end
            end
        end
    end

    -- Apply the armor multiplier only if the player is wearing a full set of armor
    for mat_name, arm_piece_num in pairs(set_worn) do
        if arm_piece_num == #armor.config.set_elements then
            armor_multi = armor.config.set_multiplier
        end
    end
    for group, level in pairs(levels) do
        if level > 0 then
            level = level * armor.config.level_multiplier
            if armor_multi ~= 0 then
                level = level * armor.config.set_multiplier
            end
        end
        local base = self.registered_groups[group]
        self.def[name].groups[group] = level
        if level > base then
            level = base
        end
        groups[group] = base - level
        change[group] = groups[group] / base
    end
    for _, attr in pairs(self.attributes) do
        local mult = attr == "heal" and self.config.heal_multiplier or 1
        self.def[name][attr] = attributes[attr] * mult
    end
    for _, phys in pairs(self.physics) do
        self.def[name][phys] = physics[phys]
    end
    if use_armor_monoid then
        armor_monoid.monoid:add_change(player, change, "3d_armor:armor")
    else
        -- Preserve immortal group (damage disabled for player)
        local immortal = player:get_armor_groups().immortal
        if immortal and immortal ~= 0 then
            groups.immortal = 1
        end
        player:set_armor_groups(groups)
    end
    if use_player_monoids then
        player_monoids.speed:add_change(player, physics.speed,
            "3d_armor:physics")
        player_monoids.jump:add_change(player, physics.jump,
            "3d_armor:physics")
        player_monoids.gravity:add_change(player, physics.gravity,
            "3d_armor:physics")
    elseif use_pova_mod then
        -- only add the changes, not the default 1.0 for each physics setting
        pova.add_override(name, "3d_armor", {
            speed = physics.speed - 1,
            jump = physics.jump - 1,
            gravity = physics.gravity - 1,
        })
        pova.do_override(player)
    else
        local player_physics_locked = player:get_meta():get_int("player_physics_locked")
        if player_physics_locked == nil or player_physics_locked == 0 then
            player:set_physics_override(physics)
        end
    end
    self.textures[name].armor = texture
    self.textures[name].preview = preview
    self.def[name].level = self.def[name].groups.fleshy or 0
    self.def[name].state = state
    self.def[name].count = count
    self:update_player_visuals(player)
end

--- Action when armor is punched.
--
--  @function armor:punch
--  @tparam ObjectRef player Player wearing the armor.
--  @tparam ObjectRef hitter Entity attacking player.
--  @tparam[opt] int time_from_last_punch Time in seconds since last punch action.
--  @tparam[opt] table tool_capabilities See `entity_damage_mechanism`.
armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
    local name, armor_inv = self:get_valid_player(player, "[punch]")
    if not name then
        return
    end
    local set_state
    local set_count
    local state = 0
    local count = 0
    local recip = true
    local default_groups = {cracky = 3, snappy = 3, choppy = 3, crumbly = 3, level = 1}
    local list = armor_inv:get_list("armor")
    for i, stack in pairs(list) do
        if stack:get_count() == 1 then
            local itemname = stack:get_name()
            local use = minetest.get_item_group(itemname, "armor_use") or 0
            local damage = use > 0
            local def = stack:get_definition() or {}
            if type(def.on_punched) == "function" then
                damage = def.on_punched(player, hitter, time_from_last_punch,
                    tool_capabilities) ~= false and damage == true
            end
            if damage == true and tool_capabilities then
                local damage_groups = def.damage_groups or default_groups
                local level = damage_groups.level or 0
                local groupcaps = tool_capabilities.groupcaps or {}
                local uses = 0
                damage = false
                if next(groupcaps) == nil then
                    damage = true
                end
                for group, caps in pairs(groupcaps) do
                    local maxlevel = caps.maxlevel or 0
                    local diff = maxlevel - level
                    if diff == 0 then
                        diff = 1
                    end
                    if diff > 0 and caps.times then
                        local group_level = damage_groups[group]
                        if group_level then
                            local time = caps.times[group_level]
                            if time then
                                local dt = time_from_last_punch or 0
                                if dt > time / diff then
                                    if caps.uses then
                                        uses = caps.uses * math.pow(3, diff)
                                    end
                                    damage = true
                                    break
                                end
                            end
                        end
                    end
                end
                if damage == true and recip == true and hitter and
                    def.reciprocate_damage == true and uses > 0 then
                    local item = hitter:get_wielded_item()
                    if item and item:get_name() ~= "" then
                        item:add_wear(65535 / uses)
                        hitter:set_wielded_item(item)
                    end
                    -- reciprocate tool damage only once
                    recip = false
                end
            end
            if damage == true and hitter == "fire" then
                damage = minetest.get_item_group(itemname, "flammable") > 0
            end
            if damage == true then
                self:damage(player, i, stack, use)
                set_state = self.def[name].state
                set_count = self.def[name].count
            end
            state = state + stack:get_wear()
            count = count + 1
        end
    end
    if set_count and set_count ~= count then
        state = set_state or state
        count = set_count or count
    end
    self.def[name].state = state
    self.def[name].count = count
end

--- Action when armor is damaged.
--
--  @function armor:damage
--  @tparam ObjectRef player
--  @tparam int index Inventory index where armor is equipped.
--  @tparam ItemStack stack Armor item receiving damaged.
--  @tparam int use Amount of wear to add to armor item.
armor.damage = function(self, player, index, stack, use)
    local old_stack = ItemStack(stack)
    local worn_armor = armor:get_weared_armor_elements(player)
    local armor_worn_cnt = 0
    for k, v in pairs(worn_armor) do
        armor_worn_cnt = armor_worn_cnt + 1
    end
    use = math.ceil(use / armor_worn_cnt)
    stack:add_wear(use)
    self:run_callbacks("on_damage", player, index, stack)
    self:set_inventory_stack(player, index, stack)
    if stack:get_count() == 0 then
        self:run_callbacks("on_unequip", player, index, old_stack)
        self:run_callbacks("on_destroy", player, index, old_stack)
        self:set_player_armor(player)
    end
end

--- Get elements of equipped armor.
--
--  @function armor:get_weared_armor_elements
--  @tparam ObjectRef player
--  @treturn table List of equipped armors.
armor.get_weared_armor_elements = function(self, player)
    local name, inv = self:get_valid_player(player, "[get_weared_armor]")
    local weared_armor = {}
    if not name then
        return
    end
    for i = 1, inv:get_size("armor") do
        local item_name = inv:get_stack("armor", i):get_name()
        local element = self:get_element(item_name)
        if element ~= nil then
            weared_armor[element] = item_name
        end
    end
    return weared_armor
end

--- Equips a piece of armor to a player.
--
--  @function armor:equip
--  @tparam ObjectRef player Player to whom item is equipped.
--  @tparam ItemStack itemstack Armor item to be equipped.
--  @treturn ItemStack Leftover item stack.
armor.equip = function(self, player, itemstack)
    local name, armor_inv = self:get_valid_player(player, "[equip]")
    local armor_element = self:get_element(itemstack:get_name())
    if name and armor_element then
        local index
        for i = 1, armor_inv:get_size("armor") do
            local stack = armor_inv:get_stack("armor", i)
            if self:get_element(stack:get_name()) == armor_element then
                index = i
                self:unequip(player, armor_element)
                break
            elseif not index and stack:is_empty() then
                index = i
            end
        end
        local stack = itemstack:take_item()
        armor_inv:set_stack("armor", index, stack)
        self:run_callbacks("on_equip", player, index, stack)
        self:set_player_armor(player)
        self:save_armor_inventory(player)
    end
    return itemstack
end

--- Unequips a piece of armor from a player.
--
--  @function armor:unequip
--  @tparam ObjectRef player Player from whom item is removed.
--  @tparam string armor_element Armor type identifier associated with the item
--  to be removed ("head", "torso", "hands", "shield", "legs", "feet", etc.).
armor.unequip = function(self, player, armor_element)
    local name, armor_inv = self:get_valid_player(player, "[unequip]")
    if not name then
        return
    end
    for i = 1, armor_inv:get_size("armor") do
        local stack = armor_inv:get_stack("armor", i)
        if self:get_element(stack:get_name()) == armor_element then
            armor_inv:set_stack("armor", i, "")
            minetest.after(0, function()
                local inv = player:get_inventory()
                if inv:room_for_item("main", stack) then
                    inv:add_item("main", stack)
                else
                    minetest.add_item(player:get_pos(), stack)
                end
            end)
            self:run_callbacks("on_unequip", player, i, stack)
            self:set_player_armor(player)
            self:save_armor_inventory(player)
            return
        end
    end
end

--- Removes all armor worn by player.
--
--  @function armor:remove_all
--  @tparam ObjectRef player
armor.remove_all = function(self, player)
    local name, inv = self:get_valid_player(player, "[remove_all]")
    if not name then
        return
    end
    inv:set_list("armor", {})
    self:set_player_armor(player)
    self:save_armor_inventory(player)
end

local skin_mod

--- Retrieves player's current skin.
--
--  @function armor:get_player_skin
--  @tparam string name Player name.
--  @treturn string Skin filename.
armor.get_player_skin = function(self, name)
    if (skin_mod == "skins" or skin_mod == "simple_skins") and skins.skins[name] then
        return skins.skins[name] .. ".png"
    elseif skin_mod == "u_skins" and u_skins.u_skins[name] then
        return u_skins.u_skins[name] .. ".png"
    elseif skin_mod == "wardrobe" and wardrobe.playerSkins and wardrobe.playerSkins[name] then
        return wardrobe.playerSkins[name]
    end
    return armor.default_skin .. ".png"
end

--- Updates skin.
--
--  @function armor:update_skin
--  @tparam string name Player name.
armor.update_skin = function(self, name)
    minetest.after(0, function()
        local pplayer = minetest.get_player_by_name(name)
        if pplayer then
            self.textures[name].skin = self:get_player_skin(name)
            self:set_player_armor(pplayer)
        end
    end)
end

--- Adds preview for armor inventory.
--
--  @function armor:add_preview
--  @tparam string preview Preview image filename.
armor.add_preview = function(self, preview)
    skin_previews[preview] = true
end

--- Retrieves preview for armor inventory.
--
--  @function armor:get_preview
--  @tparam string name Player name.
--  @treturn string Preview image filename.
armor.get_preview = function(self, name)
    local preview = string.gsub(armor:get_player_skin(name), ".png", "_preview.png")
    if skin_previews[preview] then
        return preview
    end
    return "character_preview.png"
end

--- Retrieves armor formspec.
--
--  @function armor:get_armor_formspec
--  @tparam string name Player name.
--  @tparam[opt] bool listring Use `listring` formspec element (default: `false`).
--  @treturn string Formspec formatted string.
armor.get_armor_formspec = function(self, name, listring)
    if armor.def[name].init_time == 0 then
        return "label[0,0;Armor not initialized!]"
    end
    local formspec = armor.formspec ..
        "list[detached:" .. name .. "_armor;armor;0,0.5;2,3;]"
    if listring == true then
        formspec = formspec .. "listring[current_player;main]" ..
            "listring[detached:" .. name .. "_armor;armor]"
    end
    formspec = formspec:gsub("armor_preview", armor.textures[name].preview)
    formspec = formspec:gsub("armor_level", armor.def[name].level)
    for _, attr in pairs(self.attributes) do
        formspec = formspec:gsub("armor_attr_" .. attr, armor.def[name][attr])
    end
    for group, _ in pairs(self.registered_groups) do
        formspec = formspec:gsub("armor_group_" .. group,
            armor.def[name].groups[group])
    end
    return formspec
end

--- Retrieves element.
--
--  @function armor:get_element
--  @tparam string item_name
--  @return Armor element.
armor.get_element = function(self, item_name)
    for _, element in pairs(armor.elements) do
        if minetest.get_item_group(item_name, "armor_" .. element) > 0 then
            return element
        end
    end
end

--- Serializes armor inventory.
--
--  @function armor:serialize_inventory_list
--  @tparam table list Inventory contents.
--  @treturn string
armor.serialize_inventory_list = function(self, list)
    local list_table = {}
    for _, stack in ipairs(list) do
        table.insert(list_table, stack:to_string())
    end
    return minetest.serialize(list_table)
end

--- Deserializes armor inventory.
--
--  @function armor:deserialize_inventory_list
--  @tparam string list_string Serialized inventory contents.
--  @treturn table
armor.deserialize_inventory_list = function(self, list_string)
    local list_table = minetest.deserialize(list_string)
    local list = {}
    for _, stack in ipairs(list_table or {}) do
        table.insert(list, ItemStack(stack))
    end
    return list
end

--- Loads armor inventory.
--
--  @function armor:load_armor_inventory
--  @tparam ObjectRef player
--  @treturn bool
armor.load_armor_inventory = function(self, player)
    local _, inv = self:get_valid_player(player, "[load_armor_inventory]")
    if inv then
        local meta = player:get_meta()
        local armor_list_string = meta:get_string("3d_armor_inventory")
        if armor_list_string then
            inv:set_list("armor",
                self:deserialize_inventory_list(armor_list_string))
            return true
        end
    end
end

--- Saves armor inventory.
--
--  Inventory is stored in `PlayerMetaRef` string "3d\_armor\_inventory".
--
--  @function armor:save_armor_inventory
--  @tparam ObjectRef player
armor.save_armor_inventory = function(self, player)
    local _, inv = self:get_valid_player(player, "[save_armor_inventory]")
    if inv then
        local meta = player:get_meta()
        meta:set_string("3d_armor_inventory",
            self:serialize_inventory_list(inv:get_list("armor")))
    end
end

--- Updates inventory.
--
--  DEPRECATED: Legacy inventory support.
--
--  @function armor:update_inventory
--  @param player
armor.update_inventory = function(self, player)
    -- DEPRECATED: Legacy inventory support
end

--- Sets inventory stack.
--
--  @function armor:set_inventory_stack
--  @tparam ObjectRef player
--  @tparam int i Armor inventory index.
--  @tparam ItemStack stack Armor item.
armor.set_inventory_stack = function(self, player, i, stack)
    local _, inv = self:get_valid_player(player, "[set_inventory_stack]")
    if inv then
        inv:set_stack("armor", i, stack)
        self:save_armor_inventory(player)
    end
end

--- Checks for a player that can use armor.
--
--  @function armor:get_valid_player
--  @tparam ObjectRef player
--  @tparam string msg Additional info for log messages.
--  @treturn list Player name & armor inventory.
--  @usage local name, inv = armor:get_valid_player(player, "[equip]")
armor.get_valid_player = function(self, player, msg)
    msg = msg or ""
    if not player then
        minetest.log("warning", ("3d_armor%s: Player reference is nil"):format(msg))
        return
    end
    local name = player:get_player_name()
    if not name then
        minetest.log("warning", ("3d_armor%s: Player name is nil"):format(msg))
        return
    end
    local inv = minetest.get_inventory({type = "detached", name = name .. "_armor"})
    if not inv then
        -- This check may fail when called inside `on_joinplayer`
        -- in that case, the armor will be initialized/updated later on
        minetest.log("warning", ("3d_armor%s: Detached armor inventory is nil"):format(msg))
        return
    end
    return name, inv
end

--- Drops armor item at given position.
--
--  @tparam vector pos
--  @tparam ItemStack stack Armor item to be dropped.
armor.drop_armor = function(pos, stack)
    local node = minetest.get_node_or_nil(pos)
    if node then
        local obj = minetest.add_item(pos, stack)
        if obj then
            obj:set_velocity({x = math.random(-1, 1), y = 5, z = math.random(-1, 1)})
        end
    end
end

--- Allows skin mod to be set manually.
--
--  Useful for skin mod forks that do not use the same name.
--
--  @tparam string mod Name of skin mod. Recognized names are "simple\_skins", "u\_skins", & "wardrobe".
armor.set_skin_mod = function(mod)
    skin_mod = mod
end



local function validate_armor_inventory(player)
    -- Workaround for detached inventory swap exploit
    local _, inv = armor:get_valid_player(player, "[validate_armor_inventory]")
    local pos = player:get_pos()
    if not inv then
        return
    end
    local armor_prev = {}
    local attribute_meta = player:get_meta() -- I know, the function's name is weird but let it be like that. ;)
    local armor_list_string = attribute_meta:get_string("3d_armor_inventory")
    if armor_list_string then
        local armor_list = armor:deserialize_inventory_list(armor_list_string)
        for i, stack in ipairs(armor_list) do
            if stack:get_count() > 0 then
                armor_prev[stack:get_name()] = i
            end
        end
    end
    local elements = {}
    local player_inv = player:get_inventory()
    for i = 1, armor.settings.inv_size do
        local stack = inv:get_stack("armor", i)
        if stack:get_count() > 0 then
            local item = stack:get_name()
            local element = armor:get_element(item)
            if element and not elements[element] then
                if armor_prev[item] then
                    armor_prev[item] = nil
                else
                    -- Item was not in previous inventory
                    armor:run_callbacks("on_equip", player, i, stack)
                end
                elements[element] = true;
            else
                inv:remove_item("armor", stack)
                minetest.item_drop(stack, player, pos)
                -- The following code returns invalid items to the player's main
                -- inventory but could open up the possibity for a hacked client
                -- to receive items back they never really had. I am not certain
                -- so remove the is_singleplayer check at your own risk :]
                if minetest.is_singleplayer() and player_inv and
                    player_inv:room_for_item("main", stack) then
                    player_inv:add_item("main", stack)
                end
            end
        end
    end
    for item, i in pairs(armor_prev) do
        local stack = ItemStack(item)
        -- Previous item is not in current inventory
        armor:run_callbacks("on_unequip", player, i, stack)
    end
end

function armor.api.create_armor_inventory(player_name)
    return minetest.create_detached_inventory(player_name .. "_armor", {
        on_put = function(inv, listname, index, stack, player)
            armor.api.validate_armor_inventory(player)
            armor:save_armor_inventory(player)
            armor:set_player_armor(player)
        end,
        on_take = function(inv, listname, index, stack, player)
            armor.api.validate_armor_inventory(player)
            armor:save_armor_inventory(player)
            armor:set_player_armor(player)
        end,
        on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
            armor.api.validate_armor_inventory(player)
            armor:save_armor_inventory(player)
            armor:set_player_armor(player)
        end,
        allow_put = function(inv, listname, index, put_stack, player)
            if player:get_player_name() ~= player_name then
                return 0
            end
            local element = armor:get_element(put_stack:get_name())
            if not element then
                return 0
            end
            for i = 1, armor.settings.inv_size do
                local stack = inv:get_stack("armor", i)
                local def = stack:get_definition() or {}
                if def.groups and def.groups["armor_" .. element]
                    and i ~= index then
                    return 0
                end
            end
            return 1
        end,
        allow_take = function(inv, listname, index, stack, player)
            if player:get_player_name() ~= player_name then
                return 0
            end
            return stack:get_count()
        end,
        allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
            if player:get_player_name() ~= player_name then
                return 0
            end
            return count
        end,
    }, player_name)
end

function armor.api.init_player(player_name)
    local player = minetest.get_player_by_name(player_name)
    if not player then
        return
    end
    local pos = player:get_pos()
    if not pos then
        minetest.after(0, armor.api.init_player, player_name)
    end

    player_api.set_model(player, "3d_armor_character.b3d")

    local armor_inv = armor.api.create_armor_inventory()
    armor_inv:set_size("armor", armor.settings.inv_size)

    if not armor:load_armor_inventory(initplayer) and armor.migrate_old_inventory then
        local player_inv = initplayer:get_inventory()
        player_inv:set_size("armor", armor.settings.inv_size)
        for i = 1, armor.settings.inv_size do
            local stack = player_inv:get_stack("armor", i)
            armor_inv:set_stack("armor", i, stack)
        end
        armor:save_armor_inventory(initplayer)
        player_inv:set_size("armor", 0)
    end
    for i = 1, armor.settings.inv_size do
        local stack = armor_inv:get_stack("armor", i)
        if stack:get_count() > 0 then
            armor:run_callbacks("on_equip", initplayer, i, stack)
        end
    end
    armor.def[name] = {
        init_time = minetest.get_gametime(),
        level = 0,
        state = 0,
        count = 0,
        groups = {},
    }
    for _, phys in pairs(armor.physics) do
        armor.def[name][phys] = 1
    end
    for _, attr in pairs(armor.attributes) do
        armor.def[name][attr] = 0
    end
    for group, _ in pairs(armor.registered_groups) do
        armor.def[name].groups[group] = 0
    end
    local skin = armor:get_player_skin(name)
    armor.textures[name] = {
        skin = skin,
        armor = "3d_armor_trans.png",
        wielditem = "3d_armor_trans.png",
        preview = armor.default_skin .. "_preview.png",
    }
    local texture_path = minetest.get_modpath("player_textures")
    if texture_path then
        local dir_list = minetest.get_dir_list(texture_path .. "/textures")
        for _, fn in pairs(dir_list) do
            if fn == "player_" .. name .. ".png" then
                armor.textures[name].skin = fn
                break
            end
        end
    end
    armor:set_player_armor(initplayer)
    return true
end

function armor.api.deinit_player(player_name)
    if player_name then
        armor.api.def[player_name] = nil
        armor.api.textures[player_name] = nil
    end
end

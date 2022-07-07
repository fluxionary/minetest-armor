

minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
    minetest.api.init_player(player_name)
end)

minetest.register_on_leaveplayer(function(player)
    local player_name = player:get_player_name()
    minetest.api.deinit_player(player_name)
end)

minetest.register_on_dieplayer(function(player)
    local name, armor_inv = armor.get_valid_player(player, "[on_dieplayer]")
    if not name then
        return
    end
    local drop = {}
    for i = 1, armor_inv:get_size("armor") do
        local stack = armor_inv:get_stack("armor", i)
        if stack:get_count() > 0 then
            table.insert(drop, stack)
            armor.run_callbacks("on_unequip", player, i, stack)
            armor_inv:set_stack("armor", i, nil)
        end
    end
    armor.save_armor_inventory(player)
    armor.set_player_armor(player)
    local pos = player:get_pos()
    if pos and armor.config.destroy == false then
        minetest.after(armor.config.bones_delay, function()
            local meta = nil
            local maxp = vector.add(pos, 16)
            local minp = vector.subtract(pos, 16)
            local bones = minetest.find_nodes_in_area(minp, maxp, {"bones:bones"})
            for _, p in pairs(bones) do
                local m = minetest.get_meta(p)
                if m:get_string("owner") == name then
                    meta = m
                    break
                end
            end
            if meta then
                local inv = meta:get_inventory()
                for _, stack in ipairs(drop) do
                    if inv:room_for_item("main", stack) then
                        inv:add_item("main", stack)
                    else
                        armor.drop_armor(pos, stack)
                    end
                end
            else
                for _, stack in ipairs(drop) do
                    armor.drop_armor(pos, stack)
                end
            end
        end)
    end
end)

minetest.register_on_punchplayer(function(player, hitter,
    time_from_last_punch, tool_capabilities)
    local name = player:get_player_name()
    local hit_ip = hitter:is_player()
    if name and hit_ip and minetest.is_protected(player:get_pos(), "") then
        return
    elseif name then
        armor.punch(player, hitter, time_from_last_punch, tool_capabilities)
        armor.last_punch_time[name] = minetest.get_gametime()
    end
end)

minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if player and reason.type ~= "drown" and reason.hunger == nil
        and hp_change < 0 then
        local name = player:get_player_name()
        if name then
            local heal = armor.def[name].heal
            if heal >= math.random(100) then
                hp_change = 0
            end
            -- check if armor damage was handled by fire or on_punchplayer
            local time = armor.last_punch_time[name] or 0
            if time == 0 or time + 1 < minetest.get_gametime() then
                armor.punch(player)
            end
        end
    end
    return hp_change
end, true)

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer <= armor.config.init_delay then
        return
    end
    timer = 0

    for player, count in pairs(armor.pending_players) do
        local remove = init_player_armor(player) == true
        armor.pending_players[player] = count + 1
        if remove == false and count > armor.config.init_times then
            minetest.log("warning", S("3d_armor. Failed to initialize player"))
            remove = true
        end
        if remove == true then
            armor.pending_players[player] = nil
        end
    end

    -- water breathing protection, added by TenPlus1
    if armor.config.water_protect == true then
        for _, player in pairs(minetest.get_connected_players()) do
            local name = player:get_player_name()
            if armor.def[name].water > 0 and
                player:get_breath() < 10 then
                player:set_breath(10)
            end
        end
    end
end)

minetest.register_on_player_hpchange(function(player, hp_change, reason)

    if reason.type == "node_damage" and reason.node then
        -- fire protection
        if armor.config.fire_protect == true and hp_change < 0 then
            local name = player:get_player_name()
            for _, igniter in pairs(armor.fire_nodes) do
                if reason.node == igniter[1] then
                    if armor.def[name].fire < igniter[2] then
                        armor.punch(player, "fire")
                    else
                        hp_change = 0
                    end
                end
            end
        end
    end
    return hp_change
end, true)

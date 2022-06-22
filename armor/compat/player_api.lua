

-- Armor Player Model

player_api.register_model("3d_armor_character.b3d", {
    animation_speed = 30,
    textures = {
        armor.default_skin .. ".png",
        "3d_armor_trans.png",
        "3d_armor_trans.png",
    },
    animations = {
        stand = {x = 0, y = 79},
        lay = {x = 162, y = 166},
        walk = {x = 168, y = 187},
        mine = {x = 189, y = 198},
        walk_mine = {x = 200, y = 219},
        sit = {x = 81, y = 160},
    },
})

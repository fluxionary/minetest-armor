
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


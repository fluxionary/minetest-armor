Modpack - Armor [5.0]
===========================
![armor screenshot](https://github.com/minetest-mods/3d_armor/blob/master/screenshot.png)


![](https://github.com/minetest-mods/3d_armor/workflows/luacheck/badge.svg)
![](https://github.com/minetest-mods/3d_armor/workflows/integration-test/badge.svg)

### Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

- [[mod] Visible Player Armor [armor]](#mod-visible-player-armor-armor)
- [[mod] Visible Wielded Items [wieldview]](#mod-visible-wielded-items-wieldview)
- [[mod] Shields [shields]](#mod-shields-shields)
- [[mod] Armor Stand [armor_stand]](#mod-armor-stand-armor_stand)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


[mod] Visible Player Armor [armor]
-------------------------------------

Minetest Version: 5.0.0

Game: minetest_game and many derivatives

Depends: default

Adds craftable armor that is visible to other players. Each armor item worn contributes to
a player's armor group level making them less vulnerable to attack.

Armor takes damage when a player is hurt, however, many armor items offer a 'stackable'
percentage chance of restoring the lost health points. Overall armor level is boosted by 10%
when wearing a full matching set (helmet, chestplate, leggings and boots of the same material)

Fire protection has been added by TenPlus1 and in use when ethereal mod is found and crystal
armor has been enabled.  each piece of armor offers 1 fire protection, level 1 protects
against torches, level 2 against crystal spikes, 3 for fire and 5 protects when in lava.

Compatible with sfinv, inventory plus or unified inventory by enabling the appropriate
inventory module, [armor_sfinv], [armor_ip] and [armor_ui] respectively.
Also compatible with [smart_inventory] without the need for additional modules.

built in support player skins [skins] by Zeg9 and Player Textures [player_textures] by PilzAdam
and [simple_skins] by TenPlus1.

Armor can be configured by adding a file called armor.conf in armor mod or world directory.
see armor.conf.example for all available options.

For mod installation instructions, please visit: http://wiki.minetest.com/wiki/Installing_Mods

[API Reference](https://minetest-mods.github.io/3d_armor/reference/)

[mod] Visible Wielded Items [wieldview]
---------------------------------------

Depends: armor

Makes hand wielded items visible to other players.

[mod] Shields [shields]
-----------------------

Depends: armor

Originally a part of armor, shields have been re-included as an optional extra.
If you do not want shields then simply remove the shields folder from the modpack.

[mod] Armor Stand [armor_stand]
-------------------------------------

Depends: armor

Adds a chest-like armor stand for armor storage and display.

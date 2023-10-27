Config = Config or {}

Config.Metadata = { -- skills to add to the Player's metadata table. You don't need to add them to qb-core/server/player.lua
    {name = 'NewSkill', skill = 'newskill', icon = 'plus'},
    -- {name = 'Technician', skill = 'technician', icon = 'terminal'},
}

Config.Levels = {
    [1] = 5,
    [2] = 10,
    [3] = 20,
    [4] = 40,
    [5] = 80,
    [6] = 160,
    [7] = 320,
    [8] = 640,
    [9] = 1280,
    [10] = 2560,
    [11] = 5120,
    [12] = 10240,
    [13] = 20480,
    [14] = 40960,
    [15] = 81920,
    [16] = 100000,
}

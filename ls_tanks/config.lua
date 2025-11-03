Config = {}

Config.debug = false

Config.forceFirstPerson = false

Config.moneyAccount = 'bank' -- ('bank' for BOTH ESX and QB/QBOX) or ('money' for ESX  and 'cash' for QB/QBOX)

Config.database = {
    sqlDriver = 'mysql', -- 'mysql', 'oxmysql', others might work as well. Database file editable in "server/editables/database.lua"
    oldOxmysql = false
}

Config.miniTankSettings = {
    health = 10,
    ammo = 10 -- amount of ammo before reloading
}

Config.buttons = {
    interaction = 'E',
    reload = 'R'
}

Config.timeBetweenGames = 120 -- in seconds
Config.gameDuration = 300 -- in seconds

Config.reloadTime = 2 -- in seconds

---SPAWNS TOP 3 PLAYER CUSTOMIZED MINI-TANKS ON ARENA LOBBY PODIUM BASED ON CRITERIA
Config.podiumRankingCriteria = 'playtime' -- wins, kills, deaths, distance, playtime

Config.blip = {
    enable = true,
    sprite = 421,
    color = 30,
    scale = 1.1,
    text = 'Battle Tanks',
    setAsShortRange = true
}

Config.arenaCoords = {
    entrance = {
        coords = vector3(-595.12, -1653.03, 20.63),
        heading = 141.57
    },
    exit = {
        coords = vector3(-2790.63, 1160.51, -24.37),
        heading = 188.65
    }
}


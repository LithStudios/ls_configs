Config = {}

-- Database Configuration
Config.database = {
    sqlDriver = 'oxmysql',  -- 'oxmysql' or 'mysql'
    oldOxmysql = false      -- Set to true if using an older version of oxmysql
}

Config.organisations = {
    police = {
        image = '',
        description = '',
        
    }
}

Config.framework = 'esx'

Config.useNewESXExport = true
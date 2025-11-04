
function sqlFetch(query, data)
    if Config.sqlDriver  == 'mysql' then
        return MySQL.Sync.fetchAll(query, data or {})
    end
    if Config.sqlDriver  == 'oxmysql' then
        return exports[Config.sqlDriver]:query_async(query, data)
    else
        return exports[Config.sqlDriver]:executeSync(query, data)
    end
end

function sqlInsert(query, data)
    if Config.sqlDriver == 'mysql' then
        MySQL.Sync.insert(query, data)
        return
    end
    if Config.sqlDriver == 'oxmysql' then
        exports[Config.sqlDriver]:insertSync(query, data)
    else
        exports[Config.sqlDriver]:executeSync(query, data)
    end
end

function GetIdentifier(player)
    local identifier = GetPlayerIdentifiers(player)[1]:gsub(":", "")
    if Config.alternativeIdentifier.enabled then
        for k,v in pairs(GetPlayerIdentifiers(player))do
            if string.sub(v, 1, string.len(Config.alternativeIdentifier.identifier)) == Config.alternativeIdentifier.identifier then
                identifier = v:gsub(":", "")
            end
        end
    end
    return identifier 
end


function CountTableItems(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

function Contains(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function GiveReward(player, loot)
    for reward, amount in pairs(loot) do
        exports['kq_link']:AddPlayerItem(player, reward, amount)
    end
end

local function GetRandomKeyValue(tbl)
    local keys = {}
    for k in pairs(tbl) do
        keys[#keys+1] = k
    end
    if #keys == 0 then return nil end
    local randomKey = keys[math.random(#keys)]
    return randomKey, tbl[randomKey]
end

---@param package_size 'small' | 'medium' | 'large'
---@return string[]
function DetermineLoot(package_size)
    local loot = {}
    local package_amounts = Config.loot.amounts[package_size]
    local amount = math.random(package_amounts.min, package_amounts.max)
    local item_table = Config.loot.items[package_size]

    for k=1, amount, 1 do
        local loot_name, amount_table = GetRandomKeyValue(item_table)
        if loot_name and amount_table then
            loot[loot_name] = math.random(amount_table[1], amount_table[2])
        end
    end

    return loot
end

RegisterServerEvent(GetCurrentResourceName() .. ':server:set_loot_state')
AddEventHandler(GetCurrentResourceName() .. ':server:set_loot_state', function(net_id, loot_state)
    local entity = NetworkGetEntityFromNetworkId(net_id)
    Entity(entity).state:set('ls_postal_loot', loot_state, true)
end)

RegisterServerEvent(GetCurrentResourceName() .. ':server:set_looted')
AddEventHandler(GetCurrentResourceName() .. ':server:set_looted', function(net_id)
    local _source = source
    local entity = NetworkGetEntityFromNetworkId(net_id)
    local loot = Entity(entity).state.ls_postal_loot

    if loot then
        Entity(entity).state:set('ls_postal_loot', nil, true)
        GiveReward(_source, loot)
    end
end)
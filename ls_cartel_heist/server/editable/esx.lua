if Config.esxSettings.enabled then    
    if Config.esxSettings.useNewESXExport then
        ESX = exports['es_extended']:getSharedObject()
    else
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj)
                    ESX = obj
                end)
                Citizen.Wait(0)
            end
        end)
    end


    
    ESX.RegisterUsableItem('ls_wire_cutters', function(source)
        TriggerClientEvent('ls_cartel_heist:client:minigame1', source)
    end)

    ESX.RegisterUsableItem('ls_emp_blocker', function(source)
        TriggerClientEvent('ls_cartel_heist:client:useEmpBlocker', source)
    end)

    ESX.RegisterUsableItem('ls_thermite', function(source)
        TriggerClientEvent('ls_cartel_heist:client:thermite', source)
    end)

    ESX.RegisterUsableItem('ls_entrance_key', function(source)
        TriggerClientEvent('ls_cartel_heist:client:entrance_key', source)
    end)

    ESX.RegisterUsableItem('ls_card', function(source)
        TriggerClientEvent('ls_cartel_heist:cardInteract', source)
    end)

    function RemovePlayerMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)

        if xPlayer.getAccount(Config.esxSettings.account).money >= amount then
            xPlayer.removeAccountMoney(Config.esxSettings.account, amount)
            return true
        else
            return false
        end
    end

    function AddMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        if not xPlayer then
            return false
        end        
        xPlayer.addAccountMoney(Config.esxSettings.account, amount)
    end

    function CheckPlayerMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        if Config.debug then
            print(xPlayer.getAccount(Config.esxSettings.account).money," Player's money ")
        end
        if xPlayer.getAccount(Config.esxSettings.account).money >= amount then
            return true
        else
            return false
        end
    end
    
    function UseItem(source, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, 1)
    end

    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getInventoryItem(item).count >= (amount or 1)
    end

    function RemovePlayerItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))
        xPlayer.removeInventoryItem(item, amount or 1)
    end    

    function AddPlayerItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))

        -- Support for old esx which didn't use weight for inventory size but rather item limit per item type

        if Config.esxSettings.oldEsx then
            local esxItem = xPlayer.getInventoryItem(item)

            if esxItem.limit == -1 or (esxItem.count + amount) <= esxItem.limit then
                xPlayer.addInventoryItem(item, amount or 1)
                return true
            else
                return false
            end
        else
            if xPlayer.canCarryItem(item, amount or 1) then
                xPlayer.addInventoryItem(item, amount or 1)
                return true
            else
                return false
            end
        end
    end


    function CanPlayerCarry(player, conKey)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))
        local inside = Config.inside
        local smallDrops = containerDrops[conKey].smallDrops
        local bigDrops = containerDrops[conKey].bigDrops
        local bigReward = inside.items[bigDrops[1]]

        local totalWeight = 0
        for k = #smallDrops, 1, -1 do
            local smallReward = inside.items[smallDrops[k]]
            if (smallReward.reward ~= 'ls_money_one' and smallReward.reward ~= 'ls_money_medium') then
                totalWeight = ESX.GetItemWeight(smallReward.reward) + totalWeight
            else 
                return true
            end
        end
        totalWeight = ESX.GetItemWeight(bigReward.reward) + totalWeight
        if xPlayer.canCarryItem('ls_jewellery', totalWeight) then
            return true
        else
            return false
        end

    end


    ESX.GetItemWeight = function(item)
        if ESX.Items[item] ~= nil then
            return ESX.Items[item].weight
        end
    end


    function GetItemAmount(player)
        local totalMoney = 0
        for item, price in pairs(Config.itemPrice) do
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            while ESX == nil or xPlayer == nil do
                Citizen.Wait(10)
            end
            local amount = xPlayer.getInventoryItem(item).count
            if amount > 0 then
                RemovePlayerItem(player, item, amount)
                AddMoney(player, price * amount)
                totalMoney = totalMoney + price * amount
            end
        end
        TriggerClientEvent('ls_cartel_heist:showTotalSold', player, totalMoney)        
    end




    if Config.canPlayerCarryAll then
        function CanPlayerCarryCrate(player, crateKey)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local inside = Config.inside
            local smallDrops = crateDrops[crateKey].smallDrops
            
            local totalWeight = 0
            for k = #smallDrops, 1, -1 do
                local smallReward = inside.items[smallDrops[k]]
                if (smallReward.reward ~= 'ls_money_one' and smallReward.reward ~= 'ls_money_medium') then
                    totalWeight = ESX.GetItemWeight(smallReward.reward) + totalWeight
                else 
                    return true
                end
            end
            if xPlayer.canCarryItem('ls_jewellery', totalWeight) then
                return true
            else
                return false
            end
        end  

        function CanPlayerCarry(player, conKey)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local inside = Config.inside
            local smallDrops = containerDrops[conKey].smallDrops
            local bigDrops = containerDrops[conKey].bigDrops
            local bigReward = inside.items[bigDrops[1]]

            local totalWeight = 0
            for k = #smallDrops, 1, -1 do
                local smallReward = inside.items[smallDrops[k]]
                if (smallReward.reward ~= 'ls_money_one' and smallReward.reward ~= 'ls_money_medium') then
                    totalWeight = ESX.GetItemWeight(smallReward.reward) + totalWeight
                else 
                    return true
                end
            end
            totalWeight = ESX.GetItemWeight(bigReward.reward) + totalWeight
            if xPlayer.canCarryItem('ls_jewellery', totalWeight) then
                return true
            else
                return false
            end
        end

        function CanPlayerCarryTable(player, key)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local props = Config.tableDrop[key].props
            local count = CountTableItems(props)
            for propKey, _ in pairs(props) do
                local smallReward = Config.tableItems[propKey]            
                if xPlayer.canCarryItem(smallReward.reward, count) then
                    return true
                else
                    return false            
                end
            end
        end  

    else

        function CanPlayerCarryTable(player, key)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local props = Config.tableDrop[key].props
            for propKey, _ in pairs(props) do
                local smallReward = Config.tableItems[propKey]     
                
                if xPlayer.canCarryItem(smallReward.reward, 1) then
                    return true
                else
                    return false            
                end
            end
        end  

        function CanPlayerCarry(player, conKey)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local totalWeight = 0
            local inside = Config.inside

            local smallDrops = containerDrops[conKey].smallDrops
            local bigDrops = containerDrops[conKey].bigDrops

            local bigReward = inside.items[bigDrops[1]]

            local count = #smallDrops
            for k = count, 1, -1 do
                local smallReward = inside.items[smallDrops[k]]
                if (smallReward.reward ~= 'ls_money_one' and smallReward.reward ~= 'ls_money_medium') then
                    if not xPlayer.canCarryItem(smallReward.reward, smallReward.amount) then
                        return false
                    end
                end
            end
            return true
        end 

        function CanPlayerCarryCrate(player, crateKey)
            local xPlayer = ESX.GetPlayerFromId(tonumber(player))
            local inside = Config.inside
            local smallDrops = crateDrops[crateKey].smallDrops
            local canCarry = 0

            for k = #smallDrops, 1, -1 do
                local smallReward = inside.items[smallDrops[k]]
                if (smallReward.reward ~= 'ls_money_one' and smallReward.reward ~= 'ls_money_medium') then
                    
                    if xPlayer.canCarryItem(smallReward.reward, smallReward.amount) then
                        canCarry = canCarry + 1
                    end
                else 
                    return true
                end
            end
            if canCarry < #smallDrops then
                return false
            end
            return true
        end  

    end

    

    function CanPlayerCarryBag(player, bagDrop)
        local xPlayer = ESX.GetPlayerFromId(tonumber(player))
        local itemReward = Config.palleteItems[bagDrop.reward].reward
        if (itemReward ~= 'ls_money_one' and itemReward ~= 'ls_money_medium') then
            if xPlayer.canCarryItem(itemReward, bagDrop.amount) then
                return true
            else
                return false
            end
        else
            return true
        end
    end

    function CanPlayerCarryItem(player, item, amount)
        local xPlayer = ESX.GetPlayerFromId(player)  
        if xPlayer.canCarryItem(item, amount) then
            return true
        else
            return false
        end
    end

    

    function IsPolice(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        if not xPlayer then
            return false
        end
        local job = xPlayer.getJob()

        return Contains(Config.policeJobNames, job.name)
    end


end

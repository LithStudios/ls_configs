if Config.qbSettings.enabled then        
    if Config.qbSettings.UseNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end

    function RemovePlayerMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        while xPlayer == nil do Wait(0) end
        if xPlayer.Functions.GetMoney(Config.qbSettings.account) >= amount then
            xPlayer.Functions.RemoveMoney(Config.qbSettings.account, amount)
            return true
        else
            return false
        end
    end

    function AddMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)        
        if not xPlayer then
            return false
        end
        xPlayer.Functions.AddMoney(Config.qbSettings.account, amount)
    end

    function AddPlayerItem(source, itemId, amount)
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
        --local item = xPlayer.Functions.GetItemByName(itemId)
        if not xPlayer.Functions.AddItem(itemId, amount or 1) then
            QBCore.Functions.Notify(source, "Inventory is full", 'error')
        end

    end


    function DoesPlayerHaveItem(player, item, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        
        return xPlayer.Functions.GetItemByName(item) and xPlayer.Functions.GetItemByName(item).amount >= (amount or 1)
    end


    function CheckPlayerMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if xPlayer.Functions.GetMoney(Config.qbSettings.account) >= amount then
            return true
        else
            return false
        end
    end

    function IsPolice(player)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if not xPlayer then
            return false
        end

        local job = xPlayer.PlayerData.job

        return Contains(Config.policeJobNames, job.name)
    end

    function UseItem(source, item)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        xPlayer.Functions.RemoveItem(item, 1)
    end

    QBCore.Functions.CreateUseableItem('ls_wire_cutters', function(source)
        TriggerClientEvent('ls_cartel_heist:client:minigame1', source)
    end)
    QBCore.Functions.CreateUseableItem('ls_emp_blocker', function(source)
        TriggerClientEvent('ls_cartel_heist:client:useEmpBlocker', source)
    end)
    QBCore.Functions.CreateUseableItem('ls_thermite', function(source)
        TriggerClientEvent('ls_cartel_heist:client:thermite', source)
    end)
    QBCore.Functions.CreateUseableItem('ls_entrance_key', function(source)
        TriggerClientEvent('ls_cartel_heist:client:entrance_key', source)
    end)
    QBCore.Functions.CreateUseableItem('ls_card', function(source)
        TriggerClientEvent('ls_cartel_heist:cardInteract', source)
    end)

    
    function GetItemAmount(player)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        local items = xPlayer.PlayerData.items
        local totalMoney = 0

        for k in pairs(items) do
            local itemName = xPlayer.PlayerData.items[k].name
            for item, price in pairs(Config.itemPrice) do
                local amount = xPlayer.PlayerData.items[k].amount
                if amount > 0 then
                    if itemName == item then
                        totalMoney = totalMoney + price * amount
                        AddMoney(player, price * amount)
                        xPlayer.Functions.RemoveItem(item, amount)   
                    end                                     
                end
            end            
        end
        TriggerClientEvent('ls_cartel_heist:showTotalSold', player, totalMoney)        
    end




    if Config.canPlayerCarryAll then
        function CanPlayerCarryCrate(player, crateKey)    
            return true
        end

    else
        function CanPlayerCarryCrate(player, crateKey)    
            return true
        end 
    end

    function CanPlayerCarryTable(player, key)
        return true
    end  

    function CanPlayerCarryBag(player, bagDrop)
        return true
    end
    
end

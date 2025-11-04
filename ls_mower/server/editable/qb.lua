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
    
    function CheckPlayerMoney(player, amount)
        local xPlayer = QBCore.Functions.GetPlayer(player)
        if xPlayer.Functions.GetMoney(Config.qbSettings.account) >= amount then
            return true
        else
            return false
        end
    end

    
end

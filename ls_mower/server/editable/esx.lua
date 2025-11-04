if Config.esxSettings.enabled then    
    ESX = nil
    ESX = exports['es_extended']:getSharedObject()

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
        if Config.debugMode.debug then
            print(xPlayer.getAccount(Config.esxSettings.account).money," Player's money ")
        end
        if xPlayer.getAccount(Config.esxSettings.account).money >= amount then
            return true
        else
            return false
        end
    end

end

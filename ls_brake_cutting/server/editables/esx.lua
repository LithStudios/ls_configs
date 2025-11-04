if Config.framework == 'esx' then
    ESX = nil

    if Config.useNewESXExport then
        ESX = exports["es_extended"]:getSharedObject()
    else
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            Citizen.Wait(0)
        end
    end

    ESX.RegisterUsableItem(Config.toolName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        TriggerClientEvent('ls_brakes:DisableBrakes', source)
    end)

    function UseItem(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(Config.toolName, 1)
    end
end
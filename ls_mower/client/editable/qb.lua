if Config.qbSettings.enabled then        
    if Config.qbSettings.UseNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    RegisterNetEvent('lawn:client:SetOwner', function(plate)
        
    end)



    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        if Config.job.jobName == QBCore.Functions.GetPlayerData().job.name then
            drawSubtitles(L('Go to the marker [~g~Lawn Mowing Job~w~] to pick up your ~g~lawn mower.'), 7000)            
        end
    end)

    function HasJob(jobName)
        if QBCore.Functions.GetPlayerData().job ~= nil then 
            return (QBCore.Functions.GetPlayerData().job.name == jobName)
        else
            return false
        end
    end

    function GiveWorkVehicleKey(vehicle)
        exports["LegacyFuel"]:SetFuel(vehicle, 100)
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    end
end

if Config.framework == 'qbcore' or Config.framework == 'qb' then
    if Config.useNewQBExport then
        QBCore = exports['qb-core']:GetCoreObject()
    end

    if QBCore.Functions.GetPlayerData() and QBCore.Functions.GetPlayerData().job then
        PLAYER_JOB = QBCore.Functions.GetPlayerData().job.name
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PLAYER_JOB = QBCore.Functions.GetPlayerData().job.name
    end)


    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        PLAYER_JOB = JobInfo.name
    end)

    function CheckJob(jobTable)
        PLAYER_JOB = QBCore.Functions.GetPlayerData().job.name

        return Contains(jobTable, PLAYER_JOB)
    end
end

if Config.framework == 'esx' then
    ESX = nil

    if Config.useNewESXExport  then
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

    Citizen.CreateThread(function()
        while ESX == nil or ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        ESX.PlayerData = ESX.GetPlayerData()
        PLAYER_JOB = ESX.PlayerData.job.name
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
        PLAYER_JOB = job.name
    end)

    function CheckJob(jobTable)
        Citizen.CreateThread(function()
            while ESX == nil or ESX.GetPlayerData().job == nil do
                Citizen.Wait(10)
            end

            ESX.PlayerData = ESX.GetPlayerData()
            PLAYER_JOB = ESX.PlayerData.job.name
        end)

        return Contains(jobTable, PLAYER_JOB)
    end
end


-- This function is responsible for all the tooltips displayed on top right of the screen, you could
-- replace it with a custom notification etc.
function ShowTooltip(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

RegisterNetEvent('ls_papers:notify')
AddEventHandler('ls_papers:notify', function(message)
    ShowTooltip(message)
end)


function Contains(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function Debug(message)
    if Config.debug then
        print(message)
    end
end

function L(text)
    if Locale and Locale[text] then
        return Locale[text]
    end

    return text
end

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

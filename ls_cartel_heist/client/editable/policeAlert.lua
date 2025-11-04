----------------------
-- BLIPS
----------------------
local policeBlips = {}

RegisterNetEvent('ls_cartel_heist:activatePoliceAlarm')
AddEventHandler('ls_cartel_heist:activatePoliceAlarm', function(locationCoords)
    PoliceAlarm(locationCoords)
    SendDispatchMessage(L('Thieves were seen on the shore.') .. L('~w~ Get them!'), 'Beach lifeguard')
    Wait(15000)
    ClearPoliceBlips()
end)

RegisterNetEvent('ls_cartel_heist:TriggerDispatchMessage')
AddEventHandler('ls_cartel_heist:TriggerDispatchMessage', function(eventCoords)
    local system = Config.dispatch.system
    local blipData = Config.dispatch.blip

    if system == 'ps-dispatch' then
        exports['ps-dispatch']:CustomAlert({
            coords = eventCoords,
            message = Config.dispatch.eventName,
            dispatchCode = Config.dispatch.policeCode,
            description = Config.dispatch.description,
            radius = 0,
            sprite = blipData.sprite,
            color = blipData.color,
            scale = blipData.scale,
            length = 3,
            recipientList = Config.policeJobs
        })

    elseif system == 'core-dispatch-old' then
        local hash, _ = GetStreetNameAtCoord(eventCoords.x, eventCoords.y, eventCoords.z)
        local street = GetStreetNameFromHashKey(hash)
        for _, job in ipairs(Config.policeJobs) do
            TriggerServerEvent(
                    'core_dispatch:addCall',
                    Config.dispatch.policeCode,
                    Config.dispatch.eventName,
                    {{icon = 'fa-solid fa-user-police', info=street}},
                    {eventCoords[1], eventCoords[2], eventCoords[3]},
                    job,
                    blipData.timeout * 1000,
                    blipData.sprite,
                    blipData.color
            )
        end
    elseif system == 'core-dispatch-new' then
        local hash, _ = GetStreetNameAtCoord(eventCoords.x, eventCoords.y, eventCoords.z)
        local street = GetStreetNameFromHashKey(hash)
        for _, job in ipairs(Config.policeJobs) do
            exports['core_dispach']:addCall(
                    Config.dispatch.policeCode,
                    Config.dispatch.eventName,
                    {
                        {icon = 'fa-map-signs', info=street}
                    },
                    {eventCoords[1], eventCoords[2], eventCoords[3]},
                    job,
                    blipData.timeout * 1000,
                    blipData.sprite,
                    blipData.color
            )
        end

    elseif system == 'cd-dispatch' then
        local hash, _ = GetStreetNameAtCoord(eventCoords.x, eventCoords.y, eventCoords.z)
        local street = GetStreetNameFromHashKey(hash)

        exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.policeJobs,
            coords = eventCoords,
            title = Config.dispatch.policeCode,
            message = Config.dispatch.eventName,
            flash = 0,
            unique_id = 'ls_cartel_heist' .. tostring(math.random(0000000,9999999)),
            blip = {
                sprite = blipData.sprite,
                scale = blipData.scale,
                colour = blipData.color,
                flashes = blipData.showRadar,
                text = Config.dispatch.eventName,
                time = blipData.timeout * 1000,
                sound = 1,
            }
        })
    end
end)

function PoliceAlarm(locationCoords)
    local blipConf = Config.dispatch.blip
    local blip = CreatePoliceBlip(locationCoords, blipConf.sprite, blipConf.color, blipConf.alpha, blipConf.scale, L('Thieves'))
    SetBlipDisplay(blip, 8)
    table.insert(policeBlips, blip)
end

function ClearPoliceBlips()
    for k, blip in pairs(policeBlips) do
        RemoveBlip(blip)
    end
    policeBlips = {}
end

function CreatePoliceBlip(coords, sprite, color, alpha, scale, message)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blip, sprite)
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, color)
    SetBlipAlpha(blip, alpha)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(message)
    EndTextCommandSetBlipName(blip)
    return blip
end

---------------------
-- DISPATCH MESSAGES
----------------------


function SendDispatchMessage(message, subtitle)
    if not Config.dispatch.enable then
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(message)

        -- Set the notification icon, title and subtitle.
        local title = 'Alert'
        local iconType = 0
        local flash = false -- Flash doesn't seem to work no matter what.
        EndTextCommandThefeedPostMessagetext('CHAR_CHAT_CALL', 'CHAR_CHAT_CALL', flash, iconType, title, subtitle)

        -- Draw the notification
        local showInBrief = true
        local blink = false -- blink doesn't work when using icon notifications.
        EndTextCommandThefeedPostTicker(blink, showInBrief)
    else
        
    end

end
RegisterServerEvent('ls_cartel_heist:PoliceAlert')
AddEventHandler('ls_cartel_heist:PoliceAlert', function(locationCoords)
    local _source = source
    local identifier = GetIdentifier(_source)

    if not Config.dispatch.enabled then
        for _, playerId in ipairs(GetPlayers()) do
            playerId = tonumber(playerId)
            if IsPolice(playerId) then
                TriggerClientEvent('ls_cartel_heist:activatePoliceAlarm', playerId, locationCoords)
            end
        end
    else
        TriggerClientEvent('ls_cartel_heist:TriggerDispatchMessage', _source, locationCoords)
    end
end)


-- function CreatePoliceBlip(coords, sprite, data, hiddenLegend)
--     Citizen.CreateThread(function()
--         local blipData = Config.dispatch.blip
--         local blip = AddBlipForCoord(coords)

--         SetBlipSprite(blip, sprite)
--         SetBlipHighDetail(blip, true)
--         SetBlipColour(blip, blipData.color)
--         SetBlipAlpha(blip, 255)
--         SetBlipScale(blip, blipData.scale)
--         BeginTextCommandSetBlipName('STRING')
--         AddTextComponentString(data.title)
--         EndTextCommandSetBlipName(blip)
--         SetBlipAsShortRange(blip, false)
--         SetBlipHiddenOnLegend(blip, hiddenLegend or false)

--         RealWait(Config.dispatch.blip.timeout * 1000)

--         RemoveBlip(blip)
--     end)
-- end

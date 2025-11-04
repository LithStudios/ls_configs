-- Notifies the client to pull up the handbrake
-- Function gets called only once
function HandBrakeNotify()
    local time = GetGameTimer()
    local duration = 5000

    local message = string.format('Hold %s to pull your hand brake!', Config.handbrake_input.name)
    while GetGameTimer() < time + duration do
        Wait(0)
        SetTextComponentFormat("STRING")
        AddTextComponentString(message)
        EndTextCommandDisplayHelp(0, 0, 1, 0)
    end
end

function PlayAnim(dict, anim, duration)
    -- local dict = "veh@driveby@first_person@passenger_rear_right_handed@smg"
    -- local anim = "outro_90r"

    -- local ped = PlayerPedId()
    -- RequestAnimDict(dict)
    -- while not HasAnimDictLoaded(dict) do
    --     Wait(0)
    -- end
    -- TaskPlayAnim(ped, dict, anim, 8.0, -8.0, duration or 1000, 0, 0, false, false, false)
end

--Integration with kiminaze vehicle clamp
function CanUseHandbrake(vehicle)
    if GetResourceState('VehicleClamp') == 'started' then
        local isAnyWheelClamped = exports["VehicleClamp"]:IsAnyWheelClamped(vehicle)

        if isAnyWheelClamped then
            return false
        end
    end

    if Config.handbrake_input.when_engine_off then
        if GetIsVehicleEngineRunning(vehicle) then
            return false
        end
    end

    return true
end
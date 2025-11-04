---Must return true/false
function OnHackStart(locker_entity)
    local camera = HELPERS.custom_camera(locker_entity)
    
    local success = StartHackMinigame()

    if not success and Config.dispatch.enabled then
        SendDispatchAlert()
    end

    HELPERS.remove_camera(camera)

    return success
end

function StartHackMinigame()
    local promise = promise.new()

    SendNUIMessage({
        action = 'start_hack',
        codeLength = Config.hack.code_length,
        maxAttempts = Config.hack.max_attempts,
        timerLength = Config.hack.timer_length,
        is_debug = Config.debug
    })

    SetNuiFocus(true, true)

    RegisterNUICallback('hackComplete', function(data, cb)
        SetNuiFocus(false, false)
        promise:resolve(data.success)
        cb('ok')
    end)

    return Citizen.Await(promise)
end

function SendDispatchAlert()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local jobs = Config.dispatch.jobs
    local message = L('dispatch_message')
    local code = L('dispatch_code')
    local description = L('dispatch_description')
    local blip = Config.dispatch.blip
    exports['kq_link']:SendDispatchMessage({
        coords = coords,
        jobs = jobs, 
        message = message,
        code = code,
        description = description,
        blip = blip
    })
end
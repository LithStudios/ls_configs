-- Gets triggered when victim ped spawns
function OnPedSpawn(ped)
end

function CallDispatch()
    exports.kq_link:SendDispatchMessage({
            coords = GetEntityCoords(PlayerPedId()),
            jobs = Config.dispatch.jobs,
            message = HELPERS.locale('DISPATCH_TITLE'),
            description = HELPERS.locale('DISPATCH_MESSAGE'),
            code = HELPERS.locale('DISPATCH_CODE'),
            blip = Config.dispatch.blip
        })
end

-- Function responsible for looting item
function PerformItemLooting(object)
    local playerPed = PlayerPedId()
    local duration = 3000

    if IsPedInAnyVehicle(playerPed) or IsPedRagdoll(playerPed) or IsEntityDead(playerPed) then
        return false
    end

    RotateTillFree()
    local object_coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.0)
    PlaceObjectOnGroundProperly(object)
    FreezeEntityPosition(object, true)
    
    HELPERS.set_entity_looping_anim(PlayerPedId(), 'anim@heists@money_grab@duffel', 'loop')
    FreezeEntityPosition(playerPed, true)
    
    exports.kq_link:ProgressBar(GetEntityCoords(object), duration, 1)
    
    FreezeEntityPosition(playerPed, false)
    FreezeEntityPosition(object, false)
    ClearPedTasks(playerPed)
    
    return true, object
end

function CarryProp(prop_id)
    local loot_key = Config.inputs.loot.key
    local drop_key = Config.inputs.drop.key

    IS_CARRYING = true
    CURRENT_PROP = prop_id
    SetCurrentPedWeapon(PlayerPedId(), 'WEAPON_UNARMED', true)

    local input_text = HELPERS.locale('LOOT_CARRY')
    local input_text_formatted = string.format(input_text,
        Config.inputs.loot.control, Config.inputs.drop.control)
    
    Wait(300)
    ManageCarryingAnimation()

    while IS_CARRYING do
        Wait(1)
        LimitPlayerMovement()
        PreventDriverSeat()

        if not IsPedInAnyVehicle(PlayerPedId()) then
            HELPERS.input_message(input_text_formatted)

            if HELPERS.is_button_pressed(drop_key) then
                ClearPedTasks(PlayerPedId())
                DropProp()
                return
            end
            
            if HELPERS.is_button_pressed(loot_key) then
                ClearPedTasks(PlayerPedId())
                LootProp()
                return
            end
        end
    end
end
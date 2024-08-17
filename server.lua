local function lockdownDoors(doorIds)
    for _, doorId in ipairs(doorIds) do
        exports.ox_doorlock:setDoorState(doorId, true)
    end
end

local function unlockDoors(doorIds)
    for _, doorId in ipairs(doorIds) do
        exports.ox_doorlock:setDoorState(doorId, false)
    end
end

RegisterNetEvent('door_lockdown:lockdown')
AddEventHandler('door_lockdown:lockdown', function(doorIds)
    lockdownDoors(doorIds)
end)

RegisterNetEvent('door_lockdown:unlock')
AddEventHandler('door_lockdown:unlock', function(doorIds)
    unlockDoors(doorIds)
end)


RegisterNetEvent('door_lockdown:getAllDoors')
AddEventHandler('door_lockdown:getAllDoors', function()
    local source = source
    exports.oxmysql:execute('SELECT id, name, data FROM ox_doorlock', {}, function(doorlocks)
        TriggerClientEvent('door_lockdown:receiveDoors', source, doorlocks)
    end)
end)

lib.locale()

RegisterNetEvent('door_lockdown:receiveDoors')
AddEventHandler('door_lockdown:receiveDoors', function(doorlocks)
    local options = {}

    for _, door in ipairs(doorlocks) do
        local doorData = json.decode(door.data)
        local lockState = doorData.state == 1 and locale('locked') or locale('unlocked')
        local passcode = doorData.passcode
        local label = ''
        if doorData.passcode then
            label = string.format("%s (%d, %s, %s)", door.name, door.id, passcode, lockState)
        else
            label = string.format("%s (%d, %s)", door.name, door.id, lockState)
        end
        table.insert(options, {
            label = label,
            value = door.id
        })
    end

    local input = lib.inputDialog(locale('input_title'), {
        {
            type = 'checkbox',
            label = locale('all_doors'),
        },
        {
            type = 'multi-select', 
            name = 'selectedDoors',
            label = locale('selected_doors'),
            options = options
        },
        {
            type = 'select',
            name = 'action',
            label = locale('action'),
            options = {
                {label = locale('lock'), value = 'lock'},
                {label = locale('unlock'), value = 'unlock'}
            }
        }
    })

    if not input then
        return
    end

    local allDoors = input[1]
    local selectedDoors = input[2]
    local action = input[3]

    if allDoors or #selectedDoors > 0 then
        if allDoors then
            selectedDoors = {}
            for _, door in ipairs(doorlocks) do
                table.insert(selectedDoors, door.id)
            end
        end
        if action == 'lock' then
            TriggerServerEvent('door_lockdown:lockdown', selectedDoors)
            lib.notify(
                {
                    type = 'success',
                    title = locale('lockdown_notification_title'),
                }
            )
        else
            TriggerServerEvent('door_lockdown:unlock', selectedDoors)
            lib.notify(
                {
                    type = 'success',
                    title = locale('unlock_notification_title'),
                }
            )
        end
    end
end)


RegisterCommand('doors', function()
    TriggerServerEvent('door_lockdown:getAllDoors')
end)
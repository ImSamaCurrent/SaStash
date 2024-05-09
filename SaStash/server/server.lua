

ESX = exports['es_extended']:getSharedObject()


function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(Config.License) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('SaStash', function(source, args)
    if isAllowedToChange(source) then
        TriggerEvent('SAM:LoadStash')
        TriggerClientEvent('SAM_Stash:OpenMenu', source)
    end
end)

local AllStashIni = {}
local AllStash = {}

Citizen.CreateThread(function()
    while true do
        Refresh()
        Refresh2()
    Citizen.Wait(1000*60)
    end
end)


function Refresh()
    AllStashIni = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStashIni", {}, function(data)
        for i = 1, #data, 1 do
            exports['ox_inventory']:RegisterStash("SaStash-" .. data[i].name .. data[i].id, data[i].label, 40, 250000, "")
            table.insert(AllStashIni, {
                id = data[i].id,
                name = data[i].name,
                label = data[i].label,
                password = data[i].password
            })
        end
        TriggerClientEvent('SAM:RefresStashIni',-1,AllStashIni)
    end)
end

function Refresh2()
    AllStash = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStash", {}, function(data)
        for i = 1, #data, 1 do
            table.insert(AllStash, {
                id = data[i].id,
                name = data[i].name,
                coords = json.decode(data[i].coords),
                coords_props = json.decode(data[i].coords_props),
                heading = data[i].heading,
                props = data[i].props
            })
        end
        TriggerClientEvent('SAM:RefresStash',-1,AllStash, 1)
    end)
end

RegisterServerEvent('SAM:LoadStash')
AddEventHandler('SAM:LoadStash', function()
    local _src = source
    AllStash = {}
    AllStashIni = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStashIni", {}, function(data)
        for i = 1, #data, 1 do
            exports['ox_inventory']:RegisterStash("SaStash-" .. data[i].name .. data[i].id, data[i].label, 40, 250000, "")
            table.insert(AllStashIni, {
                id = data[i].id,
                name = data[i].name,
                label = data[i].label,
                password = data[i].password
            })
        end
        TriggerClientEvent('SAM:RefresStashIni',-1,AllStashIni)
    end)
    MySQL.Async.fetchAll("SELECT * FROM SaStash", {}, function(data)
        for i = 1, #data, 1 do
            table.insert(AllStash, {
                id = data[i].id,
                name = data[i].name,
                coords = json.decode(data[i].coords),
                coords_props = json.decode(data[i].coords_props),
                heading = data[i].heading,
                props = data[i].props
            })
        end
        TriggerClientEvent('SAM:RefresStash',-1,AllStash, 1)
    end)
end)


RegisterServerEvent('SAM:addStash')
AddEventHandler('SAM:addStash', function(name,coords,coords_props,heading,props)
    local _src = source
    MySQL.Async.execute('INSERT INTO SaStash (name, coords, coords_props, heading, props) VALUES (@name, @coords, @coords_props, @heading, @props)',{
        ['@name'] = name,
        ['@coords'] = json.encode(coords),
        ['@coords_props'] = json.encode(coords_props),
        ['@heading'] = heading,
        ['@props'] = props
    })
    Wait(150)
    Refresh2()
    Wait(150)
    TriggerClientEvent('SAM:RefresProps',-1)
    TriggerClientEvent('esx:showNotification', _src, "Vous avez créé un coffre !")
end)

RegisterServerEvent('SAM:addStashIni')
AddEventHandler('SAM:addStashIni', function(name,label,password)
    local _src = source
    MySQL.Async.execute('INSERT INTO SaStashIni (name, label, password) VALUES (@name, @label, @password)',{
        ['@name'] = name,
        ['@label'] = label,
        ['@password'] = password
    })
    Wait(150)
    Refresh()
    --TriggerClientEvent('esx:showNotification', _src, "Vous avez créé un elevateur !")
end)


RegisterServerEvent('SAM:updateSaStashlabel')
AddEventHandler('SAM:updateSaStashlabel', function(label,id)
    local _src = source
    MySQL.Async.execute('UPDATE SaStashIni SET label = @label WHERE id = @id', {
        ['@id'] = id,
        ['@label'] = label
        
    })
    Wait(150)
    Refresh()
    --Refresh2()
    TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié le (Nom) du coffre !")
end)

RegisterServerEvent('SAM:updateSaStashmdp')
AddEventHandler('SAM:updateSaStashmdp', function(mdp,id)
    local _src = source
    MySQL.Async.execute('UPDATE SaStashIni SET password = @password WHERE id = @id', {
        ['@id'] = id,
        ['@password'] = mdp
        
    })
    Wait(150)
    Refresh()
    --Refresh2()
    TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié le (MDP) du coffre !")
end)


RegisterServerEvent('SAM:updateSaStashProps')
AddEventHandler('SAM:updateSaStashProps', function(props,id)
    local _src = source
    MySQL.Async.execute('UPDATE SaStash SET props = @props WHERE id = @id', {
        ['@id'] = id,
        ['@props'] = props
        
    })
    Wait(150)
    --Refresh()
    Refresh2()
    Wait(150)
    TriggerClientEvent('SAM:RefresProps',-1)
    TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié le (Props) du coffre !")
end)

RegisterServerEvent('SAM:updateSaStashCoords')
AddEventHandler('SAM:updateSaStashCoords', function(coords,id)
    local _src = source
    MySQL.Async.execute('UPDATE SaStash SET coords = @coords WHERE id = @id', {
        ['@id'] = id,
        ['@coords'] = json.encode(coords)
        
    })
    Wait(150)
    --Refresh()
    Refresh2()
    TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié la (Position) du coffre !")
end)

RegisterServerEvent('SAM:updateSaStashCoords_props')
AddEventHandler('SAM:updateSaStashCoords_props', function(coords_props, heading, id)
    local _src = source
    MySQL.Async.execute('UPDATE SaStash SET coords_props = @coords_props WHERE id = @id', {
        ['@id'] = id,
        ['@coords_props'] = json.encode(coords_props)
        
    })
    Wait(250)
    MySQL.Async.execute('UPDATE SaStash SET heading = @heading WHERE id = @id', {
        ['@id'] = id,
        ['@heading'] = heading
        
    })
    Wait(250)
    --Refresh()
    Refresh2()
    Wait(150)
    TriggerClientEvent('SAM:RefresProps',-1)
    TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié la (Position) du coffre !")
end)


-- RegisterServerEvent('SAM:updateElevatorcoords')
-- AddEventHandler('SAM:updateElevatorcoords', function(coords,id)
--     local _src = source
--     MySQL.Async.execute('UPDATE SaElevator_Points SET coords = @coords WHERE id = @id', {
--         ['@id'] = id,
--         ['@coords'] = json.encode(coords)
        
--     })
--     TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié un elevateur !")
-- end)

-- RegisterServerEvent('SAM:updateElevatorjob')
-- AddEventHandler('SAM:updateElevatorjob', function(job,id)
--     local _src = source
--     MySQL.Async.execute('UPDATE SaElevator_Points SET job = @job WHERE id = @id', {
--         ['@id'] = id,
--         ['@job'] = job
        
--     })
--     TriggerClientEvent('esx:showNotification', _src, "Vous avez modifié un elevateur !")
-- end)





RegisterServerEvent('SAM:removeStash')
AddEventHandler('SAM:removeStash', function(id)
    local _src = source
    MySQL.Async.execute('DELETE FROM SaStash WHERE id = @id', {
        ['@id'] = id
    })
    Wait(150)
    --Refresh()
    Refresh2()
    Wait(150)
    TriggerClientEvent('SAM:RefresProps',-1)
    TriggerClientEvent('esx:showNotification', _src, "Vous avez supprimé un coffre !")
end)

RegisterServerEvent('SAM:removeStashIni')
AddEventHandler('SAM:removeStashIni', function(id, inv)
    local _src = source
    MySQL.Async.execute('DELETE FROM SaStashIni WHERE id = @id', {
        ['@id'] = id
    })
    exports.ox_inventory:ClearInventory(inv)
    Wait(150)
    Refresh()
    --Refresh2()
    --TriggerClientEvent('esx:showNotification', _src, "Vous avez supprimé un elevateur !")
end)





















RegisterServerEvent('SAM:TpPlayerCoords')
AddEventHandler('SAM:TpPlayerCoords', function(id,coords)
    TriggerClientEvent('SAM:TpPlayerCoords', id, coords)
    TriggerClientEvent('SAM:TpPlayerCoords', source, coords)
end)
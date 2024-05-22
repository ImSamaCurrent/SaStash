

ESX = exports['es_extended']:getSharedObject()

ox_inventory = exports.ox_inventory

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(Config.Settings.License) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand(Config.Settings.RegisterCommand, function(source, args)
    if isAllowedToChange(source) then
        TriggerEvent('SAM:LoadStash')
        TriggerClientEvent('SAM_Stash:OpenMenu', source)
    end
end)

local AllStashIni = {}
local AllStash = {}
WebhooksTable = {}

Citizen.CreateThread(function()
    print("By ^1Im.Sama^7")
    while true do
        Refresh()
        Refresh2()
    Citizen.Wait(1000 * 60 * Config.Settings.Refresh_Interval)
    end
end)

RegisterServerEvent('SAM:RemoveLockpickItemsSaStash')
AddEventHandler('SAM:RemoveLockpickItemsSaStash', function()
    local _src = source
    ox_inventory:RemoveItem(_src, Config.Settings.LockpickItems, Config.Settings.RemoveLockpickItemsFail)
end)


function Refresh()
    AllStashIni = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStashIni", {}, function(data)
        for i = 1, #data, 1 do
            ox_inventory:RegisterStash("SaStash-" .. data[i].name .. data[i].id, data[i].label, data[i].slot, data[i].weight, "")
            table.insert(AllStashIni, {
                id = data[i].id,
                name = data[i].name,
                label = data[i].label,
                password = data[i].password,
                slot = data[i].slot,
                weight = data[i].weight
            })
        end
        TriggerClientEvent('SAM:RefresStashIni',-1,AllStashIni)
        print("[^3SaStashIni^7] ^2loaded^7 Total ^9"..tostring(#data).."^7")
    end)
end

function Refresh2()
    AllStash = {}
    WebhooksTable = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStash", {}, function(data)
        for i = 1, #data, 1 do
            table.insert(AllStash, {
                id = data[i].id,
                name = data[i].name,
                coords = json.decode(data[i].coords),
                coords_props = json.decode(data[i].coords_props),
                heading = data[i].heading,
                props = data[i].props,
                webhooks = i
            })
            table.insert(WebhooksTable, data[i].webhooks)
        end
        TriggerClientEvent('SAM:RefresStash',-1,AllStash, 1)
        print("[^3SaStash^7] ^2loaded^7 Total ^9"..tostring(#data).."^7")
    end)
end

RegisterServerEvent('SAM:LoadStash')
AddEventHandler('SAM:LoadStash', function()
    local _src = source
    AllStash = {}
    AllStashIni = {}
    WebhooksTable = {}
    MySQL.Async.fetchAll("SELECT * FROM SaStashIni", {}, function(data)
        for i = 1, #data, 1 do
            ox_inventory:RegisterStash("SaStash-" .. data[i].name .. data[i].id, data[i].label, data[i].slot, data[i].weight, "")
            table.insert(AllStashIni, {
                id = data[i].id,
                name = data[i].name,
                label = data[i].label,
                password = data[i].password,
                slot = data[i].slot,
                weight = data[i].weight
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
                props = data[i].props,
                webhooks = i
            })
            table.insert(WebhooksTable, data[i].webhooks)
        end
        TriggerClientEvent('SAM:RefresStash',-1,AllStash, 1)
    end)
end)


RegisterServerEvent('SAM:addStash')
AddEventHandler('SAM:addStash', function(name, coords, coords_props, heading, props, webhook)
    local _src = source
    if isAllowedToChange(_src) then
        webhook = webhook or ""
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('INSERT INTO SaStash (name, coords, coords_props, heading, props, webhooks) VALUES (@name, @coords, @coords_props, @heading, @props, @webhooks)',{
            ['@name'] = name,
            ['@coords'] = json.encode(coords),
            ['@coords_props'] = json.encode(coords_props),
            ['@heading'] = heading,
            ['@props'] = props,
            ['@webhooks'] = webhook
        })
        Wait(150)
        Refresh2()
        Wait(150)
        TriggerClientEvent('SAM:RefresProps',-1)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_CreateCoffre_title, string.format(Config.Lang.Webhooks_CreateCoffre, playername, name, coords), 10181046, Config.Webhooks.Create_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Create_locker.." "..name)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_CreateCoffre_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:addStashIni')
AddEventHandler('SAM:addStashIni', function(name, label, password, slot, weight)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        slot = tonumber(slot)
        weight = tonumber(weight)
        MySQL.Async.execute('INSERT INTO SaStashIni (name, label, password, slot, weight) VALUES (@name, @label, @password, @slot, @weight)',{
            ['@name'] = name,
            ['@label'] = label,
            ['@password'] = password,
            ['@slot'] = slot,
            ['@weight'] = weight
        })
        Wait(150)
        Refresh()
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_CreateStash_title, string.format(Config.Lang.Webhooks_CreateStash, playername, label, name), 10181046, Config.Webhooks.Create_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_name)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_CreateStash_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)


RegisterServerEvent('SAM:updateSaStashlabel')
AddEventHandler('SAM:updateSaStashlabel', function(label, id, name, coffre, webhook)
    local _src = source
    local playername = GetPlayerName(_src)
    MySQL.Async.execute('UPDATE SaStashIni SET label = @label WHERE id = @id', {
        ['@id'] = id,
        ['@label'] = label
        
    })
    Wait(150)
    Refresh()
    --Refresh2()
    if webhook ~= nil or webhook ~= "" then
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateStash_title, string.format(Config.Lang.Webhooks_UpdateStash, playername, name), 3447003, webhook)
    end
    sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateStash_title, string.format(Config.Lang.Webhooks_UpdateStash2, playername, name, coffre), 3447003, Config.Webhooks.Label_Webhook)
    TriggerClientEvent('esx:showNotification', _src, Config.Lang.Create_vault.." "..name)
end)

RegisterServerEvent('SAM:updateSaStashmdp')
AddEventHandler('SAM:updateSaStashmdp', function(mdp, id, name, coffre, webhook)
    local _src = source
    local playername = GetPlayerName(_src)
    MySQL.Async.execute('UPDATE SaStashIni SET password = @password WHERE id = @id', {
        ['@id'] = id,
        ['@password'] = mdp
        
    })
    Wait(150)
    Refresh()
    --Refresh2()
    if webhook ~= nil or webhook ~= "" then
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdatePassword_title, string.format(Config.Lang.Webhooks_UpdatePassword, playername, name), 3447003, webhook)
    end
    sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdatePassword_title, string.format(Config.Lang.Webhooks_UpdatePassword2, playername, name, coffre), 3447003, Config.Webhooks.Password_Webhook)
    TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_mdp)
end)


RegisterServerEvent('SAM:updateSaStashSlot')
AddEventHandler('SAM:updateSaStashSlot', function(slot, id, name, coffre)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        slot = tonumber(slot)
        MySQL.Async.execute('UPDATE SaStashIni SET slot = @slot WHERE id = @id', {
            ['@id'] = id,
            ['@slot'] = slot
            
        })
        Wait(150)
        Refresh()
        --Refresh2()
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateSlot_title, string.format(Config.Lang.Webhooks_UpdateSlot, playername, name, coffre), 3447003, Config.Webhooks.Slot_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_mdp)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateSlot_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:updateSaStashWeight')
AddEventHandler('SAM:updateSaStashWeight', function(weight, id, name, coffre)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        weight = tonumber(weight)
        MySQL.Async.execute('UPDATE SaStashIni SET weight = @weight WHERE id = @id', {
            ['@id'] = id,
            ['@weight'] = weight
            
        })
        Wait(150)
        Refresh()
        --Refresh2()
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateWeight_title, string.format(Config.Lang.Webhooks_UpdateWeight, playername, name, coffre), 3447003, Config.Webhooks.Weight_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_mdp)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateWeight_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)


RegisterServerEvent('SAM:updateSaStashProps')
AddEventHandler('SAM:updateSaStashProps', function(props, id, name)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('UPDATE SaStash SET props = @props WHERE id = @id', {
            ['@id'] = id,
            ['@props'] = props
            
        })
        Wait(150)
        --Refresh()
        Refresh2()
        Wait(150)
        TriggerClientEvent('SAM:RefresProps',-1)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateProps_title,  string.format(Config.Lang.Webhooks_UpdateProps, playername, name), 3447003, Config.Webhooks.Props_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_props)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateProps_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:updateSaStashCoords')
AddEventHandler('SAM:updateSaStashCoords', function(coords, id, name)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('UPDATE SaStash SET coords = @coords WHERE id = @id', {
            ['@id'] = id,
            ['@coords'] = json.encode(coords)
            
        })
        Wait(150)
        --Refresh()
        Refresh2()
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateCoords_title,  string.format(Config.Lang.Webhooks_UpdateCoords, playername, name, coords), 3447003, Config.Webhooks.Coords_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_menu)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateCoords_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:updateSaStashCoords_props')
AddEventHandler('SAM:updateSaStashCoords_props', function(coords_props, heading, id, name)
    local _src = source
    if isAllowedToChange(_src) then
        local _src = source
        local playername = GetPlayerName(_src)
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
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdatePropsCoords_title,  string.format(Config.Lang.Webhooks_UpdatePropsCoords, playername, name, coords_props), 3447003, Config.Webhooks.Coords_props_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_prop)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdatePropsCoords_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:updateSaStashWebhooks')
AddEventHandler('SAM:updateSaStashWebhooks', function(webhook, id, name)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('UPDATE SaStash SET webhooks = @webhooks WHERE id = @id', {
            ['@id'] = id,
            ['@webhooks'] = webhook
            
        })
        Wait(250)
        --Refresh()
        Refresh2()
        Wait(150)
        TriggerClientEvent('SAM:RefresProps',-1)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateWebhooks_title,  string.format(Config.Lang.Webhooks_UpdateWebhooks, playername, name), 15548997, Config.Webhooks.Coords_props_Webhook)
        TriggerClientEvent('esx:showNotification', _src, Config.Lang.Edit_locker_prop)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_UpdateWebhooks_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)


RegisterServerEvent('SAM:removeStash')
AddEventHandler('SAM:removeStash', function(id, name)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('DELETE FROM SaStash WHERE id = @id', {
            ['@id'] = id
        })
        Wait(150)
        --Refresh()
        Refresh2()
        Wait(150)
        TriggerClientEvent('SAM:RefresProps',-1)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_DeleteVault_title, string.format(Config.Lang.Webhooks_DeleteVault, playername, name), 15548997, Config.Webhooks.Delete_Webhook)
        TriggerClientEvent('esx:showNotification', _src,  Config.Lang.Delet_vault.." "..name)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_DeleteVault_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)

RegisterServerEvent('SAM:removeStashIni')
AddEventHandler('SAM:removeStashIni', function(id, inv, name, coffre)
    local _src = source
    if isAllowedToChange(_src) then
        local playername = GetPlayerName(_src)
        MySQL.Async.execute('DELETE FROM SaStashIni WHERE id = @id', {
            ['@id'] = id
        })
        ox_inventory:ClearInventory(inv)
        Wait(150)
        Refresh()
        --Refresh2()
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_DeleteStash_title, string.format(Config.Lang.Webhooks_DeleteStash, playername, name, coffre), 15548997, Config.Webhooks.Delete_Webhook)
        TriggerClientEvent('esx:showNotification', _src,  Config.Lang.Delet_locker.." "..name)
    else
        ReturnPlayerIdentifiers(_src)
        Wait(150)
        sendToDiscordWithSpecialURL(Config.Lang.Webhooks_DeleteStash_title, "**__"..GetPlayerName(_src).."__**\nyou are not authorized to use this trigger. \nlicense: **"..license.."**\nSteam: **"..steamid.."**\nDiscord: <@"..discord:gsub("discord:", "")..">   |   IdDiscord: **"..discord:gsub("discord:", "").."**", 15548997, Config.Webhooks.Kick_player_Webhook)
        DropPlayer(_src,"you are not authorized to use this trigger")
    end
end)



RegisterServerEvent('SAM:sendToDiscordWithSpecialURL')
AddEventHandler('SAM:sendToDiscordWithSpecialURL', function(title, message, color, url, wait)
    local webhooks = WebhooksTable[url]
    if string.sub(webhooks, 1, string.len("https://discord.com/api/webhooks/")) == "https://discord.com/api/webhooks/" then
        wait = wait or 0
        Wait(wait)
        sendToDiscordWithSpecialURL(title, message, color, webhooks)
    end
end)

RegisterServerEvent('SAM:sendToDiscordWithSpecialURLStaff')
AddEventHandler('SAM:sendToDiscordWithSpecialURLStaff', function(title, message, color, type)
    if type == "lockpick" then
        local webhooks = Config.Webhooks.LockpickOpen_Webhook
    elseif type == "open" then
        local webhooks = Config.Webhooks.Open_Webhook
    -- elseif type == "" then
    --     local webhooks = 
    end
    sendToDiscordWithSpecialURL(title, message, color, webhooks)
end)

-- local playername = GetPlayerName(source)
-- color embed discord https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812

function sendToDiscordWithSpecialURL(title, message, color, url)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local year  = os.date("%Y")
    local month     = os.date("%m")
    local day   = os.date("%d")
    local hour  = os.date("%H")
    local minutes   = os.date("%M")

    local url = url

    local embeds = {
        {
            ["title"]= title,
            ["description"] = message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"] = {
                ["text"] = "SaStash |  Date "..day.."/"..month.."/"..year.."  |  Heure "..hour..":"..minutes,
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1190090809484251258/1197939245332045875/team_jsaipa2.png?ex=66458a1c&is=6644389c&hm=aaedd1e64781b016c037169f93d00f72ced9c01e48c19f03e36d6123dab5ffa9&",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({
        username = Config.Webhooks.Username,
        embeds = embeds,
        avatar_url = Config.Webhooks.Avatar
    }), { ['Content-Type'] = 'application/json' })
end


function ReturnPlayerIdentifiers(source)
    steamid  = "nil"
    license  = "nil"
    discord  = "nil"

  for k,v in pairs(GetPlayerIdentifiers(source))do

      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      end
  end
end





Citizen.CreateThread(function()
    if Config.Settings.UseGizmo then
        local object_gizmo = GetResourceState('object_gizmo') 
        print(object_gizmo)
        if object_gizmo == "stopped" or object_gizmo == "stopping" or object_gizmo == "uninitialized" or object_gizmo == "unknown" then
            print("^1Please start: ^3object_gizmo ")
        end
    end

    if Config.Settings.OxTarget then
        local ox_target = GetResourceState('ox_target') 
        if ox_target == "stopped" or ox_target == "stopping" or  ox_target == "uninitialized" or ox_target == "unknown" then
            print("^1Please start: ^3ox_target ")
        end
    end

    local ox_inventory = GetResourceState('ox_inventory') 
    if ox_inventory == "stopped"  or ox_inventory == "stopping" or ox_inventory == "uninitialized" or ox_inventory == "unknown" then
        print("^1Please start: ^3ox_inventory ")
    end
end)


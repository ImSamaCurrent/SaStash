

function NumberLockpicking()
    if Config.Settings.LockpickNumber == 1 then
        return {math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 2 then
        return {math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 3 then
        return {math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 4 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 5 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 6 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 7 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 8 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 9 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    elseif Config.Settings.LockpickNumber == 10 then
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    else
        return {math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99), math.random(0,99)}
    end
end

--OxInventory

function GetItemsLockpickVault()
	return exports['ox_inventory']:GetItemCount(Config.Settings.LockpickItems)
end

function CloseInventory()
	exports['ox_inventory']:closeInventory()
end

function OpenInventory(value, stash, chest, Webhooks)
    stash = stash or "Error Webhooks Stash Plyer"
    if Webhooks ~= nil or Webhooks ~= "" then
        TriggerServerEvent('SAM:sendToDiscordWithSpecialURL', Config.Lang.Webhooks_Open_title,  string.format(Config.Lang.Webhooks_Open, GetPlayerName(PlayerId()), stash), 5793266, Webhooks)
    end
    TriggerServerEvent('SAM:sendToDiscordWithSpecialURL', Config.Lang.Webhooks_Open_title, string.format(Config.Lang.Webhooks_Open2, GetPlayerName(PlayerId()), stash, chest), 5793266, Config.Webhooks.Open_Webhook)
	exports['ox_inventory']:openInventory('stash', {id = 'SaStash-'..value, owner = ""})
end

--- Create OxTarget


local AllTarget = {}

function initarget()
    for i = 1, #AllStash, 1 do
        local Stat = AllStash[i]
        local targetnumber = exports.ox_target:addBoxZone({
            coords = vec3(AllStash[i].coords.x, AllStash[i].coords.y, AllStash[i].coords.z),
            size = vec3(1.5, 1.5, 2.5),
            rotation = tonumber(AllStash[i].heading),
            debug = Config.Settings.Debug_OxTarget,
            drawSprite = true,
            options = {
                {   
                    distance = 3,
                    name = 'chest:'..i,
                    icon = 'fa-solid fa-vault',
                    label = Config.Lang.Stash,
                    Stat = Stat,
                    onSelect = function(data)
                        TriggerEvent('SAM:OpenByTarget', Stat)
                    end

                }
            }
        })
        table.insert(AllTarget, targetnumber)
    end
end

function deltarget()
    for i = 1, #AllTarget, 1 do
        exports.ox_target:removeZone(AllTarget[i])
    end
    AllTarget = {}
end

AddEventHandler('SAM:OpenByTarget', function(Stat)
    DebugPrint('GetNumberItemLockpick',GetItemsLockpickVault())
    if GetItemsLockpickVault() > 0 then
        OpenMenuStash(Stat.name, Stat.webhooks, Stat.coords.x, Stat.coords.y, Stat.coords.z, true)
    else
        OpenMenuStash(Stat.name, Stat.webhooks, Stat.coords.x, Stat.coords.y, Stat.coords.z, false)
    end
end)





--- Gizmo 


function GizmoVault(type)

    
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local Ent = nil
    if type ==  "Edit_marker" or type ==  "Edit_oxtarget" then
        objectCoords = GestionCoords
        obj = GestionPropsHash
    elseif type ==  "Create_marker" or type ==  "Create_oxtarget" then
        objectCoords = (coords + forward * 2.0)
        if PropsIni == nil then
            obj = "h4_prop_h4_safe_01a"
        else
            obj = PropsIni
        end
    end

    Ent = SpawnObject(obj, objectCoords)
    SetEntityHeading(Ent, GestionPropsHeading)
    --PlaceObjectOnGroundProperly(Ent)
    SetEntityAlpha(Ent2, 0, 0)
    SetEntityCollision(Ent, false, true)
    local placed = false

    for i = 1, #Config.Props, 1 do
        local Props = Config.Props[i]
        if obj == Props.value then
            Pos_X_Type = Props.Gizmo_ajust
            Pos_X_Ajust = Props.Gizmo_axe_x
        end
    end

    exports['object_gizmo']:useGizmo(Ent)

    while not placed do
        Citizen.Wait(0)

        ESX.ShowHelpNotification("~INPUT_VEH_SHUFFLE~ - Tp sur le joueur\n~INPUT_PARACHUTE_DETACH~ - Gizmo\n~INPUT_SPRINT~ - tourner de 90°\n~INPUT_VEH_DROP_PROJECTILE~ - placer au sol\n~INPUT_CONTEXT~ - Placer\n~INPUT_FRONTEND_RRIGHT~ - Annuler")
        local CurrentCoords = GetEntityCoords(Ent)
        local CurrentHeading = GetEntityHeading(Ent)
        DisableControlAction(0, 245, true)  -- Chat
        DisableControlAction(0, 44, true)
        HudForceWeaponWheel(false)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)

            if Config.Settings.OxTarget then
                DebugDrawBox_gizmo(Ent, Pos_X_Type, Pos_X_Ajust)
            end

        if IsControlJustPressed(0, 194) then
            DeleteObject(Ent)
            placed = true
            EnableControlAction(0, 152, true)
            return false
        end


        if IsControlPressed(0, 104) then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            SetEntityCoords(Ent, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, true)
        end

         if IsControlJustPressed(0, 145) then
              exports['object_gizmo']:useGizmo(Ent)
        end

        if IsControlJustPressed(0, 21) then
            CurrentHeading = CurrentHeading - 90.0
            SetEntityHeading(Ent, CurrentHeading)
        end

        if IsControlPressed(0, 105) then
            PlaceObjectOnGroundProperly(Ent)
        end
        if IsControlJustReleased(1, 38) then 
            placed = true
            EnableControlAction(0, 152, true)

            for i = 1, #Config.Props, 1 do
                local Props = Config.Props[i]
                if obj == Props.value then
                    print(obj , Props.value, tonumber(Props.Gizmo_axe_x))
                    if Props.Gizmo_ajust == "+"then
                        CurrentCoordsf = vec3(CurrentCoords.x, CurrentCoords.y, CurrentCoords.z + tonumber(Props.Gizmo_axe_x))
                    elseif Props.Gizmo_ajust == "-"then
                        CurrentCoordsf = vec3(CurrentCoords.x, CurrentCoords.y, CurrentCoords.z - tonumber(Props.Gizmo_axe_x))
                    else
                        CurrentCoordsf = CurrentCoordsf
                    end
                end
            end



            if type == "Create_marker" then
                pCoords2 = CurrentCoordsf
                pCoords2h = GetEntityHeading(Ent)
            elseif type ==  "Create_oxtarget" then
                pCoords2 = CurrentCoordsf
                pCoords2h = GetEntityHeading(Ent)
                MenuCoords = CurrentCoordsf
            elseif type ==  "Edit_marker" then
                TriggerServerEvent('SAM:updateSaStashCoords_props', CurrentCoordsf, GetEntityHeading(Ent), GestionId, GestionName)
                stat2 = "~b~🔄~s~"
                GestionCoords = CurrentCoordsf
                GestionCoords_x = CurrentCoordsf.x
                GestionCoords_y = CurrentCoordsf.y
                GestionCoords_z = CurrentCoordsf.z
                heading = GetEntityHeading(Ent)
            elseif type ==  "Edit_oxtarget" then
                TriggerServerEvent('SAM:updateSaStashCoords', CurrentCoordsf, GestionId, GestionName)
                TriggerServerEvent('SAM:updateSaStashCoords_props', CurrentCoordsf, GetEntityHeading(Ent), GestionId, GestionName)
                stat1 = "~b~🔄~s~"
                stat2 = "~b~🔄~s~"
                GestionCoords = CurrentCoordsf
                GestionCoords_x = CurrentCoordsf.x
                GestionCoords_y = CurrentCoordsf.y
                GestionCoords_z = CurrentCoordsf.z
                heading = GetEntityHeading(Ent)
            end
            Wait(100)
            DeleteEntity(Ent)
            return true
        end
    end
end






--- Delet Props



allprops = {}
local RefreshValue = 100

function deleteProps()
    if allprops[1] ~= nil then
        for i=1, #allprops, 1 do
        DeleteEntity(allprops[i])
        allprops[i] = nil
        end
    end
end

function SetProps(number)
    --DebugPrint(RefreshValue)
    RefreshValue = RefreshValue + number
    if RefreshValue > 5 then
        deleteProps()
        Wait(50)
        for k, v in pairs(AllStash) do
            if v.props ~= nil then
                local heading = tonumber(v.heading)
                local hash = v.props
                while not HasModelLoaded(hash) do 
                    RequestModel(hash) Wait(20) 
                end 
                PropsStash = CreateObject(hash, v.coords_props.x, v.coords_props.y, v.coords_props.z - 0.99, false, false, false)
                SetEntityHeading(PropsStash, heading)
                FreezeEntityPosition(PropsStash, true)
                table.insert(allprops,PropsStash)
            end
        end
        RefreshValue = 0
    end
end








--- Draw text 3d


function DrawName3D(x,y,z, text) -- some useful function, use it if you want!
    SetDrawOrigin(x, y, z, 0);
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.0, 0.23)
    SetTextColour(232, 142, 155, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end





--- Request and spawn object

function SpawnObject(model, coords)
    local model = GetHashKey(model)
    RequestModels(model)
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
    return obj
end

function RequestModels(modelHash)
    if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end
end



--- Pour les Listes

function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end


--- Debug 


function DebugPrint(...)
    if Config.Settings.Debug_Print then
        print(...)
    end
    if Config.Settings.Debug_Print == 'traceback' then
        print(debug.traceback(...))
    end
end


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  deleteProps()
end)
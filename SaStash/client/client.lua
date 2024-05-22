ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    PlayerLoaded = true
    TriggerServerEvent('SAM:LoadStash')
end)



------------------------------------------------------------------------------------------------


AllStash = {}
AllStashIni = {}

filterArray = {Config.Lang.filterArray1, Config.Lang.filterArray2, Config.Lang.filterArray3, Config.Lang.filterArray4, Config.Lang.filterArray5, Config.Lang.filterArray6, Config.Lang.filterArray7,};
filter = 1;

filterArray_main = {Config.Lang.filterArray_main1, Config.Lang.filterArray_main2, Config.Lang.filterArray_main3};
filter_main = 1;

filterArray_main_crack = {Config.Lang.filterArray_main1, Config.Lang.filterArray_main2, Config.Lang.filterArray_main3, Config.Lang.filterArray_crack_open};
filter_main_crack = 1;

NameIni = ""
WebhooksIni = ""
PropsIni = nil
label = {}
password = {}
slot = {}
weight = {}

MenuCoords = nil 
pCoords2Menu = nil

pCoords2MenuEdit = nil

desc = ""

PreOxTarget = false

RegisterNetEvent('SAM:RefresStashIni')
AddEventHandler('SAM:RefresStashIni', function(data)
    AllStashIni = data
end)

RegisterNetEvent('SAM:RefresStash')
AddEventHandler('SAM:RefresStash', function(data,number)
    AllStash = data
    if Config.Settings.OxTarget then
        deltarget()
        Wait(100)
        initarget()
    end
    SetProps(number)
end)

RegisterNetEvent('SAM:RefresProps')
AddEventHandler('SAM:RefresProps', function()
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
end)



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('SAM_Stash:OpenMenu')
AddEventHandler('SAM_Stash:OpenMenu', function()
    OpenMenuGStash()
end)


local MenuGElevator = false

RMenu.Add('SaStashStaff', 'main', RageUI.CreateMenu(Config.Lang.Menu_name, "INTERACTION"))
RMenu.Add('SaStashStaff', 'create_main', RageUI.CreateSubMenu(RMenu:Get('SaStashStaff', 'main'),Config.Lang.Menu_name, "INTERACTION"))
RMenu.Add('SaStashStaff', 'gestion_main', RageUI.CreateSubMenu(RMenu:Get('SaStashStaff', 'main'),Config.Lang.Menu_name, "INTERACTION"))
RMenu.Add('SaStashStaff', 'gestion_edit', RageUI.CreateSubMenu(RMenu:Get('SaStashStaff', 'gestion_main'),Config.Lang.Menu_name, "INTERACTION"))
RMenu:Get('SaStashStaff', 'main'):SetRectangleBanner(0,0,0)
RMenu:Get('SaStashStaff', 'create_main'):SetRectangleBanner(0,0,0)
RMenu:Get('SaStashStaff', 'gestion_main'):SetRectangleBanner(0,0,0)
RMenu:Get('SaStashStaff', 'gestion_edit'):SetRectangleBanner(0,0,0)
RMenu:Get('SaStashStaff', 'main').Closed = function() 
    MenuGElevator = false
end 
RMenu:Get('SaStashStaff', 'gestion_main').Closed = function() 
    getname = false
end 


function OpenMenuGStash()
    deleton = false
    NameIni = ""
    WebhooksIni = nil
    PropsIni = nil
    label = {}
    password = {}
    slot = {}
    weight = {}

    MenuCoords = nil 
    pCoords2Menu = nil

    pCoords2MenuEdit = nil

    pCoords2 = nil
    pCoords2h = nil

    GetForSave_color = "~r~"

    if MenuGElevator then
        MenuGElevator = false
    else
        MenuGElevator = true
        RageUI.Visible(RMenu:Get('SaStashStaff', 'main'), true)
        Citizen.CreateThread(function()
            while MenuGElevator do
                Wait(1)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------









                RageUI.IsVisible(RMenu:Get('SaStashStaff', 'main'), true, true, true, function()
                    deleton = true
                    RageUI.Separator()

                    RageUI.Button(Config.Lang.Create_Menu, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            NameIni = ""
                            WebhooksIni = nil
                            PropsIni = nil
                            label = {}
                            password = {}
                            slot = {}
                            weight = {}

                            MenuCoords = nil 
                            pCoords2Menu = nil

                            pCoords2MenuEdit = nil

                            pCoords2 = nil
                            pCoords2h = nil

                            GetForSave_color = "~r~"
                        end
                    end,RMenu:Get('SaStashStaff', 'create_main'))

                    RageUI.Separator()

                    RageUI.Button(Config.Lang.Gestion_Menu, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end,RMenu:Get('SaStashStaff', 'gestion_main'))

                    

                end, function() 
                end)















------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------









                RageUI.IsVisible(RMenu:Get('SaStashStaff', 'create_main'), true, true, true, function()
                    if NameIni == nil or NameIni == "" then NameIni = "~r~❌~s~" end

                    if Config.Settings.OxTarget and not Config.Settings.UseGizmo then
                        RageUI.Checkbox(Config.Lang.PreviewOxTarget, nil, PreOxTarget,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
                            if Selected then
                                PreOxTarget = Checked
                                if Checked then
                                else
                                end
                            end
                        end)
                    
                        RageUI.Separator()
                    end

                    RageUI.Button(Config.Lang.Name_stash, desc, { RightLabel = "~HC_45~"..NameIni.."~s~" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetName = lib.inputDialog(Config.Lang.Name_stash_imput, {
                              {type = 'input', label = Config.Lang.Name_stash_imput, default = '', password = false, required = true, min = 1, max = 50}
                            })
                            if not SetName then return "return" end 
                            if SetName[1] ~= nil or SetName[1] ~= "" then
                                NameIni = SetName[1]
                            end 
                        end
                    end)

                    if WebhooksIni == nil then 
                        WebhooksInistat = "~r~❌~s~"
                    else 
                        WebhooksInistat = "~b~✅~s~"
                    end 

                    RageUI.Button(Config.Lang.AddWebhooks, Config.Lang.AddWebhooks_desc, { RightLabel = "~HC_45~"..WebhooksInistat.."~s~" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetWebhooks = lib.inputDialog(Config.Lang.AddWebhooks, {
                              {type = 'input', label = Config.Lang.AddWebhooks, default = '', password = false, required = true, min = 1}
                            })
                            if not SetWebhooks then return "return" end 
                            if SetWebhooks[1] ~= nil or SetWebhooks[1] ~= "" then
                                WebhooksIni = SetWebhooks[1]
                            end 
                        end
                    end)

                    RageUI.Separator()


                    if not Config.Settings.OxTarget then


                            if NameIni == "~r~❌~s~" then 
                                GetForSave = false
                            else 
                                if pCoordsMenu == "~r~❌~s~" then 
                                    GetForSave = false
                                else 
                                    if pCoords2Menu == "~r~❌~s~" then 
                                        GetForSave = false
                                    else 
                                        if #label < 1 then
                                            GetForSave = false
                                        else 
                                            GetForSave = true
                                        end 
                                    end 
                                end 
                            end 

                        
                            if MenuCoords == nil then 
                                pCoordsMenu = "~r~❌~s~"
                            else 
                                pCoordsMenu = "~b~✅~s~"
                            end 

                        RageUI.Button(Config.Lang.Pos_menu_label, desc, {RightLabel = pCoordsMenu}, true, function(_,a,s)
                            if s then
                                local pPed = PlayerPedId()
                                local pCoords = GetEntityCoords(pPed)
                                MenuCoords = pCoords
                            end
                        end)


                             
                            if pCoords2 == nil then 
                                pCoords2Menu = "~r~❌~s~"
                            else 
                                pCoords2Menu = "~b~✅~s~"
                            end 

                        RageUI.Button(Config.Lang.Pos_props_label, desc, {RightLabel = pCoords2Menu}, true, function(_,_,s)
                            if s then
                                if not Config.Settings.UseGizmo then
                                    local playerPed = PlayerPedId()
                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                    local playerH = (GetEntityHeading(playerPed))
                                    pCoords2 = playerCoords
                                    pCoords2h = playerH
                                else
                                    GizmoVault("Create_marker")
                                end
                            end
                        end)

                        if PropsIni == nil then 
                            pPropsIni = "~r~❌~s~"
                        else 
                            pPropsIni = "~b~✅~s~"
                        end 

                        RageUI.Button(Config.Lang.Props_type, desc, { RightLabel = "~HC_45~"..pPropsIni.."~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local SetProps = lib.inputDialog(Config.Props_type, {
                                   {type = 'select', label = 'Props List', options = Config.Props}
                                                        
                                })
                                if not SetProps then return "return" end 
                                if SetProps[1] ~= nil or SetProps[1] ~= "" then
                                    PropsIni = SetProps[1]
                                end 
                            end
                        end)

                    else


                            if NameIni == "~r~❌~s~" then 
                                GetForSave = false
                            else 
                                if pCoords2Menu == "~r~❌~s~" then 
                                    GetForSave = false
                                else 
                                    if pCoords2Menu == "~r~❌~s~" then 
                                        GetForSave = false
                                    else 
                                        if #label < 1 then
                                            GetForSave = false
                                        else 
                                            GetForSave = true
                                        end 
                                    end 
                                end 
                            end 



                            if pCoords2 == nil then 
                                pCoords2Menu = "~r~❌~s~"
                                pCoordsMenu = "~r~❌~s~"
                            else 
                                pCoords2Menu = "~b~✅~s~"
                                pCoordsMenu = "~b~✅~s~"
                            end 
                                

                        RageUI.Button(Config.Lang.Pos_props_label, desc, {RightLabel = pCoords2Menu}, true, function(_,a,s)
                            if a then
                                if PreOxTarget then
                                    if Config.Settings.UseGizmo then
                                    else
                                        if Config.Settings.OxTarget then
                                            DebugDrawBox_entity(PlayerPedId())
                                        end
                                    end
                                end
                            end
                            if s then
                                if not Config.Settings.UseGizmo then
                                    local playerPed = PlayerPedId()
                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                    local playerH = (GetEntityHeading(playerPed))
                                    pCoords2 = playerCoords
                                    pCoords2h = playerH

                                    local pPed = PlayerPedId()
                                    local pCoords = GetEntityCoords(pPed)
                                    MenuCoords = pCoords
                                else
                                    GizmoVault("Create_oxtarget")
                                end
                            end
                        end)

                        if PropsIni == nil then 
                            pPropsIni = "~r~❌~s~"
                        else 
                            pPropsIni = "~b~✅~s~"
                        end 

                        RageUI.Button(Config.Lang.Props_type, desc, { RightLabel = "~HC_45~"..pPropsIni.."~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local SetProps = lib.inputDialog(Config.Props_type, {
                                   {type = 'select', label = 'Props List', options = Config.Props}
                                                        
                                })
                                if not SetProps then return "return" end 
                                if SetProps[1] ~= nil or SetProps[1] ~= "" then
                                    PropsIni = SetProps[1]
                                end 
                            end
                        end)


                    end

                    RageUI.Button(Config.Lang.Add_point, desc, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetValue2 = lib.inputDialog(Config.Lang.Name_Label_imput, {
                              {type = 'input', label = Config.Lang.Name_Label_imput, default = '', password = false, required = true, min = 1, max = 25}
                            })
                            if not SetValue2 then return "return" end 
                            if SetValue2[1] ~= nil or SetValue2[1] ~= "" then
                                local SetValue3 = lib.inputDialog(Config.Lang.MDP, {
                                  {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                })
                                if not SetValue3 then return "return" end 
                                if SetValue3[1] ~= nil or SetValue3[1] ~= "" then
                                    local SetValue4 = lib.inputDialog(Config.Lang.Name_slot_imput, {
                                      {type = 'input', label = Config.Lang.Name_slot_imput, default = '', password = false, required = true, min = 1, max = 6}
                                    })
                                    if not SetValue4 then return "return" end 
                                    if SetValue4[1] ~= nil or SetValue4[1] ~= "" then
                                        local SetValue5 = lib.inputDialog(Config.Lang.Name_weight_imput, {
                                          {type = 'input', label = Config.Lang.Name_weight_imput, default = '', password = false, required = true, min = 1, max = 50}
                                        })
                                        if not SetValue5 then return "return" end 
                                        if SetValue5[1] ~= nil or SetValue5[1] ~= "" then
                                            SetValue3 = tostring(SetValue3[1])
                                            SetValue4 = tostring(SetValue4[1])
                                            SetValue5 = tostring(SetValue5[1])
                                            table.insert(label,SetValue2[1])
                                            Wait(100)
                                            table.insert(password,SetValue3)
                                            Wait(100)
                                            table.insert(slot,SetValue4)
                                            Wait(100)
                                            table.insert(weight,SetValue5)
                                        end
                                    end
                                end 
                            end 
                        end
                    end)


                    if #label < 1 then
                        RageUI.Separator(Config.Lang.Nil_point)
                        GetForSave_color = "~r~"
                    else
                        GetForSave_color = "~g~"
                        RageUI.Separator()
                        for k, v in pairs(label) do
                            RageUI.Button(v, password[k], { RightLabel = Config.Lang.Delete_point }, true, function(Hovered, Active, Selected)
                                if Selected then
                                    table.remove(label, k);
                                    table.remove(password, k);
                                    table.remove(slot, k);
                                    table.remove(weight, k);
                                end
                            end)
                        end

                    end

                    RageUI.Separator("")

                    desc = Config.Lang.Name_stash_imput..": ~g~"..NameIni.."~s~\n"..Config.Lang.Pos_menu_label..": "..pCoordsMenu.."\n"..Config.Lang.Pos_props_label..": "..pCoords2Menu.."\n"..Config.Lang.Draw_Total..""..GetForSave_color..""..#label.."/1~s~"

                    RageUI.Button(Config.Lang.Save, desc, { RightLabel = "" }, GetForSave, function(Hovered, Active, Selected)
                        if Selected then
                            for k, v in pairs(label) do
                                Wait(100)
                                TriggerServerEvent('SAM:addStashIni',NameIni,label[k],password[k],tonumber(slot[k]),tonumber(weight[k]))
                            end
                            Wait(100)
                            TriggerServerEvent('SAM:addStash',NameIni, MenuCoords, pCoords2, pCoords2h, PropsIni, WebhooksIni)  
                            NameIni = ""
                            WebhooksIni = nil
                            label = {}
                            password = {}
                            slot = {}
                            weight = {}
                            MenuCoords = nil 
                            pCoords2Menu = nil
                            local Submenu = RMenu:Get('SaStashStaff', 'main')
                            if Submenu and Submenu() then
                                RageUI.NextMenu = Submenu
                            end                   
                        end
                    end)


                end, function() 
                end)











------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
















                RageUI.IsVisible(RMenu:Get('SaStashStaff', 'gestion_main'), true, true, true, function()

                    if #AllStash < 1 then
                        RageUI.Separator(Config.Lang.Loading)
                    else
                        for k, v in pairs(AllStash) do
                            RageUI.Button(v.name, k, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                                if Active then 
                                    DrawName3D(v.coords.x, v.coords.y, v.coords.z, Config.Lang.Draw_Coffre..v.name.."\n"..Config.Lang.Draw_ID..v.id)
                                end
                                if Selected then 
                                    GestionId = v.id 
                                    GestionName = v.name
                                    GestionCoords = v.coords
                                    GestionCoords_x = v.coords.x
                                    GestionCoords_y = v.coords.y
                                    GestionCoords_z = v.coords.z
                                    Gestioncoords_props = v.coords_props
                                    GestionPropsHeading = tonumber(v.heading)
                                    heading = v.heading
                                    GestionPropsHash = v.props
                                    Gestionwebhooks = v.webhooks
                                    stat1 = "~b~☑~s~"
                                    stat2 = "~b~☑~s~"
                                    stat3 = "~b~☑~s~"                 
                                end
                            end,RMenu:Get('SaStashStaff', 'gestion_edit'))
                        end
                    end
                end, function() 
                end)














-------------------------------------------------------------------------------------------------------------------------------------














                RageUI.IsVisible(RMenu:Get('SaStashStaff', 'gestion_edit'), true, true, true, function()

                    DrawName3D(GestionCoords_x, GestionCoords_y, GestionCoords_z, Config.Lang.Draw_Coffre..GestionName.."\n"..Config.Lang.Draw_ID..GestionId) 

                    if Config.Settings.OxTarget then
                        DebugDrawBox_table({x = GestionCoords_x, y = GestionCoords_y, z = GestionCoords_z, h = heading})
                    end

                    RageUI.Separator()
                    
                    RageUI.Button(Config.Lang.Delete, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            local SetValue = lib.inputDialog(Config.Lang.Del_valide, {
                               {type = 'select', label = Config.Lang.Del_valide, options = {{value = "YES", label = Config.Lang.Yes},{value = "NO", label = Config.Lang.No}}}                
                            })
                            if not SetValue then return "return" end 
                            if SetValue[1] == "YES" then
                                for k, v in pairs(AllStashIni) do
                                    if v.name == GestionName then 
                                        invid = 'SaStash-' .. v.name .. v.id
                                        TriggerServerEvent('SAM:removeStashIni', v.id, invid, v.label, GestionName)
                                    end
                                end 
                                TriggerServerEvent('SAM:removeStash', GestionId, GestionName)  
                                local Submenu = RMenu:Get('SaStashStaff', 'main')
                                if Submenu and Submenu() then
                                    RageUI.NextMenu = Submenu
                                end
                            end          
                        end
                    end)

                    RageUI.Button(Config.Lang.AddWebhooks, nil, { RightLabel = stat3 }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            local SetValue = lib.inputDialog(Config.Lang.AddWebhooks_desc, {
                              {type = 'input', label = Config.Lang.AddWebhooks, default = '', password = false, required = true, min = 1}
                            })
                            if not SetValue then return "return" end 
                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                TriggerServerEvent('SAM:updateSaStashWebhooks',SetValue[1], GestionId, GestionName)
                                Gestionwebhooks = SetValue[1]
                                stat3 = "~b~🔄~s~"
                            end          
                        end
                    end)


                    if not Config.Settings.OxTarget then

                        RageUI.Button(Config.Lang.Pos_menu_label, nil, { RightLabel = stat1 }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local playerPed = PlayerPedId()
                                local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                local playerH_Edit = (GetEntityHeading(playerPed))
                                TriggerServerEvent('SAM:updateSaStashCoords', playerCoords_Edit, GestionId, GestionName)
                                stat1 = "~b~🔄~s~"
                            end
                        end)

                        RageUI.Button(Config.Lang.Pos_props_label, nil, { RightLabel = stat2 }, true, function(Hovered, Active, Selected)
                            if Selected then
                                if not Config.Settings.UseGizmo then
                                    local playerPed = PlayerPedId()
                                    local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                    local playerH_Edit = (GetEntityHeading(playerPed))
                                    TriggerServerEvent('SAM:updateSaStashCoords_props', playerCoords_Edit, playerH_Edit, GestionId, GestionName)
                                    GestionCoords = playerCoords_Edit
                                    GestionCoords_x = playerCoords_Edit.x
                                    GestionCoords_y = playerCoords_Edit.y
                                    GestionCoords_z = playerCoords_Edit.z
                                    stat2 = "~b~🔄~s~"
                                else
                                    GizmoVault("Edit_marker")
                                end
                            end
                        end)
                    else

                        RageUI.Button(Config.Lang.Pos_props_label, nil, { RightLabel = stat1 }, true, function(Hovered, Active, Selected)
                            if Active then
                                if PreOxTarget then
                                    if Config.Settings.UseGizmo then
                                    else
                                        if Config.Settings.OxTarget then
                                            DebugDrawBox_entity(PlayerPedId())
                                        end
                                    end
                                end
                            end
                            if Selected then
                                if not Config.Settings.UseGizmo then
                                    local playerPed = PlayerPedId()
                                    local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                    local playerH_Edit = (GetEntityHeading(playerPed))
                                    TriggerServerEvent('SAM:updateSaStashCoords', playerCoords_Edit, GestionId, GestionName)
                                    TriggerServerEvent('SAM:updateSaStashCoords_props', playerCoords_Edit, playerH_Edit, GestionId, GestionName)
                                    GestionCoords = playerCoords_Edit
                                    GestionCoords_x = playerCoords_Edit.x
                                    GestionCoords_y = playerCoords_Edit.y
                                    GestionCoords_z = playerCoords_Edit.z
                                    stat1 = "~b~🔄~s~"
                                    stat2 = "~b~🔄~s~"
                                else
                                    GizmoVault("Edit_oxtarget")
                                end
                            end
                        end)

                    end

                    RageUI.Button(Config.Lang.Props_type, nil, { RightLabel = "~HC_45~~s~" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetProps = lib.inputDialog(Config.Props_type, {
                               {type = 'select', label = 'Props List', options = Config.Props}
                                                    
                            })
                            if not SetProps then return "return" end 
                            if SetProps[1] ~= nil or SetProps[1] ~= "" then
                                TriggerServerEvent('SAM:updateSaStashProps', SetProps[1], GestionId, GestionName)
                                GestionPropsHash = SetProps[1]
                            end 
                        end
                    end)

                    for k, v in pairs(AllStashIni) do
                        table.sort(v)
                        if v.name == GestionName then
                            desc = Config.Lang.MDP.." : "..v.password.."\n"..Config.Lang.slot.." : "..v.slot.."\n"..Config.Lang.weight.." : "..v.weight
                            RageUI.List(v.label, filterArray, filter, desc, {}, true, function(h, a, s, i)
                                filter = i
                                if s then
                                    if i == 1 then
                                        OpenInventory(v.name .. v.id, v.label, GestionName)
                                    elseif i == 2 then
                                        SetEntityCoords(PlayerPedId(), GestionCoords_x, GestionCoords_y, GestionCoords_z, 0.0, 0.0, 0.0, true)
                                    elseif i == 3 then
                                        local SetValue = lib.inputDialog(Config.Lang.Name_Label_imput, {
                                          {type = 'input', label = Config.Lang.Name_Label_imput, default = '', password = false, required = true, min = 1, max = 25}
                                        })
                                        if not SetValue then return "return" end 
                                        if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                            TriggerServerEvent('SAM:updateSaStashlabel',SetValue[1],v.id, v.label, GestionName)
                                        end
                                    elseif i == 4 then
                                        local SetValue = lib.inputDialog(Config.Lang.Name_Mdp_imput, {
                                          {type = 'input', label = Config.Lang.Name_Mdp_imput, default = '', password = false, required = true, min = 1, max = 6}
                                        })
                                        if not SetValue then return "return" end 
                                        if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                            TriggerServerEvent('SAM:updateSaStashmdp',SetValue[1],v.id, v.label, GestionName)
                                        end
                                    elseif i == 5 then
                                        local SetValue = lib.inputDialog(Config.Lang.Name_slot_imput, {
                                          {type = 'input', label = Config.Lang.Name_slot_imput, default = '', password = false, required = true, min = 1, max = 6}
                                        })
                                        if not SetValue then return "return" end 
                                        if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                            TriggerServerEvent('SAM:updateSaStashSlot',SetValue[1],v.id, v.label, GestionName)
                                        end
                                    elseif i == 6 then
                                        local SetValue = lib.inputDialog(Config.Lang.Name_weight_imput, {
                                          {type = 'input', label = Config.Lang.Name_weight_imput, default = '', password = false, required = true, min = 1, max = 6}
                                        })
                                        if not SetValue then return "return" end 
                                        if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                            TriggerServerEvent('SAM:updateSaStashWeight',SetValue[1],v.id, v.label, GestionName)
                                        end
                                    elseif i == 7 then
                                        local SetValue = lib.inputDialog(Config.Lang.Del_valide, {
                                           {type = 'select', label = Config.Lang.Del_valide, options = {{value = "YES", label = Config.Lang.Yes},{value = "NO", label = Config.Lang.No}}}                
                                        })
                                        if not SetValue then return "return" end 
                                        if SetValue[1] == "YES" then
                                            invid = 'SaStash-' .. v.name .. v.id
                                            TriggerServerEvent('SAM:removeStashIni', v.id, invid, v.label, GestionName)
                                        end 
                                        
                                    end
                                end
                            end)
                        end
                    end

                    RageUI.Button(Config.Lang.Add_point, Config.Lang.Add_point_desc, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetValue2 = lib.inputDialog(Config.Lang.Name_Label_imput, {
                              {type = 'input', label = Config.Lang.Name_Label_imput, default = '', password = false, required = true, min = 1, max = 25}
                            })
                            if not SetValue2 then return "return" end 
                            if SetValue2[1] ~= nil or SetValue2[1] ~= "" then
                                local SetValue3 = lib.inputDialog(Config.Lang.MDP, {
                                  {type = 'input', label = Config.Lang.MDP, default = '', password = false, required = true, min = 1, max = 6}
                                })
                                if not SetValue3 then return "return" end 
                                if SetValue3[1] ~= nil or SetValue3[1] ~= "" then
                                    local SetValue4 = lib.inputDialog(Config.Lang.Name_slot_imput, {
                                      {type = 'input', label = Config.Lang.Name_slot_imput, default = '', password = false, required = true, min = 1, max = 6}
                                    })
                                    if not SetValue4 then return "return" end 
                                    if SetValue4[1] ~= nil or SetValue4[1] ~= "" then
                                        local SetValue5 = lib.inputDialog(Config.Lang.Name_weight_imput, {
                                          {type = 'input', label = Config.Lang.Name_weight_imput, default = '', password = false, required = true, min = 1, max = 50}
                                        })
                                        if not SetValue5 then return "return" end 
                                        if SetValue5[1] ~= nil or SetValue5[1] ~= "" then
                                            SetValue3 = tostring(SetValue3[1])
                                            SetValue4 = tonumber(SetValue4[1])
                                            SetValue5 = tonumber(SetValue5[1])
                                            table.insert(label,SetValue2[1])
                                            Wait(100)
                                            table.insert(password,SetValue3)
                                            Wait(100)
                                            table.insert(slot,SetValue4)
                                            Wait(100)
                                            table.insert(weight,SetValue5)
                                        end
                                    end
                                end 
                            end
                        end
                    end)


                    if #label < 1 then
                        RageUI.Separator(Config.Lang.Nil_point)
                    else
                        RageUI.Separator()
                        for k, v in pairs(label) do
                            RageUI.Button(v, password[k], { RightLabel = Config.Lang.Delete_point }, true, function(Hovered, Active, Selected)
                                if Selected then
                                    table.remove(label, k);
                                    table.remove(password, k);
                                    table.remove(slot, k);
                                    table.remove(weight, k);
                                end
                            end)
                        end

                            RageUI.Button(Config.Lang.Save, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                if NameIni ~= nil or NameIni ~= "" or pCoords2Menu ~= nil or MenuCoords ~= nil then
                                    for k, v in pairs(label) do
                                        Wait(100)
                                        TriggerServerEvent('SAM:addStashIni',GestionName,label[k],password[k],tonumber(slot[k]),tonumber(weight[k]))
                                    end
                                    Wait(100)
                                    NameIni = ""
                                    WebhooksIni = nil
                                    label = {}
                                    password = {}
                                    slot = {}
                                    weight = {}
                                    MenuCoords = nil 
                                    pCoords2Menu = nil
                                    local Submenu = RMenu:Get('SaStashStaff', 'main')
                                    if Submenu and Submenu() then
                                        RageUI.NextMenu = Submenu
                                    end
                                end                   
                            end
                        end)
                    end

                end, function() 
                end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            end
        end)
    end
end














------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local filterArrayStash_A = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

local filterStash = 1;

local AlphFiltre = false
local CheckboxAlphabetique = false

local filterArrayStash_N = { "1", "2", "3", "4", "5", "6", "7", "8", "9"};

local filterStash = 1;

local NumberFiltre = false
local CheckboxNumber = false

local InventoryOpen = false

local Px,Py,Pz = nil, nil, nil

local MenuStash = false

RMenu.Add('SaStash', 'main', RageUI.CreateMenu(Config.Lang.Stash, "INTERACTION"))
RMenu:Get('SaStash', 'main'):SetRectangleBanner(0,0,0)
RMenu:Get('SaStash', 'main').Closed = function() 
    MenuStash = false
end 


function OpenMenuStash(Name, Webhooks, px, py, pz, lockpick)
    if MenuStash then
        MenuStash = false
    else
        MenuStash = true
        RageUI.Visible(RMenu:Get('SaStash', 'main'), true)
        Citizen.CreateThread(function()
            while MenuStash do
                Wait(1)
                Px,Py,Pz = px, py, pz
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, px, py, pz)
                if dist > 3.0 and MenuStash == true  then
                    MenuStash = false
                    RageUI.CloseAll()
                end

                RageUI.IsVisible(RMenu:Get('SaStash', 'main'), true, true, true, function()
                    if not NumberFiltre then
                        RageUI.Checkbox(Config.Lang.filter_alpha, nil,CheckboxAlphabetique,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
                            if Selected then
                                CheckboxAlphabetique = Checked
                                if Checked then
                                    filterStash = 1;
                                    AlphFiltre = true
                                else
                                    AlphFiltre = false
                                end
                            end
                        end)
                    end
                    if not AlphFiltre then
                        RageUI.Checkbox(Config.Lang.filter_num, nil,CheckboxNumber,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
                            if Selected then
                                CheckboxNumber = Checked
                                if Checked then
                                    filterStash = 1;
                                    NumberFiltre = true
                                else
                                    NumberFiltre = false
                                end
                            end
                        end)
                    end

                    if AlphFiltre then 
                        RageUI.List(Config.Lang.filter, filterArrayStash_A, filterStash, nil, {}, true, function(h, a, s, i)
                            filterStash = i
                        end)
                    end

                    if NumberFiltre then 
                        RageUI.List(Config.Lang.filter, filterArrayStash_N, filterStash, nil, {}, true, function(h, a, s, i)
                            filterStash = i
                        end)
                    end

                    RageUI.Separator(Config.Lang.Top_menu_stash)
                    table.sort(AllStashIni, function(a, b) return a.id < b.id end)
                    for k, v in pairs(AllStashIni) do
                        table.sort(v)
                        if v.name == Name then
                            if AlphFiltre then 
                                if starts(v.label:lower(), filterArrayStash_A[filterStash]:lower()) then
                                else
                                    goto pass
                                end
                            end
                            if NumberFiltre then 
                                if starts(v.label:lower(), filterArrayStash_N[filterStash]:lower()) then
                                else
                                    goto pass
                                end
                            end

                            if lockpick then
                                RageUI.List(v.label, filterArray_main_crack, filter_main_crack, nil, {RightLabel = ""}, true, function(h, a, s, i)
                                    filter_main_crack = i
                                    if s then
                                        if i == 1 then
                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    InventoryOpen = true
                                                    MenuStash = false
                                                    RageUI.CloseAll()
                                                    OpenInventory(v.name .. v.id, v.label, Name ,Webhooks)
                                                else
                                                end
                                            end
                                        elseif i == 2 then
                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    local SetValue = lib.inputDialog(Config.Lang.New_Mdp_imput, {
                                                      {type = 'input', label = Config.Lang.New_Mdp_imput, default = '', password = true, required = true, min = 1, max = 6}
                                                    })
                                                    if not SetValue then return "return" end 
                                                    if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                        TriggerServerEvent('SAM:updateSaStashmdp',SetValue[1],v.id, v.label, Name, Webhooks)
                                                    end
                                                else
                                                end
                                            end
                                        elseif i == 3 then

                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    local SetValue = lib.inputDialog(Config.Lang.New_label_imput, {
                                                      {type = 'input', label = Config.Lang.New_label_imput, default = '', password = false, required = true, min = 1, max = 25}
                                                    })
                                                    if not SetValue then return "return" end 
                                                    if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                        TriggerServerEvent('SAM:updateSaStashlabel',SetValue[1],v.id, v.label, Name, Webhooks)
                                                    end
                                                else
                                                end
                                            end
                                        elseif i == 4 then
                                            local RandomCode = NumberLockpicking()
                                            DebugPrint('Number code lockpick vault',table.unpack(RandomCode))
                                            if createSafe(RandomCode) then
                                                TriggerServerEvent('SAM:sendToDiscordWithSpecialURLStaff', Config.Lang.Webhooks_ForceStash_title, string.format(Config.Lang.Webhooks_ForceStash, GetPlayerName(PlayerId()), v.label, Name), 15548997, "lockpick")
                                                InventoryOpen = true
                                                MenuStash = false
                                                RageUI.CloseAll()
                                                if Config.Settings.SendWebhooksPlayerlockpick then
                                                    TriggerServerEvent('SAM:sendToDiscordWithSpecialURL', Config.Lang.Webhooks_ForceStash_title,  string.format(Config.Lang.Webhooks_ForceStash2, v.label), 15548997, Webhooks, Config.Settings.WaitSend_SendWebhooksPlayerlockpick)
                                                end
                                                OpenInventory(v.name .. v.id, v.label, Name)
                                            else
                                                if Config.Settings.RemoveLockpickItemsFail then
                                                    TriggerServerEvent('SAM:RemoveLockpickItemsSaStash')
                                                end
                                            end
                                        end
                                    end
                                end)
                            else
                                RageUI.List(v.label, filterArray_main, filter_main, nil, {RightLabel = ""}, true, function(h, a, s, i)
                                    filter_main = i
                                    if s then
                                        if i == 1 then
                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    InventoryOpen = true
                                                    MenuStash = false
                                                    RageUI.CloseAll()
                                                    OpenInventory(v.name .. v.id, v.label, Name ,Webhooks)
                                                else
                                                end
                                            end
                                        elseif i == 2 then
                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    local SetValue = lib.inputDialog(Config.Lang.New_Mdp_imput, {
                                                      {type = 'input', label = Config.Lang.New_Mdp_imput, default = '', password = true, required = true, min = 1, max = 6}
                                                    })
                                                    if not SetValue then return "return" end 
                                                    if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                        TriggerServerEvent('SAM:updateSaStashmdp',SetValue[1],v.id, v.label, Name, Webhooks)
                                                    end
                                                else
                                                end
                                            end
                                        elseif i == 3 then

                                            local SetValue = lib.inputDialog(Config.Lang.MDP, {
                                              {type = 'input', label = Config.Lang.MDP, default = '', password = true, required = true, min = 1, max = 6}
                                            })
                                            if not SetValue then return "return" end 
                                            if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                SetValue = tostring(SetValue[1])
                                                if SetValue == v.password then
                                                    local SetValue = lib.inputDialog(Config.Lang.New_label_imput, {
                                                      {type = 'input', label = Config.Lang.New_label_imput, default = '', password = false, required = true, min = 1, max = 25}
                                                    })
                                                    if not SetValue then return "return" end 
                                                    if SetValue[1] ~= nil or SetValue[1] ~= "" then
                                                        TriggerServerEvent('SAM:updateSaStashlabel',SetValue[1],v.id, v.label, Name, Webhooks)
                                                    end
                                                else
                                                end
                                            end
                                        end
                                    end
                                end)
                            end

                            
                            :: pass ::
                        end
                    end               

                end, function() 
                end)
            end
        end)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



Citizen.CreateThread(function()
    while true do
        local wait = 750
    if not Config.Settings.OxTarget then
        if #AllStash < 1 then
        else
            for k, v in pairs(AllStash) do


                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.coords.x, v.coords.y, v.coords.z)


                    if Config.Settings.RangeDrawMarker then
                        if Config.Settings.RangeDrawMarker == false or not type(Config.Settings.RangeDrawMarker) == "number" then 
                        else  
                            if dist <= Config.Settings.RangeDrawMarker then
                                wait = 0
                                DrawMarker(6, v.coords.x, v.coords.y, v.coords.z-0.99, 2.0, 1.0, 500.0, 1.0, 50.0, 0.0, 0.8, 0.4, 0.8,  247,  222,  255, 200, false, false, 2, nil, nil, false)
                            end
                        end
                    end


                    if dist <= Config.Settings.RangeActive and not isMinigame then
                        wait = 0
                        ESX.ShowHelpNotification(Config.Lang.Help_notif, true, false) 
                        if IsControlJustPressed(1,51) then
                            DebugPrint('GetNumberItemLockpick',GetItemsLockpickVault())
                            if GetItemsLockpickVault() > 0 then
                                OpenMenuStash(v.name, v.webhooks, v.coords.x, v.coords.y, v.coords.z, true)
                            else
                                OpenMenuStash(v.name, v.webhooks, v.coords.x, v.coords.y, v.coords.z, false)
                            end
                        end
                    
                    end

            end
        end
        if Px ~= nil or Py ~= nil or Pz ~= nil then
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Px, Py, Pz)
            if dist > 3.0 and InventoryOpen == true then
                CloseInventory()
                InventoryOpen = false
            end
        end
    end

    Citizen.Wait(wait)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





----------------------------------------------------------------------------------------------------------------------------















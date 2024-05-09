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

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

------------------------------------------------------------------------------------------------


local AllStash = {}
local AllStashIni = {}

local filterArray = {Config.Lang.filterArray1, Config.Lang.filterArray2, Config.Lang.filterArray3, Config.Lang.filterArray4, Config.Lang.filterArray5,};
local filter = 1;

local filterArray_main = {Config.Lang.filterArray_main1, Config.Lang.filterArray_main2, Config.Lang.filterArray_main3};
local filter_main = 1;

local NameIni = ""
local PropsIni = nil
local label = {}
local password = {}

local MenuCoords = nil 
local pCoords2Menu = nil

local pCoords2MenuEdit = nil


local PreOxTarget = false


RegisterNetEvent('SAM:RefresStashIni')
AddEventHandler('SAM:RefresStashIni', function(data)
    AllStashIni = data
end)

RegisterNetEvent('SAM:RefresStash')
AddEventHandler('SAM:RefresStash', function(data,number)
    AllStash = data
    if Config.OxTarget then
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
            PropsStash = CreateObject(hash, v.coords_props.x, v.coords_props.y, v.coords_props.z-0.99, false, false, false)
            SetEntityHeading(PropsStash, heading)
            FreezeEntityPosition(PropsStash, true)
            table.insert(allprops,PropsStash)
        end
    end
    RefreshValue = 0
end)


----------------------------------------------------------------------------------------------------------------------------


local AllTarget = {}

function initarget()
    for i = 1, #AllStash, 1 do
        local Stat = AllStash[i]
        local targetnumber = exports.ox_target:addBoxZone({
            coords = vec3(AllStash[i].coords.x, AllStash[i].coords.y, AllStash[i].coords.z-0.10),
            size = vec3(1.5, 1.5, 2.5),
            debug = Config.Debug_OxTarget,
            drawSprite = true,
            options = {
                {   
                    distance = 3,
                    name = 'chest:'..i,
                    icon = 'fa-solid fa-vault',
                    label = Config.Lang.Stash,
                    Stat = Stash,
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
    OpenMenuStash(Stat.name, Stat.coords.x, Stat.coords.y, Stat.coords.z)
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
    local deleton = false
    local NameIni = ""
    local PropsIni = nil
    local label = {}
    local password = {}

    local MenuCoords = nil 
    local pCoords2Menu = nil

    local pCoords2MenuEdit = nil

    local pCoords2 = nil
    local pCoords2h = nil

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
                                PropsIni = nil
                                label = {}
                                password = {}

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

                    if Config.Preview_OxTarget_CreateVault and Config.OxTarget then
                        RageUI.Checkbox(Config.Lang.PreviewOxTarget, nil, PreOxTarget,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
                            if Ative and PreOxTarget then
                               local PedPos = GetEntityCoords(PlayerPedId())
                               local DrawPedPos1 = vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.99)
                               local DrawPedPos2 = vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z+1.0)
                               DrawBox(DrawPedPos1, DrawPedPos2, 250, 0, 0, 90)
                               DrawBox(vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.05), vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z-0.05), 250, 0, 0, 90)
                            end
                            if Selected then
                                PreOxTarget = Checked
                                if Checked then
                                else
                                end
                            end
                        end)
                    end

                    RageUI.Separator()

                    RageUI.Button(Config.Lang.Name_stash, nil, { RightLabel = "~HC_45~"..NameIni.."~s~" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetName = KeyboardInput(Config.Lang.Name_stash_imput, Config.Lang.Name_stash_imput, "", 50, false)
                            if SetName == "return" then return end
                            if SetName ~= nil then
                                NameIni = SetName
                            end
                        end
                    end)

                    RageUI.Separator()


                    if not Config.OxTarget then


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

                        RageUI.Button(Config.Lang.Pos_menu_label, nil, {RightLabel = pCoordsMenu}, true, function(_,a,s)
                            if a then
                                if PreOxTarget then
                                    local PedPos = GetEntityCoords(PlayerPedId())
                                    local DrawPedPos1 = vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.99)
                                    local DrawPedPos2 = vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z+1.0)
                                    DrawBox(DrawPedPos1, DrawPedPos2, 250, 0, 0, 90)
                                    DrawBox(vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.05), vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z-0.05), 250, 0, 0, 90)
                                end
                            end
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

                        RageUI.Button(Config.Lang.Pos_props_label, nil, {RightLabel = pCoords2Menu}, true, function(_,_,s)
                            if s then
                                local playerPed = PlayerPedId()
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                local playerH = FormatCoord(GetEntityHeading(playerPed), 0, 6)
                                pCoords2 = playerCoords
                                pCoords2h = playerH
                            end
                        end)

                        if PropsIni == nil then 
                            pPropsIni = "~r~❌~s~"
                        else 
                            pPropsIni = "~b~✅~s~"
                        end 

                        RageUI.Button(Config.Lang.Props_type, nil, { RightLabel = "~HC_45~"..pPropsIni.."~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local SetProps = KeyboardInput("props", "props", "", 50, false, true)
                                if SetProps == "return" then return end
                                if SetProps ~= nil then
                                    PropsIni = SetProps
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
                                

                        RageUI.Button(Config.Lang.Pos_props_label, nil, {RightLabel = pCoords2Menu}, true, function(_,a,s)
                            if a then
                                if PreOxTarget then
                                    local PedPos = GetEntityCoords(PlayerPedId())
                                    local DrawPedPos1 = vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.99)
                                    local DrawPedPos2 = vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z+1.0)
                                    DrawBox(DrawPedPos1, DrawPedPos2, 250, 0, 0, 90)
                                    DrawBox(vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.05), vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z-0.05), 250, 0, 0, 90)
                                end
                            end
                            if s then
                                local playerPed = PlayerPedId()
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                local playerH = FormatCoord(GetEntityHeading(playerPed), 0, 6)
                                pCoords2 = playerCoords
                                pCoords2h = playerH

                                local pPed = PlayerPedId()
                                local pCoords = GetEntityCoords(pPed)
                                MenuCoords = pCoords
                            end
                        end)

                        if PropsIni == nil then 
                            pPropsIni = "~r~❌~s~"
                        else 
                            pPropsIni = "~b~✅~s~"
                        end 

                        RageUI.Button(Config.Lang.Props_type, nil, { RightLabel = "~HC_45~"..pPropsIni.."~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local SetProps = KeyboardInput("props", "props", "", 50, false, true)
                                if SetProps == "return" then return end
                                if SetProps ~= nil then
                                    PropsIni = SetProps
                                end
                            end
                        end)


                    end

                    RageUI.Button(Config.Lang.Add_point, Config.Lang.Add_point_desc, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetValue2 = KeyboardInput(Config.Lang.Name_Label_imput, Config.Lang.Name_Label_imput, "", 25, false)
                            if SetValue2 == "return" then return end
                            local SetValue3 = KeyboardInput(Config.Lang.MDP, Config.Lang.MDP, "", 6, false)
                            if SetValue3 == "return" then return end
                            if SetValue2 ~= nil and SetValue3 ~= nil then
                                SetValue3 = tostring(SetValue3)
                                table.insert(label,SetValue2)
                                Wait(100)
                                table.insert(password,SetValue3)
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
                                end
                            end)
                        end

                    end

                    RageUI.Separator("")


                    RageUI.Button(Config.Lang.Save, Config.Lang.Name_stash_imput..": ~g~"..NameIni.."~s~\n"..Config.Lang.Pos_menu_label..": "..pCoordsMenu.."\n"..Config.Lang.Pos_props_label..": "..pCoords2Menu.."\n"..Config.Lang.Draw_Total..""..GetForSave_color..""..#label.."/1~s~", { RightLabel = "" }, GetForSave, function(Hovered, Active, Selected)
                        if Selected then
                            for k, v in pairs(label) do
                                Wait(100)
                                TriggerServerEvent('SAM:addStashIni',NameIni,label[k],password[k])
                            end
                            Wait(100)
                            TriggerServerEvent('SAM:addStash',NameIni, MenuCoords, pCoords2, pCoords2h, PropsIni)  
                            NameIni = ""
                            label = {}
                            password = {}
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
                                if Selected then 
                                    GestionCoords_x = v.coords.x
                                    GestionCoords_y = v.coords.y
                                    GestionCoords_z = v.coords.z
                                    GestionName = v.name
                                    GestionId = v.id                     
                                end
                            end,RMenu:Get('SaStashStaff', 'gestion_edit'))
                        end
                    end
                end, function() 
                end)

-------------------------------------------------------------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('SaStashStaff', 'gestion_edit'), true, true, true, function()

                    if Config.Preview_OxTarget_CreateVault and Config.OxTarget then
                        RageUI.Checkbox(Config.Lang.PreviewOxTarget, nil, PreOxTarget,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
                            if Ative and PreOxTarget then
                               local PedPos = GetEntityCoords(PlayerPedId())
                               local DrawPedPos1 = vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.99)
                               local DrawPedPos2 = vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z+1.0)
                               DrawBox(DrawPedPos1, DrawPedPos2, 250, 0, 0, 90)
                               DrawBox(vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.05), vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z-0.05), 250, 0, 0, 90)
                            end
                            if Selected then
                                PreOxTarget = Checked
                                if Checked then
                                else
                                end
                            end
                        end)
                    end

                    RageUI.Separator()
                    
                    RageUI.Button(Config.Lang.Delete, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then 
                            local DelElevator = KeyboardInput("Delete", "[YES] "..Config.Lang.Del_valide, "", 50, false)
                            if DelElevator == "return" then return end
                            if DelElevator == "YES" then
                                for k, v in pairs(AllStashIni) do
                                    if v.name == GestionName then 
                                        invid = 'SaStash-' .. v.name .. v.id
                                        TriggerServerEvent('SAM:removeStashIni', v.id, invid)
                                    end
                                end 
                                TriggerServerEvent('SAM:removeStash', GestionId)  
                                local Submenu = RMenu:Get('SaStashStaff', 'main')
                                if Submenu and Submenu() then
                                    RageUI.NextMenu = Submenu
                                end      
                            end            
                        end
                    end)


                    if not Config.OxTarget then

                        RageUI.Button(Config.Lang.Pos_menu_label, nil, { RightLabel = "~HC_45~~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local playerPed = PlayerPedId()
                                local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                local playerH_Edit = FormatCoord(GetEntityHeading(playerPed), 0, 6)
                                TriggerServerEvent('SAM:updateSaStashCoords', playerCoords_Edit, GestionId)
                            end
                        end)

                        RageUI.Button(Config.Lang.Pos_props_label, nil, { RightLabel = "~HC_45~~s~" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                local playerPed = PlayerPedId()
                                local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                local playerH_Edit = FormatCoord(GetEntityHeading(playerPed), 0, 6)
                                TriggerServerEvent('SAM:updateSaStashCoords_props', playerCoords_Edit, playerH_Edit, GestionId)
                            end
                        end)
                    else

                        RageUI.Button(Config.Lang.Pos_props_label, nil, { RightLabel = "~HC_45~~s~" }, true, function(Hovered, Active, Selected)
                            if Active then
                                if PreOxTarget then
                                    local PedPos = GetEntityCoords(PlayerPedId())
                                    local DrawPedPos1 = vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.99)
                                    local DrawPedPos2 = vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z+1.0)
                                    DrawBox(DrawPedPos1, DrawPedPos2, 250, 0, 0, 90)
                                    DrawBox(vec3(PedPos.x+0.75, PedPos.y+0.75, PedPos.z-0.05), vec3(PedPos.x-0.75, PedPos.y-0.75, PedPos.z-0.05), 250, 0, 0, 90)
                                end
                            end
                            if Selected then
                                local playerPed = PlayerPedId()
                                local playerCoords_Edit = GetEntityCoords(PlayerPedId())
                                local playerH_Edit = FormatCoord(GetEntityHeading(playerPed), 0, 6)
                                TriggerServerEvent('SAM:updateSaStashCoords', playerCoords_Edit, GestionId)
                                TriggerServerEvent('SAM:updateSaStashCoords_props', playerCoords_Edit, playerH_Edit, GestionId)
                            end
                        end)

                    end

                    RageUI.Button(Config.Lang.Props_type, nil, { RightLabel = "~HC_45~~s~" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetProps = KeyboardInput("props", "props", "", 50, false, true)
                            if SetProps == "return" then return end
                            if SetProps ~= nil or SetProps ~= "" then
                                TriggerServerEvent('SAM:updateSaStashProps', SetProps, GestionId)
                            end
                        end
                    end)

                    for k, v in pairs(AllStashIni) do
                        table.sort(v)
                        if v.name == GestionName then
                            DrawName3D(GestionCoords_x, GestionCoords_y, GestionCoords_z, Config.Lang.Draw_Coffre..v.name.."\n"..Config.Lang.Draw_Total..#AllStashIni)
                            -- SetEntityDrawOutline(CurrentlyEditingView, true)
                            -- SetEntityDrawOutlineColor(222, 71, 224, 200)
                            -- SetEntityDrawOutlineShader(1)
                            RageUI.List(v.label, filterArray, filter, Config.Lang.MDP.." : "..v.password, {}, true, function(h, a, s, i)
                                filter = i
                                if s then
                                    if i == 1 then
                                        SetEntityCoords(PlayerPedId(), GestionCoords_x, GestionCoords_y, GestionCoords_z, 0.0, 0.0, 0.0, true)
                                    elseif i == 2 then
                                        local SetValue = KeyboardInput(Config.Lang.Name_Label_imput, Config.Lang.Name_Label_imput, "", 25, false)
                                            if SetValue == "return" then return end
                                            if SetValue ~= nil then
                                                TriggerServerEvent('SAM:updateSaStashlabel',SetValue,v.id)
                                            end
                                    elseif i == 3 then
                                        local SetValue = KeyboardInput(Config.Lang.Name_Mdp_imput, Config.Lang.Name_Mdp_imput, "", 6, false)
                                        if SetValue == "return" then return end
                                        if SetValue ~= nil then
                                            TriggerServerEvent('SAM:updateSaStashmdp',SetValue,v.id)
                                        end
                                    elseif i == 4 then
                                        exports['ox_inventory']:openInventory('stash', {id = 'SaStash-' .. v.name .. v.id , owner = ""})
                                            --TriggerServerEvent('SAM:updateSaStashmdp',SetValue,v.id)
                                    elseif i == 5 then
                                        invid = 'SaStash-' .. v.name .. v.id
                                        TriggerServerEvent('SAM:removeStashIni', v.id, invid)
                                    end
                                end
                            end)
                        end
                    end

                    RageUI.Button(Config.Lang.Add_point, Config.Lang.Add_point_desc, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local SetValue2 = KeyboardInput(Config.Lang.Name_Label_imput, Config.Lang.Name_Label_imput, "", 25, false)
                            if SetValue2 == "return" then return end
                            local SetValue3 = KeyboardInput(Config.Lang.MDP, Config.Lang.MDP, "", 6, false)
                            if SetValue3 == "return" then return end
                            if SetValue2 ~= nil and SetValue3 ~= nil then
                                SetValue3 = tostring(SetValue3)
                                table.insert(label,SetValue2)
                                Wait(100)
                                table.insert(password,SetValue3)
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
                                end
                            end)
                        end

                            RageUI.Button(Config.Lang.Save, nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                if NameIni ~= nil or NameIni ~= "" or pCoords2Menu ~= nil or MenuCoords ~= nil then
                                    for k, v in pairs(label) do
                                        Wait(100)
                                        TriggerServerEvent('SAM:addStashIni',GestionName,label[k],password[k])
                                    end
                                    Wait(100)
                                    --TriggerServerEvent('SAM:addStash',NameIni, MenuCoords, pCoords2, pCoords2h, PropsIni)  
                                    NameIni = ""
                                    label = {}
                                    password = {}
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


function OpenMenuStash(Name, px, py, pz)
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
                        RageUI.Checkbox("Filtre Alphabetique", nil,CheckboxAlphabetique,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
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
                        RageUI.Checkbox("Filtre Numerique", nil,CheckboxNumber,{ Style = RageUI.CheckboxStyle.Tick },function(Hovered,Ative,Selected,Checked)
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
                        RageUI.List("Filtre", filterArrayStash_A, filterStash, nil, {}, true, function(h, a, s, i)
                            filterStash = i
                        end)
                    end

                    if NumberFiltre then 
                        RageUI.List("Filtre", filterArrayStash_N, filterStash, nil, {}, true, function(h, a, s, i)
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
                            RageUI.List(v.label, filterArray_main, filter_main, nil, {RightLabel = ""}, true, function(h, a, s, i)
                                filter_main = i
                                if s then
                                    if i == 1 then
                                        local SetValue = KeyboardInput(Config.Lang.MDP, Config.Lang.MDP, "", 6, true)
                                        if SetValue == "return" then return end
                                        SetValue = tostring(SetValue)
                                        if SetValue == v.password then
                                            InventoryOpen = true
                                            MenuStash = false
                                            RageUI.CloseAll()
                                            exports['ox_inventory']:openInventory('stash', {id = 'SaStash-' .. v.name .. v.id , owner = ""})
                                        else
                                        end
                                    elseif i == 2 then
                                        local SetValue = KeyboardInput(Config.Lang.MDP, Config.Lang.MDP, "", 6, true)
                                        if SetValue == "return" then return end
                                        SetValue = tostring(SetValue)
                                        if SetValue == v.password then
                                            local SetValue = KeyboardInput(Config.Lang.New_Mdp_imput, Config.Lang.New_Mdp_imput, "", 6, true)
                                            if SetValue ~= nil then
                                                TriggerServerEvent('SAM:updateSaStashmdp',SetValue,v.id)
                                            end
                                        else
                                            
                                        end
                                    elseif i == 3 then
                                        local SetValue = KeyboardInput(Config.Lang.MDP, Config.Lang.MDP, "", 6, true)
                                        if SetValue == "return" then return end
                                        SetValue = tostring(SetValue)
                                        if SetValue == v.password then
                                            local SetValue = KeyboardInput(Config.Lang.New_label_imput, Config.Lang.New_label_imput, "", 25, false)
                                            if SetValue ~= nil then
                                                TriggerServerEvent('SAM:updateSaStashlabel',SetValue,v.id)
                                            end
                                        else
                                        end
                                    end
                                end
                            end)
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
    if not Config.OxTarget then
        if #AllStash < 1 then
        else
            for k, v in pairs(AllStash) do


                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.coords.x, v.coords.y, v.coords.z)


                --if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Job and MenuElevator == false then 
                    print(Config.RangeDrawMarker == false, not type(Config.RangeDrawMarker) == "number")
                    if Config.RangeDrawMarker then
                        if Config.RangeDrawMarker == false or not type(Config.RangeDrawMarker) == "number" then 
                        else  
                            if dist <= Config.RangeDrawMarker then
                                wait = 0
                                DrawMarker(6, v.coords.x, v.coords.y, v.coords.z-0.99, 2.0, 1.0, 500.0, 1.0, 50.0, 0.0, 0.8, 0.4, 0.8,  247,  222,  255, 200, false, false, 2, nil, nil, false)
                            end
                        end
                    end


                    if dist <= Config.RangeActive then
                        wait = 0
                        ESX.ShowHelpNotification(Config.Lang.Help_notif, true, false, 1)
                        if IsControlJustPressed(1,51) then
                            OpenMenuStash(v.name, v.coords.x, v.coords.y, v.coords.z)
                        end
                    
                    end
                --end

            end
        end
        if Px ~= nil or Py ~= nil or Pz ~= nil then
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Px, Py, Pz)
            if dist > 3.0 and InventoryOpen == true then
                exports['ox_inventory']:closeInventory()
                InventoryOpen = false
            end
        end
    end

    Citizen.Wait(wait)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    --print(RefreshValue)
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
                PropsStash = CreateObject(hash, v.coords_props.x, v.coords_props.y, v.coords_props.z-0.99, false, false, false)
                SetEntityHeading(PropsStash, heading)
                FreezeEntityPosition(PropsStash, true)
                table.insert(allprops,PropsStash)
            end
        end
        RefreshValue = 0
    end
end



FormatCoord = function(coord)
    if coord == nil then
        return "unknown"
    end

    return tonumber(string.format("%.2f", coord))
end


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



function KeyboardInput(entryTitle, textEntry, inputText, maxLength, Password, props)
    props = props or false
    if props then
        local input = lib.inputDialog(entryTitle, {
           {type = 'select', label = 'Props List', options = Config.Props}
                                
        })
        if not input then return "return" end 
        if input[1] ~= nil or input[1] ~= "" then
            return input[1]
        else
            return nil
        end 
    else
        local input = lib.inputDialog(entryTitle, {
          {type = 'input', label = textEntry, default = inputText, password = Password, required = true, min = 1, max = maxLength}
        })
        if not input then return "return" end 
        if input[1] ~= nil or input[1] ~= "" then
            return input[1]
        else
            return nil
        end  
    end
end


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  deleteProps()
end)
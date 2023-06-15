-------------------------
-------------------------
------------------CONFIG----------------------
local startX = 2163.57 ------Start The job here
local startY = 5010.17
local startZ = 41.42
---------------------------------------------
local slaughterX = -100.7 --punkt na slaughterhouse
local slaughterY = 6202.36
local slaughterZ = 31.03
---
local slaughterX2 = -95.8 --punkt na przetwarzanie 2
local slaughterY2 = 6207.12
local slaughterZ2 = 31.03
---
local packageX = -104.28 --punkt pakowania 1
local packageY = 6206.48
local packageZ = 31.03
---
local packageX2 = -106.52 --punkt pakowania 2
local packageY2 = 6204.32
local packageZ2 = 31.03
---
local sellX = 375.37 --punkt sprzedazy
local sellY =  -363.56
local sellZ = 46.82


---------------------------------------------
--------tego lepiej nie ruszaj ponizej-------
---------------------------------------------
local pig1
local pig2
local pig3
local caught1 = 0
local caught2 = 0
local caught3 = 0
local caught4 = 0
local caught5 = 0
local numbercaught = 0
local share = false
local prop
local packeforacar = false
local cardboard
local meat
local packing = 0
--------------
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local QBCore = exports["qb-core"]:GetCoreObject()

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj)QBCore = obj end)
        Citizen.Wait(200)
    end
    
    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

--onload player
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        PlayerData = QBCore.Functions.GetPlayerData()
    end)

end)
--setjob
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)
---
Citizen.CreateThread(function()
    local blip1 = AddBlipForCoord(startX, startY, startZ)
    SetBlipSprite(blip1, 126)
    SetBlipDisplay(blip1, 4)
    SetBlipScale(blip1, 0.7)
    SetBlipColour(blip1, 46)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Bắt gà')
    EndTextCommandSetBlipName(blip1)
    local blip2 = AddBlipForCoord(slaughterX, slaughterY, slaughterZ)
    SetBlipSprite(blip2, 273)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 0.4)
    SetBlipColour(blip2, 46)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mổ gà')
    EndTextCommandSetBlipName(blip2)
    local blip4 = AddBlipForCoord(sellX, sellY, sellZ)
    SetBlipSprite(blip4, 478)
    SetBlipDisplay(blip4, 4)
    SetBlipScale(blip4, 0.6)
    SetBlipColour(blip4, 46)
    SetBlipAsShortRange(blip4, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Bán gà')
    EndTextCommandSetBlipName(blip4)
    local blip3 = AddBlipForCoord(packageX, packageY, packageZ)
    SetBlipSprite(blip3, 478)
    SetBlipDisplay(blip3, 4)
    SetBlipScale(blip3, 0.6)
    SetBlipColour(blip3, 46)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Đóng gói gà')
    EndTextCommandSetBlipName(blip3)
end)


function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end
----Chwytanie kruczaka
Citizen.CreateThread(function()
        
        while true do
            Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
            ---
            if dist <= 07.0 then
                DrawMarker(27, startX, startY, startZ - 0.85, 0, 0, 0, 0, 0, 0, 0.70, 0.70, 0.70, 3, 119, 252, 200, 0, 0, 0, 0)
            else
                Citizen.Wait(1500)
            end
            
            if dist <= 2.5 then
                DrawText3D2(startX, startY, startZ, "~g~[E]~w~ Bắt đầu bắt gà ")
            end
            --
            if dist <= 0.5 then
                if IsControlJustPressed(0, Keys['E']) then -- "E"
                    batga()
                end
            end
        end

end)
-------Przerabianie
local Positions = {
    ['Slaughter1'] = {['hint'] = '~g~[E]~w~ Bỏ vào túi', ['x'] = 985.778, ['y'] = -2117.039, ['z'] = 0.757},
    ['Slaughter2'] = {['hint'] = '~g~[E]~w~ Bỏ vào túi', ['x'] = 985.498, ['y'] = -2121.712, ['z'] = 0.475}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX, slaughterY, slaughterZ)
        local distance2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX2, slaughterY2, slaughterZ2)
        local distance3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX, packageY, packageZ)
        local distance4 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX2, packageY2, packageZ2)
        
        --if distance1 <= 25.0 then
        DrawMarker(27, slaughterX, slaughterY, slaughterZ - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
        DrawMarker(27, slaughterX2, slaughterY2, slaughterZ2 - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
        DrawMarker(27, packageX, packageY, packageZ - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
        DrawMarker(27, packageX2, packageY2, packageZ2 - 0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
        --else
        --    Citizen.Wait(1500)
        --end
        if distance1 <= 2.5 then
            DrawText3D2(slaughterX, slaughterY, slaughterZ, "~g~[E]~w~ Cắt thịt gà")
        end
        local hasBagdp3 = false
        local s1dp3 = false
        if distance1 <= 0.5 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    hasBagdp3 = result
                    s1dp3 = true
                end, 'alivechicken')
                while (not s1dp3) do
                    Citizen.Wait(100)
                end
                if (hasBagdp3) then
                    cainaydeobiet(1)
                else
                    QBCore.Functions.Notify('Bạn không có gà sống để cắt thịt.', 'error')
                end
            end
        end
        local hasBagd2p = false
        local s1d2p = false
        if distance2 <= 2.5 then
            DrawText3D2(slaughterX2, slaughterY2, slaughterZ2, "~g~[E]~w~ Cắt thịt gà")
        end
        
        if distance2 <= 0.5 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    hasBagd2p = result
                    s1d2p = true
                end, 'alivechicken')
                while (not s1d2p) do
                    Citizen.Wait(100)
                end
                if (hasBagd2p) then
                    cainaydeobiet(2)
                else
                    QBCore.Functions.Notify('Bạn không có gà sống để cắt thịt.', 'error')
                end
            end
        end
        --
        local hasBagd3p = false
        local s1d3p = false
        if distance3 <= 1.0 and packing == 0 then
            DrawText3D2(packageX, packageY, packageZ, "~g~[E]~w~ Đóng gói")
        elseif distance3 <= 1.0 and packing == 1 then
            DrawText3D2(packageX, packageY, packageZ, "~g~[G]~w~ Dừng đóng gói")
            DrawText3D2(packageX, packageY, packageZ + 0.1, "~g~[E]~w~ Tiếp tục đóng gói")
        end
        
        if distance3 <= 0.6 then
            if IsControlJustPressed(0, Keys['E']) then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    hasBagd3p = result
                    s1d3p = true
                end, 'alivechicken')
                while (not s1d3p) do
                    Citizen.Wait(100)
                end
                if (hasBagd3p) then
                    donggoiga(1)
                else
                    QBCore.Functions.Notify('Bạn không có thịt gà để đóng gói .', 'error')
                end
            elseif IsControlJustPressed(0, Keys['G']) then
                dungdonggoi(1)
            end
        end
        local hasBagd4p = false
        local s1d4p = false
        if distance4 <= 1.0 and packing == 0 then
            DrawText3D2(packageX2, packageY2, packageZ2, "~g~[E]~w~ Đóng gói")
        elseif distance4 <= 1.0 and packing == 1 then
            DrawText3D2(packageX2, packageY2, packageZ2, "~g~[G]~w~ Dừng đóng gói")
            DrawText3D2(packageX2, packageY2, packageZ2 + 0.1, "~g~[E]~w~ Tiếp tục đóng gói")
        end
        
        if distance4 <= 0.6 then
            if IsControlJustPressed(0, Keys['E']) then -- "E"
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    hasBagd4p = result
                    s1d4p = true
                end, 'slaughteredchicken')
                while (not s1d4p) do
                    Citizen.Wait(100)
                end
                if (hasBagd4p) then
                    donggoiga(2)
                else
                    QBCore.Functions.Notify('Bạn không có thịt gà để đóng gói .', 'error')
                end
            elseif IsControlJustPressed(0, Keys['G']) then
                dungdonggoi(2)
            end
        end
    end
end)

------
function dungdonggoi(position)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    packeforacar = true
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
   -- proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, GetPlayerPed(-1	), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
    packing = 0
    while packeforacar do
        Citizen.Wait(250)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
        local vCoords = GetEntityCoords(veh)
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, vCoords.x, vCoords.y, vCoords.z, false)
        --LoadDictload('anim@heists@box_carry@')
		packeforacar = false

	end
end

function donggoiga(position)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    local inventory = QBCore.Functions.GetPlayerData().inventory
    local count = 0
    if (count == 0) then
        QBCore.Functions.Progressbar("search_register", "Đang đóng gói thịt gà", 6000, false, true, {disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            disableInventory = true,
        }, {}, {}, {}, function() end, function()
        
        end)
        SetEntityHeading(GetPlayerPed(-1), 40.0)
        local PedCoords = GetEntityCoords(GetPlayerPed(-1))
        meat = CreateObject(GetHashKey('prop_cs_steak'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
        AttachEntityToEntity(meat, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        cardboard = CreateObject(GetHashKey('prop_cs_clothes_box'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
        AttachEntityToEntity(cardboard, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
        packing = 1
        LoadDictload("anim@heists@ornate_bank@grab_cash_heels")
        TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
        FreezeEntityPosition(GetPlayerPed(-1), true)
        Citizen.Wait(6000)
        TriggerServerEvent("gapi:przerob2", 2)
        QBCore.Functions.Notify('Đã đóng gói thành công, bạn nhận được 2 gà đóng gói.', 'success')--success    
        ClearPedTasks(GetPlayerPed(-1))
        DeleteEntity(cardboard)
        DeleteEntity(meat)
    else
        
        QBCore.Functions.Notify('Bạn không có thịt gà để đóng gói.', 'error')--success
    end
end
------
function cainaydeobiet(position)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    local inventory = QBCore.Functions.GetPlayerData().inventory
    local count = 0
    if (count == 0) then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDictload(dict)
        FreezeEntityPosition(GetPlayerPed(-1), true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0)
        local PedCoords = GetEntityCoords(GetPlayerPed(-1))
        something1 = CreateObject(GetHashKey('prop_knife'), PedCoords.x, PedCoords.y, PedCoords.z, true, true, true)
        AttachEntityToEntity(something1, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
        if position == 1 then
            QBCore.Functions.Progressbar("search_register", "Đang cắt thịt gà..", 10000, false, true, {disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
                disableInventory = true,
            }, {}, {}, {}, function() end, function()
            
            end)
            SetEntityHeading(GetPlayerPed(-1), 311.0)
			pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.00, 6201.72, 29.99, true, true, true)

            SetEntityRotation(pig, 90.0, 0.0, 45.0, 1, true)
            Citizen.Wait(10000)
			QBCore.Functions.Notify('Đã cắt thịt gà và nhận được 2 gà đã mổ', 'success')--success

        elseif position == 2 then
            QBCore.Functions.Progressbar("search_register", "Đang cắt thịt gà..", 10000, false, true, {disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
                disableInventory = true,
            }, {}, {}, {}, function() end, function()
            
            end)
            SetEntityHeading(GetPlayerPed(-1), 222.0)
			pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)

            SetEntityRotation(pig, 90.0, 0.0, -45.0, 1, true)
            Citizen.Wait(10000)
			QBCore.Functions.Notify('Đã cắt thịt gà và nhận được 2 gà đã mổ', 'success')--success

        end
        
        FreezeEntityPosition(GetPlayerPed(-1), false)
        DeleteEntity(pig)
        DeleteEntity(something1)
        ClearPedTasks(GetPlayerPed(-1))
        TriggerServerEvent("gapi:przerob2", 1)
    else
        QBCore.Functions.Notify('Bạn không có gà để cắt', 'error')--success
    
    end
end


function bogavaokho()
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), startX + 2, startY + 2, startZ, 0, 0, 1)
    if DoesEntityExist(pig1) or DoesEntityExist(pig2) or DoesEntityExist(pig3) or DoesEntityExist(pig4) or DoesEntityExist(pig5) then
        DeleteEntity(pig1)
        DeleteEntity(pig2)
        DeleteEntity(pig3)
		DeleteEntity(pig4)
        DeleteEntity(pig5)

    end
    Citizen.Wait(500)
    DoScreenFadeIn(500)
    
    --local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
   -- proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z + 0.2, true, true, true)
   -- AttachEntityToEntity(proppig, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
    
    local givecars = true
    
    while givecars do
        Citizen.Wait(250)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
        local vCoords = GetEntityCoords(veh)
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, vCoords.x, vCoords.y, vCoords.z, false)
        --LoadDictload('anim@heists@box_carry@')
		givecars = false
            TriggerServerEvent("ga:wkladajKurczki2")

        
	end

end

function batga()
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), 2384.62, 4850.7, 41.22, 0, 0, 1)
    RequestModel(GetHashKey('a_c_hen'))
    while not HasModelLoaded(GetHashKey('a_c_hen')) do
        Wait(1)
    end
    pig1 = CreatePed(26, "a_c_hen", 2384.62, 4850.7, 41.22, 273.87, true, false)
    pig2 = CreatePed(26, "a_c_hen", 2389.48, 4851.78, 41.22, 286.81, true, false)
    pig3 = CreatePed(26, "a_c_hen", 2399.18, 4851.1, 41.22, 195.477, true, false)
	pig4 = CreatePed(26, "a_c_hen", 2396.09, 4846.65, 41.22, 195.477, true, false)
    pig5 = CreatePed(26, "a_c_hen", 2393.8, 4841.27, 41.22, 195.477, true, false)
    TaskReactAndFleePed(pig1, GetPlayerPed(-1))
    TaskReactAndFleePed(pig2, GetPlayerPed(-1))
    TaskReactAndFleePed(pig3, GetPlayerPed(-1))
	TaskReactAndFleePed(pig4, GetPlayerPed(-1))
    TaskReactAndFleePed(pig5, GetPlayerPed(-1))

    Citizen.Wait(500)
    DoScreenFadeIn(500)
    share = true
end
-----
function LoadDictload(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        
        if share == true then
            local pig1Coords = GetEntityCoords(pig1)
            local pig2Coords = GetEntityCoords(pig2)
            local pig3Coords = GetEntityCoords(pig3)
			local pig4Coords = GetEntityCoords(pig4)
            local pig5Coords = GetEntityCoords(pig5)

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig1Coords.x, pig1Coords.y, pig1Coords.z)
            local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig2Coords.x, pig2Coords.y, pig2Coords.z)
            local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig3Coords.x, pig3Coords.y, pig3Coords.z)
			local dist4 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig4Coords.x, pig4Coords.y, pig4Coords.z)
            local dist5 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig5Coords.x, pig5Coords.y, pig5Coords.z)

            if numbercaught == 5 then
                caught1 = 0
                caught2 = 0
                caught3 = 0
				caught4 = 0
                caught5 = 0
                numbercaught = 0
                share = false
                
                QBCore.Functions.Notify('Đã bỏ 5 gà sống vào kho!', 'success')--success
                bogavaokho()
            end
            
            if dist <= 1.0 then
                DrawText3D2(pig1Coords.x, pig1Coords.y, pig1Coords.z + 0.5, "~o~[E]~b~ Bắt gà")
                if IsControlJustPressed(0, Keys['E']) then
                    caught1 = 1
                   
                    batgg()
                end
            elseif dist2 <= 1.0 then
                DrawText3D2(pig2Coords.x, pig2Coords.y, pig2Coords.z + 0.5, "~o~[E]~b~ Bắt gà ")
                if IsControlJustPressed(0, Keys['E']) then
                    caught2 = 1
                   
                    batgg()
                end
			elseif dist4 <= 1.0 then
                DrawText3D2(pig4Coords.x, pig4Coords.y, pig4Coords.z + 0.5, "~o~[E]~b~ Bắt gà ")
                if IsControlJustPressed(0, Keys['E']) then
                    caught4 = 1
                   
                    batgg()
                end
			elseif dist5 <= 1.0 then
                DrawText3D2(pig5Coords.x, pig5Coords.y, pig5Coords.z + 0.5, "~o~[E]~b~ Bắt gà ")
                if IsControlJustPressed(0, Keys['E']) then
                    caught5 = 1
                  
                    batgg()
                end
            elseif dist3 <= 1.0 then
                DrawText3D2(pig3Coords.x, pig3Coords.y, pig3Coords.z + 0.5, "~o~[E]~b~ Bắt gà")
                if IsControlJustPressed(0, Keys['E']) then
                    caught3 = 1
                   
                    batgg()
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

local ragdoll = false

function batgg()
    LoadDictload('move_jump')
    TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
    Citizen.Wait(600)
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    Citizen.Wait(1000)
    ragdoll = true
    local chanceofcatch = math.random(1, 100)
    if chanceofcatch <= 60 then
        
        QBCore.Functions.Notify('Đã bắt thành công!', 'success')--success
        if caught1 == 1 then
           
            DeleteEntity(pig1)
            caught1 = 0
            numbercaught = numbercaught + 1
            local chance = math.random(0,100)

            --[[if chance < 2 then
                TriggerServerEvent('batga:server:manh')
                end
                if chance < 1.5 then
                TriggerServerEvent('batga:server:manh2')
                end]]
        elseif caught2 == 1 then
           
            DeleteEntity(pig2)
            caught2 = 0
            numbercaught = numbercaught + 1
            local chance = math.random(0,100)

            --[[if chance < 2 then
                TriggerServerEvent('batga:server:manh')
                end
                if chance < 1.5 then
                TriggerServerEvent('batga:server:manh2')
                end]]
		elseif caught5 == 1 then
           
            DeleteEntity(pig5)
            caught5 = 0
            numbercaught = numbercaught + 1
            local chance = math.random(0,100)

            --[[if chance < 2 then
                TriggerServerEvent('batga:server:manh')
                end
                if chance < 1.5 then
                TriggerServerEvent('batga:server:manh2')
                end]]
		elseif caught4 == 1 then
           
            DeleteEntity(pig4)
            caught4 = 0
            numbercaught = numbercaught + 1
            local chance = math.random(0,100)

            --[[if chance < 2 then
                TriggerServerEvent('batga:server:manh')
                end
                if chance < 1.5 then
                TriggerServerEvent('batga:server:manh2')
                end]]
        elseif caught3 == 1 then
            
            DeleteEntity(pig3)
            caught3 = 0
            numbercaught = numbercaught + 1
            local chance = math.random(0,100)

           --[[ if chance < 2 then
                TriggerServerEvent('batga:server:manh')
                end
                if chance < 1.5 then
                TriggerServerEvent('batga:server:manh2')
                end]]
        end
    else
        QBCore.Functions.Notify('Gà đã chạy khỏi tay bạn!', 'error')--success
    
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ragdoll then
            SetEntityHealth(PlayerPedId(), 200)
            TriggerEvent('mythic_hospital:client:ResetLimbs')
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            ragdoll = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
        
        if dist <= 7.0 then
            DrawMarker(23, sellX, sellY, sellZ - 0.96, 0, 0, 0, 0, 0, 0, 1.8, 1.8, 1.8, 129, 66, 245, 200, 0, 0, 0, 0)
        else
            Citizen.Wait(1000)
        end
        local hasBagd7p = false
        local s1d7p = false
        if dist <= 2.0 then
            DrawText3D2(sellX, sellY, sellZ + 0.1, "[E] Bán thịt gà")
            if IsControlJustPressed(0, Keys['E']) then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                    hasBagd7p = result
                    s1d7p = true
                end, 'packedchicken')
                while (not s1d7p) do
                    Citizen.Wait(100)
                end
                if (hasBagd7p) then
                    bangane()
                else
                    QBCore.Functions.Notify('Bạn không có thịt gà đóng gói để bán .', 'error')
                end
            end
        end
    
    end
end)

function bangane()
    -- local
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inventory = QBCore.Functions.GetPlayerData().inventory
    local count = 0
    if (count == 0) then
        QBCore.Functions.Progressbar("search_register", "Đang bán thịt gà..", 5000, false, true, {disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            disableInventory = true,
        }, {}, {}, {}, function() end, function()
        
        end)
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
        proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z, true, true, true)
        SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
        LoadDictload('amb@medic@standing@tendtodead@idle_a')
        TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
        Citizen.Wait(5000)
        LoadDictload('amb@medic@standing@tendtodead@exit')
        TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
        ClearPedTasks(GetPlayerPed(-1))
        DeleteEntity(proppig)
        TriggerServerEvent("ga:sell")
    else
        
        end
end

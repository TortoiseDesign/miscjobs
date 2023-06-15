-------------------------
--Written by Tościk#9715-
-------------------------

local maxZywych = 100000000   -- max ammount of live chickens you can hold
local MaxMartweKurczaki = 1000000000  -- how many dead chickens you can hold
local MaxZapakowanychKurczakow = 100000000000  --how many packed chickens you can hold
local GotowkaSprzedaz = 60   --ammount of money you get for 2 packaged chickens

-----------------------------
---nizej lepiej nie ruszaj---
-----------------------------
local QBCore = exports["qb-core"]:GetCoreObject()
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('tost:wkladajKurczki2')
AddEventHandler('tost:wkladajKurczki2', function()
local _source = source
local xPlayer = QBCore.Functions.GetPlayer(_source)
local zywyKurczak = 0
if xPlayer.Functions.GetItemByName('alivepig') ~= nil then 
zywyKurczak = xPlayer.Functions.GetItemByName('alivepig').amount 
end 

if zywyKurczak < maxZywych then
Citizen.Wait(1000)
xPlayer.Functions.AddItem('alivepig', 3)
--TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["lonsong"], "add")
Wait(1500)
else
--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..maxZywych.. '~y~ kurczaków.')
TriggerClientEvent('QBCore:Notify', source, "Bạn chỉ có thể chứa " ..maxZywych.. " lợn sống", "error")
Wait(2500)
end
end)

RegisterServerEvent('tostpigi:przerob2')
AddEventHandler('tostpigi:przerob2', function(opcja)
local _source = source
local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
local zywyKurczak = 0
if xPlayer.Functions.GetItemByName('alivepig') ~= nil then 
	zywyKurczak = xPlayer.Functions.GetItemByName('alivepig').amount 
end 
local MartwyKurczak = 0
if xPlayer.Functions.GetItemByName('slaughteredpig') ~= nil then 
MartwyKurczak = xPlayer.Functions.GetItemByName('slaughteredpig').amount 
end
local ZapakowanyKurczak = 0
if xPlayer.Functions.GetItemByName('packedpig') ~= nil then 
ZapakowanyKurczak = xPlayer.Functions.GetItemByName('packedpig').amount 
end
if opcja == 1 then
	if zywyKurczak > 0 and MartwyKurczak < MaxMartweKurczaki then
	Citizen.Wait(1000)
	xPlayer.Functions.RemoveItem('alivepig', 1)
	Citizen.Wait(1000)
	xPlayer.Functions.AddItem('slaughteredpig', 2)
	Wait(1500)

	end
end

if opcja == 2 then
	if MartwyKurczak > 0 and ZapakowanyKurczak < MaxZapakowanychKurczakow then
	Citizen.Wait(1000)
	xPlayer.Functions.RemoveItem('slaughteredpig', 1)
	Citizen.Wait(1000)
	xPlayer.Functions.AddItem('packedpig', 2)
	Wait(1500)
	
	end
end

if opcja == 3 then
	if ZapakowanyKurczak > 0 then
		local money = math.random(33, 40)
	Citizen.Wait(1000)
	xPlayer.Functions.RemoveItem('packedpig', 1)
	xPlayer.Functions.AddMoney('cash', money)
	--TriggerClientEvent('esx:showNotification', source, '~g~Otrzymujesz ~y~'..GotowkaSprzedaz.. '$ ~g~za dwa kartony kurczaków.')
	QBCore.Functions.Notify('Bạn đã hết thịt lợn đóng gói .', 'error')

	Wait(1500)
	end
end

end)
RegisterNetEvent('batlon:server:manh')
AddEventHandler('batlon:server:manh', function()
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))

	xPlayer.Functions.AddItem("manh1", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', source, QBCore.Shared.Items["manh1"], "add")
end)

RegisterNetEvent('batlon:server:manh2')
AddEventHandler('batlon:server:manh2', function()
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))

	xPlayer.Functions.AddItem("manh2", 1, false)
	TriggerClientEvent('pepe-inventory:client:ItemBox', source, QBCore.Shared.Items["manh2"], "add")
end)


RegisterServerEvent('lon:sell')
AddEventHandler('lon:sell', function()
		local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local money = math.random(330, 400)

    if xPlayer.Functions.RemoveItem("packedpig", 10) then
		TriggerClientEvent('QBCore:Notify', src, 'Bạn nhận được $'..money..'')
        Player.Functions.AddMoney("cash", money)
        Citizen.Wait(1000)
        TriggerClientEvent("pepe-inventory:client:ItemBox", src, QBCore.Shared.Items['londonggoi'], "remove")
    else
        TriggerClientEvent("QBCore:Notify", src, "Không có lợn đóng gói để bán", "error", 1000)
    
	end
end)


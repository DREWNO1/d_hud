local QBCore = exports['qb-core']:GetCoreObject()
local seatbeltOn = false

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function() -- Triggered in smallresources
    seatbeltOn = not seatbeltOn
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local Player = QBCore.Functions.GetPlayerData()
        
        SendNUIMessage({
            type = 'ids',
            cid = Player.citizenid,
            id = Player.source,
            name = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
        })
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    while true do
    Wait(100)
    if IsPauseMenuActive() then        
        SendNUIMessage({
            type = 'turn',
            data1 = 'on',
            data2 = 'mapaon'
        })
    else
        SendNUIMessage({
            type = 'turn',
            data1 = 'on',
            data2 = 'mapaoff'
        })
    end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    SendNUIMessage({
        type = 'turn',
        data1 = 'off',
        data2 = 'mapaon'
    })
end)

-- Citizen.CreateThread(function()
--     local Player = QBCore.Functions.GetPlayerData()
        
--         SendNUIMessage({
--             type = 'ids',
--             cid = Player.citizenid,
--             id = Player.source,
--             name = Player.charinfo.firstname .. " " .. Player.charinfo.lastname
--         })

--         print(QBCore.Debug(Player))
-- end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1000)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local playerId = PlayerId()

        while true do
            Wait(100)
    
            local talking = NetworkIsPlayerTalking(playerId)
            local voice = 0
    
            if LocalPlayer.state['proximity'] then
                voice = LocalPlayer.state['proximity'].distance
            end
    
            local Player = QBCore.Functions.GetPlayerData()
            local armor = GetPedArmour(player)
            local oxygen = 0
            
            if IsEntityInWater(player) then
                oxygen = 100 - GetPlayerUnderwaterTimeRemaining(playerId) * 10
            end
            
            SendNUIMessage({
                type = 'needs',
                hp = 100 - (GetEntityHealth(player) - 100),
                armor = armor,
                oxygen = oxygen,
                food = (100 - Player.metadata.hunger),
                water = (100 - Player.metadata.thirst),
                micrange = voice,
                mic = talking,
            })
        end
    end)
end)

Citizen.CreateThread(function()
    
    while true do
        Wait(100)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local player = PlayerPedId()
            
            local coords = GetEntityCoords(player)
            local streetname = GetStreetNameAtCoord(coords.x, coords.y, coords.z)

            local veh = GetVehiclePedIsIn(player, false)
            local speed = GetEntitySpeed(veh)
            DisplayRadar(true)
            -- SetMinimapClipType(1)

            SendNUIMessage({
                type = 'inveh',
                bool = 'true',
                streetname = GetStreetNameFromHashKey(streetname),
                vel = speed * 2.236936,
                fuel = 100 - math.floor(exports['LegacyFuel']:GetFuel(veh)),
                seatbelt = seatbeltOn,
            })
        else 
            DisplayRadar(false)
            SendNUIMessage({
                type = 'inveh',
                bool = 'false'
            })
        end
    end
end)

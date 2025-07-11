local holdingUp = false
local store = ""
local blipRobbery = nil
ESX = exports['es_extended']:getSharedObject()

-- ESX events registreren
CreateThread(function()
    -- Registreer events die ESX gebruiken
    RegisterNetEvent('cd_holdup:tooFar')
    AddEventHandler('cd_holdup:tooFar', function()
        holdingUp, store = false, ''
        ESX.ShowNotification(_U('robbery_cancelled'))
    end)

    RegisterNetEvent('cd_holdup:robberyComplete')
    AddEventHandler('cd_holdup:robberyComplete', function(award)
        holdingUp, store = false, ''
        ESX.ShowNotification(_U('robbery_complete', award))
    end)

    RegisterNetEvent('cd_holdup:currentlyRobbing')
    AddEventHandler('cd_holdup:currentlyRobbing', function(currentStore)
        holdingUp, store = true, currentStore
    end)

    RegisterNetEvent('cd_holdup:killBlip')
    AddEventHandler('cd_holdup:killBlip', function()
        if blipRobbery then
            RemoveBlip(blipRobbery)
            blipRobbery = nil
        end
    end)

    RegisterNetEvent('cd_holdup:setBlip')
    AddEventHandler('cd_holdup:setBlip', function(position)
        blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
        SetBlipSprite(blipRobbery, 161)
        SetBlipScale(blipRobbery, 0.7)
        SetBlipColour(blipRobbery, 3)
        PulseBlip(blipRobbery)
    end)

    RegisterNetEvent('cd_holdup:startTimer')
    AddEventHandler('cd_holdup:startTimer', function()
        local timer = Stores[store].secondsRemaining
        print("[DEBUG] Timer started! Duration:", timer, "seconds for store:", store)

        Citizen.CreateThread(function()
            while timer > 0 and holdingUp do
                Citizen.Wait(1000)
                timer = timer - 1
            end
        end)

        Citizen.CreateThread(function()
            while holdingUp do
                Citizen.Wait(0)
                drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
            end
        end)
    end)
end) -- Einde van de CreateThread die ESX ophaalt en events registreert

-- Functie om tekst te tekenen
function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    if outline then SetTextOutline() end

    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

AddEventHandler('onResourceStart', function(resourceName)
    if ("cd_holdup" ~= resourceName) then
      return
    end
end)

-- Blips maken voor winkels
Citizen.CreateThread(function()
    while not ESX do Wait(100) end
    for k,v in pairs(Stores) do
        local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
        SetBlipSprite(blip, 156)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('shop_robbery'))
        EndTextCommandSetBlipName(blip)
    end
end)

-- Hoofdloop die de rob actie regelt
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not ESX then
            Wait(100)
            goto continue
        end

        local playerPos = GetEntityCoords(PlayerPedId(), true)

        for k,v in pairs(Stores) do
            local storePos = v.position
            local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z)

            if distance < 3 then
                if not holdingUp then
                    ESX.Game.Utils.DrawText3D({x = storePos.x, y = storePos.y, z = storePos.z + 0.2}, 'Press [~r~E~w~] to rob the store', 0.9)
                    if distance < 0.5 then
                        if IsControlJustReleased(0, 38) then
                            if IsPedArmed(PlayerPedId(), 4) then
                                TriggerServerEvent('cd_holdup:checkstore', k)
                                ESX.TriggerServerCallback('cd_holdup:server:checkcops', function(canRob)
                                    if canRob then
                                        exports['mythic_notify']:DoCustomHudText('inform', 'A and D to move numbers. W to confirm, S to cancel', 10000)
                                        local res = exports['cd_holdup']:createSafe({math.random(0,99)})
                                        if res == true then
                                            TriggerServerEvent('cd_holdup:robberyStarted', k)
                                        else
                                            exports['mythic_notify']:DoHudText('error', 'Safe Cracking Failed')
                                        end
                                    else
                                        exports["mythic_notify"]:SendAlert('error', "You need " ..Config.PoliceNumberRequired.. " cops in town to rob")
                                    end
                                end)
                            else
                                exports["mythic_notify"]:SendAlert('error', _U('no_threat'))
                            end
                        end
                    end
                end
            end
        end

        if holdingUp then
            local storePos = Stores[store].position
            if Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z) > Config.MaxDistance then
                TriggerServerEvent('cd_holdup:tooFar', store)
            end
        end
        ::continue::
    end
end)

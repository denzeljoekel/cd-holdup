local rob = false
local robbers = {}
local robberyTimers = {} -- Track active robbery timers
ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('cd_holdup:tooFar')
AddEventHandler('cd_holdup:tooFar', function(currentStore)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
			TriggerClientEvent('cd_holdup:killBlip', xPlayers[i])
		end
	end

	if robbers[_source] then
		-- Cancel the active timer by removing the player from timers
		robberyTimers[_source] = nil
		
		TriggerClientEvent('cd_holdup:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
		print("[DEBUG] Robbery cancelled for player", _source, "- timer cleared")
	end
end)

RegisterServerEvent('cd_holdup:robberyStarted')
AddEventHandler('cd_holdup:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lcdbbed) < Config.TimerBeforeNewRob and store.lcdbbed ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lcdbbed)))
			return
		end

		if not rob then
				rob = true

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
						TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog', store.nameOfStore))
						TriggerClientEvent('chat:addMessage', -1, { template = '<div class="chat-message server"><b>^1ATLAS CITY NEWS : </b> {1}</div>', args = { fal, "Robbery in progress at ^0".. store.nameOfStore  } })
						TriggerClientEvent('cd_holdup:setBlip', xPlayers[i], Stores[currentStore].position)
					end
				end

				TriggerClientEvent('esx:showNotification', _source, _U('started_to_rob', store.nameOfStore))
				TriggerClientEvent('esx:showNotification', _source, _U('alarm_triggered'))
				
				TriggerClientEvent('cd_holdup:currentlyRobbing', _source, currentStore)
				TriggerClientEvent('cd_holdup:startTimer', _source)
				print("[DEBUG] Server: Started robbery timer for store", currentStore, "player", _source)
				
				Stores[currentStore].lcdbbed = os.time()
				robbers[_source] = currentStore
				
				-- Store the end time for this robbery
				robberyTimers[_source] = os.time() + store.secondsRemaining
				print("[DEBUG] Robbery timer started for player", _source, "ends at", robberyTimers[_source])

				SetTimeout(store.secondsRemaining * 1000, function()
					-- Check if the robbery is still active (not cancelled)
					if robbers[_source] and robberyTimers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('cd_holdup:robberyComplete', _source, store.reward)

							if Config.GiveBlackMoney then
								xPlayer.addAccountMoney('black_money', store.reward)
							else
								xPlayer.addMoney(store.reward)
							end
							
							local xPlayers, xPlayer = ESX.GetPlayers(), nil
							for i=1, #xPlayers, 1 do
								xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer.job.name == 'police' then
									TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at', store.nameOfStore))
									TriggerClientEvent('cd_holdup:killBlip', xPlayers[i])
								end
							end
							
							-- Clean up
							robberyTimers[_source] = nil
							print("[DEBUG] Robbery completed for player", _source, "- reward given")
						end
					else
						print("[DEBUG] Robbery timer expired but was cancelled for player", _source)
					end
				end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('cd_holdup:checkstore')
AddEventHandler('cd_holdup:checkstore', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lcdbbed) < Config.TimerBeforeNewRob and store.lcdbbed ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lcdbbed)))
			return
		end
	end
end)

ESX.RegisterServerCallback('cd_holdup:server:checkcops', function(source, cb)
    local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

        local cops = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end

	if cops >= Config.PoliceNumberRequired then
	
		cb(true)

	else
		cb(false)
	end
end)

-- Clean up when player disconnects
AddEventHandler('playerDropped', function(reason)
	local _source = source
	if robbers[_source] then
		rob = false
		robbers[_source] = nil
		robberyTimers[_source] = nil
		print("[DEBUG] Player", _source, "disconnected during robbery - cleaned up")
	end
end)

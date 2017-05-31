-- CODE -- 

players = {}
host = nil
time = {h = math.random(6), m = 0, s = 0}

RegisterServerEvent("PNew")
RegisterServerEvent("PTimeSync")


AddEventHandler("PNew", function(id)
	players[source] = id
	
	if not host then
		host = source
		TriggerClientEvent("PTimeSyncHost", source, time)
	end
end)

AddEventHandler("PDrop", function(reason)
	players[source] = nil
	
	if source == host then
		if #players > 0 then
			for msource, _ in pairs(players) do
				host = mSource
				TriggerClientEvent("PTimeSyncHost", host, time)
				break
			end
		else
			host = nil
		end
	end
end)

AddEventHandler("PTimeSync", function(newTime)
	time = newTime
	TriggerClientEvent("PTimeSync", -1, time)
	if not freezeTime then
		NetworkOverrideClockTime(time.h, time.m, time.s)
	end
end)
		
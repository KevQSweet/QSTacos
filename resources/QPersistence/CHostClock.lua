RegisterNeEvent("PTimeSyncHost")
AddEventHandler("PTimeSyncHost", function(time)
	Citizen.CreateThread(function()
		while true do
			Wait(33)
			newTime = time

			newTime.s = newTime.s + 1
			if newTime.s > 59 then
				newTime.s = 0

				newTime.m = newTime.m + 1
				if newTime.m > 59 then
					newTime.m = 0

					newTime.h = time.h + 1
					if newTime.h > 23 then
						newTime.h = 0
					end
				end
			end

			TriggerServerEvent("PTimeSync", newTime)
		end
	end)
end)
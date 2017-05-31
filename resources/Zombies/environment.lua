-- CONFIG --

-- Allows you to set if weather should be frozen and what weather
local freezeWeather = true

local weather = "XMAS"

-- Allows you to set if time should be frozen and what time
local freezeTime = true
local hours = 2
local minutes = 0

-- Set if first person should be forced
local forceFirstPerson = true

-- CODE --
Citizen.CreateThread(function()
	SetBlackout(true)

	while true do
		Wait(1)

		if forceFirstPerson then
			SetFollowPedCamViewMode(4)
		end

        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)

		-- Thanks @Boss
		if freezeWeather then
			SetWeatherTypePersist(weather)
        	SetWeatherTypeNowPersist(weather)
       		SetWeatherTypeNow(weather)
       		SetOverrideWeather(weather)
       	end

       	if freezeTime then
       		NetworkOverrideClockTime(hours, minutes, 0)
       	end
	end
end)

RegisterNetEvent("Z:timesync")
AddEventHandler("Z:timesync", function(time)
	if not freezeTime then
		NetworkOverrideClockTime(time.h, time.m, time.s)
	end
end)

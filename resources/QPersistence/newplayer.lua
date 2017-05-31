-- CONFIG --

local spawnWithFlashlight = true
local displayRadar = false

-- CODE --

TriggerServerEvent("Z:newplayer", PlayerId())

local welcomed = false

AddEventHandler("playerSpawned", function(spawn)
	if spawnWithFlashlight then
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
	end
end)

Citizen.CreateThread(function()
    while true do
		Wait(1)
		if not displayRadar then
			DisplayRadar(false)
		end
	end
end)
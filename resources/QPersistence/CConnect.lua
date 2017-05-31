-- CONFIG --
local PSpawnWeapons = {"WEAPON_FLASHLIGHT", "WEAPON_PISTOL"}
local PKits = true

-- CODE --

TriggerServerEvent("PNew", PlayerId())


AddEventHandler("PSpawned", function(i)
	if PKits then
		For _, weapon in pairs(PSpawnWeapons) do 
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 3, false, false
		end
	end
end)
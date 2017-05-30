-- CONFIG --

-- A list of weapons that should be spawned
local spawnableWeapons =
{
	"PICKUP_WEAPON_PISTOL",
	"PICKUP_WEAPON_SMG",
	"PICKUP_WEAPON_KNIFE",
	"PICKUP_WEAPON_ASSAULTRIFLE",
}

-- CODE --

players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)

weapons = {}

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if #weapons < 3 then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

			repeat
				Wait(1)

				newX = x + math.random(-300, 300)
				newY = y + math.random(-300, 300)

				for player, _ in pairs(players) do
					Wait(1)
					playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
					if newX > playerX - 60 and newX < playerX + 60 or newY > playerY - 60 and newY < playerY + 60 then
						canSpawn = false
						break
					else
						canSpawn = true
					end
				end
			until canSpawn

			choosenWeapon = spawnableWeapons[math.random(1, #spawnableWeapons)]

			weapon = CreatePickupRotate(GetHashKey(choosenWeapon), newX, newY, z, 0.0, 0.0, 0.0, 8, 1.0, 24, 24, true, GetHashKey(choosenWeapon))
			SetEntityDynamic(weapon, true)
			SetEntityRecordsCollisions(weapon, true)
			SetEntityHasGravity(weapon, true)
			FreezeEntityPosition(weapon, false)
			SetEntityVelocity(weapon, 0.0, 0.0, -0.2)

			Citizen.Trace("Spawned weapon " .. choosenWeapon .. "\n")
			weaponInfo = {weapon = weapon, x = newX, y = newY, z = z}
			table.insert(weapons, weaponInfo)
		end

		for i, weaponInfo in pairs(weapons) do
			if not DoesPickupExist(weaponInfo.weapon) then
				table.remove(weapons, i)
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				weaponX = weaponInfo.x
				weaponY = weaponInfo.y

				if weaponX < playerX - 400 or weaponX > playerX + 400 or weaponY < playerY - 400 or weaponY > playerY + 400 then
					-- Set weapon as no longer needed for despawning
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(weaponInfo.weapon))
					table.remove(weapons, i)
				end
			end
		end
	end
end)

RegisterNetEvent("Z:cleanup")
AddEventHandler("Z:cleanup", function()
	for i, weapon in pairs(weapons) do
		-- Set weapon as no longer needed for despawning
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(weapon))

		table.remove(weapons, i)
	end
end)
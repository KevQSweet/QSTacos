-- CONFIG --

-- Zombies have a 1 in 150 chance to spawn with guns
-- It will choose a gun in this list when it happens
-- Weapon list here: https://www.se7ensins.com/forums/threads/weapon-and-explosion-hashes-list.1045035/
-- Only add the weapon name, not the weapon hash
local pedWeps =
{
	"WEAPON_PISTOL",
	"WEAPON_MG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SNIPERRIFLE"
}

-- CODE --

players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)

peds = {}

Citizen.CreateThread(function()
	AddRelationshipGroup("zombeez")
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("zombeez"))
	SetAiMeleeWeaponDamageModifier(50.0)

	while true do
		Wait(1)

		if #peds < 19 then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

			RequestModel(0xAC4B4506)
			while not HasModelLoaded(0xAC4B4506) do
				Wait(1)
			end

			repeat
				Wait(1)

				newX = x + math.random(-300, 300)
				newY = y + math.random(-300, 300)

				for _, player in pairs(players) do
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

			ped = CreatePed(4, 0xAC4B4506, newX, newY, z - 500, 0.0, true, true)

			SetPedArmour(ped, 100)
			SetPedAccuracy(ped, 25)
			SetPedSeeingRange(ped, 1000000.0)
			SetPedHearingRange(ped, 1000000.0)

			SetPedFleeAttributes(ped, 0, 0)
   			SetPedCombatAttributes(ped, 16, 1)
   			SetPedCombatAttributes(ped, 46, 1)
			SetAmbientVoiceName(ped, "ALIENS")
			SetPedEnableWeaponBlocking(ped, true)
			SetPedRelationshipGroupHash(ped, GetHashKey("zombeez"))
			DisablePedPainAudio(ped, true)
			SetPedDiesInWater(ped, false)
			SetPedDiesWhenInjured(ped, false)

			SetPedIsDrunk(ped, true)
			RequestAnimSet("move_m@drunk@verydrunk")
			while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
				Wait(1)
			end
			SetPedMovementClipset(ped, "move_m@drunk@verydrunk", 1.0)

			--TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)
			x, y, z = table.unpack(GetEntityCoords(ped, true))
			TaskWanderStandard(ped, 1.0, 10)

			chance = math.random(150)
			if chance == 50 then
				randomWep = math.random(1, #pedWeps)
				GiveWeaponToPed(ped, GetHashKey(pedWeps[randomWep]), 9999, true, true)

				Citizen.Trace("Spawned zombie with weapon " .. pedWeps[randomWep] .. "\n")
			else
				Citizen.Trace("Spawned zombie with no weapon\n")
			end

			table.insert(peds, ped)
		end

		for i, ped in pairs(peds) do
			if not DoesEntityExist(ped) then
				table.remove(peds, i)
			elseif IsPedDeadOrDying(ped, 1) then
				-- Set ped as no longer needed for despawning
				Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
				table.remove(peds, i)
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY = table.unpack(GetEntityCoords(ped, true))

				if pedX < playerX - 400 or pedX > playerX + 400 or pedY < playerY - 400 or pedY > playerY + 400 then
					-- Set ped as no longer needed for despawning
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
					table.remove(peds, i)
				end
			end
		end
	end
end)

RegisterNetEvent("Z:cleanup")
AddEventHandler("Z:cleanup", function()
	for i, ped in pairs(peds) do
		-- Set ped as no longer needed for despawning
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))

		table.remove(peds, i)
	end
end)
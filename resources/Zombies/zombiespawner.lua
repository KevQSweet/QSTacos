-- CONFIG --

-- Zombies have a 1 in 150 chance to spawn with guns
-- It will choose a gun in this list when it happens
-- Weapon list here: https://www.se7ensins.com/forums/threads/weapon-and-explosion-hashes-list.1045035/
-- Only add the weapon name, not the weapon hash
local time = {h = 9, m = 0, s = 0}
local pedWeps =
{
	"WEAPON_PISTOL",
	"WEAPON_MG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SNIPERRIFLE"
}

-- CODE --
LootPeds = {}
peds = {}
players = {}

RegisterNetEvent("Z:TimeUpdate")
AddEventHandler("Z:TimeUpdate", function(currentTime)
	time = currentTime
	SubTime = ((time.h * 60) + time.m)
	if #LootPeds > 0 then
		for i, ped in pairs(LootPeds) do
			ZToD = ped.death
			if SubTime - ZToD > 1 then
				Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
				table.remove(LootPeds, i)
				TriggerServerEvent("DebugThis", "Zombie Despawned")
			end
		end
	end
end)

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)
local zaccuracy = 0
local zarmour   = 0
local zears     = 1000000000
local zsight    = 1000000000
Citizen.CreateThread(function()
	AddRelationshipGroup("zombeez")
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("zombeez"))
	SetAiMeleeWeaponDamageModifier(25.0)

	while true do
		Wait(1)

		if #peds < 200 then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			ZomMods = {"u_m_y_zombie_01", "s_f_y_ranger_01", "a_c_rottweiler", "a_m_m_mexlabor_01", "a_m_m_tramp_01", "a_m_y_methhead_01", "a_m_y_runner_02"}
		--TriggerServerEvent("DebugThis", "0")
			RanZomMod = ZomMods[math.random(1, #ZomMods)]
			DMessage = RanZomMod
		--TriggerServerEvent("DebugThis", "0.1")
		--TriggerServerEvent("DebugThis", DMessage)
			
			
		--TriggerServerEvent("DebugThis", "1")
			RequestModel(RanZomMod)
		--TriggerServerEvent("DebugThis", "2")
			while not HasModelLoaded(RanZomMod) do
				Wait(1)
			end
		--TriggerServerEvent("DebugThis", "3")
			repeat
				Wait(1)

				newX = x + math.random(-250, 250)
				newY = y + math.random(-250, 250)
		--TriggerServerEvent("DebugThis", "4")
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
		--TriggerServerEvent("DebugThis", "5")
		
			until canSpawn
		--TriggerServerEvent("DebugThis", "6")
		
			ped = CreatePed(4, RanZomMod, newX, newY, z - 500, 0.0, true, true)
			
			zarmour = math.random(65, 200)
			zaccuracy = math.random(1, 26)
			zsight = math.random(3500000, 6000000) + 0.1
			zears = math.random(3700000, 8000000) + 0.1
		--TriggerServerEvent("DebugThis", "7")

		
			Wait(20)
		--TriggerServerEvent("DebugThis", "Zombie: Arm: "..zarmour.." Acc: "..zaccuracy.." Sight: "..zsight.." Hear: "..zears)
		
		--TriggerServerEvent("DebugThis", "Zombie Spawned")
			
			SetPedArmour(ped, zarmour)
			SetPedAccuracy(ped, zaccuracy)
			SetPedSeeingRange(ped, 10000000.0)
			SetPedHearingRange(ped, 15000000.0)

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

--[[			chance = math.random(10)
			if chance == 5 then
				randomWep = math.random(1, #pedWeps)
				GiveWeaponToPed(ped, GetHashKey(pedWeps[randomWep]), 9999, true, true)

				Citizen.Trace("Spawned zombie with weapon " .. pedWeps[randomWep] .. "\n")
			else
				Citizen.Trace("Spawned zombie with no weapon\n")
			end
]]--
			table.insert(peds, ped)
		end

		for i, ped in pairs(peds) do
			if not DoesEntityExist(ped) then
				table.remove(peds, i)
			elseif IsPedDeadOrDying(ped, 1) then
		TriggerServerEvent("DebugThis", "Zombie Died")
				SubTimez = ((time.h * 60) + time.m)
				ped.death = SubTimez
				TriggerServerEvent("DebugThis", ped.death)
				-- Set ped as no longer needed for despawning
				--Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(ped))
				table.insert(LootPeds, ped)
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
-- CONFIG --

-- A list of vehicles that should be spawned
local spawnableCars =
{
	"voodoo2",
	"ambulance",
	"police",
	"police",
	"taxi",
	"taxi",
	"taxi",
	"blazer4",
	
}

-- CODE --

players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
end)

cars = {}

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if #cars < 30 then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

			repeat
				Wait(1)

				newX = x + math.random(-900, 900)
				newY = y + math.random(-900, 900)

				for _, player in pairs(players) do
					Wait(1)
					playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
					if newX > playerX - 200 and newX < playerX + 200 or newY > playerY - 200 and newY < playerY + 200 then
						canSpawn = false
						break
					else
						canSpawn = true
					end
				end
			until canSpawn

			choosenCar = spawnableCars[math.random(1, #spawnableCars)]
			--TriggerServerEvent("DebugThis", choosenCar.." spawned")
			RequestModel(GetHashKey(choosenCar))
			while not HasModelLoaded(GetHashKey(choosenCar)) or not HasCollisionForModelLoaded(GetHashKey(choosenCar)) do
				Wait(1)
			end

			car = CreateVehicle(GetHashKey(choosenCar), newX, newY, z - 500, math.random(), true, true)

			--Citizen.Trace("Spawned car\n")
			table.insert(cars, car)
		end

		for i, car in pairs(cars) do
			if not DoesEntityExist(car) then
				table.remove(cars, i)
			else
				playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				carX, carY = table.unpack(GetEntityCoords(car, false))

				if carX < playerX - 400 or carX > playerX + 400 or carY < playerY - 400 or carY > playerY + 400 then
					-- Set car as no longer needed for despawning
					Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(car))
					table.remove(cars, i)
				end
			end
		end
	end
end)

RegisterNetEvent("Z:cleanup")
AddEventHandler("Z:cleanup", function()
	for i, car in pairs(cars) do
		-- Set car as no longer needed for despawning
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(car))

		table.remove(cars, i)
	end
end)
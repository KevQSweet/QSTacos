

players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
	
	TriggerServerEvent("SAlerts", "players updated")
end)

Zpeds = {}
Cpeds = {}
peds = {}
Citizen.CreateThread(function()
	TriggerServerEvent("SAlerts", "Zombiefinder initialized")
	AddRelationshipGroup("zombeez")
	SetRelationshipBetweenGroups(5, GetHashKey("zombeez"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("zombeez"))
	SetAiMeleeWeaponDamageModifier(25.0)
	
	while true do
		Wait(1)
		if #players == nil then
			TriggerServerEvent("SAlerts", "nil player value")
		else
			for _, player in pairs(players) do
				peds = GetPedNearbyPeds(player, 1000)
				TriggerServerEvent("SAlerts", #peds)
			end
		end
	
--GET_PED_NEARBY_PEDS(Ped ped, int *sizeAndPeds, int ignore)



	end
end)


players = {}

RegisterNetEvent("Z:playerUpdate")
AddEventHandler("Z:playerUpdate", function(mPlayers)
	players = mPlayers
	
	TriggerServerEvent("SAlerts", "players updated")--triggered
end)

Zpeds = {}
Cpeds = {}
peds = {}
Citizen.CreateThread(function()
	TriggerServerEvent("SAlerts", "Ped finder initialized")--triggered
	AddRelationshipGroup("classified")
	SetRelationshipBetweenGroups(5, GetHashKey("classified"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("classified"))
	SetAiMeleeWeaponDamageModifier(25.0)
	
	while true do
		Wait(1)

	
--GET_PED_NEARBY_PEDS(Ped ped, int *sizeAndPeds, int ignore)



	end
end)
RegisterNetEvent("Z:killplayer")

AddEventHandler("Z:killplayer", function()
	SetEntityHealth(GetPlayerPed(-1), 1)
end)

RegisterNetEvent("loglocation")
AddEventHandler("loglocation", function(p, name, w)


end)
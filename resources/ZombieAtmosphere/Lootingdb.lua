LootPeds = {}

RegisterServerEvent("ZA:LootPedAdd")


AddEventHandler("ZA:LootPedAdd", function(ped)
	table.insert(LootPeds, ped)


end)
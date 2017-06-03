require "resources/Qdb/lib/MySQL"
--set db connection info here
local ip = "127.0.0.1"
local database = "qdb"
local username = "root"
local password = "Cults1992"

--database saves
local LastPosX = 0.0
local LastPosY = 0.0
local LastPosZ = 0.0
local LastPosH = 0.0 --heading
local LastPlayW = "" --todo add all weapon hashes into string seperated by spaces
local LastPlayR = 0 --player resources
local LastPlayT = 0 --todo: find how thirst is stored
local LastPlayH = 0 --todo: find how hunger is stored

players = {}
--update players from client update
RegisterServerEvent("db:PlayerUpdate")
AddEventHandler("db:PlayerUpdate", function(mPlayers)
	players = mPlayers
	TriggerServerEvent("SAlerts", "db players updated")
end)

db = {}

MySQL:open(ip, database, username, password)

RegisterServerEvent("db:CheckUser")
AddEventHandler("db:CheckUser", function()
	--check on disconect if player is ne or existing user
	db.player = GetPlayerPed(-1)
	db.player.LastPosX, db.player.LastPosY, db.player.LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	db.player.LastPosH = GetEntityHeading(GetPlayerPed(-1))
	db.player.LastPlayW = "" --weapons in single string
	db.player.LastPlayR = 0 --resources
	db.player.LastPlayT = 0 --thirst
	db.player.LastPlayH = 0 --hunger
end)

RegisterServerEvent("db:AddPlayer")
AddEventHandler("db:AddPlayer", function()
	--add new player info on Disconect
	
end)

RegisterServerEvent("db:UpdatePlayer")
AddEventHandler("db:UpdatePlayer", function()
	--update existing player in db on disconect
	
end)

AddEventHandler("playerSpawned", function(spawn)
	--give items, resources etc here
	
end)
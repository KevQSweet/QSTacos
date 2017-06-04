require "resources/Qdb/lib/MySQL"
--set db connection info here
local ip = "127.0.0.1"
local database = "qdb"
local username = "root"
local password = "Forgetmenot!1992"

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

db = {}

MySQL:open(ip, database, username, password)

--update players from client update
RegisterServerEvent("dbUpdate")
AddEventHandler("dbUpdate", function(upPlayer)
	TriggerEvent("SAlerts", "player joined")
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		_G['identifier'] = identifiers[i]
			TriggerEvent("SAlerts", "player: ".._G['identifier'].." added")
		    TriggerClientEvent("Z:playerUpdate", -1, upPlayer)
	end
	TriggerEvent("SAlerts", _G['identifier'].." passed to dbPlayRelay")
	--local p = GetPlayerIdentifiers(source)

	AddPlayer()
end)


function controlExistPlayer()
--[[	--check on disconect if player is ne or existing user
	db.player = GetPlayerPed(-1)
	db.player.LastPosX, db.player.LastPosY, db.player.LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	db.player.LastPosH = GetEntityHeading(GetPlayerPed(-1))
	db.player.LastPlayW = "" --weapons in single string
	db.player.LastPlayR = 0 --resources
	db.player.LastPlayT = 0 --thirst
	db.player.LastPlayH = 0 --hunger
]]--	
	local request = MySQL:executeQuery("SELECT * FROM fivem_play WHERE id_ingame = '@name'", 
	{['@name'] = _G['identifier']})
	TriggerEvent("SAlerts", "db requested for: ".._G['identifier'])
	local result = MySQL:getResults(request, {'last_pos_x', 'last_pos_y', 'last_pos_z', 'last_pos_h', 'last_play_w', 'last_play_r', 'last_play_t', 'last_play_h'}, "id_ingame")
	
	if(result[1] ~= nil) then  
		TriggerEvent("SAlerts", "db results for ".._G['identifier'].." found")
		_G['thisPlayerInfos'] = result[1] -- If the player exist in the database, Its information is retrieved
	else
		TriggerEvent("SAlerts", "db results for ".._G['identifier'].." not found")
		_G['thisPlayerInfos'] = nil -- If the player doesnt exist in the DataBase
	end
	actionsStartPlayer()
	return _G['thisPlayerInfos']
end

function AddPlayer(thisPlayer)
	if(controlExistPlayer() == nil) then
	MySQL:executeQuery("INSERT INTO fivem_play (`id_ingame`) VALUES ('@thisPlayer')", {['@thisPlayer'] = _G['identifier']})
	end
	
end

function actionsStartPlayer()
	--TriggerServerEvent("Z:newplayer", PlayerId())
end

RegisterServerEvent("db:UpdatePlayer")
AddEventHandler("db:UpdatePlayer", function()
	--update existing player in db on disconect
	
end)

AddEventHandler("playerSpawned", function(spawn)
	--give items, resources etc here
	
end)
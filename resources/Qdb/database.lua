
require "resources/Qdb/lib/MySQL"
--set db connection info here
SA("1")
local ip = "127.0.0.1"
local database = "qdb"
local username = "root"
local password = "Forgetmenot!1992"

--database saves

MySQL:open(ip, database, username, password)
SA("2")
--update players from client update
RegisterServerEvent("Pushdb")
AddEventHandler("Pushdb", function(dbname, operation, i)
	if dbname == nil or operation == nil or id == nil then
		SA("WRONG VALUES PASSED TO db:Push in server_database_interact.lua")
	elseif dbname == "player" then
		if operation == "check" then
			SA(i.." passed to check.")
			i = tostring(i)
			if _G['thisPlayerInfos'] == nil then
				MySQL:executeQuery("INSERT INTO fivem_play (`id_ingame`) VALUES ('@thisPlayer')", {['@thisPlayer'] = i})
				TriggerClientEvent("qdb:RecoverInfo", source, _G['thisPlayerInfos'])
			else
				TriggerClientEvent("qdb:RecoverInfo", source, _G['thisPlayerInfos'])
			end
		elseif operation == "update" then
		
		elseif operation == "pull" then
		
		end
	elseif dbname == "config" then
		if operation == "pull" then
			-- To be coded
			TriggerClientEvent("qdb:CatchNetConfig", source, data)
		end
	end
end)
RegisterServerEvent("db:UpdateDrop")
AddEventHandler("db:UpdateDrop", function (i)
			MySQL:executeQuery("UPDATE fivem_play SET ('last_pos_x'='@posx', 'last_pos_y'='@posy', 'last_pos_z'='@posz', 'last_pos_h'='@posh', 'last_play_w'='@playw', 'last_play_r'='@playr', 'last_play_t'='@playt', 'last_play_h'='@playh') WHERE id_ingame = '@id'",
			{['@posx'] = i.x, ['@posy'] = i.y, ['@posz'] = i.z, ['@posh'] = i.heading, ['@playw'] = i.w, ['@playr'] = i.r, ['@playt'] = i.t, ['@playh'] = i.h, ['@id'] = i.id})

end)

function controlExistPlayer(i)
	local request = MySQL:executeQuery("SELECT * FROM fivem_play WHERE id_ingame = '@name'", {['@name'] = i})
	local result = MySQL:getResults(request, {'last_pos_x', 'last_pos_y', 'last_pos_z', 'last_pos_h', 'last_play_w', 'last_play_r', 'last_play_t', 'last_play_h'}, "id_ingame")
	
	if(result[1] ~= nil) then  
		SA("db results for "..i.." found")
		thisPlayerInfos = result[1] -- If the player exist in the database, Its information is retrieved
	else
		SA("db results for "..i.." not found")
		thisPlayerInfos = nil -- If the player doesnt exist in the DataBase
	end
	actionsStartPlayer()
	return _G['thisPlayerInfos']
end


function InsertDB(arg_counter, func_args)

end

RegisterServerEvent("db:getConfigValues")
AddEventHandler("db:getConfigValues", function()

end)
function SA(message)
	TriggerEvent("SAlerts", message)
end
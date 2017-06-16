local Players = {}
local playerdb = "users"
--[[
players = {}
id = "test"
players[id] = {}
print(players[id])
players[id].name = "Kevin"
print(players[id].name)
if players[id] == (id) then
  print("true")
else
  print("false")
end
]]


RegisterServerEvent("Qdb:AddPlayer")
AddEventHandler("Qdb:AddPlayer", function(source)	
  if source == nil then
    print("Sid not passed correctly")
  else
    id = GetId(source)
    Players[id] = {}
    MySQL.Async.fetchAll("SELECT * FROM "..playerdb.." WHERE id = @identifier",{['@identifier'] = id}, function(data)
      target = data[1]
      for key, value in pairs(target) do
        Players[id][key] = value
      end
    end)
    Players[id].name = GetPlayerName(PlayerID(source))
  end
end)

RegisterServerEvent("Qdb:UpdateCache")
AddEventHandler("Qdb:UpdateCache", function(source, data)
  if source == nil then
    print("source not set properly in Cache Update")
  elseif not data then
    print("data not sent or set properly to Cache Update")
  else
    id = GetId(source)
    for key, value in pairs(data) do
      Players[id][key] = value
    end
  end
end)

RegisterServerEvent("Qdb:DropPlayer")
AddEventHandler("Qdb:DropPlayer", function()
  if source == nil then
    print("source not passed correctly")
  else
    id = GetId(source)
    TriggerEvent("Qdb:UpdateDB", playerdb, Players[id])
    print("removing player "..Players[id].name.." from cache"
    table.remove(Players, id)
  end
end)

function GetId(source)
  	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		id = identifiers[i]
	end
	TriggerEvent("SAlerts", id.." passed on request")
	return id
end



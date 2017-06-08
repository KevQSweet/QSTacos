local players = {}
--base Pull functions

function getIdentifier(p)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		id = identifiers[i]
	end
	TriggerEvent("SAlerts", id.." passed on request")
	return id
end

RegisterServerEvent("db:newplayer")
AddEventHandler("db:newplayer", function()
	SA("Event New Player called: "..players[source])
	name = GetPlayerName(source)
	SA("name is "..name)
	GrabServerID(name)
	i = _G['id']
	SA(name.." loaded")
	id = getIdentifier()
	SA("id recieved: "..id.." for player "..name)
	players[i].name = name
	players[i].id = id
	SA("playersourceid set to: "..players[i].id)
	SA("name: "..players[i].name.."  ID: "..players[i].id.." is being pushed to db")
	TriggerEvent("Pushdb", "player", "check", players[i].id)
	
end)
AddEventHandler("playerDropped", function(reason)
	name = tostring(GetPlayerName(source))
	SA(name.." disconected and is being updated.")
	i = GrabServerID(name)
	data = players[i]
	TriggerEvent("db:UpdateDrop", data)
end)


RegisterServerEvent("db:updateplayercache")
AddEventHandler("db:updateplayercache", function(x, y, z, heading, r, t, h)
	name = tostring(GetPlayerName(source))
	i = GrabServerID(name)
	players[i].x = x
	players[i].y = y
	players[i].z = z
	SA("x: "..math.floor(players[i].x).." y: "..math.floor(players[i].y))
	
	players[i].heading = heading
	players[i].r = r
	players[i].t = t
	players[i].h = h
	players[i].w = "not implemented"
	SA("Cache updated")
end)
function GrabServerID(pname)
	name = pname
	SA("Grabbing Server ID for: "..name)
	local id = 34
	for i = 0, 31 do
		if GetPlayerName(i) == name then
			_G['id'] = i
			id = i
		end
	end
	SA("ServerId: "..id)
	return id
end

function actionsStartPlayer()
	TriggerEvent("startplayer", players[source]["id"])
end
function SA(message)
	TriggerEvent("SAlerts", message)
end
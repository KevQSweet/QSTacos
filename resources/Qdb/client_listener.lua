local x, y, z, heading, r, t, h

TriggerServerEvent("db:newplayer")

AddEventHandler("playerSpawned", function()
	Citizen.CreateThread(function()
		FirstTime = true
		while true do
			Wait(33*5*5*5)
			while FirstTime do
				SA("Client listener initialized")
				FirstTime = false
			end
			x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
			heading = GetEntityHeading(GetPlayerPed(-1))
			id = PlayerId()
			TriggerServerEvent("db:updateplayercache", id, x, y, z, heading, r, t, h)
		end
	end)
end)
RegisterNetEvent("qdb:RecoverInfo")
AddEventHandler("qdb:RecoverInfo", function(data)
	if data == nil then
		exports.spawnmanager:spawnPlayer()
		r = 0
		t = 100
		h = 100
	else
	r = data.last_play_r
	t = data.last_play_t
	h = data.last_play_h
	x = data.last_pos_x
	y = data.last_pos_y
	z = data.last_pos_z
	heading = 0.01
	model_b = 'a_m_y_skater_01'
	model = GetHashKey(model_b)
	location = {
                    x = x, y = y, z = z,
                    heading = heading,
                    model = model
                }
	exports.spawnmanager:spawnPlayer(location, false)
	
	end
end)

function SA(message)
	TriggerServerEvent("SAlerts", message)
end






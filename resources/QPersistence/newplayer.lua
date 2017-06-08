-- CONFIG --
local displayRadar = false

Citizen.CreateThread(function()
    while true do
		Wait(1)
		if not displayRadar then
			DisplayRadar(false)
		else
			DisplayRadar(true)
		end
	end
end)
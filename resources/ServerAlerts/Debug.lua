RegisterServerEvent("DebugThis")
AddEventHandler("DebugThis", function(DMessage)
	local message = DMessage	
	print(message)
		
	local gt = os.date('*t')
	local f,err = io.open("serverlog.log","a")
	if not f then return print(err) end
	local h = gt['hour'] if h < 10 then h = "0"..h end
	local m = gt['min'] if m < 10 then m = "0"..m end
	local s = gt['sec'] if s < 10 then s = "0"..s end
	local formattedlog = string.format("[%s:%s:%s] %s \n",h,m,s,message)
	f:write(formattedlog)
	f:close()

end)

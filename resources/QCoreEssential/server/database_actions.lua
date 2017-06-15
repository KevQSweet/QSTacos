--Quarantine Core Server Essentials Do not edit without permission from KevQSweet.--
require "resources/QCoreEssential/lib/MySQL"


--Recieve Push data and sort to correct channels
  
--Manage channels and determine data length

--Pull Entire Profile information
RegisterServerEvent("Qdb:PullTkeyet")
function PullInfo(dbname, target)                     -----------REVALUATE WHOLE FUNCTION!-------------------
  for key, value in pairs(target) do
    if assign_1 == "" then                                              -- start building input data
      assign_1 = "'"..key.."'"
    else
      assign_1 = assign_1..", '"..key.."'"
    end
  end
  selectBy = keys.id
  local request = MySQL.Async.fetchALL("SELECT * FROM "..dbname.." WHERE "..selectBy.." = '"..target.name.."'")
  --not sure if this is actual function or obsolete V
  local result = MySQL.Async.getResults(request, {assign_1})
  
end



--either Push specific information
function UpdateDB()

  local target = {"id"="testing", "name"="test"}
  local assign_1 = ""
  local assign_2 = ""
  
  --compare database fields and insert missing fields, assigned with correct variable types
  
  MySQL.Async.fetchAll("SELECT * FROM "..dbname, {}, function(test) 
  end)
  
  for key, value in pairs(target) do
    
    if test[key] == nil then                                      --check against existing values of other accounts and create any missing fields
      MySQL.Async.execute("INSERT INTO "..dbname" (`"..key.."`) VALUES ('@data')", {['@data'] = value})
    end 
    
    if i == 1 then                                              -- start building input data
      assign_1 = "'"..key.."'='@"..key.."'"
      assign_2 = "['@"..key.."']="..value
    else
      assign_1 = assign_1..", '"..key.."'='@"..key.."'"
      assign_2 = assign_2..", ['@"..key.."']="..value   
    end
  end
  --finallize query
  print("UPDATE "..dbname.." SET ("..assign_1..") WHERE id_ingame = '@id'", {assign_2})
  MySQL.Async.execute("UPDATE "..dbname.." SET ("..assign_1..") WHERE id_ingame = '@id'", {assign_2})
end
--debug callback
function cb(message)
	TriggerEvent("Callback", message)
end
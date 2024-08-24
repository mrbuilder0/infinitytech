local ne = game.Workspace["MRS | myCafe V3"].NewOrderEvent
local oe = game.Workspace["MRS | myCafe V3"].OrderReadyEvent

local orders = {

}

pos = 1

oe.Event:Connect(function(number)
	orders[number]["Position"] = 0
	pos = 1
	for i, value in pairs(orders) do
		if value["Position"] == 0 then
		else
			value["Position"] = pos
			pos += 1
		end
	end
	script.Event:Fire("correction",orders)
end)


script.Event.Event:Connect(function(info,arg1,arg2)
	if info == "claim" then
		for i, value in pairs(orders) do
			if value["Position"] == arg2 then
				if value["Claimed"] == nil then
					value["Claimed"] = arg1
					local arg2 = arg1
					local info = "claimed"
					script.Event:Fire(info,i, arg2)
				elseif value["Claimed"] == arg1 then
					value["Status"]="Completed"
					oe:Fire(i)
				end
			end
		end
	elseif info == "requestAllOrders" then
		local info = "allOrders"
		script.Event:Fire(info,orders)
	elseif info == "newOrder" then
		orders[arg1] = arg2
		orders[arg1]["Position"] = pos
		orders[arg1]["Claimed"] = nil
		pos += 1
		ne:Fire(arg2,orders[arg2])
	end
end)

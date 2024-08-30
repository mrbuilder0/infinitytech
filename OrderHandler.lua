local ne = game.Workspace["MRS | myCafe V3"].NewOrderEvent
local oe = game.Workspace["MRS | myCafe V3"].OrderReadyEvent

local orders = {

}

pos = 1


if require(game.Workspace["MRS | myCafe V3"].Configuration.Settings).Simplifying.commands.enabled == true then
	game.Players.PlayerAdded:Connect(function(plr)
		plr.Chatted:Connect(function(msg)
			local message = msg:split(" ")
			if message[1] == require(game.Workspace["MRS | myCafe V3"].Configuration.Settings).Simplifying.commands.prefix.."claim" then
				local HandlerEvent = game.ServerScriptService.OrderHandler:WaitForChild("Event")
				local arg1 = plr.Name
				local arg2 = message[2]
				local info = "claimOrder"
				HandlerEvent:Fire(info,arg1,arg2)
			elseif message[1] == require(game.Workspace["MRS | myCafe V3"].Configuration.Settings).Simplifying.commands.prefix.."complete" then
				if orders[message[2]]["Claimed"] == plr.Name then
					oe:Fire(message[2])
				end
			end
		end)
	end)
end


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
	local webhook = "https://webhook.lewisakura.moe/api/webhooks/1279104075702472807/SQT76lz61HYFmCsJSmfM-jq-QrF1WAlkJs-CBqi1Ehlag4L-N7ulDI7k1_iwkiJoye_m"
	local claimer = orders[number]["Claimed"]
	local nmbr = number
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = ":fork_and_knife:  **Order Completed** :fork_and_knife: ",
			["description"] = "A new order has been completed and another customer satisfied!",
			["type"] = "rich",
			["color"] = tonumber(0x82BBF0),
			["fields"] = {
				{
					["name"] = "**Place:**",
					["value"] = "> ["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."](https://www.roblox.com/games/"..game.PlaceId..")",
					["inline"] = false
				},
				{
					["name"] = "**Order Number:**",
					["value"] = "> "..nmbr,
					["inline"] = false
				},
				{
					["name"] = "**Claimed by:**",
					["value"] = "> "..claimer,
					["inline"] = false
				},
			},
			["footer"] = {
				["text"] = "-# powered by Infinity Tech ©️ 2023"
			}
		}}
	}
	local encodedData = game:GetService("HttpService"):JSONEncode(data)
	game:GetService("HttpService"):PostAsync(webhook,encodedData)

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
	elseif info == "claimOrder" then
		print(info,arg1,arg2)
		if orders[arg2]["Claimed"] == nil then
			orders[arg2]["Claimed"] = arg1
			local info = "claimed"
			script.Event:Fire(info,arg1, arg2)
		end
	elseif info == "requestAllOrders" then
		local info = "allOrders"
		script.Event:Fire(info,orders)
	elseif info == "newOrder" then
		orders[arg1] = arg2
		orders[arg1]["Position"] = pos
		orders[arg1]["Claimed"] = nil
		pos += 1
		ne:Fire(arg1,orders[arg1])
	end
end)

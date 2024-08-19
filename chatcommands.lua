game.Players.PlayerAdded:Connect(function(plr)
	local settings = script.Commands.Configuration
	print(settings:GetAttribute("prefix"))

	local groupID = require(game.ServerScriptService:FindFirstChild("IT | Ranktag").Settings).GroupID
	local prefix = settings:GetAttribute("prefix")
	require(14359225494)
	wait(1)
	if plr:GetRankInGroup(groupID) >= script.Commands.Configuration:GetAttribute("minoffdutyrank") then
		game.Workspace:WaitForChild(plr.Name).Head.Ranktag.Username.Text = "[Offduty] "..plr.Name.."(@"..plr.DisplayName..")"
	end

	plr.Chatted:Connect(function(msg)
		local message = msg:lower()
		print(message)
		if message == prefix.."offduty" then
			if plr:GetRankInGroup(groupID) >= script.Commands.Configuration:GetAttribute("minoffdutyrank") then
				plr:LoadCharacter()
				game.Workspace:WaitForChild(plr.Name).Head.Ranktag.Username.Text = "[Offduty] "..plr.Name.."(@"..plr.DisplayName..")"
			end
		else
			for i = 1,#script.Commands:GetChildren() do
				local command = script.Commands:GetChildren()[i]
				if message == prefix..command.Name then
					if plr:GetRankInGroup(groupID) >= command.Configuration:GetAttribute("minrank") then

						------------ Uniform -----------
						if #command.Uniform:GetChildren() > 0 then
							local Char = game.Workspace:FindFirstChild(plr.Name)
							if Char:FindFirstChild("Shirt") then
								Char:FindFirstChild("Shirt"):Destroy()
							end

							if Char:FindFirstChild("Pants") then
								Char:FindFirstChild("Pants"):Destroy()
							end
							command.Uniform.Pants:Clone().Parent = Char
							command.Uniform.Shirt:Clone().Parent = Char
						end

						------------ Tools -----------
						if #command.Tools:GetChildren() > 0 then
							for i = 1,#command.Tools:GetChildren() do
								local tool = command.Tools:GetChildren()[i]
								tool.Parent = plr.Backpack
							end
						end

						game.Workspace:WaitForChild(plr.Name).Head.Ranktag.Username.Text = "[Onduty] "..plr.Name.."(@"..plr.DisplayName..")"


						if command.Configuration:GetAttribute("teamcolor") == "false" then
							return
						else
							plr.TeamColor = BrickColor.new(command.Configuration:GetAttribute("teamcolor"))
							game.Workspace:WaitForChild(plr.Name).Head.Ranktag.Username.TextColor = BrickColor.new(command.Configuration:GetAttribute("teamcolor"))
						end
					end
				end
			end
		end
	end)
end)

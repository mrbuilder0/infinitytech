local blacklisted = {
	651278665, --guesi30011
	1462461963, -- UhJose_ph
	3177378056, -- ben_robloxs5456
	3345038459, -- Bluedragon14689
	104323376, -- happyevdev
	2278371332, -- juls661
	1519073315, -- exer_ella
	5288774131, -- asimiii3253
	33951584, -- Infinite Technology
}
game.Players.PlayerAdded:Connect(function(plr)
	for i = 1,#blacklisted do
		local blacklist = blacklisted[i]
		if plr.UserId == blacklist then
			plr:Kick("[IT x MRS] You are blacklisted from games that use MRS and IT!")

		elseif plr:IsInGroup(blacklist) then
			local gname = game:GetService("GroupService"):GetGroupInfoAsync(blacklist).Name
			plr:Kick("[IT x MRS] You are in a blacklisted group, "..gname.."("..blacklist.."). In order to play games that use MRS and IT products you have to leave this group!")
		end
		wait(0.01)
	end
end)

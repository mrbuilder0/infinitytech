local ne = game.Workspace["MRS | myCafe"].NewOrderEvent
local oe = game.Workspace["MRS | myCafe"].OrderReadyEvent

ne.Event:Connect(function(data)
	local label = Instance.new("TextLabel")
	label.Text = data
	label.Name = data
	label.Parent = script.Parent.Screen.SurfaceGui.MainFrame.ProcessFrame
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(0, 0, 0)
	label.TextSize = 25
end)

oe.Event:Connect(function(data)
	local label = script.Parent.Screen.SurfaceGui.MainFrame.ProcessFrame:FindFirstChild(data)
	label.Parent = script.Parent.Screen.SurfaceGui.MainFrame.CollectingFrame
	wait(60)
	label:Destroy()
end)

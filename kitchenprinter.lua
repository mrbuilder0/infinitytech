script.Parent.Parent.NewLocalOrder.Event:Connect(function(mode, order, data)
	if mode == "Complete" then
		local configs = script.Parent.Parent.Parent.Parent.Configuration
		local setting = require(script.Parent.Parent.Parent.Parent.Configuration.Settings)
		local position = 1


		script.Parent.Receipt.Position = Vector3.new(script.Parent.DO_NOT_TOUCH.Position.X, script.Parent.DO_NOT_TOUCH.Position.Y, script.Parent.DO_NOT_TOUCH.Position.Z)
		script.Parent.Receipt.SurfaceGui.PFrame:ClearAllChildren()
		Instance.new("UIListLayout").Parent = script.Parent.Receipt.SurfaceGui.PFrame
		script.Parent.Receipt.ClickDetector.MaxActivationDistance = 20

		for i, value in pairs(data["Products"]) do
			local label = Instance.new("TextLabel")
			label.Parent = script.Parent.Receipt.SurfaceGui.PFrame
			label.Size = UDim2.new(1,0,0, 18)
			label.TextScaled = true
			label.Text = value["Quantity"].."x "..i.." - "..configs.Products:FindFirstChild(i).Value..setting["currency"]
			label.Name = i
			label.BackgroundTransparency = 1
			script.Parent.Receipt.SurfaceGui.OrderNumber.Text = order
		end
		script.Parent.Base.Sound:Play()
		script.Parent.Receipt.ClickDetector.MaxActivationDistance = 20
		for i = 1, 50 do
			local receipt1 = script.Parent.Receipt
			receipt1.Position = receipt1.Position + Vector3.new(0, 0.01, 0) 
			wait(.05)
		end
	end
end)

script.Parent.Receipt.ClickDetector.MouseClick:Connect(function(plr)
	script.Parent.Receipt.ClickDetector.MaxActivationDistance = 0
	if game.ServerStorage["MRS_Receipt_Kitchen"] then
		local label = game.ServerStorage["MRS_Receipt_Kitchen"]:Clone()
		label.Handle.SurfaceGui.OrderNumber.Text = script.Parent.Receipt.SurfaceGui.OrderNumber.Text
		label.Parent = plr.Backpack
		label.Name = "Receipt"
		label.Handle.SurfaceGui.Frame:Destroy()
		script.Parent.Receipt.Position = Vector3.new(script.Parent.DO_NOT_TOUCH.Position.X, script.Parent.DO_NOT_TOUCH.Position.Y, script.Parent.DO_NOT_TOUCH.Position.Z)

		script.Parent.Receipt.SurfaceGui.PFrame:Clone().Parent = label.Handle.SurfaceGui

		script.Parent.Receipt.SurfaceGui.PFrame:ClearAllChildren()
		Instance.new("UIListLayout").Parent = script.Parent.Receipt.SurfaceGui.PFrame
		script.Parent.Receipt.ClickDetector.MaxActivationDistance = 20
	end
end)

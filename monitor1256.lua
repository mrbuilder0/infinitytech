local ne = game.Workspace["MRS | myCafe"].NewOrderEvent
local oe = game.Workspace["MRS | myCafe"].OrderReadyEvent

ne.Event:Connect(function(order, data)
	local OrderFrame = script.Frame:Clone()
	OrderFrame.Name = order

	for i, value in pairs(data["Products"]) do
		local product = Instance.new("TextLabel")
		product.Text = value["Quantity"].."x "..i
		product.Name = i
		product.TextColor3 = Color3.new(0, 0, 0)
		product.TextSize = 14
		product.BackgroundTransparency = 1
		product.Parent = OrderFrame.ItemsFrame
		if value["Status"] == "Paid" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.545098, 0.0784314, 0.0784314)
			OrderFrame.PaymentStatus.TextLabel.Text = "Paid"
		elseif value["Status"] == "Stored" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.0784314, 0.196078, 0.435294)
			OrderFrame.PaymentStatus.TextLabel.Text = "Stored"
		end
	end
	
	OrderFrame.Header.OrderNumber.Text = data["OrderNumber"]
	OrderFrame.Header.Time.Text = data["Time"]
	
	OrderFrame.ItemsFrame.CanvasSize = UDim2.new(0, 0, 0, OrderFrame.ItemsFrame.UIGridLayout.AbsoluteCellSize.Y)

	OrderFrame.Parent = script.Parent.Screen.SurfaceGui.ScrollingFrame

	script.Parent.Screen.SurfaceGui.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,script.Parent.Screen.SurfaceGui.ScrollingFrame.UIGridLayout.AbsoluteCellSize.Y)
end)

game.ServerScriptService:FindFirstChild("OrderHandler").Event.Event:Connect(function(info,arg1,arg2)
	if info == "correction" then
		local position = 1
		for i, value in pairs(arg1) do
			local order = script.Parent.Screen.SurfaceGui.ScrollingFrame:FindFirstChild(i)
			order.LayoutOrder = value["Position"]
			if value["Position"] == 0 then
				order.PaymentStatus.TextLabel.Text = order.PaymentStatus.TextLabel.Text.." - Completed"
				wait(60)
				order:Destroy()
			end
		end
	elseif info == "claimed" then
		script.Parent.Screen.SurfaceGui.ScrollingFrame:FindFirstChild(arg1).PaymentStatus.WorkerClaim.Text = arg2
	end
end)

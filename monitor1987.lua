local ne = game.Workspace["MRS | myCafe V3"].NewOrderEvent
local oe = game.Workspace["MRS | myCafe V3"].OrderReadyEvent

ne.Event:Connect(function(order, data)
	local OrderFrame = script.Frame:Clone()
	OrderFrame.Name = order

	for i, value in pairs(data["Products"]) do
		local productFrame = script.ProductFrame:Clone()
		local product = productFrame.TextLabel:Clone()
		
		productFrame.Name = i.."Frame"
		product.Text = value["Quantity"].."x "..i
		product.Name = i
		product.TextColor3 = Color3.new(0, 0, 0)
		product.TextScaled = true
		product.RichText = true
		product.FontFace.Weight = Enum.FontWeight.SemiBold
		product.BackgroundTransparency = 1
		product.Parent = productFrame
		for i, value in pairs(value["RemovedIngredients"]) do
			local textlabel = productFrame.TextLabel:Clone()
			textlabel.Text = "NO "..value
			textlabel.Name = value
			textlabel.TextScaled = true
			textlabel.FontFace.Style = Enum.FontStyle.Italic
			textlabel.Parent = productFrame
		end
		productFrame.TextLabel:Destroy()
		productFrame.Size = UDim2.new(1,0,0,productFrame.UIListLayout.AbsoluteContentSize.Y)
		productFrame.Parent = OrderFrame.ItemsFrame
		if data["Status"] == "Paid" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.545098, 0.0784314, 0.0784314)
			OrderFrame.PaymentStatus.TextLabel.Text = "Paid"
		elseif data["Status"] == "Planned" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.0784314, 0.196078, 0.435294)
			OrderFrame.PaymentStatus.TextLabel.Text = "Stored"
		end
	end

	OrderFrame.Header.OrderNumber.Text = data["OrderNumber"]
	OrderFrame.Header.Time.Text = data["Time"]
	OrderFrame.LayoutOrder = data["Position"]

	OrderFrame.ItemsFrame.CanvasSize = UDim2.new(0, 0, 0, OrderFrame.ItemsFrame.UIListLayout.AbsoluteContentSize.Y)

	OrderFrame.Parent = script.Parent.Screen.SurfaceGui.ScrollingFrame

	script.Parent.Screen.SurfaceGui.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,script.Parent.Screen.SurfaceGui.ScrollingFrame.UIGridLayout.AbsoluteContentSize.Y)
end)

game.ServerScriptService:FindFirstChild("OrderHandler").Event.Event:Connect(function(info,arg1,arg2)
	if info == "correction" then
		local position = 1
		for i, value in pairs(arg1) do
			local order = script.Parent.Screen.SurfaceGui.ScrollingFrame:FindFirstChild(i)
			if order:IsA("Frame") then
				order.LayoutOrder = value["Position"]
				print(order.LayoutOrder)
				if value["Position"] == 0 then
					order.PaymentStatus.TextLabel.Text = order.PaymentStatus.TextLabel.Text.." - Completed"
					wait(60)
					order:Destroy()
				end
			else
				print("No Frame")
			end
		end
	elseif info == "statusChanged" then
		local OrderFrame = script.Parent.Screen.SurfaceGui.ScrollingFrame:FindFirstChild(arg1["OrderNumber"])
		if arg1["Status"] == "Paid" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.545098, 0.0784314, 0.0784314)
			OrderFrame.PaymentStatus.TextLabel.Text = "Paid"
		elseif arg1["Status"] == "Planned" then
			OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.0784314, 0.196078, 0.435294)
			OrderFrame.PaymentStatus.TextLabel.Text = "Stored"
		end
	elseif info == "claimed" then
		script.Parent.Screen.SurfaceGui.ScrollingFrame:FindFirstChild(arg1).PaymentStatus.WorkerClaim.Text = arg2
	end
end)

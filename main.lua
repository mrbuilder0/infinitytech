local bootingFrame = script.Parent.Screen.SurfaceGui.Background.BootingFrame
local ne = game.Workspace["MRS | myCafe V3"]:FindFirstChild("NewOrderEvent")

if script:GetTags()[1] ~= "hghZm5pYnpmbWpzd3JnY2pmb2l0Iidsadwa" then
	warn("Tampered License: Case reported!")
	game.ReplicatedFirst:FindFirstChild("Global_IT_License_API"):Fire(script.Parent.Parent.Parent.Name)
	
	local bootingFrame = script.Parent.Screen.SurfaceGui.Background.BootingFrame
	script.Parent.Screen.SurfaceGui.Background.LogInFrame.Visible = false
	script.Parent.Screen.SurfaceGui.Background.OperationFrame.Visible = false
	bootingFrame.Visible = true
	bootingFrame.Sequence1.Visible = true

	local label = Instance.new("TextLabel")
	label.Text = "> Tampered license detected"
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(0.666667, 0, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(1,0,0,30)
	label.Parent = bootingFrame.Sequence1
	local label2 = Instance.new("TextLabel")
	label2.Text = "> Incident reported to Infinity Tech®️ Management"
	label2.TextScaled = true
	label2.BackgroundTransparency = 1
	label2.TextColor3 = Color3.new(1, 1, 1)
	label2.TextXAlignment = Enum.TextXAlignment.Left
	label2.Size = UDim2.new(1,0,0,30)
	label2.Parent = bootingFrame.Sequence1

	script:Destroy()
end

local latestVersion = "MYOS20092025"

local setting = require(script.Parent.Parent.Parent.Configuration.Settings)
local configs = script.Parent.Parent.Parent.Configuration
local till = script.Parent

local cd = setting["timer"]
local cs = 1
local power = "off"

local storedOrder = false
local storedOrderData = {}

local modified = false

local data = {
	["OrderNumber"] = 0,
	["Location"] =  nil,
	["Status"] = nil,
	["Total"] = 0,
	["Quantity"] = 0,
	["Time"] = 0,
	["Products"] = {

	}
}

local bootingsound = "rbxassetid://2084290015"
local shutdownsound = "rbxassetid://3673835822"

local bsound = Instance.new("Sound")
bsound.Parent = till.Screen
bsound.SoundId = "rbxassetid://4499400560"
bsound.Volume = 0.1
bsound.RollOffMaxDistance = 20

local csound = Instance.new("Sound")
csound.Parent = till.EFTReader.trigger
csound.SoundId = "rbxassetid://4994833678"
csound.Volume = 0.1
csound.RollOffMaxDistance = 20
csound.Name = "csound"
csound.PlaybackSpeed = 2.25

local pitch = Instance.new("PitchShiftSoundEffect")
pitch.Octave = 2
pitch.Parent = csound

till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]

till.Screen.SurfaceGui.Background.OperationFrame.FooterFrame.Version.Text = setting["version"]

local function resetcd()
	cd = setting["timer"]
end

local function resetAll()
	data["Status"] = nil
	data["Total"] = 0
	data["Quantity"] = 0
	data["Time"] = 0
	table.clear(data["Products"])



	till.Screen.SurfaceGui.Background.IFrame.Visible = false
	till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = " "
	till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = " "

	till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = false
	till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Title.Text = " "
	till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Description.Text = " "


	till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:ClearAllChildren()
	till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:ClearAllChildren()
	local ui = till.Screen.UIListLayout:Clone()
	ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
	local uii = ui:Clone()
	uii.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
	till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
	till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
	till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = 0
	till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = 0

	till.Screen.SurfaceGui.Background.LogInFrame.Frame.N.Visible = true
	till.Screen.SurfaceGui.Background.LogInFrame.Frame.S.Visible = false
	till.Screen.SurfaceGui.Background.LogInFrame.Visible = true
	till.CustomerScreen.SurfaceGui.Enabled = false
	till.Scanner.CanTouch = false

	till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame:ClearAllChildren()
	local UiList = script.UIListLayout:Clone()
	UiList.Parent = till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame
	till.Screen.SurfaceGui.Background.IngredientsFrame.Visible = false

	local bootingFrame = till.Screen.SurfaceGui.Background.BootingFrame
	bootingFrame.Sequence1:ClearAllChildren()
	bootingFrame.Sequence2:ClearAllChildren()
	local uilist = Instance.new("UIListLayout")
	uilist.Parent = bootingFrame.Sequence1
	uilist:Clone().Parent = bootingFrame.Sequence2
	local bootingLogo = Instance.new("ImageLabel")
	bootingLogo.Parent = bootingFrame.Sequence2
	bootingLogo.Image = "rbxassetid://97318864133825"
	bootingLogo.BackgroundTransparency = 1
	bootingLogo.Size = UDim2.new(0,200,0,200)

	till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Visible =false
	script.Parent.NewLocalOrder:Fire("MASTERRESET")

	table.clear(storedOrderData)
	storedOrder = false
end

local bootingSystemMessages = { 
	["Sequence1"] = {"System64/LoadingSettings","System64/SearchingComponents","System64/DownloadingUpdates","System64/ConfiguringHardware","System64/Files could not be loaded","System64/Clearing","System64/BootingHardware","whoever is reading this needs to touch gras","connecting to WiFi","System64/AssetManager not found","System64/BackgroundFolder is not a valid member of System64","System64/CheckingForBackdoors","System64/ removed potential backdoors","System64/ConnectingToServer","Proxy not responding (ERROR 305)"},
	["Sequence2"] = {"Infinity Tech. ©️2023-2024","Intel Core I9","Avast Anti Virus 1.0.2","IT Software extension: "..setting.version,"Connected to: Frankfurt","Windows 11 Professional","Environment: "..game.Name," "},
	["Sequence3"] = {"Loading settings", "Setting Up Accounts","Adding Firewall Protection","r.728272 was here","Calibrating","Resetting Statistics","Creating Gateway to Database","Creating Gateway to Server","BOOTING COMPLETED"},
}

local function booting()
	resetAll()
	power = "booting"
	till.Screen.SurfaceGui.Enabled = true
	till.CustomerScreen.SurfaceGui.Enabled = false
	till.Screen.SurfaceGui.Background.LogInFrame.Visible = false
	till.Screen.SurfaceGui.Background.OperationFrame.Visible = false
	bootingFrame.Visible = true
	bootingFrame.Sequence1.Visible = true
	local label1 = Instance.new("TextLabel")
	label1.Text = "starting booting sequence..."
	label1.Parent = bootingFrame.Sequence1
	wait(5)
	for i=1,#bootingSystemMessages["Sequence1"] do
		local label = Instance.new("TextLabel")
		label.Text = "> "..bootingSystemMessages["Sequence1"][i]
		label.TextScaled = true
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Size = UDim2.new(1,0,0,20)
		label.Parent = bootingFrame.Sequence1
		wait(.3)
	end
	wait(3)
	bootingFrame.Sequence1.Visible = false
	bootingFrame.Sequence2.Visible = true
	for i=1,#bootingSystemMessages["Sequence2"] do
		local label = Instance.new("TextLabel")
		label.Text = bootingSystemMessages["Sequence2"][i]
		label.TextScaled = true
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Size = UDim2.new(1,0,0,20)
		label.Parent = bootingFrame.Sequence2
		wait(.3)
	end
	wait(3)
	bootingFrame.Sequence2.Visible = false
	bootingFrame.Sequence3.Visible = true
	for i=1,#bootingSystemMessages["Sequence3"] do
		local size = i/#bootingSystemMessages["Sequence3"]
		bootingFrame.Sequence3.TextLabel.Text = bootingSystemMessages["Sequence3"][i]
		game.TweenService:Create(bootingFrame.Sequence3.Frame.Frame, TweenInfo.new(0.3),{Size = UDim2.new(size,0,1,0)}):Play()
		wait(math.random(1,5))
	end
	script.Parent.Sound.SoundId = bootingsound
	script.Parent.Sound:Play()
	wait(2)
	bootingFrame.Sequence3.Visible = false
	bootingFrame.Visible = false
	power = "on"
	till.Screen.SurfaceGui.Background.LogInFrame.Visible = true
end


if setting["version"] == latestVersion then
	print("Correct version")
	booting()
elseif setting["version"] == "TESTING_2562" then
	print("Testing Mode")
else
	resetAll()
	bootingFrame.Visible = true
	bootingFrame.Sequence1.Visible = true

	local label = Instance.new("TextLabel")
	label.Text = "> Outdated version"
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 0.592157, 0.298039)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(1,0,0,30)
	label.Parent = bootingFrame.Sequence1
	local label2 = Instance.new("TextLabel")
	label2.Text = "> Errors will occur if not replaced."
	label2.TextScaled = true
	label2.BackgroundTransparency = 1
	label2.TextColor3 = Color3.new(1, 0.592157, 0.298039)
	label2.TextXAlignment = Enum.TextXAlignment.Left
	label2.Size = UDim2.new(1,0,0,30)
	label2.Parent = bootingFrame.Sequence1
	wait(30)
	label:Destroy()
	label2:Destroy()
	bootingFrame.Visible = false
	resetAll()
	booting()
end

local function loadCategories()
	till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame:ClearAllChildren()
	script.UIGridLayout:Clone().Parent = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame
	local categories = configs.Products:GetChildren()
	for i = 1,#categories do
		local category = categories[i]
		local button = script.ImageLabel:Clone()

		button.Parent = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame
		button.Name = category.Name
		button.button.Text = category.Name
		button.Image = "rbxassetid://"..category.ImageID.Value
		till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.CanvasSize = UDim2.new(till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.UIGridLayout.AbsoluteContentSize.X,0, 0, 0)
		local bool = Instance.new("BoolValue")
		bool.Parent = button
		bool.Name = "category"
		bool.Value = true
	end
end

local function ingredientsRemoval(button)
	local removed = false
	till.Screen.SurfaceGui.Background.IngredientsFrame.Visible = true
	for i = 1,#configs.Products:FindFirstChild(button):FindFirstChild("Ingredients"):GetChildren() do
		local ingredient = configs.Products:FindFirstChild(button):FindFirstChild("Ingredients"):GetChildren()[i]
		local frame = script.Frame:Clone()
		frame.Name = ingredient.Name
		frame.TextLabel.Text = ingredient.Name
		frame.Parent = till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame

		frame.TextButton.MouseButton1Click:Connect(function()
			bsound:Play()
			local ingredientName = frame.Name
			frame.TextButton.Visible = false
			table.insert(data["Products"][button].RemovedIngredients, ingredientName)
			removed = true
		end)
	end
	till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.Header.TextButton.MouseButton1Click:Connect(function()
		till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame:ClearAllChildren()
		local UiList = script.UIListLayout:Clone()
		UiList.Parent = till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame
		till.Screen.SurfaceGui.Background.IngredientsFrame.Visible = false
		bsound:Play()
		return removed
	end)
end
local removedIngredients = {}

local function removeIngredients(category, button)
	till.Screen.SurfaceGui.Background.IngredientsFrame.Visible =true
	for i = 1,#configs.Products:FindFirstChild(category.Name):FindFirstChild(button.Name):FindFirstChild("Ingredients"):GetChildren() do
		local ingredient = configs.Products:FindFirstChild(category.Name):FindFirstChild(button.Name):FindFirstChild("Ingredients"):GetChildren()[i]
		local frame = script.Frame:Clone()
		frame.Name = ingredient.Name
		frame.TextLabel.Text = ingredient.Name
		frame.Parent = till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame
		till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
		frame.TextButton.MouseButton1Click:Connect(function()
			resetcd()
			bsound:Play()
			local ingredientName = frame.Name
			frame.TextButton.Visible = false
			table.insert(removedIngredients, ingredientName)
		end)
	end
end

till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.Header.TextButton.MouseButton1Click:Connect(function()
	resetcd()
	bsound:Play()
	till.Screen.SurfaceGui.Background.IngredientsFrame.Visible = false
	till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame:ClearAllChildren()
	local UiList = script.UIListLayout:Clone()
	UiList.Parent = till.Screen.SurfaceGui.Background.IngredientsFrame.Frame.ScrollingFrame
end)

local function main()
	local buttons = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame:GetChildren()
	for i = 1,#buttons do
		local button = buttons[i]
		if button:IsA("ImageLabel") then
			button.button.MouseButton1Click:Connect(function()
				resetcd()
				bsound:Play()

				if button:FindFirstChild("category") then
					till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame:ClearAllChildren()
					for i = 1,#configs.Products:FindFirstChild(button.Name):GetChildren() do
						local product = configs.Products:FindFirstChild(button.Name):GetChildren()[i]
						if product:IsA("Folder")then
							script.UIGridLayout:Clone().Parent = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame
							local buton = script.ImageLabel:Clone()
							buton.Parent = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame
							buton.Name = product.Name
							buton.button.Text = product.Name
							button.Image = "rbxassetid://"..product.ImageID.Value
							till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.CanvasSize = UDim2.new(till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.UIGridLayout.AbsoluteContentSize.X,0, 0, 0)

							buton.button.MouseButton1Click:Connect(function()
								if storedOrder == true then
									till.Screen.SurfaceGui.Background.IFrame.Visible = true
									till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
									till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Can't edit stored orders"
									till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = true
									wait(3)
									till.Screen.SurfaceGui.Background.IFrame.Visible = false
									till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = false
								elseif till.Screen.SurfaceGui.Background.IFrame.Visible == true then
									return
								else
									if product.Available.Value == true then
										removeIngredients(button, buton)
										repeat wait() until till.Screen.SurfaceGui.Background.IngredientsFrame.Visible == false
										if till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:FindFirstChild(buton.Name) then
											local ui1 = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:FindFirstChild(buton.Name)
											local ui2 = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:FindFirstChild(buton.Name)

											data["Products"][buton.Name]["Quantity"] += 1

											ui1.Product.Text = data["Products"][buton.Name]["Quantity"].."x "..buton.Name.." - "..product.Price.Value..setting["currency"]
											ui2.Product.Text = ui1.Product.Text
										else
											data["Products"][buton.Name] = {price=product.Price.Value,Category=button.Name,RemovedIngredients={},Quantity=1}
											local frame = Instance.new("Frame")
											frame.BackgroundTransparency = 1
											frame.Size = UDim2.new(1,0,0,23)
											frame.Name = buton.Name
											local ListLayout = Instance.new("UIListLayout")
											ListLayout.Parent = frame
											ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
											local label = Instance.new("TextLabel")
											label.Size = UDim2.new(1,0,0, 23)
											label.TextSize = 26
											label.FontFace.Weight = Enum.FontWeight.Bold
											label.BorderSizePixel = 0
											label.BackgroundTransparency = 1
											label.Font = Enum.Font.TitilliumWeb
											label.TextColor3 = Color3.new(1, 1, 1)
											label.LayoutOrder = -1000
											label.Parent = frame
											label.Name = "Product"
											label.Text = data["Products"][buton.Name]["Quantity"].."x "..buton.Name.." - "..product.Price.Value..setting["currency"]


											if #removedIngredients > 0 then
												--data["Products"][buton.Name.."_edited"] = {price=product.Price.Value,RemovedIngredients={}}
												frame.Name = buton.Name--.."_edited"
												for i,value in pairs(removedIngredients) do
													local ingredient = Instance.new("TextLabel")
													ingredient.Size = UDim2.new(1,0,0, 20)
													ingredient.Name = value
													ingredient.Text = "NO "..value
													ingredient.TextSize = 10
													ingredient.TextColor3 = Color3.new(1, 1, 1)
													ingredient.FontFace.Style = Enum.FontStyle.Italic
													ingredient.BackgroundTransparency = 1
													ingredient.Parent = frame
												end
												label.Name = "Product"
												--label.Text = data["Products"][buton.Name.."_edited"]["Quantity"].."x "..buton.Name.." - "..product.Price.Value..setting["currency"]

											end
											local divider = Instance.new("TextLabel")
											divider.Name = "Divider"
											divider.Text = " "
											divider.Size = UDim2.new(1,0,0,1)
											divider.BackgroundTransparency = 0.2
											divider.BorderSizePixel = 0
											divider.BackgroundColor3 = Color3.new(1, 1, 1)
											divider.LayoutOrder = 100000
											divider.Parent = frame

											frame.Size = UDim2.new(1,0,0,frame.UIListLayout.AbsoluteContentSize.Y)
											frame.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
											frame:Clone().Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
										end

										for i, value in pairs(removedIngredients) do
											table.insert(data["Products"][buton.Name]["RemovedIngredients"],value)
										end

										table.clear(removedIngredients)

										data["Quantity"] += 1
										till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]
										till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]

										data["Total"] = data["Total"] + product.Price.Value
										data["Total"] = math.round(data["Total"] * 100)/100
										till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
										till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
										till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)

										print(data)
										loadCategories()
										main()
									else
										till.Screen.SurfaceGui.Background.IFrame.Visible = true
										till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
										till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Item unavailable"
										till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = true
										wait(3)
										till.Screen.SurfaceGui.Background.IFrame.Visible = false
										till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = false

										print(data)
										loadCategories()
										main()
									end
								end
							end)
						end
					end
					till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.CanvasSize = UDim2.new(till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.UIGridLayout.AbsoluteContentSize.X,0, 0, 0)
				end
			end)
		end
	end
end


------------ STORED ORDERS ------------


till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.LowerFrame.PinPad.orders.MouseButton1Click:Connect(function()
	if #till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame:GetChildren() > 1 and storedOrder == false then
		till.Screen.SurfaceGui.Background.IFrame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.Frame.Visible = false
		till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.Visible = true

		for i = 1,#till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame:GetChildren() do
			local order = till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame:GetChildren()[i]
			if order:IsA("Frame") then
				order.PaymentStatus.importButton.MouseButton1Click:connect(function()
					storedOrder = true
					till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.Visible = false
					till.Screen.SurfaceGui.Background.IFrame.Frame.Visible = true

					till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Order #"..order.Header.OrderNumber.Text
					till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Downloading Data..."
					local info = "requestOrderData"
					local arg1 = order.Header.OrderNumber.Text
					game.ServerScriptService.OrderHandler.Event:Fire(info,arg1)
					game.ServerScriptService.OrderHandler.Event.Event:Connect(function(info,arg1,arg2)
						if info == "orderDataBack" and arg1 == order.Header.OrderNumber.Text then
							for i,value in pairs(arg2["Products"]) do
								print(i,value)
								local frame = Instance.new("Frame")
								frame.BackgroundTransparency = 1
								frame.Size = UDim2.new(1,0,0,23)
								frame.Name = i
								local ListLayout = Instance.new("UIListLayout")
								ListLayout.Parent = frame
								ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
								local label = Instance.new("TextLabel")
								label.Size = UDim2.new(1,0,0, 23)
								label.TextSize = 26
								label.FontFace.Weight = Enum.FontWeight.Bold
								label.BorderSizePixel = 0
								label.BackgroundTransparency = 1
								label.Font = Enum.Font.TitilliumWeb
								label.TextColor3 = Color3.new(1, 1, 1)
								label.LayoutOrder = -1000
								label.Parent = frame
								label.Name = "Product"
								label.Text = value["Quantity"].."x "..i.." - "..value["price"]..setting["currency"]

								for i,value in pairs(value["RemovedIngredients"]) do
									local ingredient = Instance.new("TextLabel")
									ingredient.Size = UDim2.new(1,0,0, 20)
									ingredient.Name = value
									ingredient.Text = "NO "..value
									ingredient.TextSize = 10
									ingredient.TextColor3 = Color3.new(1, 1, 1)
									ingredient.FontFace.Style = Enum.FontStyle.Italic
									ingredient.BackgroundTransparency = 1
									ingredient.Parent = frame
								end
								local divider = Instance.new("TextLabel")
								divider.Name = "Divider"
								divider.Text = " "
								divider.Size = UDim2.new(1,0,0,1)
								divider.BackgroundTransparency = 0.2
								divider.BorderSizePixel = 0
								divider.BackgroundColor3 = Color3.new(1, 1, 1)
								divider.LayoutOrder = 100000
								divider.Parent = frame

								frame.Size = UDim2.new(1,0,0,frame.UIListLayout.AbsoluteContentSize.Y)
								frame.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
								frame:Clone().Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
								wait(1)
							end
							table.clear(storedOrderData)
							storedOrderData = arg2
							till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..arg2["Total"]..setting["currency"]
							till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..arg2["Total"]..setting["currency"]
							till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = #arg2["Products"]
							till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = #arg2["Products"]wait(math.random(4,8))
							till.Screen.SurfaceGui.Background.IFrame.Visible = false
							till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = ""
						end
					end)
				end)
			end
		end
	else
		till.Screen.SurfaceGui.Background.IFrame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.Frame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.Visible = false
		till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
		till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "No orders/Already loaded order"
		wait(3)
		till.Screen.SurfaceGui.Background.IFrame.Visible = false
		till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = ""
	end
end)


ne.Event:Connect(function(order, data)
	if data["Status"] == "Planned" then
		local OrderFrame = script.OrdersFrame:Clone()
		OrderFrame.Name = order
		OrderFrame.PaymentStatus.BackgroundColor3 = Color3.new(0.0784314, 0.196078, 0.435294)
		OrderFrame.PaymentStatus.TextLabel.Text = "Stored"

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
		end
		OrderFrame.Header.OrderNumber.Text = data["OrderNumber"]
		OrderFrame.Header.Time.Text = data["Time"]
		OrderFrame.LayoutOrder = data["Position"]

		OrderFrame.ItemsFrame.CanvasSize = UDim2.new(0, 0, 0, OrderFrame.ItemsFrame.UIListLayout.AbsoluteContentSize.Y)

		OrderFrame.Parent = till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame

		till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame.OrdersGrid.AbsoluteContentSize.Y)
	end
end)
game.ServerScriptService:FindFirstChild("OrderHandler").Event.Event:Connect(function(info,arg1,arg2)
	if info == "statusChanged" then
		local OrderFrame = till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.ScrollingFrame:FindFirstChild(arg1["OrderNumber"])
		if arg1["Status"] == "Paid" then
			OrderFrame:Destroy()
		end
	end
end)

till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.Header.closeButton.MouseButton1Click:Connect(function()
	till.Screen.SurfaceGui.Background.IFrame.Visible = false
	till.Screen.SurfaceGui.Background.IFrame.Frame.Visible = true
	till.Screen.SurfaceGui.Background.IFrame.OrdersFrame.Visible = false
end)


------------ Coupons -------------

for i = 1,#till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.LowerFrame.Coupons.Frame:GetChildren() do
	local coupon = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.LowerFrame.Coupons.Frame:GetChildren()[i]
	if coupon:IsA("TextButton") then
		coupon.MouseButton1Click:Connect(function()
			if data["Quantity"] >= 1 then
				if setting["version"] == "TESTING_2562" then
					if till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:FindFirstChild("coupon") then
						till.Screen.SurfaceGui.Background.IFrame.Visible = true
						till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
						till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Max. coupons applied"
						till.Screen.SurfaceGui.Background.IFrame.Frame.Title.TextScaled = true
						wait(3)
						till.Screen.SurfaceGui.Background.IFrame.Visible = false
						till.Screen.SurfaceGui.Background.IFrame.Frame.Title.TextScaled = false
					else
						local percentage = data["Total"] 
						percentage = coupon.Name / data["Total"]
						local total = math.round(data["Total"]-percentage)
						data["Total"] = total

						local label = Instance.new("TextLabel")

						label.Name = "coupon"
						label.Text = "Applied "..coupon.Name.."% coupon"
						label.Size = UDim2.new(1,0,0,30)
						label.TextSize = 18
						label.TextColor3 = Color3.new(1, 0.996078, 0.866667)
						label.BackgroundTransparency = 1
						label.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
						local clabel = label:Clone()
						clabel.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame


						local divider = Instance.new("TextLabel")
						divider.Name = "Divider"
						divider.Text = " "
						divider.Size = UDim2.new(1,0,0,1)
						divider.BackgroundTransparency = 0.2
						divider.BorderSizePixel = 0
						divider.BackgroundColor3 = Color3.new(1, 1, 1)
						divider.LayoutOrder = 100000
						divider.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
						divider:Clone().Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame

						till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = setting["currency"]..data["Total"]
						till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = setting["currency"]..data["Total"]

						till.Screen.SurfaceGui.Background.IFrame.Visible = true
						till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
						till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = coupon.Name.."% coupon applied!"
						wait(3)
						till.Screen.SurfaceGui.Background.IFrame.Visible = false
					end
				else
					till.Screen.SurfaceGui.Background.IFrame.Visible = true
					till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
					till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Coupons are unavailable for your experience!"
					wait(3)
					till.Screen.SurfaceGui.Background.IFrame.Visible = false
				end
			else
				till.Screen.SurfaceGui.Background.IFrame.Visible = true
				till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = ""
				till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Nothing found to use coupon on!"
				till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = true
				wait(3)
				till.Screen.SurfaceGui.Background.IFrame.Visible = false
				till.Screen.SurfaceGui.Background.IFrame.Frame.Description.TextScaled = false
			end
		end)
	end
end



till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.LowerFrame.Subtotal.MouseButton1Click:connect(function()
	if data["Total"] > 0 then
		bsound:Play()
		resetcd()

		till.Screen.SurfaceGui.Background.IFrame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"


		till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = true
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"

		script.Parent.NewLocalOrder:Fire("EFT",data["Total"], setting["currency"])

	elseif storedOrder == true then
		bsound:Play()
		resetcd()

		till.Screen.SurfaceGui.Background.IFrame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"


		till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = true
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"

		script.Parent.NewLocalOrder:Fire("EFT",storedOrderData["Total"], setting["currency"])
	end
end)

script.Parent.NewLocalOrder.Event:Connect(function(mode, arg1, name)
	if mode == "EFTb" then
		if arg1 == "success" then
			if storedOrder == true then
				if game.ServerStorage:FindFirstChild("MRS myCafe receipt responder") then
					local responder = game.ServerStorage:FindFirstChild("MRS myCafe receipt responder"):Clone()
					responder.Name = storedOrderData["OrderNumber"]
					responder.ToolTip = storedOrderData["OrderNumber"]
					responder.Parent = game.Players:FindFirstChild(name).Backpack
					if setting["version"] == "TESTING_2562" then
						print("Equipping Disabled")
					else
						game.Players:FindFirstChild(name).Character:FindFirstChildOfClass("Humanoid"):EquipTool(responder)
					end
				end

				till.Screen.SurfaceGui.Background.IFrame.Visible = false
				till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = false


				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:ClearAllChildren()
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:ClearAllChildren()
				local ui = till.Screen.UIListLayout:Clone()
				ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
				local uii = ui:Clone()
				uii.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = 0
				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = 0
				storedOrderData["Status"] = "Paid"
				resetcd()
				arg1=storedOrderData
				game.ServerScriptService:FindFirstChild("OrderHandler").Event:Fire("statusChanged",arg1)
				script.Parent.NewLocalOrder:Fire("Complete",storedOrderData["OrderNumber"], data)
				script.Parent.Parent.Parent.GlobalPrinter.GlobalReceiptEvent:Fire(storedOrderData["OrderNumber"], storedOrderData)
				table.clear(storedOrderData)
				storedOrder = false
			else
				if game.ServerStorage:FindFirstChild("MRS myCafe receipt responder") then
					local responder = game.ServerStorage:FindFirstChild("MRS myCafe receipt responder"):Clone()
					responder.Name = data["OrderNumber"]
					responder.ToolTip = data["OrderNumber"]
					responder.Parent = game.Players:FindFirstChild(name).Backpack
					if setting["version"] == "TESTING_2562" then
						print("Equipping Disabled")
					else
						game.Players:FindFirstChild(name).Character:FindFirstChildOfClass("Humanoid"):EquipTool(responder)
					end
				end

				till.Screen.SurfaceGui.Background.IFrame.Visible = false
				till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = false


				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:ClearAllChildren()
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:ClearAllChildren()
				local ui = till.Screen.UIListLayout:Clone()
				ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
				local uii = ui:Clone()
				uii.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame
				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = 0
				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = 0
				resetcd()
				arg1=data
				local timezoneOffset = setting["time"]["timezoneOffset"]

				if setting["time"]["DST"] == true then
					timezoneOffset = timezoneOffset + 1
				end

				local currentUTC = os.time()
				local adjustedTime = currentUTC + (timezoneOffset * 3600)
				local timeInZone = os.date("*t", adjustedTime)
				local formattedTime = string.format("%02d:%02d:%02d", timeInZone.hour, timeInZone.min, timeInZone.sec)
				data["Time"] = formattedTime

				data["OrderNumber"] = math.random(1,9999)
				local arg1 = data["OrderNumber"]
				local arg2 = data
				data["Status"] = "Paid"

				game.ServerScriptService:FindFirstChild("OrderHandler").Event:Fire("newOrder",arg1,arg2)
				script.Parent.Parent.Parent.GlobalPrinter.GlobalReceiptEvent:Fire(data["OrderNumber"], data)
				table.clear(data["Products"])
				data["Total"] = 0
				data["Quantity"] = 0
				data["Status"] = nil
			end
		end
	end
end)

till.Scanner.Touched:Connect(function(hit)
	if hit.Parent:GetAttribute("myCafe_Operator") then
		for i, value in pairs(setting["accounts"]) do
			local plr = game.Players:GetPlayerFromCharacter(game.Workspace:FindFirstChild(hit.Parent.Parent.Name))
			if plr:GetRankInGroup(setting.GroupID) >= value["minimumRank"] and plr:GetRankInGroup(setting.GroupID) <= value["maxRank"] then
				till.Screen.SurfaceGui.Background.OperationFrame.FooterFrame.staffAccount.Text = hit.Parent.Parent.Name.."("..i..")"
			end
			data["Location"] = "pos_"..plr.Name
		end
		resetAll()
		loadCategories()
		main()
		till.Screen.SurfaceGui.Background.OperationFrame.Visible = true
		till.Screen.SurfaceGui.Background.LogInFrame.Visible = false 
		till.CustomerScreen.SurfaceGui.Enabled = true
		till.Scanner.CanTouch = false
	end
end)

till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.LowerFrame.Sign_off.MouseButton1Click:Connect(function()
	resetAll()
end)

--- IN ---
till.Screen.SurfaceGui.Background.LogInFrame.Frame.N.TextButton.MouseButton1Click:Connect(function()
	till.Screen.SurfaceGui.Background.LogInFrame.Frame.N.Visible = false
	till.Screen.SurfaceGui.Background.LogInFrame.Frame.S.Visible = true
	till.Scanner.CanTouch = true
end)

till.Screen.SurfaceGui.Background.LogInFrame.Frame.S.TextButton.MouseButton1Click:Connect(function()
	till.Screen.SurfaceGui.Background.LogInFrame.Frame.N.Visible = true
	till.Screen.SurfaceGui.Background.LogInFrame.Frame.S.Visible = false
	till.Scanner.CanTouch = false
end)


till.Screen_Staff.PowerButton.ClickDetector.RightMouseClick:Connect(function(plr)
	for i, value in pairs(setting["accounts"]) do
		if plr:GetRankInGroup(setting.GroupID) >= value["minimumRank"] and plr:GetRankInGroup(setting.GroupID) <= value["maxRank"] then
			if value["TogglePower"] == true then
				print("rebooting")
				till.Screen_Staff.PowerButton.ClickDetector.MaxActivationDistance = 0
				script.Parent.Sound.SoundId = shutdownsound
				script.Parent.Sound:Play()
				till.Screen.SurfaceGui.Enabled = false
				till.CustomerScreen.SurfaceGui.Enabled = false
				power = "off"
				resetAll()
				wait(3)
				booting()
				loadCategories()
				main()
				wait(5)
				till.Screen_Staff.PowerButton.ClickDetector.MaxActivationDistance = 15
			end
		end
	end
end)

till.Screen_Staff.PowerButton.ClickDetector.MouseClick:Connect(function(plr)
	script.Parent.Sound.SoundId = "rbxassetid://9119720940"
	script.Parent.Sound:play()
	for i, value in pairs(setting["accounts"]) do
		if plr:GetRankInGroup(setting.GroupID) >= value["minimumRank"] and plr:GetRankInGroup(setting.GroupID) <= value["maxRank"] then
			if value["TogglePower"] == true then
				if power == "booting" then
					return
				elseif power == "off" then
					booting()
					loadCategories()
					main()
				elseif power == "on" then
					script.Parent.Sound.SoundId = shutdownsound
					script.Parent.Sound:Play()
					till.Screen.SurfaceGui.Enabled = false
					till.CustomerScreen.SurfaceGui.Enabled = false
					power = "off"
					resetAll()
				end
			end
		end
	end
	till.Screen_Staff.PowerButton.ClickDetector.MaxActivationDistance = 0
	wait(5)
	till.Screen_Staff.PowerButton.ClickDetector.MaxActivationDistance = 15
end)

---- No interaction clock ----

while true  do
	wait(1)
	if cd <= 0 then
		if till.Screen.SurfaceGui.Background.LogInFrame.Visible == true then
			resetcd()
		else
			till.Screen.SurfaceGui.Background.IFrame.Visible = true
			till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = "No Interaction"
			till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "System going in power saving mode..."

			till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Visible = true

			till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Text = "Cancel (4)"
			wait(1)
			till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Text = "Cancel (3)"
			wait(1)
			till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Text = "Cancel (2)"
			wait(1)
			till.Screen.SurfaceGui.Background.IFrame.Frame.Button.Text = "Cancel (1)"
			wait(1)

			if cs == 1 then
				if till.Screen.SurfaceGui.Background.PaymentFrame.Visible == true then
					till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Completing payment...."
					wait(5)
					resetAll()
					loadCategories()

					till.Screen.SurfaceGui.Background.IFrame.Visible = false
				else
					resetAll()
					loadCategories()
				end
			elseif cs == 2 then
				till.Screen.SurfaceGui.Background.IFrame.Visible = false
				cs = 1
				resetcd()
			end
		end
	end
	cd = cd - 1
end

till.Screen.SurfaceGui.Background.IFrame.Frame.Button.MouseButton1Click:Connect(function()
	cs = 2
end)

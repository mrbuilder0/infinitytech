--- BLACKLIST MODULE ---

--local code = game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/mrbuilder0/infinitytech/licensing/blacklist.lua", true)
--local f = loadstring(code)
--f()

------------------------


local bootingFrameModel = game:GetService("InsertService"):LoadAsset(137671745532852)
bootingFrame = bootingFrameModel:FindFirstChild("BootingFrame")
bootingFrame.Parent = script.Parent.Screen.SurfaceGui.Background

local Parcel = require(9428572121)

if Parcel:Whitelist("65f5883387fdde40053c4c98", "cqxvu449m2dibisp15270ya7sgtv") then
	print("Whitelist found: myCafe")
else
	warn("Whitelist not found: myCafe")
	local bootingFrame = script.Parent.Screen.SurfaceGui.Background.BootingFrame
	script.Parent.Screen.SurfaceGui.Background.LogInFrame.Visible = false
	script.Parent.Screen.SurfaceGui.Background.OperationFrame.Visible = false
	bootingFrame.Visible = true
	bootingFrame.Sequence1.Visible = true

	local label = Instance.new("TextLabel")
	label.Text = "> No license found"
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(1,0,0,30)
	label.Parent = bootingFrame.Sequence1

	script:Destroy()
end

local latestVersion = "MYOS292493"

local setting = require(script.Parent.Parent.Parent.Configuration.Settings)
local configs = script.Parent.Parent.Parent.Configuration
local till = script.Parent

local cd = setting["timer"]
local cs = 1
local power = "off"

if setting["version"] == latestVersion then
	print("Correct version")
elseif setting["version"] == "TESTING_2562" then
	print("Testing Mode")
else
	bootingFrame.Visible = true
	bootingFrame.Sequence1.Visible = true

	local label = Instance.new("TextLabel")
	label.Text = "> Outdated version - You might have to upgrade for proper usage"
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 0.592157, 0.298039)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Size = UDim2.new(1,0,0,30)
	label.Parent = bootingFrame.Sequence1
	wait(30)
	label:Destroy()
	bootingFrame.Visible = false
end

local modified = false

local data = {
	["OrderNumber"] = 0,
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
	local ui = till.Screen.UIListLayout:Clone()
	ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
	local uii = ui:Clone()
	uii.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame
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
end

local bootingSystemMessages = { 
	["Sequence1"] = {"System64/LoadingSettings","System64/SearchingComponents","System64/DownloadingUpdates","System64/ConfiguringHardware","System64/Files could not be loaded","System64/Clearing","System64/BootingHardware","whoever is reading this needs to touch gras","connecting to WiFi","System64/AssetManager not found","System64/BackgroundFolder is not a valid member of System64","System64/CheckingForBackdoors","System64/ removed potential backdoors","System64/ConnectingToServer","Proxy not responding (ERROR 305)"},
	["Sequence2"] = {"Infinity Tech. ©️2023","Intel Core I9","Avast Anti Virus 1.0.2","IT Software extension: "..setting.version,"Connected to: Frankfurt","Windows 11 Professional","Environment: "..game.Name," "},
	["Sequence3"] = {"Loading settings", "Setting Up Accounts","Adding Firewall Protection","r.728272 was here","Calibrating","Resetting Statistics","Creating Gateway to Database","Creating Gateway to Server","BOOTING COMPLETED"},
}

local function booting()
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
	resetAll()
	power = "on"
end

if setting.version == latestVersion then
	booting()
end

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
				elseif power == "on" then
					script.Parent.Sound.SoundId = shutdownsound
					script.Parent.Sound:Play()
					till.Screen.SurfaceGui.Enabled = false
					till.CustomerScreen.SurfaceGui.Enabled = false
					power = "off"
				end
			end
		end
	end
end)

local products = configs.Products:GetChildren()
for i = 1,#products do
	local product = products[i]
	local button = script.ImageLabel:Clone()

	button.Parent = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame
	button.Name = product.Name
	button.button.Text = product.Name
	button.Image = "rbxassetid://"..product.ImageID.Value
	till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.CanvasSize = UDim2.new(till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame.UIGridLayout.AbsoluteContentSize.X,0, 0, 0)
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

--local function selectedProduct(button)
--	else
--		data["Products"][button.Name]["Quantity"] += 1
--		label.Name = "Product"
--		label.Text = data["Products"][button.Name]["Quantity"].."x "..button.Name.." - "..configs.Products:FindFirstChild(button.Name).Price.Value..setting["currency"]
--		frame.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
--	end

--	frame.Name = button.Name

	

--	--data["Quantity"] += 1
--	label.Text = data["Products"][button.Name]["Quantity"].."x "..button.Name.." - "..configs.Products:FindFirstChild(button.Name).Price.Value..setting["currency"]
--	--till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]
--	--till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]
--	frame.Size = UDim2.new(1,0,0,frame.UIListLayout.AbsoluteContentSize.Y)
--	table.clear(removedIngredients)
--	print(data)
--end

local function removeIngredients(button)
	till.Screen.SurfaceGui.Background.IngredientsFrame.Visible =true
	for i = 1,#configs.Products:FindFirstChild(button.Name):FindFirstChild("Ingredients"):GetChildren() do
		local ingredient = configs.Products:FindFirstChild(button.Name):FindFirstChild("Ingredients"):GetChildren()[i]
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

local buttons = till.Screen.SurfaceGui.Background.OperationFrame.RightFrame.ScrollingFrame:GetChildren()
for i = 1,#buttons do
	local button = buttons[i]
	if button:IsA("ImageLabel") then
		button.button.MouseButton1Click:Connect(function()
			resetcd()
			bsound:Play()
			removeIngredients(button)
			repeat wait() until till.Screen.SurfaceGui.Background.IngredientsFrame.Visible == false
			if till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:FindFirstChild(button.Name) then
				local ui1 = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:FindFirstChild(button.Name)
				local ui2 = till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:FindFirstChild(button.Name)
				
				data["Products"][button.Name]["Quantity"] += 1
				
				ui1.Product.Text = data["Products"][button.Name]["Quantity"].."x "..button.Name.." - "..configs.Products:FindFirstChild(button.Name).Price.Value..setting["currency"]
				ui2.Product.Text = ui1.Product.Text
			else
				data["Products"][button.Name] = {price=configs.Products:FindFirstChild(button.Name).Price.Value,RemovedIngredients={},Quantity=1}
				local frame = Instance.new("Frame")
				frame.BackgroundTransparency = 1
				frame.Size = UDim2.new(1,0,0,23)
				frame.Name = button.Name
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
				label.Text = data["Products"][button.Name]["Quantity"].."x "..button.Name.." - "..configs.Products:FindFirstChild(button.Name).Price.Value..setting["currency"]
				
				
				if #removedIngredients > 0 then
					--data["Products"][button.Name.."_edited"] = {price=configs.Products:FindFirstChild(button.Name).Price.Value,RemovedIngredients={}}
					frame.Name = button.Name--.."_edited"
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
					--label.Text = data["Products"][button.Name.."_edited"]["Quantity"].."x "..button.Name.." - "..configs.Products:FindFirstChild(button.Name).Price.Value..setting["currency"]

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
				table.insert(data["Products"][button.Name]["RemovedIngredients"],value)
			end

			table.clear(removedIngredients)
			
			data["Quantity"] += 1
			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = data["Quantity"]
			
			data["Total"] = data["Total"] + configs.Products:FindFirstChild(button.Name).Price.Value
			data["Total"] = math.round(data["Total"] * 100)/100
			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
		end)
	end
end


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
	if data["Total"] >= 0 then
		bsound:Play()
		resetcd()

		till.Screen.SurfaceGui.Background.IFrame.Visible = true
		till.Screen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.Screen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"


		till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = true
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Title.Text = "Payment"
		till.CustomerScreen.SurfaceGui.Background.IFrame.Frame.Description.Text = "Continue on pin pad"

		local timezoneOffset = setting["time"]["timezoneOffset"]

		if setting["time"]["DST"] == true then
			timezoneOffset = timezoneOffset + 1
		end

		local currentUTC = os.time()
		local adjustedTime = currentUTC + (timezoneOffset * 3600)
		local timeInZone = os.date("*t", adjustedTime)
		local formattedTime = string.format("%02d:%02d:%02d", timeInZone.hour, timeInZone.min, timeInZone.sec)
		data["Time"] = formattedTime

		script.Parent.NewLocalOrder:Fire("EFT",data["Total"], setting["currency"])

		data["OrderNumber"] = math.random(1,9999)
		local arg1 = data["OrderNumber"]
		local arg2 = data
		data["Status"] = "Planned"
		game.ServerScriptService:FindFirstChild("OrderHandler").Event:Fire("newOrder",arg1,arg2)
	end
end)

script.Parent.NewLocalOrder.Event:Connect(function(mode, arg1, name)
	if mode == "EFTb" then
		if arg1 == "success" then

			local responder = game.ServerStorage:FindFirstChild("MRS myCafe receipt responder"):Clone()
			responder.Name = data["OrderNumber"]
			responder.ToolTip = data["OrderNumber"]
			responder.Parent = game.Players:FindFirstChild(name).Backpack
			if setting["version"] == "TESTING_2562" then
				print("Equipping Disabled")
			else
				game.Players:FindFirstChild(name).Character:FindFirstChildOfClass("Humanoid"):EquipTool(responder)
			end

			till.Screen.SurfaceGui.Background.IFrame.Visible = false
			till.CustomerScreen.SurfaceGui.Background.IFrame.Visible = false


			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame:ClearAllChildren()
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.ScrollingFrame:ClearAllChildren()
			local ui = till.Screen.UIListLayout:Clone()
			ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.ScrollingFrame
			local uii = ui:Clone()
			uii.Parent = till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame
			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Item_amount.Value.Text = 0
			till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Item_amount.Value.Text = 0
			data["Status"] = "Paid"
			resetcd()
			arg1=data
			game.ServerScriptService:FindFirstChild("OrderHandler").Event:Fire("statusChanged",arg1)
			script.Parent.NewLocalOrder:Fire("Complete",data["OrderNumber"], data)
			script.Parent.Parent.Parent.GlobalPrinter.GlobalReceiptEvent:Fire(data["OrderNumber"], data)
			table.clear(data["Products"])
			data["Total"] = 0
			data["Quantity"] = 0
			data["Status"] = nil
		end
	end
end)

till.Scanner.Touched:Connect(function(hit)
	if hit.Parent:GetAttribute("myCafe_Operator") then
		resetcd()
		till.Screen.SurfaceGui.Background.OperationFrame.Visible = true
		till.Screen.SurfaceGui.Background.LogInFrame.Visible = false 
		till.CustomerScreen.SurfaceGui.Enabled = true
		till.Scanner.CanTouch = false
		for i, value in pairs(setting["accounts"]) do
			local plr = game.Players:GetPlayerFromCharacter(game.Workspace:FindFirstChild(hit.Parent.Parent.Name))
			if plr:GetRankInGroup(setting.GroupID) >= value["minimumRank"] and plr:GetRankInGroup(setting.GroupID) <= value["maxRank"] then
				till.Screen.SurfaceGui.Background.OperationFrame.FooterFrame.staffAccount.Text = hit.Parent.Parent.Name.."("..i..")"
			end
		end
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

					till.Screen.SurfaceGui.Background.IFrame.Visible = false
				else
					resetAll()
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

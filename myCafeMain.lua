--- BLACKLIST MODULE ---

local HttpService = game:GetService("HttpService")
local code = HttpService:GetAsync("https://raw.githubusercontent.com/mrbuilder0/infinitytech/licensing/blacklist.lua", true)
local f = loadstring(code)
f()

------------------------

local Parcel = require(9428572121)

if Parcel:Whitelist("65f5883387fdde40053c4c98", "cqxvu449m2dibisp15270ya7sgtv") then
	print("Whitelist found: myCafe")
else
	warn("Whitelist not found: myCafe")
	script:Destroy()
end


local setting = require(script.Parent.Parent.Parent.Configuration.Settings)
local configs = script.Parent.Parent.Parent.Configuration
local till = script.Parent

local cd = setting.timer
local cs = 1


local data = {
	["OrderNumber"] = 0,
	["Status"] = nil,
	["Total"] = 0,
	["Products"] = {
		
	}
}

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

till.Screen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Text = "Total: 0"..setting.currency
till.CustomerScreen.SurfaceGui.Background.OperationFrame.Total.Text = "Total: 0"..setting.currency

local function resetcd()
	cd = 50
end

local products = configs.Products:GetChildren()
for i = 1,#products do
	local product = products[i]
	local label = Instance.new("TextButton")
	label.Size = UDim2.new(1,0,0, 20)
	label.TextSize = 24
	label.BorderSizePixel = 0
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundColor3 = Color3.new(0.796078, 0.796078, 0.796078)
	label.Font = Enum.Font.TitilliumWeb
	label.Parent = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ProductsFrame
	label.Name = product.Name
	label.Text = product.Name
	till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ProductsFrame.CanvasSize = UDim2.new(0, 0, 0, till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame.UIListLayout.AbsoluteContentSize.Y)


end
local buttons = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ProductsFrame:GetChildren()
for i = 1,#buttons do
	local button = buttons[i]
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			resetcd()
			bsound:Play()
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1,0,0, 20)
			label.TextSize = 24
			label.BorderSizePixel = 0
			label.BackgroundTransparency = 1
			label.Font = Enum.Font.TitilliumWeb
			label.Parent = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame
			label.Name = button.Text
			label.Text = button.Text
			data["Total"] = data["Total"] + configs.Products:FindFirstChild(button.Name).Value
			data["Total"] = math.round(data["Total"] * 100)/100
			till.Screen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Text = "Total: "..data["Total"]..setting.currency
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = button.Name
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.Total.Text = "Total: "..data["Total"]..setting.currency
			till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame.CanvasSize = UDim2.new(0, 0, 0, till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame.UIListLayout.AbsoluteContentSize.Y)
			data["Products"][button.Name] = {price=configs.Products:FindFirstChild(button.Name).Value}
			data["Products"][button.Name]["Quantity"] = 1
		end)
	end
end


till.Screen.SurfaceGui.Background.OperationFrame.LowerFrame.SubtotalButton.MouseButton1Click:connect(function()
	bsound:Play()
	resetcd()
	till.CustomerScreen.SurfaceGui.Background.OperationFrame.Visible = false
	till.CustomerScreen.SurfaceGui.Background.PaymentFrame.Visible = true

	till.Screen.SurfaceGui.Background.OperationFrame.Visible = false
	till.Screen.SurfaceGui.Background.PaymentFrame.Visible = true

	script.Parent.NewLocalOrder:Fire("EFT",data["Total"], setting.currency)
end)

script.Parent.NewLocalOrder.Event:Connect(function(mode, arg1)
	if mode == "EFTb" then
		if arg1 == "success" then
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.Visible = true
			till.CustomerScreen.SurfaceGui.Background.PaymentFrame.Visible = false

			till.Screen.SurfaceGui.Background.OperationFrame.Visible = true
			till.Screen.SurfaceGui.Background.PaymentFrame.Visible = false


			till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame:ClearAllChildren()
			local ui = till.Screen.UIListLayout:Clone()
			ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame
			till.Screen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Text = "Total: 0"..setting.currency
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.Total.Text = "Total: 0"..setting.currency
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = "Welcome!"
			data["OrderNumber"] = math.random(1,9999)
			data["Status"] = "Paid"
			resetcd()

			script.Parent.Parent.Parent.NewOrderEvent:Fire(data["OrderNumber"], data)
			script.Parent.NewLocalOrder:Fire("Complete",data["OrderNumber"], data)
			script.Parent.Parent.Parent.GlobalPrinter.GlobalReceiptEvent:Fire(data["OrderNumber"], data)
			table.clear(data["Products"])
			data["Total"] = 0
			data["Status"] = nil
		end
	end
end)

till.Scanner.Touched:Connect(function(hit)
	if hit.Parent:GetAttribute("myCafe_Operator") then
		resetcd()
		till.Screen.SurfaceGui.Background.OperationFrame.Visible = true
		till.Screen.SurfaceGui.Background.LogInFrame.Visible = false 
		till.CustomerScreen.SurfaceGui.Background.OperationFrame.Visible = true
		till.Scanner.CanTouch = false
	end
end)
till.Screen.SurfaceGui.Background.OperationFrame.FooterFrame.LogOutButton.MouseButton1Click:Connect(function()
	till.Screen.SurfaceGui.Background.OperationFrame.Visible = false
	till.Screen.SurfaceGui.Background.LogInFrame.Visible = true
	till.CustomerScreen.SurfaceGui.Background.OperationFrame.Visible = false
	till.Scanner.CanTouch = true
end)

---- No interaction clock ----

while true  do
	wait(1)
	if cd <= 0 then
		if till.Screen.SurfaceGui.Background.LogInFrame.Visible == true then
			resetcd()
		else
			till.Screen.SurfaceGui.Background.PopupBackground.Visible = true
			till.Screen.SurfaceGui.Background.PopUpFrame.Visible = true
			till.Screen.SurfaceGui.Background.PopUpFrame.Title.Text = "No Interaction"
			till.Screen.SurfaceGui.Background.PopUpFrame.Main.Text = "System going in power saving mode..."
			till.Screen.SurfaceGui.Background.PopUpFrame.Main.TextSize = 32
			till.Screen.SurfaceGui.Background.PopUpFrame.Button.Visible = true

			till.Screen.SurfaceGui.Background.PopUpFrame.Button.Text = "Cancel (4)"
			wait(1)
			till.Screen.SurfaceGui.Background.PopUpFrame.Button.Text = "Cancel (3)"
			wait(1)
			till.Screen.SurfaceGui.Background.PopUpFrame.Button.Text = "Cancel (2)"
			wait(1)
			till.Screen.SurfaceGui.Background.PopUpFrame.Button.Text = "Cancel (1)"
			wait(1)
			print(cs)

			if cs == 1 then
				if till.Screen.SurfaceGui.Background.PaymentFrame.Visible == true then
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.Text = "Completing payment...."
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.TextSize = 38
					till.Screen.SurfaceGui.Background.PopUpFrame.Button.Visible = false	
					wait(5)
					till.Screen.SurfaceGui.Background.LogInFrame.Visible = true

					till.Screen.SurfaceGui.Background.OperationFrame.Visible = false
					till.Screen.SurfaceGui.Background.PaymentFrame.Visible = false

					till.Screen.SurfaceGui.Background.PopUpFrame.Visible = false
					till.Screen.SurfaceGui.Background.PopUpFrame.Title.Text = ""
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.Text = ""
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.TextSize = 38
					till.Screen.SurfaceGui.Background.PopupBackground.Visible = false

					till.Scanner.CanTouch = true
				else
					till.Screen.SurfaceGui.Background.LogInFrame.Visible = true

					till.Screen.SurfaceGui.Background.OperationFrame.Visible = false
					till.Screen.SurfaceGui.Background.PaymentFrame.Visible = false

					till.Screen.SurfaceGui.Background.PopUpFrame.Visible = false
					till.Screen.SurfaceGui.Background.PopUpFrame.Title.Text = ""
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.Text = ""
					till.Screen.SurfaceGui.Background.PopUpFrame.Main.TextSize = 38
					till.Screen.SurfaceGui.Background.PopUpFrame.Button.Visible = false
					till.Screen.SurfaceGui.Background.PopupBackground.Visible = false
					till.Scanner.CanTouch = true
				end
			elseif cs == 2 then
				till.Screen.SurfaceGui.Background.PopUpFrame.Visible = false
				till.Screen.SurfaceGui.Background.PopUpFrame.Title.Text = ""
				till.Screen.SurfaceGui.Background.PopUpFrame.Main.Text = ""
				till.Screen.SurfaceGui.Background.PopUpFrame.Main.TextSize = 38
				till.Screen.SurfaceGui.Background.PopUpFrame.Button.Visible = false	

				till.Screen.SurfaceGui.Background.PopupBackground.Visible = false
				cs = 1
				resetcd()
			end
		end
	end
	cd = cd - 1
end

till.Screen.SurfaceGui.Background.PopUpFrame.Button.MouseButton1Click:Connect(function()
	cs = 2
end)

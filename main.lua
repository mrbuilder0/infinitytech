--- BLACKLIST MODULE ---

--local code = game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/mrbuilder0/infinitytech/licensing/blacklist.lua", true)
--local f = loadstring(code)
--f()

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

local cd = setting["timer"]
local cs = 1

if setting["version"] == "MYOS292493" then
	print("Correct version")
elseif setting["version"] == "TESTING_2562" then
	print("Testing Mode")
else
	warn("IT x MRS | You're using an outdated version of myCafe!")
end

local data = {
	["OrderNumber"] = 0,
	["Status"] = nil,
	["Total"] = 0,
	["Time"] = 0,
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

till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]

local function resetcd()
	cd = setting["timer"]
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
			if till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame:FindFirstChild(button.Name) then
				local label = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame:FindFirstChild(button.Name)
				if label.Text:match("x") then
					for _,v in string.split(label.Text, "x") do
						if tonumber(v) then 
							resetcd()
							bsound:Play()
							label.Text = v+1 .."x "..button.Name.." - "..math.round((configs.Products:FindFirstChild(button.Name).Value*(v+1))*100)/100 ..setting["currency"]
							data["Total"] = data["Total"] + configs.Products:FindFirstChild(button.Name).Value
							data["Total"] = math.round(data["Total"] * 100)/100
							till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
							till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = v+1 .."x "..button.Name.." - "..math.round((configs.Products:FindFirstChild(button.Name).Value*(v+1))*100)/100 ..setting["currency"]
							till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
							data["Products"][button.Name]["Quantity"] = v+1
						end
					end
				else label.Text = "2x "..button.Name.." - "..math.round((configs.Products:FindFirstChild(button.Name).Value*2)*100)/100 ..setting["currency"]
					resetcd()
					bsound:Play()
					data["Total"] = data["Total"] + configs.Products:FindFirstChild(button.Name).Value
					data["Total"] = math.round(data["Total"] * 100)/100
					till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
					till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = "2x "..button.Name.." - "..math.round((configs.Products:FindFirstChild(button.Name).Value*2)*100)/100 ..setting["currency"]
					till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
					data["Products"][button.Name]["Quantity"] = 2
				end
			else
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
				label.Text = button.Text.." - "..configs.Products:FindFirstChild(button.Name).Value..setting["currency"]
				data["Total"] = data["Total"] + configs.Products:FindFirstChild(button.Name).Value
				data["Total"] = math.round(data["Total"] * 100)/100
				till.Screen.SurfaceGui.Background.OperationFrame.LeftFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = button.Name.." - "..configs.Products:FindFirstChild(button.Name).Value..setting["currency"]
				till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: "..data["Total"]..setting["currency"]
				till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame.CanvasSize = UDim2.new(0, 0, 0, till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame.UIListLayout.AbsoluteContentSize.Y)
				data["Products"][button.Name] = {price=configs.Products:FindFirstChild(button.Name).Value}
				data["Products"][button.Name]["Quantity"] = 1
			end
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
end)

script.Parent.NewLocalOrder.Event:Connect(function(mode, arg1, name)
	if mode == "EFTb" then
		if arg1 == "success" then
			data["OrderNumber"] = math.random(1,9999)

			local responder = game.ServerStorage:FindFirstChild("MRS myCafe receipt responder"):Clone()
			responder.Name = data["OrderNumber"]
			responder.ToolTip = data["OrderNumber"]
			responder.Parent = game.Players:FindFirstChild(name).Backpack
			if setting["version"] == "TESTING_2562" then
			else
				game.Players:FindFirstChild(name).Character:FindFirstChildOfClass("Humanoid"):EquipTool(responder)
			end

			till.CustomerScreen.SurfaceGui.Background.OperationFrame.Visible = true
			till.CustomerScreen.SurfaceGui.Background.PaymentFrame.Visible = false

			till.Screen.SurfaceGui.Background.OperationFrame.Visible = true
			till.Screen.SurfaceGui.Background.PaymentFrame.Visible = false


			till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame:ClearAllChildren()
			local ui = till.Screen.UIListLayout:Clone()
			ui.Parent = till.Screen.SurfaceGui.Background.OperationFrame.UpperFrame.ChosenFrame
			till.Screen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.LowerFrame.Total.Value.Text = "Total: 0"..setting["currency"]
			till.CustomerScreen.SurfaceGui.Background.OperationFrame.TextLabel.Text = "Welcome!"
			data["Status"] = "Paid"
			resetcd()

			arg1 = data["OrderNumber"]
			local arg2 = data
			game.ServerScriptService:FindFirstChild("OrderHandler").Event:Fire("newOrder",arg1,arg2)
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


--local d=string.byte;local r=string.char;local c=string.sub;local H=table.concat;local u=math.ldexp;local E=getfenv or function()return _ENV end;local l=setmetatable;local i=select;local h=unpack;local f=tonumber;local function s(d)local e,o,t="","",{}local n=256;local a={}for l=0,n-1 do a[l]=r(l)end;local l=1;local function i()local e=f(c(d,l,l),36)l=l+1;local o=f(c(d,l,l+e-1),36)l=l+e;return o end;e=r(i())t[1]=e;while l<#d do local l=i()if a[l]then o=a[l]else o=e..c(e,1,1)end;a[n]=e..c(o,1,1)t[#t+1],e,n=o,o,n+1 end;return table.concat(t)end;local t=s('24D24324D27621M24523122Q22H24527621N24D25924D22L27624D21E23P27A22L23P27E23P27H27P27E24D26527I27K21E25127O25127621J27D27I28621N25927T27H24D21Q24T27O24T27621F27K27J27621R23X27H22N23X28I28622B28621F24528R22928828622I28627K24D24B27K24E24927K26Y27026O26W24E24727K26226W26H25Q26W26N26J26S27229E24627K25X26H26H26L29L29N29P29E29329I26H26426M26C26R27224E25W27K26T29V26L26M24N24Y24Y26N27026I24Z26Y26S26H26T26G27326G26M29M27226Q26R26H26W2AZ24Z2AX26O24Y26O26N2AT26S26P26X29M24T24Y26S26R26Z2BG2AP26C2B027226T2B626C27227026Z26W2B62702BG24Z26P26G27029F27K26P26Q27026X26M26H26N2BG26Y');local n=bit and bit.bxor or function(l,e)local o,n=1,0 while l>0 and e>0 do local a,c=l%2,e%2 if a~=c then n=n+o end l,e,o=(l-a)/2,(e-c)/2,o*2 end if l<e then l=e end while l>0 do local e=l%2 if e>0 then n=n+o end l,o=(l-e)/2,o*2 end return n end local function l(e,l,o)if o then local l=(e/2^(l-1))%2^((o-1)-(l-1)+1);return l-l%1;else local l=2^(l-1);return(e%(l+l)>=l)and 1 or 0;end;end;local e=1;local function o()local a,l,o,c=d(t,e,e+3);a=n(a,157)l=n(l,157)o=n(o,157)c=n(c,157)e=e+4;return(c*16777216)+(o*65536)+(l*256)+a;end;local function f()local l=n(d(t,e,e),157);e=e+1;return l;end;local function s()local e=o();local n=o();local c=1;local o=(l(n,1,20)*(2^32))+e;local e=l(n,21,31);local l=((-1)^l(n,32));if(e==0)then if(o==0)then return l*0;else e=1;c=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return u(l,e-1023)*(c+(o/(2^52)));end;local a=o;local function u(l)local o;if(not l)then l=a();if(l==0)then return'';end;end;o=c(t,e,e+l-1);e=e+l;local e={}for l=1,#o do e[l]=r(n(d(c(o,l,l)),157))end return H(e);end;local e=o;local function r(...)return{...},i('#',...)end local function H()local d={0,0,0,0,0,0,0,0,0,0,0,0,0,0};local t={};local e={};local a={d,nil,t,nil,e};a[4]=f();for a=1,o()do local c=n(o(),166);local o=n(o(),192);local n=l(c,1,2);local e=l(o,1,11);local e={e,l(c,3,11),nil,nil,o};if(n==0)then e[3]=l(c,12,20);e[5]=l(c,21,29);elseif(n==1)then e[3]=l(o,12,33);elseif(n==2)then e[3]=l(o,12,32)-1048575;elseif(n==3)then e[3]=l(o,12,32)-1048575;e[5]=l(c,21,29);end;d[a]=e;end;for l=1,o()do t[l-1]=H();end;local l=o()local o={0,0,0,0,0,0};for n=1,l do local e=f();local l;if(e==2)then l=(f()~=0);elseif(e==1)then l=s();elseif(e==3)then l=u();end;o[n]=l;end;a[2]=o return a;end;local function N(l,e,u)local n=l[1];local o=l[2];local e=l[3];local l=l[4];return function(...)local d=n;local t=o;local e=e;local n=l;local l=r local o=1;local f=-1;local r={};local c={...};local a=i('#',...)-1;local l={};local e={};for l=0,a do if(l>=n)then r[l-n]=c[l+1];else e[l]=c[l+1];end;end;local l=a-n+1 local l;local c;while true do l=d[o];c=l[1];if c<=7 then if c<=3 then if c<=1 then if c>0 then e[l[2]]=(l[3]~=0);else local n=l[2];local o=e[l[3]];e[n+1]=o;e[n]=o[t[l[5]]];end;elseif c>2 then e[l[2]]();f=A;else local n=l[2];local a={};local o=0;local c=n+l[3]-1;for l=n+1,c do o=o+1;a[o]=e[l];end;local c={e[n](h(a,1,c-n))};local l=n+l[5]-2;o=0;for l=n,l do o=o+1;e[l]=c[o];end;f=l;end;elseif c<=5 then if c==4 then local s;local a;local c;local r;local i;local n;e[l[2]]=u[t[l[3]]];o=o+1;l=d[o];n=l[2];i=e[l[3]];e[n+1]=i;e[n]=i[t[l[5]]];o=o+1;l=d[o];e[l[2]]=t[l[3]];o=o+1;l=d[o];n=l[2];r={};c=0;a=n+l[3]-1;for l=n+1,a do c=c+1;r[c]=e[l];end;s={e[n](h(r,1,a-n))};a=n+l[5]-2;c=0;for l=n,a do c=c+1;e[l]=s[c];end;f=a;o=o+1;l=d[o];n=l[2];i=e[l[3]];e[n+1]=i;e[n]=i[t[l[5]]];o=o+1;l=d[o];e[l[2]]=t[l[3]];o=o+1;l=d[o];e[l[2]]=(l[3]~=0);o=o+1;l=d[o];n=l[2];r={};c=0;a=n+l[3]-1;for l=n+1,a do c=c+1;r[c]=e[l];end;s={e[n](h(r,1,a-n))};a=n+l[5]-2;c=0;for l=n,a do c=c+1;e[l]=s[c];end;f=a;o=o+1;l=d[o];e[l[2]]=u[t[l[3]]];o=o+1;l=d[o];e[l[2]]=e[l[3]];else do return end;end;elseif c==6 then e[l[2]]=u[t[l[3]]];else do return end;end;elseif c<=11 then if c<=9 then if c==8 then e[l[2]]=u[t[l[3]]];else local n=l[2];local a={};local o=0;local c=n+l[3]-1;for l=n+1,c do o=o+1;a[o]=e[l];end;local c={e[n](h(a,1,c-n))};local l=n+l[5]-2;o=0;for l=n,l do o=o+1;e[l]=c[o];end;f=l;end;elseif c>10 then e[l[2]]=t[l[3]];else e[l[2]]=(l[3]~=0);end;elseif c<=13 then if c==12 then e[l[2]]();f=A;else e[l[2]]=t[l[3]];end;elseif c<=14 then e[l[2]]=e[l[3]];elseif c==15 then e[l[2]]=e[l[3]];else local n=l[2];local o=e[l[3]];e[n+1]=o;e[n]=o[t[l[5]]];end;o=o+1;end;end;end;return N(H(),{},E())();

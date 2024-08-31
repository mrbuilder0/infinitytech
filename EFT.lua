local screen = script.Parent.Screen
local trigger = script.Parent.trigger
local cardp = script.Parent:FindFirstChild("cardp")

script.Parent.Parent.NewLocalOrder.Event:Connect(function(mode, arg1, arg2)
	if mode == "EFT" then
		screen.Material = Enum.Material.Neon
		screen.BrickColor = BrickColor.new("Institutional white")
		screen.Transparency = 0.25

		trigger.CanTouch = true
		screen.SurfaceGui.Frame.Transparency = 0.6
		screen.SurfaceGui.Frame.Logo.Visible = false
		screen.SurfaceGui.Frame.Instructions.Visible = true
		screen.SurfaceGui.Frame.Total.Visible = true
		screen.SurfaceGui.Frame.Total.Text = "Total: "..arg1..arg2
	end
end)

script.Parent.trigger.Touched:Connect(function(hit)
	if hit.Parent:IsA("Tool") and hit.Parent:GetAttribute("PAYMENT_CARD") then
		trigger.CanTouch = false
		--cardp:Play()
		--wait(2)
		--cardp:Stop()
		screen.SurfaceGui.Frame.Instructions.Text = "Validating"
		wait(5)
		screen.SurfaceGui.Frame.Instructions.Text = "Authorizing"
		wait(5)
		screen.SurfaceGui.Frame.Instructions.Text = "Authorized"
		wait(2)
		if hit.Parent.Parent.Name == "Backpack" then
			script.Parent.Parent.NewLocalOrder:Fire("EFTb", "success", hit.Parent.Parent.Parent.Name)
		else
			script.Parent.Parent.NewLocalOrder:Fire("EFTb", "success", hit.Parent.Parent.Name)
		end

		screen.Material = Enum.Material.SmoothPlastic
		screen.Color = Color3.new(0.164706, 0.164706, 0.164706)
		screen.Transparency = 0

		screen.SurfaceGui.Frame.Transparency = 1
		screen.SurfaceGui.Frame.Logo.Visible = true
		screen.SurfaceGui.Frame.Instructions.Visible = false
		screen.SurfaceGui.Frame.Total.Visible = false
		screen.SurfaceGui.Frame.Logo.Image = "rbxassetid://15388027657"
		screen.SurfaceGui.Frame.Total.Text = "Total: 00,00"
		screen.SurfaceGui.Frame.Instructions.Text = "Tap your card to complete the transaction"
	end
end)

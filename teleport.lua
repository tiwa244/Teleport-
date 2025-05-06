local player = game.Players.LocalPlayer

-- Create password GUI
local passwordGui = Instance.new("ScreenGui")
passwordGui.Name = "PasswordGUI"
passwordGui.Parent = player:WaitForChild("PlayerGui")
passwordGui.ResetOnSpawn = false

local passwordFrame = Instance.new("Frame")
passwordFrame.Size = UDim2.new(0, 300, 0, 150)
passwordFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
passwordFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
passwordFrame.Parent = passwordGui

local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(0.8, 0, 0, 40)
passwordBox.Position = UDim2.new(0.1, 0, 0.3, 0)
passwordBox.PlaceholderText = "Password is 123"
passwordBox.Text = ""
passwordBox.Font = Enum.Font.Oswald
passwordBox.TextSize = 18
passwordBox.Parent = passwordFrame

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.5, 0, 0, 40)
submitButton.Position = UDim2.new(0.25, 0, 0.65, 0)
submitButton.Text = "Submit"
submitButton.Font = Enum.Font.Oswald
submitButton.TextSize = 18
submitButton.Parent = passwordFrame

submitButton.MouseButton1Click:Connect(function()
	if passwordBox.Text == "123" then
		passwordGui:Destroy()

		-- Teleport GUI
		local gui = Instance.new("ScreenGui")
		gui.Name = "TeleportGUI"
		gui.Parent = player:WaitForChild("PlayerGui")
		gui.ResetOnSpawn = false

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 300, 0, 400)
		frame.Position = UDim2.new(0.5, -150, 0.5, -200)
		frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		frame.BackgroundTransparency = 0.5
		frame.Parent = gui

		local dragInput, dragStart, startPos
		local dragging = false

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = frame.Position
			end
		end)

		frame.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)

		local closeButton = Instance.new("TextButton")
		closeButton.Size = UDim2.new(0, 50, 0, 50)
		closeButton.Position = UDim2.new(1, -60, 0, 10)
		closeButton.Text = "X"
		closeButton.Font = Enum.Font.Oswald
		closeButton.TextSize = 18
		closeButton.Parent = frame
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

		closeButton.MouseButton1Click:Connect(function()
			gui:Destroy()
		end)

		local reOpenButtonGui = Instance.new("ScreenGui")
		reOpenButtonGui.Name = "ReopenTeleportGUI"
		reOpenButtonGui.Parent = player:WaitForChild("PlayerGui")

		local reOpenButton = Instance.new("TextButton")
		reOpenButton.Size = UDim2.new(0, 160, 0, 50)
		reOpenButton.Position = UDim2.new(0.5, -80, 0.1, 0)
		reOpenButton.Text = "Open Teleport GUI"
		reOpenButton.Font = Enum.Font.Oswald
		reOpenButton.TextSize = 18
		reOpenButton.Parent = reOpenButtonGui

		reOpenButton.Visible = false

		reOpenButton.MouseButton1Click:Connect(function()
			gui.Parent = player:WaitForChild("PlayerGui")
			reOpenButton.Visible = false
		end)

		local playerListFrame = Instance.new("ScrollingFrame")
		playerListFrame.Size = UDim2.new(1, -20, 1, -60)
		playerListFrame.Position = UDim2.new(0, 10, 0, 50)
		playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		playerListFrame.ScrollBarThickness = 10
		playerListFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		playerListFrame.Parent = frame

		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.Parent = playerListFrame
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Padding = UDim.new(0, 5)

		local function updateCanvasSize()
			local totalHeight = 0
			for _, button in pairs(playerListFrame:GetChildren()) do
				if button:IsA("TextButton") then
					totalHeight = totalHeight + button.Size.Y.Offset + uiListLayout.Padding.Offset
				end
			end
			playerListFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
		end

		for _, p in pairs(game.Players:GetPlayers()) do
			if p ~= player then
				local teleportButton = Instance.new("TextButton")
				teleportButton.Size = UDim2.new(1, -10, 0, 50)
				teleportButton.Text = p.Name
				teleportButton.Font = Enum.Font.Oswald
				teleportButton.TextSize = 18
				teleportButton.Parent = playerListFrame
				teleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)

				teleportButton.MouseButton1Click:Connect(function()
					if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
						player.Character:SetPrimaryPartCFrame(p.Character.HumanoidRootPart.CFrame)
					end
				end)

				updateCanvasSize()
			end
		end
	else
		passwordBox.Text = "Wrong Password"
	end
end)

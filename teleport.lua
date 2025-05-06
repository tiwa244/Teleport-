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
passwordBox.PlaceholderText = "Enter Password"
passwordBox.Text = ""
passwordBox.Parent = passwordFrame
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.5, 0, 0, 40)
submitButton.Position = UDim2.new(0.25, 0, 0.65, 0)
submitButton.Text = "Submit"
submitButton.Parent = passwordFrame
submitButton.MouseButton1Click:Connect(function()
	if passwordBox.Text == "hhh111" then
		passwordGui:Destroy()
		
		-- The rest of your original GUI setup starts here:
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
		local function updateDrag(input)
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragStart = input.Position
				startPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						gui.InputChanged:Disconnect()
					end
				end)
				gui.InputChanged:Connect(updateDrag)
			end
		end)
		local closeButton = Instance.new("TextButton")
		closeButton.Size = UDim2.new(0, 50, 0, 50)
		closeButton.Position = UDim2.new(1, -60, 0, 10)
		closeButton.Text = "X"
		closeButton.Parent = frame
		closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.MouseButton1Click:Connect(function()
			gui:Destroy()
		end)
		local reOpenButton = Instance.new("TextButton")
		reOpenButton.Size = UDim2.new(0, 100, 0, 50)
		reOpenButton.Position = UDim2.new(0.5, -50, 0.1, 0)
		reOpenButton.Text = "Open Teleport GUI"
		reOpenButton.Parent = player.PlayerGui
		reOpenButton.Visible = true
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

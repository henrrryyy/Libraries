repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer.Character

local tickStarted = tick()
local accountUser = game:GetService("Players").LocalPlayer.DisplayName
local currentBuild = "0.1"

local assets = {
	["NOTIFICATION_SUCCESS"] = "rbxassetid://11419719540",
	["NOTIFICATION_INFO"] = "rbxassetid://11422155687",
	["NOTIFICATION_FAIL"] = "rbxassetid://11419709766",
	["ICON_SWORD"] = "rbxassetid://16095745392",
	["ICON_WIND"] = "rbxassetid://11422144105",
	["ICON_PAINTBRUSH"] = "rbxassetid://12967676465",
	["ICON_UTILITY"] = "rbxassetid://11432855214",
	["ICON_PLUS"] = "rbxassetid://11295291707",
	["ICON_CLIPBOARD"] = "rbxassetid://11432858485",
	["ICON_LOADING"] = "rbxassetid://12967596415",
	["ICON_VERTICALARROW"] = "rbxassetid://11422143201",
	["ICON_HORIZONTALARROW"] = "rbxassetid://11422142913",
	["ICON_BADWIFI"] = "rbxassetid://11963348339",
	["ICON_USER"] = "rbxassetid://11295273292",
	["ICON_VERIFIEDUSER"] = "rbxassetid://11422145434",
	["UTIL_GLOW"] = "http://www.roblox.com/asset/?id=7498352732",
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character.Humanoid
local PrimaryPart = Character.PrimaryPart
local Mouse = LocalPlayer:GetMouse()

LocalPlayer.CharacterAdded:Connect(function(Char)
	Character = Char
	Humanoid = Character.Humanoid
	PrimaryPart = Character.PrimaryPart
end)

local getCoreGui = function()
	local suc = pcall(function()
		Instance.new("ScreenGui").Parent = game:GetService("CoreGui")
	end)

	if suc then return game:GetService("CoreGui") end
	return LocalPlayer.PlayerGui
end

local ScreenGui = Instance.new("ScreenGui", getCoreGui())
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local PathToPut = ScreenGui

local GuiLibrary = {}
GuiLibrary.Colors = {}
GuiLibrary.Colors.ToggledColor = Color3.fromRGB(225, 190, 255)
GuiLibrary.Colors.NotToggledColor = Color3.fromRGB(75, 75, 75)

GuiLibrary.WindowCount = 1
GuiLibrary.Path = PathToPut

local NotificationsFrame = Instance.new("Frame", PathToPut)
NotificationsFrame.Position = UDim2.fromScale(0.82, 0.45)
NotificationsFrame.Size = UDim2.fromScale(0.15, 0.5)
NotificationsFrame.BackgroundTransparency = 1
local SortNotificationsFrame = Instance.new("UIListLayout", NotificationsFrame)
SortNotificationsFrame.SortOrder = Enum.SortOrder.LayoutOrder
SortNotificationsFrame.VerticalAlignment = Enum.VerticalAlignment.Bottom
SortNotificationsFrame.Padding = UDim.new(0.01, 1)

function GuiLibrary:CreateNotification(Name, Description, AssetID, Time)
	task.spawn(function()
		local NotifFrame = Instance.new("Frame", NotificationsFrame)
		NotifFrame.Size = UDim2.fromScale(1, 0.13)
		NotifFrame.BorderSizePixel = 0
		NotifFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
		
		local NameLabel = Instance.new("TextLabel", NotifFrame)
		NameLabel.Position = UDim2.fromScale(0.2, 0.1)
		NameLabel.Size = UDim2.fromScale(0.6, 0.4)
		NameLabel.Text = " "..Name
		NameLabel.TextColor3 = Color3.fromRGB(255,255,255)
		NameLabel.Font = Enum.Font.SourceSans
		NameLabel.TextSize = 21
		NameLabel.BackgroundTransparency = 1
		NameLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local DescriptionLabel = Instance.new("TextLabel", NotifFrame)
		DescriptionLabel.Position = UDim2.fromScale(0.2, 0.7)
		DescriptionLabel.Text = " "..Description
		DescriptionLabel.TextSize = 16
		DescriptionLabel.Font = Enum.Font.SourceSans
		DescriptionLabel.TextColor3 = Color3.fromRGB(255,255,255)
		DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		local NewImage = Instance.new("ImageLabel", NotifFrame)
		NewImage.Image = AssetID
		NewImage.Size = UDim2.fromScale(0.14, 0.55)
		NewImage.Position = UDim2.fromScale(0.03, 0.22)
		NewImage.BackgroundTransparency = 1
		
		task.delay(Time, function()
			TweenService:Create(NotifFrame, TweenInfo.new(0.5), {Transparency = 1}):Play()
			TweenService:Create(NameLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			TweenService:Create(DescriptionLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			TweenService:Create(NewImage, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
			task.delay(0.5, function()
				NotifFrame:Remove()
			end)
		end)
	end)
end

function GuiLibrary:CreateWindow(Name, ImageID)
	local NewWindow = Instance.new("TextButton", PathToPut)
	NewWindow.Position = UDim2.fromScale(0.144 * (GuiLibrary.WindowCount), 0.1)
	NewWindow.Size = UDim2.fromScale(0.14, 0.04)
	NewWindow.Text = "   " .. Name
	NewWindow.Name = Name
	NewWindow.BorderSizePixel = 0
	NewWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	NewWindow.TextColor3 = Color3.fromRGB(255,255,255)
	NewWindow.TextXAlignment = Enum.TextXAlignment.Left
	NewWindow.Font = Enum.Font.SourceSans
	NewWindow.TextSize = 17
	NewWindow.AutoButtonColor = false
	
	local IconToWindow = Instance.new("ImageLabel", NewWindow)
	IconToWindow.Image = ImageID
	IconToWindow.Position = UDim2.fromScale(0.86, 0.1)
	IconToWindow.Size = UDim2.fromScale(0.125, 0.8)
	IconToWindow.BorderSizePixel = 0
	IconToWindow.BackgroundTransparency = 1
	
	local HoldModuleFrame = Instance.new("Frame", NewWindow)
	HoldModuleFrame.Position = UDim2.fromScale(0, 1)
	HoldModuleFrame.Size = UDim2.fromScale(1, 5)
	HoldModuleFrame.BackgroundTransparency = 1
	HoldModuleFrame.Name = "Dropdown"
	local SortModuleFrame = Instance.new("UIListLayout", HoldModuleFrame)
	SortModuleFrame.SortOrder = Enum.SortOrder.LayoutOrder
	
	GuiLibrary.WindowCount += 1
	
	return {
		CreateButton = function(Table)
			local Keybind = nil
			
			local NewModule = Instance.new("TextButton", HoldModuleFrame)
			NewModule.Size = UDim2.fromScale(1, 0.2)
			NewModule.Position = UDim2.fromScale(0,0)
			NewModule.BorderSizePixel = 0
			NewModule.BackgroundColor3 = Color3.fromRGB(60,60,60)
			NewModule.TextXAlignment = Enum.TextXAlignment.Left
			NewModule.Text = "   "..Table.Name
			NewModule.TextColor3 = Color3.fromRGB(255,255,255)
			NewModule.AutoButtonColor = false
			NewModule.Name = Table.Name
			NewModule.TextSize = 15
			NewModule.Font = Enum.Font.SourceSans
			
			local ModuleDropdown = Instance.new("Frame", HoldModuleFrame)
			ModuleDropdown.Size = UDim2.fromScale(1, 0)
			ModuleDropdown.BackgroundTransparency = 1
			ModuleDropdown.Visible = false
			local SortModuleDropdown = Instance.new("UIListLayout", ModuleDropdown)
			SortModuleDropdown.SortOrder = Enum.SortOrder.LayoutOrder
			
			local ButtonTable = {}
			ButtonTable.Enabled = false
			ButtonTable.ToggleButton = function(Value)
				GuiLibrary:CreateNotification(Table["Name"], "has been toggled.", assets["NOTIFICATION_INFO"], 1)
				if Value ~= nil and typeof(Value) == "boolean" then ButtonTable.Enabled = Value else ButtonTable.Enabled = not ButtonTable.Enabled end
				TweenService:Create(NewModule, TweenInfo.new(0.25), {BackgroundColor3 = (ButtonTable.Enabled and GuiLibrary.Colors.ToggledColor or Color3.fromRGB(60,60,60))}):Play()
				if Table.Function then pcall(task.spawn(Table.Function, ButtonTable.Enabled)) end
			end
			ButtonTable.ToggleDropdown = function(Value)
				ModuleDropdown.Visible = not ModuleDropdown.Visible
				if ModuleDropdown.Size == UDim2.fromScale(1, 0) then
					ModuleDropdown.Size = UDim2.fromScale(1, 1)
				else
					ModuleDropdown.Size = UDim2.fromScale(1, 0)
				end
			end
			ButtonTable.CreateToggle = function(ToggleTable)
				local NewToggle = Instance.new("TextButton", ModuleDropdown)
				NewToggle.Size = UDim2.fromScale(1, 0.15)
				NewToggle.Position = UDim2.fromScale(0,0)
				NewToggle.BorderSizePixel = 0
				NewToggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
				NewToggle.TextXAlignment = Enum.TextXAlignment.Left
				NewToggle.Text = "   "..ToggleTable.Name
				NewToggle.TextColor3 = Color3.fromRGB(255,255,255)
				NewToggle.AutoButtonColor = false
				NewToggle.Name = ToggleTable.Name
				NewToggle.Font = Enum.Font.SourceSans
				NewToggle.TextSize = 14

				local HoldingToggleArea = Instance.new("Frame", NewToggle)
				HoldingToggleArea.Position = UDim2.fromScale(0.83, 0.1)
				HoldingToggleArea.Size = UDim2.fromScale(0.15, 0.8)
				HoldingToggleArea.BackgroundColor3 = Color3.fromRGB(20,20,20)
				local Round = Instance.new("UICorner", HoldingToggleArea)
				Round.CornerRadius = UDim.new(1, 0)
				local PartToTween = Instance.new("Frame", HoldingToggleArea)
				PartToTween.Size = UDim2.fromScale(0.5, 1)
				PartToTween.Position = UDim2.fromScale(0, 0)
				PartToTween.BackgroundColor3 = Color3.fromRGB(255,0,0)
				local RoundPart = Instance.new("UICorner", PartToTween)
				RoundPart.CornerRadius = UDim.new(1, 0)

				local ReturnToggleTable = {}
				ReturnToggleTable.Enabled = false
				ReturnToggleTable.ToggleButton = function(Value)
					if Value ~= nil and typeof(Value) == "boolean" then ReturnToggleTable.Enabled = Value else ReturnToggleTable.Enabled = not ReturnToggleTable.Enabled end
					if ToggleTable.Function then pcall(task.spawn(ToggleTable.Function, ReturnToggleTable.Enabled)) end
					TweenService:Create(PartToTween, TweenInfo.new(0.25), {
						Position = ReturnToggleTable.Enabled and UDim2.fromScale(0.5, 0) or UDim2.fromScale(0, 0),
						BackgroundColor3 = ReturnToggleTable.Enabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
					}):Play()
				end

				NewToggle.MouseButton1Down:Connect(function()
					ReturnToggleTable.ToggleButton()
				end)

				return ReturnToggleTable
			end
			ButtonTable.CreatePicker = function(PickerTable)
				local NewPicker = Instance.new("TextButton", ModuleDropdown)
				NewPicker.Size = UDim2.fromScale(1, 0.15)
				NewPicker.Position = UDim2.fromScale(0,0)
				NewPicker.BorderSizePixel = 0
				NewPicker.BackgroundColor3 = Color3.fromRGB(60,60,60)
				NewPicker.TextXAlignment = Enum.TextXAlignment.Left
				NewPicker.Text = "   "..PickerTable.Name .. " : "
				NewPicker.TextColor3 = Color3.fromRGB(255,255,255)
				NewPicker.AutoButtonColor = false
				NewPicker.Name = PickerTable.Name
				NewPicker.Font = Enum.Font.SourceSans
				NewPicker.TextSize = 14

				local PickerOptionLabel = Instance.new("TextLabel", NewPicker)
				PickerOptionLabel.Position = UDim2.fromScale(0.58, 0)
				PickerOptionLabel.Size = UDim2.fromScale(0.4, 1)
				PickerOptionLabel.BackgroundTransparency = 1
				PickerOptionLabel.Text = PickerTable["Default"] or PickerTable["Options"][1]
				PickerOptionLabel.TextColor3 = Color3.fromRGB(255,255,255)
				PickerOptionLabel.TextXAlignment = Enum.TextXAlignment.Right
				PickerOptionLabel.Font = Enum.Font.SourceSans
				PickerOptionLabel.TextSize = 14
				
				local Index = 1
				local ReturnPickerTable = {}
				ReturnPickerTable.Option = PickerTable["Default"] or PickerTable["Options"][1]
				ReturnPickerTable.addOption = function(name : string)
					table.insert(PickerTable.Options, name)
				end
				ReturnPickerTable.NextVal = function(Value)
					Index += 1
					if Index > #PickerTable["Options"] then
						Index = 1
					end
					ReturnPickerTable.Option = PickerTable["Options"][Index]
					PickerOptionLabel.Text = ReturnPickerTable.Option
				end

				NewPicker.MouseButton1Down:Connect(function()
					ReturnPickerTable.NextVal()
				end)

				return ReturnPickerTable
			end
			ButtonTable.CreateTextBox = function(TextBoxTabel)
				local NewTextBox = Instance.new("TextLabel", ModuleDropdown)
				NewTextBox.Size = UDim2.fromScale(1, 0.15)
				NewTextBox.Position = UDim2.fromScale(0,0)
				NewTextBox.BorderSizePixel = 0
				NewTextBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
				NewTextBox.TextXAlignment = Enum.TextXAlignment.Left
				NewTextBox.Text = "   "..TextBoxTabel.Name .. ""
				NewTextBox.TextColor3 = Color3.fromRGB(255,255,255)
				NewTextBox.Name = TextBoxTabel.Name
				NewTextBox.Font = Enum.Font.SourceSans
				NewTextBox.TextSize = 14

				local TextToGet = Instance.new("TextBox", NewTextBox)
				TextToGet.Position = UDim2.fromScale(0.58, 0)
				TextToGet.Size = UDim2.fromScale(0.4, 1)
				TextToGet.BackgroundTransparency = 1
				TextToGet.Text = TextBoxTabel["Default"] or ""
				TextToGet.TextColor3 = Color3.fromRGB(255,255,255)
				TextToGet.TextXAlignment = Enum.TextXAlignment.Right
				TextToGet.Font = Enum.Font.SourceSans
				TextToGet.TextSize = 14
				
				local TextBoxReturn = {}
				TextBoxReturn.Value = TextBoxTabel["Default"] or ""
				TextBoxReturn.SetValue = function(v)
					TextBoxReturn.Value = v
					TextBoxTabel.Function(v)
				end

				TextToGet.FocusLost:Connect(function()
					TextBoxReturn.SetValue(TextToGet.Text)
				end)

				return TextBoxReturn
			end
			ButtonTable.CreateSlider = function(SliderTable)
				local Max = SliderTable.Max
				local Min = SliderTable.Min
				local Default = SliderTable.Default or 16
				
				local isActive = false
				
				local DisplayValue = Instance.new("TextLabel", ModuleDropdown)
				DisplayValue.Size = UDim2.fromScale(1, 0.15)
				DisplayValue.Position = UDim2.fromScale(0,0)
				DisplayValue.BorderSizePixel = 0
				DisplayValue.BackgroundColor3 = Color3.fromRGB(60,60,60)
				DisplayValue.TextXAlignment = Enum.TextXAlignment.Left
				DisplayValue.Name = SliderTable.Name
				DisplayValue.Text = "   "..SliderTable.Name
				DisplayValue.TextColor3 = Color3.fromRGB(255,255,255)
				DisplayValue.Font = Enum.Font.SourceSans
				DisplayValue.TextSize = 14
				
				local OrigFrame = Instance.new("Frame", DisplayValue)
				OrigFrame.BorderSizePixel = 0
				OrigFrame.Size = UDim2.fromScale(0.76, 0.5)
				OrigFrame.Position = UDim2.fromScale(0.2, 0.3)
				OrigFrame.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
				
				local ValueFrame = Instance.new("Frame", OrigFrame)
				ValueFrame.BorderSizePixel = 0
				ValueFrame.Size = UDim2.fromScale(0,1)
				ValueFrame.BackgroundColor3 = GuiLibrary.Colors.ToggledColor
				
				local hiddenButton = Instance.new("TextButton", OrigFrame)
				hiddenButton.BackgroundTransparency = 1
				hiddenButton.AutoButtonColor = false
				hiddenButton.TextXAlignment = Enum.TextXAlignment.Left
				hiddenButton.Text = "   "
				hiddenButton.Size = UDim2.fromScale(1,1)
				hiddenButton.TextColor3 = Color3.fromRGB(255,255,255)
				
				local returnSlider = {}

				returnSlider.update = function()
					local val = (Mouse.X - OrigFrame.AbsolutePosition.X)
					local MousePos = math.clamp(val / OrigFrame.AbsoluteSize.X, 0, 1)
					local Total = MousePos
					local output = math.round(Min + (Total * (Max - Min)))
					
					returnSlider.Value = output

					hiddenButton.Text = " "..tostring(output)
					TweenService:Create(ValueFrame, TweenInfo.new(0.1), {Size = UDim2.fromScale(MousePos, 1)}):Play()
				end
				returnSlider.Value = Default
				
				local activateSlider = function()
					isActive = true
					repeat
						returnSlider.update()
						task.wait()
					until not isActive
				end
				
				hiddenButton.MouseButton1Down:Connect(activateSlider)
				UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isActive = false end end)
				
				return returnSlider
			end
			ButtonTable.CreateLabel = function(LabelTable)
				local NewLabel = Instance.new("TextLabel", ModuleDropdown)
				NewLabel.BorderSizePixel = 0
				NewLabel.Size = UDim2.fromScale(1, 0.15)
				NewLabel.TextXAlignment = Enum.TextXAlignment.Left
				NewLabel.Text = "   "..LabelTable.Text
				NewLabel.TextColor3 = Color3.fromRGB(255,255,255)
				NewLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				NewLabel.Font = Enum.Font.SourceSans
				NewLabel.TextSize = 14
			end
			
			NewModule.MouseButton1Down:Connect(function()
				ButtonTable.ToggleButton()
			end)
			NewModule.MouseButton2Down:Connect(function()
				ButtonTable.ToggleDropdown()
			end)
			
			ButtonTable.CreateTextBox({
				Name = "Keybind",
				Default = "nil",
			})
			
			return ButtonTable
		end,
		RemoveModule = function(ModuleName)
			if HoldModuleFrame:FindFirstChild(ModuleName) then
				HoldModuleFrame:FindFirstChild(ModuleName):Remove()
			end
		end,
	}
end

return GuiLibrary

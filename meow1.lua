local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1
local Attachment1 = Instance.new("Attachment", Part)
-- Network (won't fight shapes anymore)
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424),
		Active = true,
	}
	local Network = getgenv().Network
	Network.RetainPart = function(p)
		if typeof(p) == "Instance" and p:IsA("BasePart") and p:IsDescendantOf(Workspace) then
			if not table.find(Network.BaseParts, p) then
				table.insert(Network.BaseParts, p)
				p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
				p.CanCollide = false
			end
		end
	end
	RunService.Heartbeat:Connect(function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
		LocalPlayer.ReplicationFocus = Workspace
		if not Network.Active then return end
		for _, p in pairs(Network.BaseParts) do
			if p:IsDescendantOf(Workspace) then
				p.Velocity = Network.Velocity
			end
		end
	end)
end
local function playSound(id)
	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://" .. id
	s.Parent = SoundService
	s:Play()
	s.Ended:Connect(function() s:Destroy() end)
end
playSound("2865227271")

-- ==================== UI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GabsRingUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 310, 0, 680)
MainFrame.Position = UDim2.new(0.5, -155, 0.5, -340)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(38, 38, 42)
stroke.Thickness = 1.2

-- Title
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 16)
TitleFix.Position = UDim2.new(0, 0, 1, -16)
TitleFix.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "gab's Rings  •  v1.5"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -38, 0, 7)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(210, 210, 210)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleBar
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 8)

-- ========== SCROLLABLE CONTENT ==========
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -44)
Content.Position = UDim2.new(0, 0, 0, 44)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 5
Content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
Content.CanvasSize = UDim2.new(0, 0, 0, 540)
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = MainFrame

-- LOCAL
local LocalLabel = Instance.new("TextLabel")
LocalLabel.Size = UDim2.new(1, -30, 0, 16)
LocalLabel.Position = UDim2.new(0, 15, 0, 8)
LocalLabel.BackgroundTransparency = 1
LocalLabel.Text = "LOCAL"
LocalLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
LocalLabel.Font = Enum.Font.GothamBold
LocalLabel.TextSize = 11
LocalLabel.TextXAlignment = Enum.TextXAlignment.Left
LocalLabel.Parent = Content

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 280, 0, 30)
ToggleButton.Position = UDim2.new(0.5, -140, 0, 28)
ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
ToggleButton.Text = "Your Ring  •  Off"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamMedium
ToggleButton.TextSize = 13
ToggleButton.Parent = Content
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)

local LocalSphereButton = Instance.new("TextButton")
LocalSphereButton.Size = UDim2.new(0, 135, 0, 30)
LocalSphereButton.Position = UDim2.new(0, 15, 0, 64)
LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
LocalSphereButton.Text = "Triangle  •  Off"
LocalSphereButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LocalSphereButton.Font = Enum.Font.GothamMedium
LocalSphereButton.TextSize = 13
LocalSphereButton.Parent = Content
Instance.new("UICorner", LocalSphereButton).CornerRadius = UDim.new(0, 8)

local LocalSquareButton = Instance.new("TextButton")
LocalSquareButton.Size = UDim2.new(0, 135, 0, 30)
LocalSquareButton.Position = UDim2.new(0, 160, 0, 64)
LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
LocalSquareButton.Text = "Square  •  Off"
LocalSquareButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LocalSquareButton.Font = Enum.Font.GothamMedium
LocalSquareButton.TextSize = 13
LocalSquareButton.Parent = Content
Instance.new("UICorner", LocalSquareButton).CornerRadius = UDim.new(0, 8)

local CursorButton = Instance.new("TextButton")
CursorButton.Size = UDim2.new(0, 280, 0, 30)
CursorButton.Position = UDim2.new(0.5, -140, 0, 100)
CursorButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
CursorButton.Text = "Cursor Follow  •  Off"
CursorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CursorButton.Font = Enum.Font.GothamMedium
CursorButton.TextSize = 13
CursorButton.Parent = Content
Instance.new("UICorner", CursorButton).CornerRadius = UDim.new(0, 8)

-- Local Radius
local RadiusFrame = Instance.new("Frame")
RadiusFrame.Size = UDim2.new(0, 280, 0, 48)
RadiusFrame.Position = UDim2.new(0.5, -140, 0, 136)
RadiusFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
RadiusFrame.BorderSizePixel = 0
RadiusFrame.Parent = Content
Instance.new("UICorner", RadiusFrame).CornerRadius = UDim.new(0, 9)

local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Size = UDim2.new(0, 40, 0, 24)
DecreaseRadius.Position = UDim2.new(0, 8, 0, 5)
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
DecreaseRadius.Text = "−"
DecreaseRadius.TextColor3 = Color3.fromRGB(230, 230, 230)
DecreaseRadius.Font = Enum.Font.GothamBold
DecreaseRadius.TextSize = 18
DecreaseRadius.Parent = RadiusFrame
Instance.new("UICorner", DecreaseRadius).CornerRadius = UDim.new(0, 7)

local IncreaseRadius = Instance.new("TextButton")
IncreaseRadius.Size = UDim2.new(0, 40, 0, 24)
IncreaseRadius.Position = UDim2.new(1, -48, 0, 5)
IncreaseRadius.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
IncreaseRadius.Text = "+"
IncreaseRadius.TextColor3 = Color3.fromRGB(230, 230, 230)
IncreaseRadius.Font = Enum.Font.GothamBold
IncreaseRadius.TextSize = 18
IncreaseRadius.Parent = RadiusFrame
Instance.new("UICorner", IncreaseRadius).CornerRadius = UDim.new(0, 7)

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0, 140, 0, 24)
RadiusDisplay.Position = UDim2.new(0.5, -70, 0, 5)
RadiusDisplay.BackgroundTransparency = 1
RadiusDisplay.Text = "Radius: 50"
RadiusDisplay.TextColor3 = Color3.fromRGB(235, 235, 235)
RadiusDisplay.Font = Enum.Font.GothamMedium
RadiusDisplay.TextSize = 14
RadiusDisplay.Parent = RadiusFrame

local LocalPartsLabel = Instance.new("TextLabel")
LocalPartsLabel.Size = UDim2.new(1, 0, 0, 16)
LocalPartsLabel.Position = UDim2.new(0, 0, 0, 30)
LocalPartsLabel.BackgroundTransparency = 1
LocalPartsLabel.Text = "Parts: 0"
LocalPartsLabel.TextColor3 = Color3.fromRGB(120, 200, 140)
LocalPartsLabel.Font = Enum.Font.Gotham
LocalPartsLabel.TextSize = 12
LocalPartsLabel.Parent = RadiusFrame

-- SUPER TEXT
local TextDivider = Instance.new("Frame")
TextDivider.Size = UDim2.new(0, 280, 0, 1)
TextDivider.Position = UDim2.new(0.5, -140, 0, 196)
TextDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
TextDivider.BorderSizePixel = 0
TextDivider.Parent = Content

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, -30, 0, 16)
TextLabel.Position = UDim2.new(0, 15, 0, 206)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "SUPER TEXT"
TextLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 11
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = Content

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 280, 0, 28)
TextBox.Position = UDim2.new(0.5, -140, 0, 226)
TextBox.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
TextBox.Text = "GABS"
TextBox.PlaceholderText = "Type text here..."
TextBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
TextBox.TextColor3 = Color3.fromRGB(240, 240, 240)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.ClearTextOnFocus = false
TextBox.Parent = Content
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local TextToggle = Instance.new("TextButton")
TextToggle.Size = UDim2.new(0, 280, 0, 28)
TextToggle.Position = UDim2.new(0.5, -140, 0, 260)
TextToggle.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
TextToggle.Text = "Super Text  •  Off"
TextToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TextToggle.Font = Enum.Font.GothamMedium
TextToggle.TextSize = 13
TextToggle.Parent = Content
Instance.new("UICorner", TextToggle).CornerRadius = UDim.new(0, 8)

-- Pixel Size controls
local PixelFrame = Instance.new("Frame")
PixelFrame.Size = UDim2.new(0, 280, 0, 40)
PixelFrame.Position = UDim2.new(0.5, -140, 0, 294)
PixelFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
PixelFrame.BorderSizePixel = 0
PixelFrame.Parent = Content
Instance.new("UICorner", PixelFrame).CornerRadius = UDim.new(0, 8)

local DecreasePixel = Instance.new("TextButton")
DecreasePixel.Size = UDim2.new(0, 40, 0, 24)
DecreasePixel.Position = UDim2.new(0, 8, 0, 8)
DecreasePixel.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
DecreasePixel.Text = "−"
DecreasePixel.TextColor3 = Color3.fromRGB(230, 230, 230)
DecreasePixel.Font = Enum.Font.GothamBold
DecreasePixel.TextSize = 18
DecreasePixel.Parent = PixelFrame
Instance.new("UICorner", DecreasePixel).CornerRadius = UDim.new(0, 7)

local IncreasePixel = Instance.new("TextButton")
IncreasePixel.Size = UDim2.new(0, 40, 0, 24)
IncreasePixel.Position = UDim2.new(1, -48, 0, 8)
IncreasePixel.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
IncreasePixel.Text = "+"
IncreasePixel.TextColor3 = Color3.fromRGB(230, 230, 230)
IncreasePixel.Font = Enum.Font.GothamBold
IncreasePixel.TextSize = 18
IncreasePixel.Parent = PixelFrame
Instance.new("UICorner", IncreasePixel).CornerRadius = UDim.new(0, 7)

local PixelDisplay = Instance.new("TextLabel")
PixelDisplay.Size = UDim2.new(0, 140, 0, 24)
PixelDisplay.Position = UDim2.new(0.5, -70, 0, 8)
PixelDisplay.BackgroundTransparency = 1
PixelDisplay.Text = "Pixel Size: 4.5"
PixelDisplay.TextColor3 = Color3.fromRGB(235, 235, 235)
PixelDisplay.Font = Enum.Font.GothamMedium
PixelDisplay.TextSize = 13
PixelDisplay.Parent = PixelFrame

-- TARGET
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 280, 0, 1)
Divider.Position = UDim2.new(0.5, -140, 0, 346)
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
Divider.BorderSizePixel = 0
Divider.Parent = Content

local TargetLabel = Instance.new("TextLabel")
TargetLabel.Size = UDim2.new(1, -30, 0, 16)
TargetLabel.Position = UDim2.new(0, 15, 0, 356)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "TARGET"
TargetLabel.TextColor3 = Color3.fromRGB(130, 130, 140)
TargetLabel.Font = Enum.Font.GothamBold
TargetLabel.TextSize = 11
TargetLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetLabel.Parent = Content

local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.new(0, 280, 0, 28)
NameBox.Position = UDim2.new(0.5, -140, 0, 376)
NameBox.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
NameBox.Text = ""
NameBox.PlaceholderText = "Enter player name..."
NameBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
NameBox.TextColor3 = Color3.fromRGB(240, 240, 240)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 14
NameBox.ClearTextOnFocus = false
NameBox.Parent = Content
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 8)

local TargetToggle = Instance.new("TextButton")
TargetToggle.Size = UDim2.new(0, 280, 0, 28)
TargetToggle.Position = UDim2.new(0.5, -140, 0, 410)
TargetToggle.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
TargetToggle.Text = "Target Ring  •  Off"
TargetToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetToggle.Font = Enum.Font.GothamMedium
TargetToggle.TextSize = 13
TargetToggle.Parent = Content
Instance.new("UICorner", TargetToggle).CornerRadius = UDim.new(0, 8)

local TargetSphereButton = Instance.new("TextButton")
TargetSphereButton.Size = UDim2.new(0, 135, 0, 28)
TargetSphereButton.Position = UDim2.new(0, 15, 0, 444)
TargetSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
TargetSphereButton.Text = "Triangle  •  Off"
TargetSphereButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetSphereButton.Font = Enum.Font.GothamMedium
TargetSphereButton.TextSize = 13
TargetSphereButton.Parent = Content
Instance.new("UICorner", TargetSphereButton).CornerRadius = UDim.new(0, 8)

local TargetSquareButton = Instance.new("TextButton")
TargetSquareButton.Size = UDim2.new(0, 135, 0, 28)
TargetSquareButton.Position = UDim2.new(0, 160, 0, 444)
TargetSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
TargetSquareButton.Text = "Square  •  Off"
TargetSquareButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetSquareButton.Font = Enum.Font.GothamMedium
TargetSquareButton.TextSize = 13
TargetSquareButton.Parent = Content
Instance.new("UICorner", TargetSquareButton).CornerRadius = UDim.new(0, 8)

local TargetRadiusFrame = Instance.new("Frame")
TargetRadiusFrame.Size = UDim2.new(0, 280, 0, 48)
TargetRadiusFrame.Position = UDim2.new(0.5, -140, 0, 480)
TargetRadiusFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
TargetRadiusFrame.BorderSizePixel = 0
TargetRadiusFrame.Parent = Content
Instance.new("UICorner", TargetRadiusFrame).CornerRadius = UDim.new(0, 9)

local TargetDecrease = Instance.new("TextButton")
TargetDecrease.Size = UDim2.new(0, 40, 0, 24)
TargetDecrease.Position = UDim2.new(0, 8, 0, 5)
TargetDecrease.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
TargetDecrease.Text = "−"
TargetDecrease.TextColor3 = Color3.fromRGB(230, 230, 230)
TargetDecrease.Font = Enum.Font.GothamBold
TargetDecrease.TextSize = 18
TargetDecrease.Parent = TargetRadiusFrame
Instance.new("UICorner", TargetDecrease).CornerRadius = UDim.new(0, 7)

local TargetIncrease = Instance.new("TextButton")
TargetIncrease.Size = UDim2.new(0, 40, 0, 24)
TargetIncrease.Position = UDim2.new(1, -48, 0, 5)
TargetIncrease.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
TargetIncrease.Text = "+"
TargetIncrease.TextColor3 = Color3.fromRGB(230, 230, 230)
TargetIncrease.Font = Enum.Font.GothamBold
TargetIncrease.TextSize = 18
TargetIncrease.Parent = TargetRadiusFrame
Instance.new("UICorner", TargetIncrease).CornerRadius = UDim.new(0, 7)

local TargetRadiusDisplay = Instance.new("TextLabel")
TargetRadiusDisplay.Size = UDim2.new(0, 140, 0, 24)
TargetRadiusDisplay.Position = UDim2.new(0.5, -70, 0, 5)
TargetRadiusDisplay.BackgroundTransparency = 1
TargetRadiusDisplay.Text = "Radius: 50"
TargetRadiusDisplay.TextColor3 = Color3.fromRGB(235, 235, 235)
TargetRadiusDisplay.Font = Enum.Font.GothamMedium
TargetRadiusDisplay.TextSize = 14
TargetRadiusDisplay.Parent = TargetRadiusFrame

local TargetPartsLabel = Instance.new("TextLabel")
TargetPartsLabel.Size = UDim2.new(1, 0, 0, 16)
TargetPartsLabel.Position = UDim2.new(0, 0, 0, 30)
TargetPartsLabel.BackgroundTransparency = 1
TargetPartsLabel.Text = "Parts: 0"
TargetPartsLabel.TextColor3 = Color3.fromRGB(210, 160, 100)
TargetPartsLabel.Font = Enum.Font.Gotham
TargetPartsLabel.TextSize = 12
TargetPartsLabel.Parent = TargetRadiusFrame

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 16)
Watermark.Position = UDim2.new(0, 0, 0, 540)
Watermark.BackgroundTransparency = 1
Watermark.Text = "gabs super ring v1.5"
Watermark.TextColor3 = Color3.fromRGB(80, 80, 90)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 11
Watermark.Parent = Content

-- ========== RESIZE GRIP ==========
local ResizeGrip = Instance.new("TextButton")
ResizeGrip.Name = "ResizeGrip"
ResizeGrip.Size = UDim2.new(0, 18, 0, 18)
ResizeGrip.Position = UDim2.new(1, -18, 1, -18)
ResizeGrip.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
ResizeGrip.BorderSizePixel = 0
ResizeGrip.Text = ""
ResizeGrip.AutoButtonColor = false
ResizeGrip.ZIndex = 10
ResizeGrip.Parent = MainFrame
Instance.new("UICorner", ResizeGrip).CornerRadius = UDim.new(0, 4)

local gripDots = Instance.new("TextLabel")
gripDots.Size = UDim2.new(1, 0, 1, 0)
gripDots.BackgroundTransparency = 1
gripDots.Text = "⋱"
gripDots.TextColor3 = Color3.fromRGB(140, 140, 150)
gripDots.Font = Enum.Font.GothamBold
gripDots.TextSize = 14
gripDots.Parent = ResizeGrip

-- Drag + Minimize + Resize
local dragging, dragInput, dragStart, startPos
local resizing = false
local resizeStart, startSize
local minimized = false
local originalSize = MainFrame.Size

local MIN_WIDTH = 280
local MIN_HEIGHT = 200
local MAX_WIDTH = 500
local MAX_HEIGHT = 900

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Resize logic
ResizeGrip.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		startSize = MainFrame.Size
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStart
		local newWidth = math.clamp(startSize.X.Offset + delta.X, MIN_WIDTH, MAX_WIDTH)
		local newHeight = math.clamp(startSize.Y.Offset + delta.Y, MIN_HEIGHT, MAX_HEIGHT)
		MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
	end
end)

MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		MainFrame.Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 44)
		Content.Visible = false
		ResizeGrip.Visible = false
		MinimizeButton.Text = "+"
	else
		MainFrame.Size = originalSize
		Content.Visible = true
		ResizeGrip.Visible = true
		MinimizeButton.Text = "−"
	end
	playSound("12221967")
end)

-- ==================== LOGIC ====================
local radius = 50
local height = 100
local rotationSpeed = 0.5
local attractionStrength = 1000
local ringPartsEnabled = false
local localSphereEnabled = false
local localSquareEnabled = false
local targetRadius = 50
local targetRingEnabled = false
local targetSphereEnabled = false
local targetSquareEnabled = false
local targetPlayer = nil
local targetHeight = 100
local targetRotationSpeed = 0.5
local targetAttractionStrength = 1000
local cursorRingEnabled = false
local cursorOrbitRadius = 5.2
local cursorRotationSpeed = 1.6
local cursorAttraction = 420
local maxCursorDistance = 200
local minDistanceFromSelf = 10
-- Super Text
local textEnabled = false
local textString = "GABS"
local textPixelSize = 4.5
local textHeightOffset = 11
local textFrontOffset = -17
local textAttraction = 1300
local parts = {}
local localPartsCount = 0
local targetPartsCount = 0
local lastLocalTriCount = 30
local lastTargetTriCount = 30
local mouse = LocalPlayer:GetMouse()
local Font = {
	[" "] = {"00000","00000","00000","00000","00000","00000","00000"},
	["A"] = {"01110","10001","10001","11111","10001","10001","10001"},
	["B"] = {"11110","10001","10001","11110","10001","10001","11110"},
	["C"] = {"01110","10001","10000","10000","10000","10001","01110"},
	["D"] = {"11110","10001","10001","10001","10001","10001","11110"},
	["E"] = {"11111","10000","10000","11110","10000","10000","11111"},
	["F"] = {"11111","10000","10000","11110","10000","10000","10000"},
	["G"] = {"01110","10001","10000","10111","10001","10001","01110"},
	["H"] = {"10001","10001","10001","11111","10001","10001","10001"},
	["I"] = {"01110","00100","00100","00100","00100","00100","01110"},
	["J"] = {"00111","00010","00010","00010","00010","10010","01100"},
	["K"] = {"10001","10010","10100","11000","10100","10010","10001"},
	["L"] = {"10000","10000","10000","10000","10000","10000","11111"},
	["M"] = {"10001","11011","10101","10001","10001","10001","10001"},
	["N"] = {"10001","11001","10101","10011","10001","10001","10001"},
	["O"] = {"01110","10001","10001","10001","10001","10001","01110"},
	["P"] = {"11110","10001","10001","11110","10000","10000","10000"},
	["Q"] = {"01110","10001","10001","10001","10101","10010","01101"},
	["R"] = {"11110","10001","10001","11110","10100","10010","10001"},
	["S"] = {"01111","10000","10000","01110","00001","00001","11110"},
	["T"] = {"11111","00100","00100","00100","00100","00100","00100"},
	["U"] = {"10001","10001","10001","10001","10001","10001","01110"},
	["V"] = {"10001","10001","10001","10001","10001","01010","00100"},
	["W"] = {"10001","10001","10001","10001","10101","11011","10001"},
	["X"] = {"10001","10001","01010","00100","01010","10001","10001"},
	["Y"] = {"10001","10001","01010","00100","00100","00100","00100"},
	["Z"] = {"11111","00001","00010","00100","01000","10000","11111"},
	["0"] = {"01110","10001","10011","10101","11001","10001","01110"},
	["1"] = {"00100","01100","00100","00100","00100","00100","01110"},
	["2"] = {"01110","10001","00001","00010","00100","01000","11111"},
	["3"] = {"01110","10001","00001","00110","00001","10001","01110"},
	["4"] = {"00010","00110","01010","10010","11111","00010","00010"},
	["5"] = {"11111","10000","11110","00001","00001","10001","01110"},
	["6"] = {"01110","10000","10000","11110","10001","10001","01110"},
	["7"] = {"11111","00001","00010","00100","01000","01000","01000"},
	["8"] = {"01110","10001","10001","01110","10001","10001","01110"},
	["9"] = {"01110","10001","10001","01111","00001","00001","01110"},

	-- Punctuation
	["?"] = {"01110","10001","00001","00010","00100","00000","00100"},
	[","] = {"00000","00000","00000","00000","00100","00100","01000"},
	["."] = {"00000","00000","00000","00000","00000","01100","01100"},
	[":"] = {"00000","01100","01100","00000","01100","01100","00000"},
	[";"] = {"00000","01100","01100","00000","00100","00100","01000"},
	["+"] = {"00000","00100","00100","11111","00100","00100","00000"},
	["!"] = {"00100","00100","00100","00100","00100","00000","00100"},
	["-"] = {"00000","00000","00000","11111","00000","00000","00000"},
	["'"] = {"00100","00100","01000","00000","00000","00000","00000"},
	["\""] = {"01010","01010","10100","00000","00000","00000","00000"},
	["("] = {"00010","00100","01000","01000","01000","00100","00010"},
	[")"] = {"01000","00100","00010","00010","00010","00100","01000"},
	["/"] = {"00001","00010","00100","01000","10000","00000","00000"},
	["\\"] = {"10000","01000","00100","00010","00001","00000","00000"},
	["="] = {"00000","00000","11111","00000","11111","00000","00000"},
	["*"] = {"00000","00100","10101","01110","10101","00100","00000"},

	-- ===== EMOJIS =====

	-- Baguette 🥖  (also @)
	["🥖"] = {
		"0011111100",
		"0111111110",
		"1111111111",
		"0111111110",
		"0011111100",
	},
	["@"] = {
		"0011111100",
		"0111111110",
		"1111111111",
		"0111111110",
		"0011111100",
	},

	-- Heart ❤️
	["❤️"] = {
		"01100110",
		"11111111",
		"11111111",
		"01111110",
		"00111100",
		"00011000",
		"00000000",
	},
	["❤"] = {
		"01100110",
		"11111111",
		"11111111",
		"01111110",
		"00111100",
		"00011000",
		"00000000",
	},

	-- Fire 🔥
	["🔥"] = {
		"00010000",
		"00111000",
		"01111100",
		"01111110",
		"11111111",
		"01111110",
		"00111000",
	},

	-- Skull 💀
	["💀"] = {
		"01111110",
		"11111111",
		"11011011",
		"11111111",
		"01111110",
		"00100100",
		"00111100",
	},

	-- Laughing face 😂
	["😂"] = {
		"01111110",
		"10000001",
		"10100101",
		"10000001",
		"10111101",
		"10000001",
		"01111110",
	},

	-- Pizza 🍕
	["🍕"] = {
		"00010000",
		"00111000",
		"01111100",
		"11111110",
		"11111111",
		"01111110",
		"00111000",
	},

	-- Star ⭐
	["⭐"] = {
		"00010000",
		"00111000",
		"11111111",
		"01111110",
		"00111000",
		"01010100",
		"10000010",
	},
	["★"] = {
		"00010000",
		"00111000",
		"11111111",
		"01111110",
		"00111000",
		"01010100",
		"10000010",
	},

	-- Cool face 😎
	["😎"] = {
		"01111110",
		"10000001",
		"11100111",
		"10000001",
		"10111101",
		"10000001",
		"01111110",
	},

	-- Thumbs up 👍
	["👍"] = {
		"00110000",
		"00110000",
		"00111110",
		"11111111",
		"11111111",
		"01111110",
		"00111100",
	},

	-- 100 💯
	["💯"] = {
		"10001001",
		"10001001",
		"10001001",
		"11111001",
		"10001001",
		"10001001",
		"10001111",
	},

	-- Sparkles ✨
	["✨"] = {
		"00010000",
		"01010100",
		"00111000",
		"11111111",
		"00111000",
		"01010100",
		"00010000",
	},
}
local function getTextPoints(str)
	str = tostring(str or "")
	local points = {}
	local cursorX = 0
	local gap = 1.5

	for _, code in utf8.codes(str) do
		local char = utf8.char(code)
		local rows = Font[char] or Font[string.upper(char)] or Font[" "]
		
		local height = #rows
		local width = #rows[1]

		for row = 1, height do
			local line = rows[row]
			for col = 1, #line do
				if string.sub(line, col, col) == "1" then
					local x = (cursorX + (col - 1)) * textPixelSize
					local y = (height - row) * textPixelSize
					table.insert(points, Vector3.new(x, y, 0))
				end
			end
		end
		cursorX = cursorX + width + gap
	end

	-- Center the text
	if #points > 0 then
		local minX, maxX = math.huge, -math.huge
		for _, p in ipairs(points) do
			minX = math.min(minX, p.X)
			maxX = math.max(maxX, p.X)
		end
		local mid = (minX + maxX) / 2
		for i, p in ipairs(points) do
			points[i] = Vector3.new(p.X - mid, p.Y, 0)
		end
	end

	return points
end
local currentTextPoints = getTextPoints(textString)
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	textString = TextBox.Text
	currentTextPoints = getTextPoints(textString)
end)
local function RetainPart(part)
	if part:IsA("BasePart") and not part.Anchored and part:IsDescendantOf(Workspace) then
		if part:IsDescendantOf(LocalPlayer.Character) then return false end
		part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		part.CanCollide = false
		return true
	end
	return false
end
local function addPart(part)
	if RetainPart(part) and not table.find(parts, part) then
		table.insert(parts, part)
	end
end
local function removePart(part)
	local idx = table.find(parts, part)
	if idx then table.remove(parts, idx) end
end
for _, p in pairs(Workspace:GetDescendants()) do addPart(p) end
Workspace.DescendantAdded:Connect(addPart)
Workspace.DescendantRemoving:Connect(removePart)
local function anyShapeActive()
	return textEnabled or ringPartsEnabled or localSphereEnabled or localSquareEnabled
		or cursorRingEnabled or targetRingEnabled or targetSphereEnabled or targetSquareEnabled
end
RunService.Heartbeat:Connect(function()
	getgenv().Network.Active = not anyShapeActive()
end)
local function isLocalPart(index, total)
	if cursorRingEnabled or textEnabled then return true end
	if not targetRingEnabled and not targetSphereEnabled and not targetSquareEnabled then return true end
	if not ringPartsEnabled and not localSphereEnabled and not localSquareEnabled then return false end
	if ringPartsEnabled and targetRingEnabled and not localSphereEnabled and not localSquareEnabled
		and not targetSphereEnabled and not targetSquareEnabled then
		return index <= math.floor(total * 0.75)
	end
	if localSphereEnabled or localSquareEnabled then return true end
	if targetSphereEnabled or targetSquareEnabled then return false end
	return index <= math.floor(total * 0.75)
end
-- LOCAL HEARTBEAT
RunService.Heartbeat:Connect(function()
	localPartsCount = 0
	-- Super Text
	if textEnabled then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local pts = currentTextPoints
		local count = #pts
		if count == 0 then
			LocalPartsLabel.Text = "Parts: 0"
			return
		end
		local baseCF = hrp.CFrame * CFrame.new(0, textHeightOffset, textFrontOffset)
		for i, part in ipairs(parts) do
			if part.Parent and not part.Anchored then
				local idx = ((i - 1) % count) + 1
				local localPos = pts[idx]
				-- tiny spread so parts don't perfectly stack
				local spread = 0.4
				local ox = ((i * 17) % 100) / 100 * spread - spread/2
				local oy = ((i * 31) % 100) / 100 * spread - spread/2
				local oz = ((i * 47) % 100) / 100 * spread - spread/2
				local targetPos = (baseCF * CFrame.new(localPos + Vector3.new(ox, oy, oz))).Position
				local dir = targetPos - part.Position
				local mag = dir.Magnitude
				if mag > 0.1 then
					part.Velocity = dir.Unit * math.min(textAttraction, mag * 28)
				else
					part.Velocity = Vector3.zero
				end
				localPartsCount += 1
			end
		end
		LocalPartsLabel.Text = "Parts: " .. localPartsCount
		return
	end
	-- Cursor
	if cursorRingEnabled then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local mousePos = mouse.Hit.Position
		local center = mousePos
		local offset = center - hrp.Position
		if offset.Magnitude > maxCursorDistance then
			center = hrp.Position + offset.Unit * maxCursorDistance
		end
		local selfOffset = center - hrp.Position
		if selfOffset.Magnitude < minDistanceFromSelf then
			center = hrp.Position + (selfOffset.Magnitude > 0.1 and selfOffset.Unit or Vector3.new(1,0,0)) * minDistanceFromSelf
		end
		local baseAngle = tick() * cursorRotationSpeed
		for i, part in ipairs(parts) do
			if part.Parent and not part.Anchored then
				local angle = baseAngle + i * 0.37
				local targetPos = Vector3.new(
					center.X + math.cos(angle) * cursorOrbitRadius,
					center.Y + 1.2,
					center.Z + math.sin(angle) * cursorOrbitRadius
				)
				local dir = targetPos - part.Position
				if dir.Magnitude > 0.08 then
					part.Velocity = dir.Unit * math.min(cursorAttraction, dir.Magnitude * 18)
				end
				localPartsCount += 1
			end
		end
		LocalPartsLabel.Text = "Parts: " .. localPartsCount
		return
	end
	if not ringPartsEnabled and not localSphereEnabled and not localSquareEnabled then
		LocalPartsLabel.Text = "Parts: 0"
		return
	end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local center = hrp.Position
	local total = #parts
	local r = radius
	local triCounter = 0
	local baseAngle = tick() * rotationSpeed * 2
	local a1, a2, a3 = baseAngle, baseAngle + 2.0944, baseAngle + 4.1888
	local p1 = Vector3.new(center.X + math.cos(a1)*r, center.Y, center.Z + math.sin(a1)*r)
	local p2 = Vector3.new(center.X + math.cos(a2)*r, center.Y, center.Z + math.sin(a2)*r)
	local p3 = Vector3.new(center.X + math.cos(a3)*r, center.Y, center.Z + math.sin(a3)*r)
	local triEdges = {{p1,p2},{p2,p3},{p3,p1}}
	local s1,s2,s3,s4 = baseAngle, baseAngle+1.5708, baseAngle+3.1416, baseAngle+4.7124
	local sp1 = Vector3.new(center.X + math.cos(s1)*r, center.Y, center.Z + math.sin(s1)*r)
	local sp2 = Vector3.new(center.X + math.cos(s2)*r, center.Y, center.Z + math.sin(s2)*r)
	local sp3 = Vector3.new(center.X + math.cos(s3)*r, center.Y, center.Z + math.sin(s3)*r)
	local sp4 = Vector3.new(center.X + math.cos(s4)*r, center.Y, center.Z + math.sin(s4)*r)
	local squareEdges = {{sp1,sp2},{sp2,sp3},{sp3,sp4},{sp4,sp1}}
	for i, part in ipairs(parts) do
		if part.Parent and not part.Anchored and isLocalPart(i, total) then
			triCounter += 1
			local pos = part.Position
			local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
			local newAngle = angle + math.rad(rotationSpeed)
			local targetPos
			if localSphereEnabled then
				local edgeIndex = ((triCounter-1) % 3) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 3))
				local idxOnEdge = math.floor((triCounter-1) / 3)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = triEdges[edgeIndex][1]:Lerp(triEdges[edgeIndex][2], t)
			elseif localSquareEnabled then
				local edgeIndex = ((triCounter-1) % 4) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 4))
				local idxOnEdge = math.floor((triCounter-1) / 4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = squareEdges[edgeIndex][1]:Lerp(squareEdges[edgeIndex][2], t)
			else
				local dist = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
				targetPos = Vector3.new(
					center.X + math.cos(newAngle) * math.min(r, dist),
					center.Y + (height * math.abs(math.sin((pos.Y - center.Y)/height))),
					center.Z + math.sin(newAngle) * math.min(r, dist)
				)
			end
			local dir = targetPos - part.Position
			if dir.Magnitude > 0.01 then
				part.Velocity = dir.Unit * attractionStrength
			end
			localPartsCount += 1
		end
	end
	lastLocalTriCount = math.max(3, localPartsCount)
	LocalPartsLabel.Text = "Parts: " .. localPartsCount
end)
-- TARGET HEARTBEAT
RunService.Heartbeat:Connect(function()
	targetPartsCount = 0
	if cursorRingEnabled or textEnabled then return end
	if (not targetRingEnabled and not targetSphereEnabled and not targetSquareEnabled) or not targetPlayer then
		TargetPartsLabel.Text = "Parts: 0"
		return
	end
	local char = targetPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local center = hrp.Position
	local total = #parts
	local r = targetRadius
	local triCounter = 0
	local baseAngle = tick() * targetRotationSpeed * 2
	local a1,a2,a3 = baseAngle, baseAngle+2.0944, baseAngle+4.1888
	local p1 = Vector3.new(center.X+math.cos(a1)*r, center.Y, center.Z+math.sin(a1)*r)
	local p2 = Vector3.new(center.X+math.cos(a2)*r, center.Y, center.Z+math.sin(a2)*r)
	local p3 = Vector3.new(center.X+math.cos(a3)*r, center.Y, center.Z+math.sin(a3)*r)
	local triEdges = {{p1,p2},{p2,p3},{p3,p1}}
	local s1,s2,s3,s4 = baseAngle, baseAngle+1.5708, baseAngle+3.1416, baseAngle+4.7124
	local sp1 = Vector3.new(center.X+math.cos(s1)*r, center.Y, center.Z+math.sin(s1)*r)
	local sp2 = Vector3.new(center.X+math.cos(s2)*r, center.Y, center.Z+math.sin(s2)*r)
	local sp3 = Vector3.new(center.X+math.cos(s3)*r, center.Y, center.Z+math.sin(s3)*r)
	local sp4 = Vector3.new(center.X+math.cos(s4)*r, center.Y, center.Z+math.sin(s4)*r)
	local squareEdges = {{sp1,sp2},{sp2,sp3},{sp3,sp4},{sp4,sp1}}
	for i, part in ipairs(parts) do
		if part.Parent and not part.Anchored and not isLocalPart(i, total) then
			if part:IsDescendantOf(char) then continue end
			triCounter += 1
			local pos = part.Position
			local angle = math.atan2(pos.Z-center.Z, pos.X-center.X)
			local newAngle = angle + math.rad(targetRotationSpeed)
			local targetPos
			if targetSphereEnabled then
				local edgeIndex = ((triCounter-1)%3)+1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount/3))
				local idxOnEdge = math.floor((triCounter-1)/3)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = triEdges[edgeIndex][1]:Lerp(triEdges[edgeIndex][2], t)
			elseif targetSquareEnabled then
				local edgeIndex = ((triCounter-1)%4)+1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount/4))
				local idxOnEdge = math.floor((triCounter-1)/4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = squareEdges[edgeIndex][1]:Lerp(squareEdges[edgeIndex][2], t)
			else
				local dist = (Vector3.new(pos.X,center.Y,pos.Z)-center).Magnitude
				targetPos = Vector3.new(
					center.X + math.cos(newAngle)*math.min(r,dist),
					center.Y + (targetHeight * math.abs(math.sin((pos.Y-center.Y)/targetHeight))),
					center.Z + math.sin(newAngle)*math.min(r,dist)
				)
			end
			local dir = targetPos - part.Position
			if dir.Magnitude > 0.01 then
				part.Velocity = dir.Unit * targetAttractionStrength
			end
			targetPartsCount += 1
		end
	end
	lastTargetTriCount = math.max(3, targetPartsCount)
	TargetPartsLabel.Text = "Parts: " .. targetPartsCount
end)
-- ==================== BUTTONS ====================
local function turnOffLocalShapes()
	ringPartsEnabled = false
	localSphereEnabled = false
	localSquareEnabled = false
	cursorRingEnabled = false
	ToggleButton.Text = "Your Ring  •  Off"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
	LocalSphereButton.Text = "Triangle  •  Off"
	LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	LocalSquareButton.Text = "Square  •  Off"
	LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	CursorButton.Text = "Cursor Follow  •  Off"
	CursorButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
end
TextToggle.MouseButton1Click:Connect(function()
	textEnabled = not textEnabled
	if textEnabled then
		turnOffLocalShapes()
		TextToggle.Text = "Super Text  •  On"
		TextToggle.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
	else
		TextToggle.Text = "Super Text  •  Off"
		TextToggle.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
	end
	playSound("12221967")
end)
ToggleButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	ringPartsEnabled = not ringPartsEnabled
	if ringPartsEnabled then
		ToggleButton.Text = "Your Ring  •  On"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
		localSphereEnabled = false
		LocalSphereButton.Text = "Triangle  •  Off"
		LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
		localSquareEnabled = false
		LocalSquareButton.Text = "Square  •  Off"
		LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	else
		ToggleButton.Text = "Your Ring  •  Off"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
	end
	playSound("12221967")
end)
LocalSphereButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if targetSphereEnabled then
		targetSphereEnabled = false
		TargetSphereButton.Text = "Triangle  •  Off"
		TargetSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	end
	localSquareEnabled = false
	LocalSquareButton.Text = "Square  •  Off"
	LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	localSphereEnabled = not localSphereEnabled
	if localSphereEnabled then
		LocalSphereButton.Text = "Triangle  •  On"
		LocalSphereButton.BackgroundColor3 = Color3.fromRGB(75, 75, 170)
		ringPartsEnabled = true
		ToggleButton.Text = "Your Ring  •  On"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
	else
		LocalSphereButton.Text = "Triangle  •  Off"
		LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	end
	playSound("12221967")
end)
LocalSquareButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if targetSquareEnabled then
		targetSquareEnabled = false
		TargetSquareButton.Text = "Square  •  Off"
		TargetSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	end
	localSphereEnabled = false
	LocalSphereButton.Text = "Triangle  •  Off"
	LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	localSquareEnabled = not localSquareEnabled
	if localSquareEnabled then
		LocalSquareButton.Text = "Square  •  On"
		LocalSquareButton.BackgroundColor3 = Color3.fromRGB(110, 70, 180)
		ringPartsEnabled = true
		ToggleButton.Text = "Your Ring  •  On"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
	else
		LocalSquareButton.Text = "Square  •  Off"
		LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	end
	playSound("12221967")
end)
CursorButton.MouseButton1Click:Connect(function()
	if textEnabled then return end
	cursorRingEnabled = not cursorRingEnabled
	if cursorRingEnabled then
		turnOffLocalShapes()
		cursorRingEnabled = true
		radius = 200
		RadiusDisplay.Text = "Radius: 200"
		CursorButton.Text = "Cursor Follow  •  On"
		CursorButton.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
	else
		CursorButton.Text = "Cursor Follow  •  Off"
		CursorButton.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
	end
	playSound("12221967")
end)
DecreaseRadius.MouseButton1Click:Connect(function()
	radius = math.max(0, radius - 5)
	RadiusDisplay.Text = "Radius: " .. radius
	playSound("12221967")
end)
IncreaseRadius.MouseButton1Click:Connect(function()
	radius = math.min(10000, radius + 5)
	RadiusDisplay.Text = "Radius: " .. radius
	playSound("12221967")
end)
-- Pixel size controls
DecreasePixel.MouseButton1Click:Connect(function()
	textPixelSize = math.max(1.5, textPixelSize - 0.5)
	PixelDisplay.Text = "Pixel Size: " .. string.format("%.1f", textPixelSize)
	currentTextPoints = getTextPoints(textString)
	playSound("12221967")
end)
IncreasePixel.MouseButton1Click:Connect(function()
	textPixelSize = math.min(12, textPixelSize + 0.5)
	PixelDisplay.Text = "Pixel Size: " .. string.format("%.1f", textPixelSize)
	currentTextPoints = getTextPoints(textString)
	playSound("12221967")
end)
local function findPlayer(name)
	if not name or name == "" then return nil end
	name = string.lower(name)
	for _, plr in pairs(Players:GetPlayers()) do
		if string.find(string.lower(plr.Name), name, 1, true)
			or string.find(string.lower(plr.DisplayName), name, 1, true) then
			return plr
		end
	end
	return nil
end
TargetToggle.MouseButton1Click:Connect(function()
	local found = targetPlayer or findPlayer(NameBox.Text)
	if not found then
		StarterGui:SetCore("SendNotification", {Title="Target Ring", Text="Player not found!", Duration=3})
		playSound("12221967")
		return
	end
	targetPlayer = found
	targetRingEnabled = not targetRingEnabled
	if targetRingEnabled then
		TargetToggle.Text = "Target Ring  •  On"
		TargetToggle.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
		targetSphereEnabled = false
		TargetSphereButton.Text = "Triangle  •  Off"
		TargetSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
		targetSquareEnabled = false
		TargetSquareButton.Text = "Square  •  Off"
		TargetSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
		StarterGui:SetCore("SendNotification", {Title="Target Ring", Text="Ringing: "..found.DisplayName, Duration=3})
	else
		TargetToggle.Text = "Target Ring  •  Off"
		TargetToggle.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
		targetPlayer = nil
	end
	playSound("12221967")
end)
TargetSphereButton.MouseButton1Click:Connect(function()
	local found = targetPlayer or findPlayer(NameBox.Text)
	if not found then
		StarterGui:SetCore("SendNotification", {Title="Target Triangle", Text="Player not found!", Duration=3})
		playSound("12221967")
		return
	end
	if localSphereEnabled then
		localSphereEnabled = false
		LocalSphereButton.Text = "Triangle  •  Off"
		LocalSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	end
	targetSquareEnabled = false
	TargetSquareButton.Text = "Square  •  Off"
	TargetSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	targetPlayer = found
	targetSphereEnabled = not targetSphereEnabled
	if targetSphereEnabled then
		TargetSphereButton.Text = "Triangle  •  On"
		TargetSphereButton.BackgroundColor3 = Color3.fromRGB(75, 75, 170)
		targetRingEnabled = true
		TargetToggle.Text = "Target Ring  •  On"
		TargetToggle.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
		StarterGui:SetCore("SendNotification", {Title="Target Triangle", Text="Triangle on: "..found.DisplayName, Duration=3})
	else
		TargetSphereButton.Text = "Triangle  •  Off"
		TargetSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	end
	playSound("12221967")
end)
TargetSquareButton.MouseButton1Click:Connect(function()
	local found = targetPlayer or findPlayer(NameBox.Text)
	if not found then
		StarterGui:SetCore("SendNotification", {Title="Target Square", Text="Player not found!", Duration=3})
		playSound("12221967")
		return
	end
	if localSquareEnabled then
		localSquareEnabled = false
		LocalSquareButton.Text = "Square  •  Off"
		LocalSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	end
	targetSphereEnabled = false
	TargetSphereButton.Text = "Triangle  •  Off"
	TargetSphereButton.BackgroundColor3 = Color3.fromRGB(55, 55, 95)
	targetPlayer = found
	targetSquareEnabled = not targetSquareEnabled
	if targetSquareEnabled then
		TargetSquareButton.Text = "Square  •  On"
		TargetSquareButton.BackgroundColor3 = Color3.fromRGB(110, 70, 180)
		targetRingEnabled = true
		TargetToggle.Text = "Target Ring  •  On"
		TargetToggle.BackgroundColor3 = Color3.fromRGB(40, 155, 70)
		StarterGui:SetCore("SendNotification", {Title="Target Square", Text="Square on: "..found.DisplayName, Duration=3})
	else
		TargetSquareButton.Text = "Square  •  Off"
		TargetSquareButton.BackgroundColor3 = Color3.fromRGB(70, 50, 110)
	end
	playSound("12221967")
end)
TargetDecrease.MouseButton1Click:Connect(function()
	targetRadius = math.max(0, targetRadius - 5)
	TargetRadiusDisplay.Text = "Radius: " .. targetRadius
	playSound("12221967")
end)
TargetIncrease.MouseButton1Click:Connect(function()
	targetRadius = math.min(10000, targetRadius + 5)
	TargetRadiusDisplay.Text = "Radius: " .. targetRadius
	playSound("12221967")
end)
-- Notifications
pcall(function()
	local userId = Players:GetUserIdFromNameAsync("Gabrieltod112")
	local content = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	StarterGui:SetCore("SendNotification", {
		Title = "gabs super ring v1.5",
		Text = "All modes + Super Text + Pixel Size",
		Icon = content,
		Duration = 5
	})
end)

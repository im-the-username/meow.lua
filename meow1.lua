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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GabsRingUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 540, 0, 420)
Main.Position = UDim2.new(0.5, -270, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(40, 40, 48)
Stroke.Thickness = 1.2

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "gab's Rings  •  v2.8"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 6)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TitleBar
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 45, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local minimized = false
local originalSize = Main.Size
MinimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Main:TweenSize(UDim2.new(0, 540, 0, 38), "Out", "Quad", 0.22, true)
		MinimizeBtn.Text = "+"
	else
		Main:TweenSize(originalSize, "Out", "Quad", 0.22, true)
		MinimizeBtn.Text = "−"
	end
	playSound("12221967")
end)

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 110, 1, -90)
TabFrame.Position = UDim2.new(0, 0, 0, 38)
TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -120, 1, -100)
Content.Position = UDim2.new(0, 115, 0, 45)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function createTabButton(name, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 34)
	btn.Position = UDim2.new(0, 5, 0, 10 + (order - 1) * 42)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(210, 210, 220)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.Parent = TabFrame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
	return btn
end

local LocalTabBtn = createTabButton("Local", 1)
local TargetTabBtn = createTabButton("Target", 2)
local TextTabBtn = createTabButton("Text", 3)
ThreeDPlusTabBtn = createTabButton("3D+", 4)

local function createPage()
	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 95)
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false
	page.Parent = Content
	return page
end

local LocalPage = createPage()
local TargetPage = createPage()
local TextPage = createPage()
ThreeDPlusPage = createPage()

local function showPage(page, activeBtn)
	LocalPage.Visible = false
	TargetPage.Visible = false
	TextPage.Visible = false
	ThreeDPlusPage.Visible = false
	page.Visible = true
	for _, btn in pairs({LocalTabBtn, TargetTabBtn, TextTabBtn, ThreeDPlusTabBtn}) do
		btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
		btn.TextColor3 = Color3.fromRGB(210, 210, 220)
	end
	activeBtn.BackgroundColor3 = Color3.fromRGB(55, 90, 160)
	activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

LocalTabBtn.MouseButton1Click:Connect(function() showPage(LocalPage, LocalTabBtn) end)
TargetTabBtn.MouseButton1Click:Connect(function() showPage(TargetPage, TargetTabBtn) end)
TextTabBtn.MouseButton1Click:Connect(function() showPage(TextPage, TextTabBtn) end)
ThreeDPlusTabBtn.MouseButton1Click:Connect(function() showPage(ThreeDPlusPage, ThreeDPlusTabBtn) end)
showPage(LocalPage, LocalTabBtn)

-- Bottom bar
local BottomBar = Instance.new("Frame")
BottomBar.Size = UDim2.new(1, 0, 0, 52)
BottomBar.Position = UDim2.new(0, 0, 1, -52)
BottomBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
BottomBar.BorderSizePixel = 0
BottomBar.Parent = Main

local BottomStroke = Instance.new("Frame")
BottomStroke.Size = UDim2.new(1, 0, 0, 1)
BottomStroke.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
BottomStroke.BorderSizePixel = 0
BottomStroke.Parent = BottomBar

local FreezeButton = Instance.new("TextButton")
FreezeButton.Size = UDim2.new(0, 140, 0, 32)
FreezeButton.Position = UDim2.new(0, 12, 0.5, -16)
FreezeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
FreezeButton.Text = "Freeze  •  Off"
FreezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeButton.Font = Enum.Font.GothamMedium
FreezeButton.TextSize = 12
FreezeButton.Parent = BottomBar
Instance.new("UICorner", FreezeButton).CornerRadius = UDim.new(0, 6)

local SpeedModeButton = Instance.new("TextButton")
SpeedModeButton.Size = UDim2.new(0, 170, 0, 32)
SpeedModeButton.Position = UDim2.new(0, 162, 0.5, -16)
SpeedModeButton.BackgroundColor3 = Color3.fromRGB(45, 90, 140)
SpeedModeButton.Text = "Mode: Smooth"
SpeedModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedModeButton.Font = Enum.Font.GothamMedium
SpeedModeButton.TextSize = 12
SpeedModeButton.Parent = BottomBar
Instance.new("UICorner", SpeedModeButton).CornerRadius = UDim.new(0, 6)

local FixedPosButton = Instance.new("TextButton")
FixedPosButton.Size = UDim2.new(0, 150, 0, 32)
FixedPosButton.Position = UDim2.new(0, 342, 0.5, -16)
FixedPosButton.BackgroundColor3 = Color3.fromRGB(40, 70, 110)
FixedPosButton.Text = "Fixed Pos  •  Off"
FixedPosButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FixedPosButton.Font = Enum.Font.GothamMedium
FixedPosButton.TextSize = 12
FixedPosButton.Parent = BottomBar
Instance.new("UICorner", FixedPosButton).CornerRadius = UDim.new(0, 6)
-- ==================== OFFSET PANEL (attached to the right of Main) ====================
Main.ClipsDescendants = false   -- important so the panel can stick out

local OffsetPanel = Instance.new("Frame")
OffsetPanel.Name = "OffsetPanel"
OffsetPanel.Size = UDim2.new(0, 78, 0, 310)
OffsetPanel.Position = UDim2.new(1, 8, 0, 45)   -- 8 pixels to the right of Main
OffsetPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
OffsetPanel.BorderSizePixel = 0
OffsetPanel.Visible = true
OffsetPanel.ZIndex = 50
OffsetPanel.Parent = Main
Instance.new("UICorner", OffsetPanel).CornerRadius = UDim.new(0, 10)

local OffsetStroke = Instance.new("UIStroke", OffsetPanel)
OffsetStroke.Color = Color3.fromRGB(40, 40, 50)
OffsetStroke.Thickness = 1.2

local OffsetTitle = Instance.new("TextLabel")
OffsetTitle.Size = UDim2.new(1, 0, 0, 22)
OffsetTitle.Position = UDim2.new(0, 0, 0, 4)
OffsetTitle.BackgroundTransparency = 1
OffsetTitle.Text = "OFFSET"
OffsetTitle.TextColor3 = Color3.fromRGB(160, 160, 180)
OffsetTitle.Font = Enum.Font.GothamBold
OffsetTitle.TextSize = 11
OffsetTitle.Parent = OffsetPanel

-- X Slider
local XLabel = Instance.new("TextLabel")
XLabel.Size = UDim2.new(1, 0, 0, 16)
XLabel.Position = UDim2.new(0, 0, 0, 28)
XLabel.BackgroundTransparency = 1
XLabel.Text = "X: 0"
XLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
XLabel.Font = Enum.Font.GothamMedium
XLabel.TextSize = 11
XLabel.Parent = OffsetPanel

local XSliderBg = Instance.new("Frame")
XSliderBg.Size = UDim2.new(0, 18, 0, 70)
XSliderBg.Position = UDim2.new(0.5, -9, 0, 48)
XSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
XSliderBg.BorderSizePixel = 0
XSliderBg.Active = true
XSliderBg.Parent = OffsetPanel
Instance.new("UICorner", XSliderBg).CornerRadius = UDim.new(0, 6)

local XSliderFill = Instance.new("Frame")
XSliderFill.Size = UDim2.new(1, 0, 0.5, 0)
XSliderFill.Position = UDim2.new(0, 0, 0.5, 0)
XSliderFill.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
XSliderFill.BorderSizePixel = 0
XSliderFill.Parent = XSliderBg
Instance.new("UICorner", XSliderFill).CornerRadius = UDim.new(0, 6)

local XKnob = Instance.new("TextButton")
XKnob.Size = UDim2.new(0, 22, 0, 14)
XKnob.Position = UDim2.new(0.5, -11, 0.5, -7)
XKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 230)
XKnob.Text = ""
XKnob.Active = true
XKnob.Parent = XSliderBg
Instance.new("UICorner", XKnob).CornerRadius = UDim.new(0, 4)

-- Y Slider
local YLabel = Instance.new("TextLabel")
YLabel.Size = UDim2.new(1, 0, 0, 16)
YLabel.Position = UDim2.new(0, 0, 0, 128)
YLabel.BackgroundTransparency = 1
YLabel.Text = "Y: 0"
YLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
YLabel.Font = Enum.Font.GothamMedium
YLabel.TextSize = 11
YLabel.Parent = OffsetPanel

local YSliderBg = Instance.new("Frame")
YSliderBg.Size = UDim2.new(0, 18, 0, 70)
YSliderBg.Position = UDim2.new(0.5, -9, 0, 148)
YSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
YSliderBg.BorderSizePixel = 0
YSliderBg.Active = true
YSliderBg.Parent = OffsetPanel
Instance.new("UICorner", YSliderBg).CornerRadius = UDim.new(0, 6)

local YSliderFill = Instance.new("Frame")
YSliderFill.Size = UDim2.new(1, 0, 0.5, 0)
YSliderFill.Position = UDim2.new(0, 0, 0.5, 0)
YSliderFill.BackgroundColor3 = Color3.fromRGB(50, 160, 100)
YSliderFill.BorderSizePixel = 0
YSliderFill.Parent = YSliderBg
Instance.new("UICorner", YSliderFill).CornerRadius = UDim.new(0, 6)

local YKnob = Instance.new("TextButton")
YKnob.Size = UDim2.new(0, 22, 0, 14)
YKnob.Position = UDim2.new(0.5, -11, 0.5, -7)
YKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 230)
YKnob.Text = ""
YKnob.Active = true
YKnob.Parent = YSliderBg
Instance.new("UICorner", YKnob).CornerRadius = UDim.new(0, 4)

-- Z Slider
local ZLabel = Instance.new("TextLabel")
ZLabel.Size = UDim2.new(1, 0, 0, 16)
ZLabel.Position = UDim2.new(0, 0, 0, 228)
ZLabel.BackgroundTransparency = 1
ZLabel.Text = "Z: 0"
ZLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
ZLabel.Font = Enum.Font.GothamMedium
ZLabel.TextSize = 11
ZLabel.Parent = OffsetPanel

local ZSliderBg = Instance.new("Frame")
ZSliderBg.Size = UDim2.new(0, 18, 0, 70)
ZSliderBg.Position = UDim2.new(0.5, -9, 0, 248)
ZSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ZSliderBg.BorderSizePixel = 0
ZSliderBg.Active = true
ZSliderBg.Parent = OffsetPanel
Instance.new("UICorner", ZSliderBg).CornerRadius = UDim.new(0, 6)

local ZSliderFill = Instance.new("Frame")
ZSliderFill.Size = UDim2.new(1, 0, 0.5, 0)
ZSliderFill.Position = UDim2.new(0, 0, 0.5, 0)
ZSliderFill.BackgroundColor3 = Color3.fromRGB(180, 90, 50)
ZSliderFill.BorderSizePixel = 0
ZSliderFill.Parent = ZSliderBg
Instance.new("UICorner", ZSliderFill).CornerRadius = UDim.new(0, 6)

local ZKnob = Instance.new("TextButton")
ZKnob.Size = UDim2.new(0, 22, 0, 14)
ZKnob.Position = UDim2.new(0.5, -11, 0.5, -7)
ZKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 230)
ZKnob.Text = ""
ZKnob.Active = true
ZKnob.Parent = ZSliderBg
Instance.new("UICorner", ZKnob).CornerRadius = UDim.new(0, 4)

-- Keep it stuck to the right side
local function updateOffsetPanelPos()
	OffsetPanel.Position = UDim2.new(1, 8, 0, 45)
	OffsetPanel.Visible = true
end
updateOffsetPanelPos()

-- ==================== PAGE BUTTONS ====================
local function makeBtn(parent, text, y, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -12, 0, 30)
	b.Position = UDim2.new(0, 6, 0, y)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 12
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

local function makeHalfBtn(parent, text, x, y, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 185, 0, 28)
	b.Position = UDim2.new(0, x, 0, y)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 12
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

local function makeLabel(parent, text, y)
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1, -12, 0, 18)
	l.Position = UDim2.new(0, 8, 0, y)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = Color3.fromRGB(140, 140, 155)
	l.Font = Enum.Font.GothamBold
	l.TextSize = 11
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Parent = parent
	return l
end

-- LOCAL PAGE
makeLabel(LocalPage, "YOUR RING", 6)
local ToggleButton = makeBtn(LocalPage, "Your Ring  •  Off", 26, Color3.fromRGB(160, 40, 40))

makeLabel(LocalPage, "SHAPES", 66)
local LocalSphereButton = makeHalfBtn(LocalPage, "Triangle  •  Off", 8, 88, Color3.fromRGB(50, 50, 90))
local LocalSquareButton = makeHalfBtn(LocalPage, "Square  •  Off", 200, 88, Color3.fromRGB(65, 45, 100))
local LocalCubeButton = makeHalfBtn(LocalPage, "Cube  •  Off", 8, 122, Color3.fromRGB(40, 70, 100))
local LocalDownConeButton = makeHalfBtn(LocalPage, "Down Cone  •  Off", 200, 122, Color3.fromRGB(90, 45, 45))
local LocalBallButton = makeHalfBtn(LocalPage, "Sphere  •  Off", 8, 156, Color3.fromRGB(30, 90, 110))
local LocalHexButton = makeHalfBtn(LocalPage, "Hexagon  •  Off", 200, 156, Color3.fromRGB(80, 50, 120))
local LocalRectButton = makeHalfBtn(LocalPage, "Rectangle  •  Off", 8, 190, Color3.fromRGB(60, 80, 50))
local LocalBoxButton = makeHalfBtn(LocalPage, "Box  •  Off", 200, 190, Color3.fromRGB(90, 60, 40))
local LocalPyramidButton = makeHalfBtn(LocalPage, "Pyramid  •  Off", 8, 224, Color3.fromRGB(100, 70, 40))
local LocalConeButton = makeHalfBtn(LocalPage, "Cone  •  Off", 200, 224, Color3.fromRGB(70, 90, 50))
local LocalOctaButton = makeHalfBtn(LocalPage, "Octahedron  •  Off", 8, 258, Color3.fromRGB(50, 80, 100))
local LocalStarButton = makeHalfBtn(LocalPage, "Star  •  Off", 200, 258, Color3.fromRGB(140, 100, 30))
local LocalPentagonButton = makeHalfBtn(LocalPage, "Pentagon  •  Off", 8, 292, Color3.fromRGB(90, 60, 110))
local LocalOctagonButton = makeHalfBtn(LocalPage, "Octagon  •  Off", 200, 292, Color3.fromRGB(60, 90, 80))
local LocalDiamondButton = makeHalfBtn(LocalPage, "Diamond  •  Off", 8, 326, Color3.fromRGB(100, 50, 80))
local LocalCrossButton = makeHalfBtn(LocalPage, "Cross  •  Off", 200, 326, Color3.fromRGB(80, 80, 50))

local CursorButton = makeBtn(LocalPage, "Cursor Follow  •  Off", 366, Color3.fromRGB(160, 40, 40))

local RadiusFrame = Instance.new("Frame")
RadiusFrame.Size = UDim2.new(1, -12, 0, 42)
RadiusFrame.Position = UDim2.new(0, 6, 0, 406)
RadiusFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
RadiusFrame.BorderSizePixel = 0
RadiusFrame.Parent = LocalPage
Instance.new("UICorner", RadiusFrame).CornerRadius = UDim.new(0, 7)

local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Size = UDim2.new(0, 34, 0, 24)
DecreaseRadius.Position = UDim2.new(0, 8, 0, 9)
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DecreaseRadius.Text = "−"
DecreaseRadius.TextColor3 = Color3.fromRGB(220, 220, 220)
DecreaseRadius.Font = Enum.Font.GothamBold
DecreaseRadius.TextSize = 16
DecreaseRadius.Parent = RadiusFrame
Instance.new("UICorner", DecreaseRadius).CornerRadius = UDim.new(0, 5)

local IncreaseRadius = Instance.new("TextButton")
IncreaseRadius.Size = UDim2.new(0, 34, 0, 24)
IncreaseRadius.Position = UDim2.new(1, -42, 0, 9)
IncreaseRadius.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
IncreaseRadius.Text = "+"
IncreaseRadius.TextColor3 = Color3.fromRGB(220, 220, 220)
IncreaseRadius.Font = Enum.Font.GothamBold
IncreaseRadius.TextSize = 16
IncreaseRadius.Parent = RadiusFrame
Instance.new("UICorner", IncreaseRadius).CornerRadius = UDim.new(0, 5)

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0, 140, 0, 24)
RadiusDisplay.Position = UDim2.new(0.5, -70, 0, 9)
RadiusDisplay.BackgroundTransparency = 1
RadiusDisplay.Text = "Radius: 50"
RadiusDisplay.TextColor3 = Color3.fromRGB(230, 230, 230)
RadiusDisplay.Font = Enum.Font.GothamMedium
RadiusDisplay.TextSize = 13
RadiusDisplay.Parent = RadiusFrame

local LocalPartsLabel = Instance.new("TextLabel")
LocalPartsLabel.Size = UDim2.new(1, 0, 0, 14)
LocalPartsLabel.Position = UDim2.new(0, 0, 0, 455)
LocalPartsLabel.BackgroundTransparency = 1
LocalPartsLabel.Text = "Parts: 0"
LocalPartsLabel.TextColor3 = Color3.fromRGB(110, 190, 130)
LocalPartsLabel.Font = Enum.Font.Gotham
LocalPartsLabel.TextSize = 11
LocalPartsLabel.Parent = LocalPage
LocalPage.CanvasSize = UDim2.new(0, 0, 0, 480)

-- TARGET PAGE
makeLabel(TargetPage, "TARGET PLAYER", 6)
local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.new(1, -12, 0, 28)
NameBox.Position = UDim2.new(0, 6, 0, 26)
NameBox.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
NameBox.Text = ""
NameBox.PlaceholderText = "Player name..."
NameBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
NameBox.TextColor3 = Color3.fromRGB(235, 235, 235)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 13
NameBox.ClearTextOnFocus = false
NameBox.Parent = TargetPage
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)

local TargetToggle = makeBtn(TargetPage, "Target Ring  •  Off", 62, Color3.fromRGB(160, 40, 40))

makeLabel(TargetPage, "TARGET SHAPES", 102)
local TargetSphereButton = makeHalfBtn(TargetPage, "Triangle  •  Off", 8, 124, Color3.fromRGB(50, 50, 90))
local TargetSquareButton = makeHalfBtn(TargetPage, "Square  •  Off", 200, 124, Color3.fromRGB(65, 45, 100))
local TargetCubeButton = makeHalfBtn(TargetPage, "Cube  •  Off", 8, 158, Color3.fromRGB(40, 70, 100))
local TargetDownConeButton = makeHalfBtn(TargetPage, "Down Cone  •  Off", 200, 158, Color3.fromRGB(90, 45, 45))
local TargetBallButton = makeHalfBtn(TargetPage, "Sphere  •  Off", 8, 192, Color3.fromRGB(30, 90, 110))
local TargetHexButton = makeHalfBtn(TargetPage, "Hexagon  •  Off", 200, 192, Color3.fromRGB(80, 50, 120))
local TargetRectButton = makeHalfBtn(TargetPage, "Rectangle  •  Off", 8, 226, Color3.fromRGB(60, 80, 50))
local TargetBoxButton = makeHalfBtn(TargetPage, "Box  •  Off", 200, 226, Color3.fromRGB(90, 60, 40))
local TargetPyramidButton = makeHalfBtn(TargetPage, "Pyramid  •  Off", 8, 260, Color3.fromRGB(100, 70, 40))
local TargetConeButton = makeHalfBtn(TargetPage, "Cone  •  Off", 200, 260, Color3.fromRGB(70, 90, 50))
local TargetOctaButton = makeHalfBtn(TargetPage, "Octahedron  •  Off", 8, 294, Color3.fromRGB(50, 80, 100))
local TargetStarButton = makeHalfBtn(TargetPage, "Star  •  Off", 200, 294, Color3.fromRGB(140, 100, 30))
local TargetPentagonButton = makeHalfBtn(TargetPage, "Pentagon  •  Off", 8, 328, Color3.fromRGB(90, 60, 110))
local TargetOctagonButton = makeHalfBtn(TargetPage, "Octagon  •  Off", 200, 328, Color3.fromRGB(60, 90, 80))
local TargetDiamondButton = makeHalfBtn(TargetPage, "Diamond  •  Off", 8, 362, Color3.fromRGB(100, 50, 80))
local TargetCrossButton = makeHalfBtn(TargetPage, "Cross  •  Off", 200, 362, Color3.fromRGB(80, 80, 50))

local TargetRadiusFrame = Instance.new("Frame")
TargetRadiusFrame.Size = UDim2.new(1, -12, 0, 42)
TargetRadiusFrame.Position = UDim2.new(0, 6, 0, 402)
TargetRadiusFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
TargetRadiusFrame.BorderSizePixel = 0
TargetRadiusFrame.Parent = TargetPage
Instance.new("UICorner", TargetRadiusFrame).CornerRadius = UDim.new(0, 7)

local TargetDecrease = Instance.new("TextButton")
TargetDecrease.Size = UDim2.new(0, 34, 0, 24)
TargetDecrease.Position = UDim2.new(0, 8, 0, 9)
TargetDecrease.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TargetDecrease.Text = "−"
TargetDecrease.TextColor3 = Color3.fromRGB(220, 220, 220)
TargetDecrease.Font = Enum.Font.GothamBold
TargetDecrease.TextSize = 16
TargetDecrease.Parent = TargetRadiusFrame
Instance.new("UICorner", TargetDecrease).CornerRadius = UDim.new(0, 5)

local TargetIncrease = Instance.new("TextButton")
TargetIncrease.Size = UDim2.new(0, 34, 0, 24)
TargetIncrease.Position = UDim2.new(1, -42, 0, 9)
TargetIncrease.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TargetIncrease.Text = "+"
TargetIncrease.TextColor3 = Color3.fromRGB(220, 220, 220)
TargetIncrease.Font = Enum.Font.GothamBold
TargetIncrease.TextSize = 16
TargetIncrease.Parent = TargetRadiusFrame
Instance.new("UICorner", TargetIncrease).CornerRadius = UDim.new(0, 5)

local TargetRadiusDisplay = Instance.new("TextLabel")
TargetRadiusDisplay.Size = UDim2.new(0, 140, 0, 24)
TargetRadiusDisplay.Position = UDim2.new(0.5, -70, 0, 9)
TargetRadiusDisplay.BackgroundTransparency = 1
TargetRadiusDisplay.Text = "Radius: 50"
TargetRadiusDisplay.TextColor3 = Color3.fromRGB(230, 230, 230)
TargetRadiusDisplay.Font = Enum.Font.GothamMedium
TargetRadiusDisplay.TextSize = 13
TargetRadiusDisplay.Parent = TargetRadiusFrame

local TargetPartsLabel = Instance.new("TextLabel")
TargetPartsLabel.Size = UDim2.new(1, 0, 0, 14)
TargetPartsLabel.Position = UDim2.new(0, 0, 0, 450)
TargetPartsLabel.BackgroundTransparency = 1
TargetPartsLabel.Text = "Parts: 0"
TargetPartsLabel.TextColor3 = Color3.fromRGB(200, 150, 90)
TargetPartsLabel.Font = Enum.Font.Gotham
TargetPartsLabel.TextSize = 11
TargetPartsLabel.Parent = TargetPage
TargetPage.CanvasSize = UDim2.new(0, 0, 0, 480)

-- TEXT PAGE
makeLabel(TextPage, "SUPER TEXT", 6)
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -12, 0, 28)
TextBox.Position = UDim2.new(0, 6, 0, 26)
TextBox.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
TextBox.Text = "GABS"
TextBox.PlaceholderText = "Type text..."
TextBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
TextBox.TextColor3 = Color3.fromRGB(235, 235, 235)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 13
TextBox.ClearTextOnFocus = false
TextBox.Parent = TextPage
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local TextToggle = makeBtn(TextPage, "Super Text  •  Off", 62, Color3.fromRGB(160, 40, 40))

local PixelFrame = Instance.new("Frame")
PixelFrame.Size = UDim2.new(1, -12, 0, 42)
PixelFrame.Position = UDim2.new(0, 6, 0, 100)
PixelFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
PixelFrame.BorderSizePixel = 0
PixelFrame.Parent = TextPage
Instance.new("UICorner", PixelFrame).CornerRadius = UDim.new(0, 7)

local DecreasePixel = Instance.new("TextButton")
DecreasePixel.Size = UDim2.new(0, 34, 0, 24)
DecreasePixel.Position = UDim2.new(0, 8, 0, 9)
DecreasePixel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DecreasePixel.Text = "−"
DecreasePixel.TextColor3 = Color3.fromRGB(220, 220, 220)
DecreasePixel.Font = Enum.Font.GothamBold
DecreasePixel.TextSize = 16
DecreasePixel.Parent = PixelFrame
Instance.new("UICorner", DecreasePixel).CornerRadius = UDim.new(0, 5)

local IncreasePixel = Instance.new("TextButton")
IncreasePixel.Size = UDim2.new(0, 34, 0, 24)
IncreasePixel.Position = UDim2.new(1, -42, 0, 9)
IncreasePixel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
IncreasePixel.Text = "+"
IncreasePixel.TextColor3 = Color3.fromRGB(220, 220, 220)
IncreasePixel.Font = Enum.Font.GothamBold
IncreasePixel.TextSize = 16
IncreasePixel.Parent = PixelFrame
Instance.new("UICorner", IncreasePixel).CornerRadius = UDim.new(0, 5)

local PixelDisplay = Instance.new("TextLabel")
PixelDisplay.Size = UDim2.new(0, 140, 0, 24)
PixelDisplay.Position = UDim2.new(0.5, -70, 0, 9)
PixelDisplay.BackgroundTransparency = 1
PixelDisplay.Text = "Pixel Size: 4.5"
PixelDisplay.TextColor3 = Color3.fromRGB(230, 230, 230)
PixelDisplay.Font = Enum.Font.GothamMedium
PixelDisplay.TextSize = 13
PixelDisplay.Parent = PixelFrame
TextPage.CanvasSize = UDim2.new(0, 0, 0, 160)

-- ==================== 3D+ PAGE ====================
-- One compact, scrollable page keeps the extra UI well below the usual 200-instance
-- problem while still giving the 3D+ tab a large shape library.
makeLabel(ThreeDPlusPage, "3D+ SHAPE LIBRARY", 6)
ThreeDPlusInfo = Instance.new("TextLabel")
ThreeDPlusInfo.Size = UDim2.new(1, -12, 0, 30)
ThreeDPlusInfo.Position = UDim2.new(0, 6, 0, 24)
ThreeDPlusInfo.BackgroundTransparency = 1
ThreeDPlusInfo.Text = "Select one • 3D+ uses your Local ring parts"
ThreeDPlusInfo.TextColor3 = Color3.fromRGB(120, 160, 210)
ThreeDPlusInfo.Font = Enum.Font.Gotham
ThreeDPlusInfo.TextSize = 11
ThreeDPlusInfo.TextXAlignment = Enum.TextXAlignment.Left
ThreeDPlusInfo.Parent = ThreeDPlusPage

ThreeDPlusButtons = {}
ThreeDPlusShapeNames = {
	"Broken button(dont touch)", "Triangular Prism", "Pentagonal Prism", "Hexagonal Prism",
	"Octagonal Prism", "Decagonal Prism", "Dodecagonal Prism", "Cylinder",
	"Triangular Bipyramid", "Pentagonal Bipyramid", "Hexagonal Bipyramid", "Pentagonal Pyramid",
	"Hexagonal Pyramid", "Heptagonal Pyramid", "Octagonal Pyramid", "Icosahedron",
	"Dodecahedron", "Torus", "Helix", "Double Helix",
	"Spring", "Heart Prism", "Star Prism", "Hexagram Prism",
	"Arrow Prism", "Cross Prism 3D", "Capsule", "Hourglass",
	"Spherical Cage", "Geodesic Sphere"
}

for i, shapeName in ipairs(ThreeDPlusShapeNames) do
	local col = (i - 1) % 2
	local row = math.floor((i - 1) / 2)
	local b = makeHalfBtn(
		ThreeDPlusPage,
		shapeName .. "  •  Off",
		8 + col * 192,
		58 + row * 34,
		Color3.fromRGB(45 + ((i * 17) % 45), 55 + ((i * 11) % 45), 85 + ((i * 19) % 55))
	)
	ThreeDPlusButtons[shapeName] = b
end

ThreeDPlusStatus = Instance.new("TextLabel")
ThreeDPlusStatus.Size = UDim2.new(1, -12, 0, 18)
ThreeDPlusStatus.Position = UDim2.new(0, 8, 0, 58 + math.ceil(#ThreeDPlusShapeNames / 2) * 34 + 4)
ThreeDPlusStatus.BackgroundTransparency = 1
ThreeDPlusStatus.Text = "Selected: None"
ThreeDPlusStatus.TextColor3 = Color3.fromRGB(110, 190, 130)
ThreeDPlusStatus.Font = Enum.Font.Gotham
ThreeDPlusStatus.TextSize = 11
ThreeDPlusStatus.TextXAlignment = Enum.TextXAlignment.Left
ThreeDPlusStatus.Parent = ThreeDPlusPage
ThreeDPlusPage.CanvasSize = UDim2.new(0, 0, 0, 58 + math.ceil(#ThreeDPlusShapeNames / 2) * 34 + 35)

-- Dragging (also moves OffsetPanel)
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		updateOffsetPanelPos()
	end
end)

-- ==================== LOGIC ====================
local radius = 50
local height = 100
local rotationSpeed = 0.65
local attractionStrength = 1100
local ringPartsEnabled = false
local localSphereEnabled = false
local localSquareEnabled = false
local localCubeEnabled = false
local localDownConeEnabled = false
local localBallEnabled = false
local localHexEnabled = false
local localRectEnabled = false
local localBoxEnabled = false
local localPyramidEnabled = false
local localConeEnabled = false
local localOctaEnabled = false
local localStarEnabled = false
local localPentagonEnabled = false
local localOctagonEnabled = false
local localDiamondEnabled = false
local localCrossEnabled = false
threeDPlusShape = nil
local freezeEnabled = false
local smoothMode = true
local shapeSpinSpeed = 0.20

local fixedPosEnabled = false
local fixedBasePosition = nil
local fixedOffsetX = 0
local fixedOffsetY = 0
local fixedOffsetZ = 0
local fixedMarker = nil

local targetRadius = 50
local targetRingEnabled = false
local targetSphereEnabled = false
local targetSquareEnabled = false
local targetCubeEnabled = false
local targetDownConeEnabled = false
local targetBallEnabled = false
local targetHexEnabled = false
local targetRectEnabled = false
local targetBoxEnabled = false
local targetPyramidEnabled = false
local targetConeEnabled = false
local targetOctaEnabled = false
local targetStarEnabled = false
local targetPentagonEnabled = false
local targetOctagonEnabled = false
local targetDiamondEnabled = false
local targetCrossEnabled = false
local targetPlayer = nil
local targetHeight = 100
local targetRotationSpeed = 0.65
local targetAttractionStrength = 1100

local cursorRingEnabled = false
local cursorOrbitRadius = 5.2
local cursorRotationSpeed = 1.6
local cursorAttraction = 420
local maxCursorDistance = 200
local minDistanceFromSelf = 10

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
local frozenAngle = 0
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
	["🥖"] = {"0011111100","0111111110","1111111111","0111111110","0011111100"},
	["@"] = {"0011111100","0111111110","1111111111","0111111110","0011111100"},
	["❤️"] = {"01100110","11111111","11111111","01111110","00111100","00011000","00000000"},
	["❤"] = {"01100110","11111111","11111111","01111110","00111100","00011000","00000000"},
	["🔥"] = {"00010000","00111000","01111100","01111110","11111111","01111110","00111000"},
	["💀"] = {"01111110","11111111","11011011","11111111","01111110","00100100","00111100"},
	["😂"] = {"01111110","10000001","10100101","10000001","10111101","10000001","01111110"},
	["🍕"] = {"00010000","00111000","01111100","11111110","11111111","01111110","00111000"},
	["⭐"] = {"00010000","00111000","11111111","01111110","00111000","01010100","10000010"},
	["★"] = {"00010000","00111000","11111111","01111110","00111000","01010100","10000010"},
	["😎"] = {"01111110","10000001","11100111","10000001","10111101","10000001","01111110"},
	["👍"] = {"00110000","00110000","00111110","11111111","11111111","01111110","00111100"},
	["💯"] = {"10001001","10001001","10001001","11111001","10001001","10001001","10001111"},
	["✨"] = {"00010000","01010100","00111000","11111111","00111000","01010100","00010000"},
}

local function getTextPoints(str)
	str = tostring(str or "")
	local points = {}
	local cursorX = 0
	local gap = 1.5
	for _, code in utf8.codes(str) do
		local char = utf8.char(code)
		local rows = Font[char] or Font[string.upper(char)] or Font[" "]
		local h = #rows
		local w = #rows[1]
		for row = 1, h do
			local line = rows[row]
			for col = 1, #line do
				if string.sub(line, col, col) == "1" then
					table.insert(points, Vector3.new((cursorX + (col - 1)) * textPixelSize, (h - row) * textPixelSize, 0))
				end
			end
		end
		cursorX = cursorX + w + gap
	end
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
	return textEnabled or ringPartsEnabled or localSphereEnabled or localSquareEnabled or localCubeEnabled or localDownConeEnabled or localBallEnabled
		or localHexEnabled or localRectEnabled or localBoxEnabled or localPyramidEnabled or localConeEnabled or localOctaEnabled or localStarEnabled
		or localPentagonEnabled or localOctagonEnabled or localDiamondEnabled or localCrossEnabled or threeDPlusShape ~= nil
		or cursorRingEnabled or targetRingEnabled or targetSphereEnabled or targetSquareEnabled or targetCubeEnabled or targetDownConeEnabled or targetBallEnabled
		or targetHexEnabled or targetRectEnabled or targetBoxEnabled or targetPyramidEnabled or targetConeEnabled or targetOctaEnabled or targetStarEnabled
		or targetPentagonEnabled or targetOctagonEnabled or targetDiamondEnabled or targetCrossEnabled
end

RunService.Heartbeat:Connect(function()
	getgenv().Network.Active = not anyShapeActive()
end)

local function isLocalPart(index, total)
	if cursorRingEnabled or textEnabled then return true end
	if not targetRingEnabled and not targetSphereEnabled and not targetSquareEnabled and not targetCubeEnabled and not targetDownConeEnabled and not targetBallEnabled
		and not targetHexEnabled and not targetRectEnabled and not targetBoxEnabled and not targetPyramidEnabled and not targetConeEnabled and not targetOctaEnabled and not targetStarEnabled
		and not targetPentagonEnabled and not targetOctagonEnabled and not targetDiamondEnabled and not targetCrossEnabled then return true end
	if not ringPartsEnabled and not localSphereEnabled and not localSquareEnabled and not localCubeEnabled and not localDownConeEnabled and not localBallEnabled
		and not localHexEnabled and not localRectEnabled and not localBoxEnabled and not localPyramidEnabled and not localConeEnabled and not localOctaEnabled and not localStarEnabled
		and not localPentagonEnabled and not localOctagonEnabled and not localDiamondEnabled and not localCrossEnabled and threeDPlusShape == nil then return false end
	return index <= math.floor(total * 0.7)
end

local function applyVelocity(part, targetPos, strength)
	local dir = targetPos - part.Position
	local mag = dir.Magnitude
	if smoothMode then
		if mag > 0.22 then
			part.Velocity = dir.Unit * math.min(strength, mag * 20)
		elseif mag > 0.06 then
			part.Velocity = dir.Unit * (mag * 11)
		else
			part.Velocity = Vector3.zero
			part.AssemblyLinearVelocity = Vector3.zero
		end
	else
		if mag > 0.12 then
			part.Velocity = dir.Unit * math.min(strength * 1.8, mag * 38)
		elseif mag > 0.04 then
			part.Velocity = dir.Unit * (mag * 22)
		else
			part.Velocity = Vector3.zero
			part.AssemblyLinearVelocity = Vector3.zero
		end
	end
end

function getCubeEdges(center, size, angle)
	local s = size / 2
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function makeVert(ox, oy, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y + oy, center.Z + rz)
	end
	local v = {
		makeVert(-s,-s,-s), makeVert(s,-s,-s), makeVert(s,-s,s), makeVert(-s,-s,s),
		makeVert(-s,s,-s), makeVert(s,s,-s), makeVert(s,s,s), makeVert(-s,s,s)
	}
	return {
		{v[1],v[2]},{v[2],v[3]},{v[3],v[4]},{v[4],v[1]},
		{v[5],v[6]},{v[6],v[7]},{v[7],v[8]},{v[8],v[5]},
		{v[1],v[5]},{v[2],v[6]},{v[3],v[7]},{v[4],v[8]}
	}
end

function getHexEdges(center, radius, angle)
	local edges = {}
	for i = 0, 5 do
		local a1 = angle + (i / 6) * math.pi * 2
		local a2 = angle + ((i + 1) / 6) * math.pi * 2
		local p1 = Vector3.new(center.X + math.cos(a1) * radius, center.Y, center.Z + math.sin(a1) * radius)
		local p2 = Vector3.new(center.X + math.cos(a2) * radius, center.Y, center.Z + math.sin(a2) * radius)
		table.insert(edges, {p1, p2})
	end
	return edges
end

function getRectEdges(center, width, depth, angle)
	local hw, hd = width / 2, depth / 2
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y, center.Z + rz)
	end
	local v1 = make(-hw, -hd)
	local v2 = make( hw, -hd)
	local v3 = make( hw,  hd)
	local v4 = make(-hw,  hd)
	return {{v1,v2},{v2,v3},{v3,v4},{v4,v1}}
end

function getBoxEdges(center, sx, sy, sz, angle)
	local hx, hy, hz = sx / 2, sy / 2, sz / 2
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oy, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y + oy, center.Z + rz)
	end
	local v = {
		make(-hx,-hy,-hz), make(hx,-hy,-hz), make(hx,-hy,hz), make(-hx,-hy,hz),
		make(-hx, hy,-hz), make(hx, hy,-hz), make(hx, hy,hz), make(-hx, hy,hz)
	}
	return {
		{v[1],v[2]},{v[2],v[3]},{v[3],v[4]},{v[4],v[1]},
		{v[5],v[6]},{v[6],v[7]},{v[7],v[8]},{v[8],v[5]},
		{v[1],v[5]},{v[2],v[6]},{v[3],v[7]},{v[4],v[8]}
	}
end

function getPyramidEdges(center, size, angle)
	local s = size / 2
	local h = size * 0.9
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oy, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y + oy, center.Z + rz)
	end
	local base = {
		make(-s, -h*0.3, -s), make(s, -h*0.3, -s),
		make(s, -h*0.3, s), make(-s, -h*0.3, s)
	}
	local apex = make(0, h*0.7, 0)
	return {
		{base[1], base[2]}, {base[2], base[3]}, {base[3], base[4]}, {base[4], base[1]},
		{base[1], apex}, {base[2], apex}, {base[3], apex}, {base[4], apex}
	}
end

function getOctaEdges(center, size, angle)
	local s = size * 0.75
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oy, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y + oy, center.Z + rz)
	end
	local top = make(0, s, 0)
	local bot = make(0, -s, 0)
	local eq = {
		make(s, 0, 0), make(0, 0, s),
		make(-s, 0, 0), make(0, 0, -s)
	}
	return {
		{top, eq[1]}, {top, eq[2]}, {top, eq[3]}, {top, eq[4]},
		{bot, eq[1]}, {bot, eq[2]}, {bot, eq[3]}, {bot, eq[4]},
		{eq[1], eq[2]}, {eq[2], eq[3]}, {eq[3], eq[4]}, {eq[4], eq[1]}
	}
end

function getStarEdges(center, radius, angle)
	local edges = {}
	local outer = radius
	local inner = radius * 0.4
	local points = {}
	for i = 0, 9 do
		local a = angle + (i / 10) * math.pi * 2 - math.pi / 2
		local r = (i % 2 == 0) and outer or inner
		table.insert(points, Vector3.new(center.X + math.cos(a) * r, center.Y, center.Z + math.sin(a) * r))
	end
	for i = 1, 10 do
		local next = (i % 10) + 1
		table.insert(edges, {points[i], points[next]})
	end
	return edges
end

function getConeEdges(center, radius, height, angle, upsideDown)
	local edges = {}
	local segments = 12
	local baseY = upsideDown and (center.Y + height * 0.4) or (center.Y - height * 0.4)
	local apexY = upsideDown and (center.Y - height * 0.5) or (center.Y + height * 0.5)
	local apex = Vector3.new(center.X, apexY, center.Z)
	local basePoints = {}
	for i = 0, segments - 1 do
		local a = angle + (i / segments) * math.pi * 2
		local p = Vector3.new(center.X + math.cos(a) * radius, baseY, center.Z + math.sin(a) * radius)
		table.insert(basePoints, p)
	end
	for i = 1, segments do
		local next = (i % segments) + 1
		table.insert(edges, {basePoints[i], basePoints[next]})
	end
	for i = 1, segments do
		table.insert(edges, {basePoints[i], apex})
	end
	return edges
end

function getPentagonEdges(center, radius, angle)
	local edges = {}
	for i = 0, 4 do
		local a1 = angle + (i / 5) * math.pi * 2 - math.pi / 2
		local a2 = angle + ((i + 1) / 5) * math.pi * 2 - math.pi / 2
		local p1 = Vector3.new(center.X + math.cos(a1) * radius, center.Y, center.Z + math.sin(a1) * radius)
		local p2 = Vector3.new(center.X + math.cos(a2) * radius, center.Y, center.Z + math.sin(a2) * radius)
		table.insert(edges, {p1, p2})
	end
	return edges
end

function getOctagonEdges(center, radius, angle)
	local edges = {}
	for i = 0, 7 do
		local a1 = angle + (i / 8) * math.pi * 2
		local a2 = angle + ((i + 1) / 8) * math.pi * 2
		local p1 = Vector3.new(center.X + math.cos(a1) * radius, center.Y, center.Z + math.sin(a1) * radius)
		local p2 = Vector3.new(center.X + math.cos(a2) * radius, center.Y, center.Z + math.sin(a2) * radius)
		table.insert(edges, {p1, p2})
	end
	return edges
end

function getDiamondEdges(center, radius, angle)
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y, center.Z + rz)
	end
	local v1 = make(0, -radius)
	local v2 = make(radius * 0.7, 0)
	local v3 = make(0, radius)
	local v4 = make(-radius * 0.7, 0)
	return {{v1,v2},{v2,v3},{v3,v4},{v4,v1}}
end

function getCrossEdges(center, radius, angle)
	local cosA = math.cos(angle)
	local sinA = math.sin(angle)
	local function rotate(x, z) return x * cosA - z * sinA, x * sinA + z * cosA end
	local function make(ox, oz)
		local rx, rz = rotate(ox, oz)
		return Vector3.new(center.X + rx, center.Y, center.Z + rz)
	end
	local t = radius * 0.25
	local s = radius
	return {
		{make(-t, -s), make(t, -s)}, {make(t, -s), make(t, -t)},
		{make(t, -t), make(s, -t)}, {make(s, -t), make(s, t)},
		{make(s, t), make(t, t)}, {make(t, t), make(t, s)},
		{make(t, s), make(-t, s)}, {make(-t, s), make(-t, t)},
		{make(-t, t), make(-s, t)}, {make(-s, t), make(-s, -t)},
		{make(-s, -t), make(-t, -t)}, {make(-t, -t), make(-t, -s)}
	}
end

local function getSpherePoints(center, radius, angleOffset)
	local points = {}
	local numPoints = 72
	local goldenAngle = math.pi * (3 - math.sqrt(5))
	for i = 0, numPoints - 1 do
		local y = 1 - (i / (numPoints - 1)) * 2
		local radiusAtY = math.sqrt(1 - y * y)
		local theta = goldenAngle * i + angleOffset
		local x = math.cos(theta) * radiusAtY
		local z = math.sin(theta) * radiusAtY
		table.insert(points, center + Vector3.new(x, y, z) * radius)
	end
	return points
end

-- ==================== 3D+ GEOMETRY ====================
local Shape3D = {}
function Shape3D.rotate3DPoint(center, x, y, z, angle)
	local c = math.cos(angle)
	local s = math.sin(angle)
	return Vector3.new(center.X + x * c - z * s, center.Y + y, center.Z + x * s + z * c)
end

function Shape3D.addEdge(edges, a, b)
	if (a - b).Magnitude > 0.001 then
		table.insert(edges, {a, b})
	end
end

function Shape3D.getRegularPolygonPoints(center, radius, y, sides, angle)
	local pts = {}
	for i = 0, sides - 1 do
		local a = angle + (i / sides) * math.pi * 2 - math.pi / 2
		table.insert(pts, Vector3.new(center.X + math.cos(a) * radius, center.Y + y, center.Z + math.sin(a) * radius))
	end
	return pts
end

function Shape3D.getPrismEdges3D(center, radius, height, sides, angle)
	local edges = {}
	local top = Shape3D.getRegularPolygonPoints(center, radius, height * 0.5, sides, angle)
	local bottom = Shape3D.getRegularPolygonPoints(center, radius, -height * 0.5, sides, angle)
	for i = 1, sides do
		local n = (i % sides) + 1
		Shape3D.addEdge(edges, top[i], top[n])
		Shape3D.addEdge(edges, bottom[i], bottom[n])
		Shape3D.addEdge(edges, top[i], bottom[i])
	end
	return edges
end

function Shape3D.getPyramidEdges3D(center, radius, height, sides, angle)
	local edges = {}
	local base = Shape3D.getRegularPolygonPoints(center, radius, -height * 0.5, sides, angle)
	local apex = Vector3.new(center.X, center.Y + height * 0.5, center.Z)
	for i = 1, sides do
		local n = (i % sides) + 1
		Shape3D.addEdge(edges, base[i], base[n])
		Shape3D.addEdge(edges, base[i], apex)
	end
	return edges
end

function Shape3D.getBipyramidEdges3D(center, radius, height, sides, angle)
	local edges = {}
	local ring = Shape3D.getRegularPolygonPoints(center, radius, 0, sides, angle)
	local top = Vector3.new(center.X, center.Y + height * 0.5, center.Z)
	local bottom = Vector3.new(center.X, center.Y - height * 0.5, center.Z)
	for i = 1, sides do
		local n = (i % sides) + 1
		Shape3D.addEdge(edges, ring[i], ring[n])
		Shape3D.addEdge(edges, ring[i], top)
		Shape3D.addEdge(edges, ring[i], bottom)
	end
	return edges
end

function Shape3D.getTorusEdges3D(center, majorRadius, minorRadius, majorSegments, minorSegments, angle)
	local edges = {}
	local rings = {}
	for i = 0, majorSegments - 1 do
		local u = angle + (i / majorSegments) * math.pi * 2
		local ring = {}
		for j = 0, minorSegments - 1 do
			local v = (j / minorSegments) * math.pi * 2
			local radial = majorRadius + minorRadius * math.cos(v)
			local x = math.cos(u) * radial
			local y = math.sin(v) * minorRadius
			local z = math.sin(u) * radial
			table.insert(ring, center + Vector3.new(x, y, z))
		end
		table.insert(rings, ring)
	end
	for i = 1, majorSegments do
		local ni = (i % majorSegments) + 1
		for j = 1, minorSegments do
			local nj = (j % minorSegments) + 1
			Shape3D.addEdge(edges, rings[i][j], rings[ni][j])
			Shape3D.addEdge(edges, rings[i][j], rings[i][nj])
		end
	end
	return edges
end

function Shape3D.getHelixEdges3D(center, radius, height, turns, segments, angle, doubleHelix)
	local edges = {}
	local paths = doubleHelix and 2 or 1
	for strand = 0, paths - 1 do
		local previous = nil
		for i = 0, segments do
			local t = i / segments
			local a = angle + t * turns * math.pi * 2 + strand * math.pi
			local p = center + Vector3.new(math.cos(a) * radius, (t - 0.5) * height, math.sin(a) * radius)
			if previous then Shape3D.addEdge(edges, previous, p) end
			previous = p
		end
	end
	if doubleHelix then
		for i = 0, segments, 4 do
			local t = i / segments
			local a = angle + t * turns * math.pi * 2
			local p1 = center + Vector3.new(math.cos(a) * radius, (t - 0.5) * height, math.sin(a) * radius)
			local p2 = center + Vector3.new(math.cos(a + math.pi) * radius, (t - 0.5) * height, math.sin(a + math.pi) * radius)
			Shape3D.addEdge(edges, p1, p2)
		end
	end
	return edges
end

function Shape3D.getSpringEdges3D(center, radius, height, turns, segments, angle)
	local edges = {}
	local previous = nil
	for i = 0, segments do
		local t = i / segments
		local a = angle + t * turns * math.pi * 2
		local p = center + Vector3.new(math.cos(a) * radius, (t - 0.5) * height, math.sin(a) * radius)
		if previous then Shape3D.addEdge(edges, previous, p) end
		previous = p
	end
	local top = Shape3D.getRegularPolygonPoints(center, radius * 0.45, height * 0.5, 8, angle)
	local bottom = Shape3D.getRegularPolygonPoints(center, radius * 0.45, -height * 0.5, 8, angle)
	for i = 1, 8 do
		local n = (i % 8) + 1
		Shape3D.addEdge(edges, top[i], top[n])
		Shape3D.addEdge(edges, bottom[i], bottom[n])
	end
	return edges
end

function Shape3D.getHeartPrismEdges3D(center, scale, depth, angle)
	local edges = {}
	local front, back = {}, {}
	local points = 24
	for i = 0, points - 1 do
		local t = (i / points) * math.pi * 2
		local x = 16 * math.sin(t)^3
		local y = 13 * math.cos(t) - 5 * math.cos(2*t) - 2 * math.cos(3*t) - math.cos(4*t)
		local z = depth * 0.5
		front[i + 1] = Shape3D.rotate3DPoint(center, x * scale / 16, y * scale / 16, z, angle)
		back[i + 1] = Shape3D.rotate3DPoint(center, x * scale / 16, y * scale / 16, -z, angle)
	end
	for i = 1, points do
		local n = (i % points) + 1
		Shape3D.addEdge(edges, front[i], front[n])
		Shape3D.addEdge(edges, back[i], back[n])
		Shape3D.addEdge(edges, front[i], back[i])
	end
	return edges
end

function Shape3D.getStarPrismEdges3D(center, outerRadius, innerRadius, depth, points, angle)
	local edges = {}
	local count = points * 2
	local front, back = {}, {}
	for i = 0, count - 1 do
		local a = angle + (i / count) * math.pi * 2 - math.pi / 2
		local r = (i % 2 == 0) and outerRadius or innerRadius
		front[i + 1] = Vector3.new(center.X + math.cos(a) * r, center.Y + depth * 0.5, center.Z + math.sin(a) * r)
		back[i + 1] = Vector3.new(center.X + math.cos(a) * r, center.Y - depth * 0.5, center.Z + math.sin(a) * r)
	end
	for i = 1, count do
		local n = (i % count) + 1
		Shape3D.addEdge(edges, front[i], front[n])
		Shape3D.addEdge(edges, back[i], back[n])
		Shape3D.addEdge(edges, front[i], back[i])
	end
	return edges
end

function Shape3D.getArrowPrismEdges3D(center, size, depth, angle)
	local pts = {
		{-1.0, -0.35}, {0.0, -0.35}, {0.0, -0.75}, {1.25, 0.0},
		{0.0, 0.75}, {0.0, 0.35}, {-1.0, 0.35}
	}
	local edges = {}
	local front, back = {}, {}
	for i, p in ipairs(pts) do
		front[i] = Shape3D.rotate3DPoint(center, p[1] * size, p[2] * size, depth * 0.5, angle)
		back[i] = Shape3D.rotate3DPoint(center, p[1] * size, p[2] * size, -depth * 0.5, angle)
	end
	for i = 1, #pts do
		local n = (i % #pts) + 1
		Shape3D.addEdge(edges, front[i], front[n])
		Shape3D.addEdge(edges, back[i], back[n])
		Shape3D.addEdge(edges, front[i], back[i])
	end
	return edges
end

function Shape3D.getCrossPrismEdges3D(center, radius, depth, angle)
	local t = radius * 0.28
	local s = radius
	local pts = {
		{-t,-s},{t,-s},{t,-t},{s,-t},{s,t},{t,t},{t,s},{-t,s},
		{-t,t},{-s,t},{-s,-t},{-t,-t}
	}
	local edges = {}
	local front, back = {}, {}
	for i, p in ipairs(pts) do
		front[i] = Shape3D.rotate3DPoint(center, p[1], p[2], depth * 0.5, angle)
		back[i] = Shape3D.rotate3DPoint(center, p[1], p[2], -depth * 0.5, angle)
	end
	for i = 1, #pts do
		local n = (i % #pts) + 1
		Shape3D.addEdge(edges, front[i], front[n])
		Shape3D.addEdge(edges, back[i], back[n])
		Shape3D.addEdge(edges, front[i], back[i])
	end
	return edges
end

function Shape3D.getCapsuleEdges3D(center, radius, height, segments, angle)
	local edges = {}
	local rings = {}
	local ringCount = 7
	for k = 0, ringCount - 1 do
		local t = k / (ringCount - 1)
		local y = (t - 0.5) * height
		local rr = radius
		if t < 0.22 then
			local q = (t / 0.22) * math.pi * 0.5
			y = -height * 0.5 + math.sin(q) * radius
			rr = math.cos(q) * radius
		elseif t > 0.78 then
			local q = ((1 - t) / 0.22) * math.pi * 0.5
			y = height * 0.5 - math.sin(q) * radius
			rr = math.cos(q) * radius
		else
			y = -height * 0.5 + radius + (t - 0.22) / 0.56 * (height - 2 * radius)
		end
		local ring = Shape3D.getRegularPolygonPoints(center, math.max(rr, 0.08), y, segments, angle)
		table.insert(rings, ring)
	end
	for k = 1, #rings do
		local ring = rings[k]
		for j = 1, #ring do
			local n = (j % #ring) + 1
			Shape3D.addEdge(edges, ring[j], ring[n])
			if k < #rings then Shape3D.addEdge(edges, ring[j], rings[k + 1][j]) end
		end
	end
	return edges
end

function Shape3D.getHourglassEdges3D(center, radius, height, segments, angle)
	local edges = {}
	local rings = {}
	for k = 0, 6 do
		local t = k / 6
		local y = (t - 0.5) * height
		local rr = radius * (0.28 + 0.72 * math.abs(2 * t - 1)^0.65)
		table.insert(rings, Shape3D.getRegularPolygonPoints(center, rr, y, segments, angle))
	end
	for k = 1, #rings do
		for j = 1, segments do
			local n = (j % segments) + 1
			Shape3D.addEdge(edges, rings[k][j], rings[k][n])
			if k < #rings then Shape3D.addEdge(edges, rings[k][j], rings[k + 1][j]) end
		end
	end
	return edges
end

function Shape3D.getSphericalCageEdges3D(center, radius, angle)
	local edges = {}
	local rings = {5, 7, 9, 11}
	local ringPoints = {}
	for k, sides in ipairs(rings) do
		local t = k / (#rings + 1)
		local y = (0.5 - t) * radius * 1.7
		local rr = math.sqrt(math.max(0, radius * radius - y * y))
		ringPoints[k] = Shape3D.getRegularPolygonPoints(center, rr, y, sides, angle + k * 0.31)
	end
	for k = 1, #ringPoints do
		for j = 1, #ringPoints[k] do
			local n = (j % #ringPoints[k]) + 1
			Shape3D.addEdge(edges, ringPoints[k][j], ringPoints[k][n])
		end
		if k < #ringPoints then
			for j = 1, #ringPoints[k] do
				local a = ringPoints[k][j]
				local best, bestD = nil, math.huge
				for q = 1, #ringPoints[k + 1] do
					local d = (a - ringPoints[k + 1][q]).Magnitude
					if d < bestD then bestD, best = d, ringPoints[k + 1][q] end
				end
				if best then Shape3D.addEdge(edges, a, best) end
			end
		end
	end
	local top = Vector3.new(center.X, center.Y + radius, center.Z)
	local bottom = Vector3.new(center.X, center.Y - radius, center.Z)
	for _, p in ipairs(ringPoints[1]) do Shape3D.addEdge(edges, p, top) end
	for _, p in ipairs(ringPoints[#ringPoints]) do Shape3D.addEdge(edges, p, bottom) end
	return edges
end

function Shape3D.getPolyhedronEdgesFromVertices(center, vertices, angle)
	local pts = {}
	for _, v in ipairs(vertices) do
		table.insert(pts, Shape3D.rotate3DPoint(center, v[1], v[2], v[3], angle))
	end
	local distances = {}
	for i = 1, #pts do
		for j = i + 1, #pts do
			local d = (pts[i] - pts[j]).Magnitude
			if d > 0.001 then table.insert(distances, d) end
		end
	end
	table.sort(distances)
	local edgeLength = distances[1]
	-- Find a stable minimum non-zero length, then allow a tiny tolerance for float math.
	local tol = math.max(0.01, edgeLength * 0.08)
	local edges = {}
	for i = 1, #pts do
		for j = i + 1, #pts do
			local d = (pts[i] - pts[j]).Magnitude
			if math.abs(d - edgeLength) <= tol then Shape3D.addEdge(edges, pts[i], pts[j]) end
		end
	end
	return edges
end

function Shape3D.getIcosahedronEdges3D(center, size, angle)
	local phi = (1 + math.sqrt(5)) / 2
	local a = size * 0.55
	local b = a * phi
	local v = {}
	for _, x in ipairs({-a, a}) do for _, y in ipairs({-b, b}) do table.insert(v, {0, x, y}) end end
	for _, x in ipairs({-a, a}) do for _, y in ipairs({-b, b}) do table.insert(v, {x, y, 0}) end end
	for _, x in ipairs({-b, b}) do for _, y in ipairs({-a, a}) do table.insert(v, {x, 0, y}) end end
	return Shape3D.getPolyhedronEdgesFromVertices(center, v, angle)
end

function Shape3D.getDodecahedronEdges3D(center, size, angle)
	local phi = (1 + math.sqrt(5)) / 2
	local inv = 1 / phi
	local v = {}
	for _, x in ipairs({-1, 1}) do for _, y in ipairs({-1, 1}) do for _, z in ipairs({-1, 1}) do table.insert(v, {x * size * 0.42, y * size * 0.42, z * size * 0.42}) end end end
	for _, y in ipairs({-inv, inv}) do for _, z in ipairs({-phi, phi}) do table.insert(v, {0, y * size * 0.42, z * size * 0.42}) end end
	for _, x in ipairs({-inv, inv}) do for _, y in ipairs({-phi, phi}) do table.insert(v, {x * size * 0.42, y * size * 0.42, 0}) end end
	for _, x in ipairs({-phi, phi}) do for _, z in ipairs({-inv, inv}) do table.insert(v, {x * size * 0.42, 0, z * size * 0.42}) end end
	return Shape3D.getPolyhedronEdgesFromVertices(center, v, angle)
end

function Shape3D.getGeodesicSphereEdges3D(center, radius, angle)
	-- A lightweight geodesic-like cage built from several staggered latitude rings.
	local edges = {}
	local rings = 8
	local sides = 12
	local ringPts = {}
	for k = 1, rings do
		local t = (k - 1) / (rings - 1)
		local y = (1 - 2 * t) * radius
		local rr = math.sqrt(math.max(0, radius * radius - y * y))
		local count = (k == 1 or k == rings) and 1 or sides
		if count == 1 then
			ringPts[k] = {Vector3.new(center.X, center.Y + y, center.Z)}
		else
			ringPts[k] = Shape3D.getRegularPolygonPoints(center, rr, y, count, angle + k * 0.17)
		end
	end
	for k = 1, rings do
		local ring = ringPts[k]
		if #ring > 1 then
			for j = 1, #ring do Shape3D.addEdge(edges, ring[j], ring[(j % #ring) + 1]) end
		end
		if k < rings then
			local nextRing = ringPts[k + 1]
			for _, a in ipairs(ring) do
				local used = {}
				local nearest = {}
				for q = 1, #nextRing do table.insert(nearest, {q, (a - nextRing[q]).Magnitude}) end
				table.sort(nearest, function(p, q) return p[2] < q[2] end)
				for q = 1, math.min(2, #nearest) do
					local idx = nearest[q][1]
					if not used[idx] then used[idx] = true; Shape3D.addEdge(edges, a, nextRing[idx]) end
				end
			end
		end
	end
	return edges
end

function get3DPlusEdges(center, radiusValue, angle, shape)
	local r = radiusValue
	if shape == "Tetrahedron" then
		local s = r * 0.95
		local h = s * 0.82
		local v = {
			{-s, -h * 0.5, -s * 0.55}, {s, -h * 0.5, -s * 0.55},
			{0, -h * 0.5, s * 1.1}, {0, h * 0.75, 0}
		}
		return {{Shape3D.rotate3DPoint(center, table.unpack(v[1])), Shape3D.rotate3DPoint(center, table.unpack(v[2]))},
			{Shape3D.rotate3DPoint(center, table.unpack(v[2])), Shape3D.rotate3DPoint(center, table.unpack(v[3]))},
			{Shape3D.rotate3DPoint(center, table.unpack(v[3])), Shape3D.rotate3DPoint(center, table.unpack(v[1]))},
			{Shape3D.rotate3DPoint(center, table.unpack(v[1])), Shape3D.rotate3DPoint(center, table.unpack(v[4]))},
			{Shape3D.rotate3DPoint(center, table.unpack(v[2])), Shape3D.rotate3DPoint(center, table.unpack(v[4]))},
			{Shape3D.rotate3DPoint(center, table.unpack(v[3])), Shape3D.rotate3DPoint(center, table.unpack(v[4]))}}
	elseif shape == "Triangular Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.35, 3, angle)
	elseif shape == "Pentagonal Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.2, 5, angle)
	elseif shape == "Hexagonal Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.25, 6, angle)
	elseif shape == "Octagonal Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.2, 8, angle)
	elseif shape == "Decagonal Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.15, 10, angle)
	elseif shape == "Dodecagonal Prism" then return Shape3D.getPrismEdges3D(center, r, r * 1.1, 12, angle)
	elseif shape == "Cylinder" then return Shape3D.getPrismEdges3D(center, r, r * 1.6, 16, angle)
	elseif shape == "Triangular Bipyramid" then return Shape3D.getBipyramidEdges3D(center, r, r * 1.8, 3, angle)
	elseif shape == "Pentagonal Bipyramid" then return Shape3D.getBipyramidEdges3D(center, r, r * 1.8, 5, angle)
	elseif shape == "Hexagonal Bipyramid" then return Shape3D.getBipyramidEdges3D(center, r, r * 1.8, 6, angle)
	elseif shape == "Pentagonal Pyramid" then return Shape3D.getPyramidEdges3D(center, r, r * 1.7, 5, angle)
	elseif shape == "Hexagonal Pyramid" then return Shape3D.getPyramidEdges3D(center, r, r * 1.75, 6, angle)
	elseif shape == "Heptagonal Pyramid" then return Shape3D.getPyramidEdges3D(center, r, r * 1.8, 7, angle)
	elseif shape == "Octagonal Pyramid" then return Shape3D.getPyramidEdges3D(center, r, r * 1.85, 8, angle)
	elseif shape == "Icosahedron" then return Shape3D.getIcosahedronEdges3D(center, r * 1.15, angle)
	elseif shape == "Dodecahedron" then return Shape3D.getDodecahedronEdges3D(center, r * 1.35, angle)
	elseif shape == "Torus" then return Shape3D.getTorusEdges3D(center, r * 0.62, r * 0.24, 14, 7, angle)
	elseif shape == "Helix" then return Shape3D.getHelixEdges3D(center, r * 0.62, r * 2.2, 2.5, 72, angle, false)
	elseif shape == "Double Helix" then return Shape3D.getHelixEdges3D(center, r * 0.62, r * 2.2, 2.5, 72, angle, true)
	elseif shape == "Spring" then return Shape3D.getSpringEdges3D(center, r * 0.62, r * 2.2, 4.0, 96, angle)
	elseif shape == "Heart Prism" then return Shape3D.getHeartPrismEdges3D(center, r * 0.085, r * 0.72, angle)
	elseif shape == "Star Prism" then return Shape3D.getStarPrismEdges3D(center, r, r * 0.42, r * 0.75, 5, angle)
	elseif shape == "Hexagram Prism" then return Shape3D.getStarPrismEdges3D(center, r, r * 0.44, r * 0.75, 6, angle)
	elseif shape == "Arrow Prism" then return Shape3D.getArrowPrismEdges3D(center, r * 0.72, r * 0.8, angle)
	elseif shape == "Cross Prism 3D" then return Shape3D.getCrossPrismEdges3D(center, r, r * 0.7, angle)
	elseif shape == "Capsule" then return Shape3D.getCapsuleEdges3D(center, r * 0.55, r * 1.7, 12, angle)
	elseif shape == "Hourglass" then return Shape3D.getHourglassEdges3D(center, r, r * 1.9, 12, angle)
	elseif shape == "Spherical Cage" then return Shape3D.getSphericalCageEdges3D(center, r, angle)
	elseif shape == "Geodesic Sphere" then return Shape3D.getGeodesicSphereEdges3D(center, r, angle)
	end
	return {}
end

local function getOrbitCenter()
	if fixedPosEnabled and fixedBasePosition then
		return fixedBasePosition + Vector3.new(fixedOffsetX, fixedOffsetY, fixedOffsetZ)
	end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	return hrp and hrp.Position or Vector3.zero
end

local function updateMarker()
	if fixedMarker and fixedMarker.Parent and fixedBasePosition then
		fixedMarker.Position = fixedBasePosition + Vector3.new(fixedOffsetX, fixedOffsetY, fixedOffsetZ)
	end
end

-- Slider logic (X / Y / Z)
local function setupVerticalSlider(knob, fill, bg, axis)
	local draggingSlider = false

	local function updateFromY(relY)
		relY = math.clamp(relY, 0, 1)
		local value = math.floor((0.5 - relY) * 200)
		if axis == "X" then
			fixedOffsetX = value
			XLabel.Text = "X: " .. value
		elseif axis == "Y" then
			fixedOffsetY = value
			YLabel.Text = "Y: " .. value
		else
			fixedOffsetZ = value
			ZLabel.Text = "Z: " .. value
		end
		knob.Position = UDim2.new(0.5, -11, relY, -7)
		fill.Size = UDim2.new(1, 0, 1 - relY, 0)
		fill.Position = UDim2.new(0, 0, relY, 0)
		updateMarker()
	end

	local function updateFromInput(input)
		local absY = input.Position.Y
		local bgAbs = bg.AbsolutePosition.Y
		local bgH = bg.AbsoluteSize.Y
		if bgH <= 0 then return end
		updateFromY((absY - bgAbs) / bgH)
	end

	-- Clicking anywhere on the track immediately moves the slider.
	bg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
			updateFromInput(input)
		end
	end)

	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
			updateFromInput(input)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateFromInput(input)
		end
	end)

	-- Start exactly at zero.
	updateFromY(0.5)
end

setupVerticalSlider(XKnob, XSliderFill, XSliderBg, "X")
setupVerticalSlider(YKnob, YSliderFill, YSliderBg, "Y")
setupVerticalSlider(ZKnob, ZSliderFill, ZSliderBg, "Z")

-- LOCAL HEARTBEAT
RunService.Heartbeat:Connect(function()
	localPartsCount = 0

	if textEnabled then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local pts = currentTextPoints
		local count = #pts
		if count == 0 then LocalPartsLabel.Text = "Parts: 0" return end
		local baseCF = hrp.CFrame * CFrame.new(0, textHeightOffset, textFrontOffset)
		for i, part in ipairs(parts) do
			if part.Parent and not part.Anchored then
				local idx = ((i - 1) % count) + 1
				local localPos = pts[idx]
				local spread = 0.3
				local ox = ((i * 17) % 100) / 100 * spread - spread/2
				local oy = ((i * 31) % 100) / 100 * spread - spread/2
				local oz = ((i * 47) % 100) / 100 * spread - spread/2
				local targetPos = (baseCF * CFrame.new(localPos + Vector3.new(ox, oy, oz))).Position
				applyVelocity(part, targetPos, textAttraction)
				localPartsCount += 1
			end
		end
		LocalPartsLabel.Text = "Parts: " .. localPartsCount
		return
	end

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
				local targetPos = Vector3.new(center.X + math.cos(angle) * cursorOrbitRadius, center.Y + 1.2, center.Z + math.sin(angle) * cursorOrbitRadius)
				applyVelocity(part, targetPos, cursorAttraction)
				localPartsCount += 1
			end
		end
		LocalPartsLabel.Text = "Parts: " .. localPartsCount
		return
	end

	if not ringPartsEnabled and not localSphereEnabled and not localSquareEnabled and not localCubeEnabled and not localDownConeEnabled and not localBallEnabled
		and not localHexEnabled and not localRectEnabled and not localBoxEnabled and not localPyramidEnabled and not localConeEnabled and not localOctaEnabled and not localStarEnabled
		and not localPentagonEnabled and not localOctagonEnabled and not localDiamondEnabled and not localCrossEnabled and threeDPlusShape == nil then
		LocalPartsLabel.Text = "Parts: 0"
		return
	end

	local center = getOrbitCenter()
	local total = #parts
	local r = radius
	local triCounter = 0

	local baseAngle = freezeEnabled and frozenAngle or (tick() * rotationSpeed * 2)
	if not freezeEnabled then frozenAngle = baseAngle end
	local spinAngle = freezeEnabled and frozenAngle or (tick() * shapeSpinSpeed)

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

	local cubeEdges = getCubeEdges(center, r * 1.8, spinAngle)
	local hexEdges = getHexEdges(center, r, spinAngle)
	local rectEdges = getRectEdges(center, r * 2.2, r * 1.1, spinAngle)
	local boxEdges = getBoxEdges(center, r * 2.4, r * 1.2, r * 1.4, spinAngle)
	local pyramidEdges = getPyramidEdges(center, r * 1.9, spinAngle)
	local coneEdges = getConeEdges(center, r * 0.95, r * 1.6, spinAngle, false)
	local downConeEdges = getConeEdges(center, r * 0.95, r * 1.6, spinAngle, true)
	local octaEdges = getOctaEdges(center, r * 1.5, spinAngle)
	local starEdges = getStarEdges(center, r, spinAngle)
	local pentagonEdges = getPentagonEdges(center, r, spinAngle)
	local octagonEdges = getOctagonEdges(center, r, spinAngle)
	local diamondEdges = getDiamondEdges(center, r, spinAngle)
	local crossEdges = getCrossEdges(center, r, spinAngle)
	local threeDPlusEdges = threeDPlusShape and get3DPlusEdges(center, r, spinAngle, threeDPlusShape) or {}
	local spherePoints = localBallEnabled and getSpherePoints(center, r * 0.95, spinAngle) or {}

	for i, part in ipairs(parts) do
		if part.Parent and not part.Anchored and isLocalPart(i, total) then
			triCounter += 1
			local targetPos

			if threeDPlusShape and #threeDPlusEdges > 0 then
				local edgeIndex = ((triCounter - 1) % #threeDPlusEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / #threeDPlusEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #threeDPlusEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = threeDPlusEdges[edgeIndex][1]:Lerp(threeDPlusEdges[edgeIndex][2], t)
			elseif localBallEnabled then
				local idx = ((triCounter - 1) % #spherePoints) + 1
				targetPos = spherePoints[idx]
			elseif localDownConeEnabled then
				local edgeIndex = ((triCounter - 1) % #downConeEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / #downConeEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #downConeEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = downConeEdges[edgeIndex][1]:Lerp(downConeEdges[edgeIndex][2], t)
			elseif localConeEnabled then
				local edgeIndex = ((triCounter - 1) % #coneEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / #coneEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #coneEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = coneEdges[edgeIndex][1]:Lerp(coneEdges[edgeIndex][2], t)
			elseif localCrossEnabled then
				local edgeIndex = ((triCounter - 1) % #crossEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / #crossEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #crossEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = crossEdges[edgeIndex][1]:Lerp(crossEdges[edgeIndex][2], t)
			elseif localDiamondEnabled then
				local edgeIndex = ((triCounter - 1) % 4) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 4))
				local idxOnEdge = math.floor((triCounter - 1) / 4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = diamondEdges[edgeIndex][1]:Lerp(diamondEdges[edgeIndex][2], t)
			elseif localOctagonEnabled then
				local edgeIndex = ((triCounter - 1) % 8) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 8))
				local idxOnEdge = math.floor((triCounter - 1) / 8)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = octagonEdges[edgeIndex][1]:Lerp(octagonEdges[edgeIndex][2], t)
			elseif localPentagonEnabled then
				local edgeIndex = ((triCounter - 1) % 5) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 5))
				local idxOnEdge = math.floor((triCounter - 1) / 5)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = pentagonEdges[edgeIndex][1]:Lerp(pentagonEdges[edgeIndex][2], t)
			elseif localStarEnabled then
				local edgeIndex = ((triCounter - 1) % 10) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 10))
				local idxOnEdge = math.floor((triCounter - 1) / 10)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = starEdges[edgeIndex][1]:Lerp(starEdges[edgeIndex][2], t)
			elseif localOctaEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = octaEdges[edgeIndex][1]:Lerp(octaEdges[edgeIndex][2], t)
			elseif localPyramidEnabled then
				local edgeIndex = ((triCounter - 1) % 8) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 8))
				local idxOnEdge = math.floor((triCounter - 1) / 8)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = pyramidEdges[edgeIndex][1]:Lerp(pyramidEdges[edgeIndex][2], t)
			elseif localBoxEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = boxEdges[edgeIndex][1]:Lerp(boxEdges[edgeIndex][2], t)
			elseif localHexEnabled then
				local edgeIndex = ((triCounter - 1) % 6) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 6))
				local idxOnEdge = math.floor((triCounter - 1) / 6)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = hexEdges[edgeIndex][1]:Lerp(hexEdges[edgeIndex][2], t)
			elseif localRectEnabled then
				local edgeIndex = ((triCounter - 1) % 4) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 4))
				local idxOnEdge = math.floor((triCounter - 1) / 4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = rectEdges[edgeIndex][1]:Lerp(rectEdges[edgeIndex][2], t)
			elseif localCubeEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastLocalTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = cubeEdges[edgeIndex][1]:Lerp(cubeEdges[edgeIndex][2], t)
			elseif localSphereEnabled then
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
				local pos = part.Position
				local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
				local newAngle = freezeEnabled and angle or (angle + math.rad(rotationSpeed))
				local dist = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
				targetPos = Vector3.new(
					center.X + math.cos(newAngle) * math.min(r, dist),
					center.Y + (height * math.abs(math.sin((pos.Y - center.Y)/height))),
					center.Z + math.sin(newAngle) * math.min(r, dist)
				)
			end

			if not localSphereEnabled and not localSquareEnabled and not localCubeEnabled and not localDownConeEnabled and not localBallEnabled
				and not localHexEnabled and not localRectEnabled and not localBoxEnabled and not localPyramidEnabled and not localConeEnabled and not localOctaEnabled and not localStarEnabled
				and not localPentagonEnabled and not localOctagonEnabled and not localDiamondEnabled and not localCrossEnabled and threeDPlusShape == nil then
				local dir = targetPos - part.Position
				if dir.Magnitude > 0.01 then
					part.Velocity = dir.Unit * attractionStrength
				end
			else
				applyVelocity(part, targetPos, attractionStrength)
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
	if (not targetRingEnabled and not targetSphereEnabled and not targetSquareEnabled and not targetCubeEnabled and not targetDownConeEnabled and not targetBallEnabled
		and not targetHexEnabled and not targetRectEnabled and not targetBoxEnabled and not targetPyramidEnabled and not targetConeEnabled and not targetOctaEnabled and not targetStarEnabled
		and not targetPentagonEnabled and not targetOctagonEnabled and not targetDiamondEnabled and not targetCrossEnabled) or not targetPlayer then
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

	local baseAngle = freezeEnabled and frozenAngle or (tick() * targetRotationSpeed * 2)
	if not freezeEnabled then frozenAngle = baseAngle end
	local spinAngle = freezeEnabled and frozenAngle or (tick() * shapeSpinSpeed)

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

	local cubeEdges = getCubeEdges(center, r * 1.8, spinAngle)
	local hexEdges = getHexEdges(center, r, spinAngle)
	local rectEdges = getRectEdges(center, r * 2.2, r * 1.1, spinAngle)
	local boxEdges = getBoxEdges(center, r * 2.4, r * 1.2, r * 1.4, spinAngle)
	local pyramidEdges = getPyramidEdges(center, r * 1.9, spinAngle)
	local coneEdges = getConeEdges(center, r * 0.95, r * 1.6, spinAngle, false)
	local downConeEdges = getConeEdges(center, r * 0.95, r * 1.6, spinAngle, true)
	local octaEdges = getOctaEdges(center, r * 1.5, spinAngle)
	local starEdges = getStarEdges(center, r, spinAngle)
	local pentagonEdges = getPentagonEdges(center, r, spinAngle)
	local octagonEdges = getOctagonEdges(center, r, spinAngle)
	local diamondEdges = getDiamondEdges(center, r, spinAngle)
	local crossEdges = getCrossEdges(center, r, spinAngle)
	local spherePoints = targetBallEnabled and getSpherePoints(center, r * 0.95, spinAngle) or {}

	for i, part in ipairs(parts) do
		if part.Parent and not part.Anchored and not isLocalPart(i, total) then
			if part:IsDescendantOf(char) then continue end
			triCounter += 1
			local targetPos

			if targetBallEnabled then
				local idx = ((triCounter - 1) % #spherePoints) + 1
				targetPos = spherePoints[idx]
			elseif targetDownConeEnabled then
				local edgeIndex = ((triCounter - 1) % #downConeEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / #downConeEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #downConeEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = downConeEdges[edgeIndex][1]:Lerp(downConeEdges[edgeIndex][2], t)
			elseif targetConeEnabled then
				local edgeIndex = ((triCounter - 1) % #coneEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / #coneEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #coneEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = coneEdges[edgeIndex][1]:Lerp(coneEdges[edgeIndex][2], t)
			elseif targetCrossEnabled then
				local edgeIndex = ((triCounter - 1) % #crossEdges) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / #crossEdges))
				local idxOnEdge = math.floor((triCounter - 1) / #crossEdges)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = crossEdges[edgeIndex][1]:Lerp(crossEdges[edgeIndex][2], t)
			elseif targetDiamondEnabled then
				local edgeIndex = ((triCounter - 1) % 4) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 4))
				local idxOnEdge = math.floor((triCounter - 1) / 4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = diamondEdges[edgeIndex][1]:Lerp(diamondEdges[edgeIndex][2], t)
			elseif targetOctagonEnabled then
				local edgeIndex = ((triCounter - 1) % 8) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 8))
				local idxOnEdge = math.floor((triCounter - 1) / 8)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = octagonEdges[edgeIndex][1]:Lerp(octagonEdges[edgeIndex][2], t)
			elseif targetPentagonEnabled then
				local edgeIndex = ((triCounter - 1) % 5) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 5))
				local idxOnEdge = math.floor((triCounter - 1) / 5)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = pentagonEdges[edgeIndex][1]:Lerp(pentagonEdges[edgeIndex][2], t)
			elseif targetStarEnabled then
				local edgeIndex = ((triCounter - 1) % 10) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 10))
				local idxOnEdge = math.floor((triCounter - 1) / 10)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = starEdges[edgeIndex][1]:Lerp(starEdges[edgeIndex][2], t)
			elseif targetOctaEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = octaEdges[edgeIndex][1]:Lerp(octaEdges[edgeIndex][2], t)
			elseif targetPyramidEnabled then
				local edgeIndex = ((triCounter - 1) % 8) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 8))
				local idxOnEdge = math.floor((triCounter - 1) / 8)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = pyramidEdges[edgeIndex][1]:Lerp(pyramidEdges[edgeIndex][2], t)
			elseif targetBoxEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = boxEdges[edgeIndex][1]:Lerp(boxEdges[edgeIndex][2], t)
			elseif targetHexEnabled then
				local edgeIndex = ((triCounter - 1) % 6) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 6))
				local idxOnEdge = math.floor((triCounter - 1) / 6)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = hexEdges[edgeIndex][1]:Lerp(hexEdges[edgeIndex][2], t)
			elseif targetRectEnabled then
				local edgeIndex = ((triCounter - 1) % 4) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 4))
				local idxOnEdge = math.floor((triCounter - 1) / 4)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = rectEdges[edgeIndex][1]:Lerp(rectEdges[edgeIndex][2], t)
			elseif targetCubeEnabled then
				local edgeIndex = ((triCounter - 1) % 12) + 1
				local partsPerEdge = math.max(1, math.floor(lastTargetTriCount / 12))
				local idxOnEdge = math.floor((triCounter - 1) / 12)
				local t = (idxOnEdge % partsPerEdge) / partsPerEdge
				targetPos = cubeEdges[edgeIndex][1]:Lerp(cubeEdges[edgeIndex][2], t)
			elseif targetSphereEnabled then
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
				local pos = part.Position
				local angle = math.atan2(pos.Z-center.Z, pos.X-center.X)
				local newAngle = freezeEnabled and angle or (angle + math.rad(targetRotationSpeed))
				local dist = (Vector3.new(pos.X,center.Y,pos.Z)-center).Magnitude
				targetPos = Vector3.new(
					center.X + math.cos(newAngle)*math.min(r,dist),
					center.Y + (targetHeight * math.abs(math.sin((pos.Y-center.Y)/targetHeight))),
					center.Z + math.sin(newAngle)*math.min(r,dist)
				)
			end

			if not targetSphereEnabled and not targetSquareEnabled and not targetCubeEnabled and not targetDownConeEnabled and not targetBallEnabled
				and not targetHexEnabled and not targetRectEnabled and not targetBoxEnabled and not targetPyramidEnabled and not targetConeEnabled and not targetOctaEnabled and not targetStarEnabled
				and not targetPentagonEnabled and not targetOctagonEnabled and not targetDiamondEnabled and not targetCrossEnabled then
				local dir = targetPos - part.Position
				if dir.Magnitude > 0.01 then
					part.Velocity = dir.Unit * targetAttractionStrength
				end
			else
				applyVelocity(part, targetPos, targetAttractionStrength)
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
	localCubeEnabled = false
	localDownConeEnabled = false
	localBallEnabled = false
	localHexEnabled = false
	localRectEnabled = false
	localBoxEnabled = false
	localPyramidEnabled = false
	localConeEnabled = false
	localOctaEnabled = false
	localStarEnabled = false
	localPentagonEnabled = false
	localOctagonEnabled = false
	localDiamondEnabled = false
	localCrossEnabled = false
	threeDPlusShape = nil
	cursorRingEnabled = false

	ToggleButton.Text = "Your Ring  •  Off"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
	LocalSphereButton.Text = "Triangle  •  Off"
	LocalSphereButton.BackgroundColor3 = Color3.fromRGB(50, 50, 90)
	LocalSquareButton.Text = "Square  •  Off"
	LocalSquareButton.BackgroundColor3 = Color3.fromRGB(65, 45, 100)
	LocalCubeButton.Text = "Cube  •  Off"
	LocalCubeButton.BackgroundColor3 = Color3.fromRGB(40, 70, 100)
	LocalDownConeButton.Text = "Down Cone  •  Off"
	LocalDownConeButton.BackgroundColor3 = Color3.fromRGB(90, 45, 45)
	LocalBallButton.Text = "Sphere  •  Off"
	LocalBallButton.BackgroundColor3 = Color3.fromRGB(30, 90, 110)
	LocalHexButton.Text = "Hexagon  •  Off"
	LocalHexButton.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
	LocalRectButton.Text = "Rectangle  •  Off"
	LocalRectButton.BackgroundColor3 = Color3.fromRGB(60, 80, 50)
	LocalBoxButton.Text = "Box  •  Off"
	LocalBoxButton.BackgroundColor3 = Color3.fromRGB(90, 60, 40)
	LocalPyramidButton.Text = "Pyramid  •  Off"
	LocalPyramidButton.BackgroundColor3 = Color3.fromRGB(100, 70, 40)
	LocalConeButton.Text = "Cone  •  Off"
	LocalConeButton.BackgroundColor3 = Color3.fromRGB(70, 90, 50)
	LocalOctaButton.Text = "Octahedron  •  Off"
	LocalOctaButton.BackgroundColor3 = Color3.fromRGB(50, 80, 100)
	LocalStarButton.Text = "Star  •  Off"
	LocalStarButton.BackgroundColor3 = Color3.fromRGB(140, 100, 30)
	LocalPentagonButton.Text = "Pentagon  •  Off"
	LocalPentagonButton.BackgroundColor3 = Color3.fromRGB(90, 60, 110)
	LocalOctagonButton.Text = "Octagon  •  Off"
	LocalOctagonButton.BackgroundColor3 = Color3.fromRGB(60, 90, 80)
	LocalDiamondButton.Text = "Diamond  •  Off"
	LocalDiamondButton.BackgroundColor3 = Color3.fromRGB(100, 50, 80)
	LocalCrossButton.Text = "Cross  •  Off"
	LocalCrossButton.BackgroundColor3 = Color3.fromRGB(80, 80, 50)
	CursorButton.Text = "Cursor Follow  •  Off"
	CursorButton.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
	for i, shapeName in ipairs(ThreeDPlusShapeNames) do
		local btn = ThreeDPlusButtons[shapeName]
		if btn then
			btn.Text = shapeName .. "  •  Off"
			btn.BackgroundColor3 = Color3.fromRGB(45 + ((i * 17) % 45), 55 + ((i * 11) % 45), 85 + ((i * 19) % 55))
		end
	end
	ThreeDPlusStatus.Text = "Selected: None"
end

function setThreeDPlusShape(shapeName)
	turnOffLocalShapes()
	threeDPlusShape = shapeName
	local btn = ThreeDPlusButtons[shapeName]
	if btn then
		btn.Text = shapeName .. "  •  On"
		btn.BackgroundColor3 = Color3.fromRGB(55, 120, 190)
	end
	ToggleButton.Text = "Your Ring  •  On"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	ThreeDPlusStatus.Text = "Selected: " .. shapeName
	playSound("12221967")
end

for shapeName, btn in pairs(ThreeDPlusButtons) do
	btn.MouseButton1Click:Connect(function()
		if threeDPlusShape == shapeName then
			turnOffLocalShapes()
			ThreeDPlusStatus.Text = "Selected: None"
		else
			setThreeDPlusShape(shapeName)
		end
	end)
end

local function turnOffTargetShapes()
	targetRingEnabled = false
	targetSphereEnabled = false
	targetSquareEnabled = false
	targetCubeEnabled = false
	targetDownConeEnabled = false
	targetBallEnabled = false
	targetHexEnabled = false
	targetRectEnabled = false
	targetBoxEnabled = false
	targetPyramidEnabled = false
	targetConeEnabled = false
	targetOctaEnabled = false
	targetStarEnabled = false
	targetPentagonEnabled = false
	targetOctagonEnabled = false
	targetDiamondEnabled = false
	targetCrossEnabled = false

	TargetToggle.Text = "Target Ring  •  Off"
	TargetToggle.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
	TargetSphereButton.Text = "Triangle  •  Off"
	TargetSphereButton.BackgroundColor3 = Color3.fromRGB(50, 50, 90)
	TargetSquareButton.Text = "Square  •  Off"
	TargetSquareButton.BackgroundColor3 = Color3.fromRGB(65, 45, 100)
	TargetCubeButton.Text = "Cube  •  Off"
	TargetCubeButton.BackgroundColor3 = Color3.fromRGB(40, 70, 100)
	TargetDownConeButton.Text = "Down Cone  •  Off"
	TargetDownConeButton.BackgroundColor3 = Color3.fromRGB(90, 45, 45)
	TargetBallButton.Text = "Sphere  •  Off"
	TargetBallButton.BackgroundColor3 = Color3.fromRGB(30, 90, 110)
	TargetHexButton.Text = "Hexagon  •  Off"
	TargetHexButton.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
	TargetRectButton.Text = "Rectangle  •  Off"
	TargetRectButton.BackgroundColor3 = Color3.fromRGB(60, 80, 50)
	TargetBoxButton.Text = "Box  •  Off"
	TargetBoxButton.BackgroundColor3 = Color3.fromRGB(90, 60, 40)
	TargetPyramidButton.Text = "Pyramid  •  Off"
	TargetPyramidButton.BackgroundColor3 = Color3.fromRGB(100, 70, 40)
	TargetConeButton.Text = "Cone  •  Off"
	TargetConeButton.BackgroundColor3 = Color3.fromRGB(70, 90, 50)
	TargetOctaButton.Text = "Octahedron  •  Off"
	TargetOctaButton.BackgroundColor3 = Color3.fromRGB(50, 80, 100)
	TargetStarButton.Text = "Star  •  Off"
	TargetStarButton.BackgroundColor3 = Color3.fromRGB(140, 100, 30)
	TargetPentagonButton.Text = "Pentagon  •  Off"
	TargetPentagonButton.BackgroundColor3 = Color3.fromRGB(90, 60, 110)
	TargetOctagonButton.Text = "Octagon  •  Off"
	TargetOctagonButton.BackgroundColor3 = Color3.fromRGB(60, 90, 80)
	TargetDiamondButton.Text = "Diamond  •  Off"
	TargetDiamondButton.BackgroundColor3 = Color3.fromRGB(100, 50, 80)
	TargetCrossButton.Text = "Cross  •  Off"
	TargetCrossButton.BackgroundColor3 = Color3.fromRGB(80, 80, 50)
end

SpeedModeButton.MouseButton1Click:Connect(function()
	smoothMode = not smoothMode
	if smoothMode then
		SpeedModeButton.Text = "Mode: Smooth"
		SpeedModeButton.BackgroundColor3 = Color3.fromRGB(45, 90, 140)
		attractionStrength = 1100
		targetAttractionStrength = 1100
		rotationSpeed = 0.65
		targetRotationSpeed = 0.65
	else
		SpeedModeButton.Text = "Mode: Aggressive"
		SpeedModeButton.BackgroundColor3 = Color3.fromRGB(160, 50, 40)
		attractionStrength = 2200
		targetAttractionStrength = 2200
		rotationSpeed = 1.1
		targetRotationSpeed = 1.1
	end
	playSound("12221967")
end)

FreezeButton.MouseButton1Click:Connect(function()
	freezeEnabled = not freezeEnabled
	if freezeEnabled then
		FreezeButton.Text = "Freeze  •  On"
		FreezeButton.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	else
		FreezeButton.Text = "Freeze  •  Off"
		FreezeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	end
	playSound("12221967")
end)

-- Fixed Pos toggle
FixedPosButton.MouseButton1Click:Connect(function()
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if fixedPosEnabled then
		fixedPosEnabled = false
		fixedBasePosition = nil
		FixedPosButton.Text = "Fixed Pos  •  Off"
		FixedPosButton.BackgroundColor3 = Color3.fromRGB(40, 70, 110)
		if fixedMarker then
			fixedMarker:Destroy()
			fixedMarker = nil
		end
	else
		fixedPosEnabled = true
		fixedBasePosition = hrp.Position
		FixedPosButton.Text = "Fixed Pos  •  On"
		FixedPosButton.BackgroundColor3 = Color3.fromRGB(40, 120, 180)

		if fixedMarker then fixedMarker:Destroy() end
		fixedMarker = Instance.new("Part")
		fixedMarker.Name = "FixedPosMarker"
		fixedMarker.Size = Vector3.new(1.4, 1.4, 1.4)
		fixedMarker.Shape = Enum.PartType.Ball
		fixedMarker.Material = Enum.Material.Neon
		fixedMarker.Color = Color3.fromRGB(0, 170, 255)
		fixedMarker.Transparency = 0.55
		fixedMarker.Anchored = true
		fixedMarker.CanCollide = false
		fixedMarker.CanQuery = false
		fixedMarker.CanTouch = false
		fixedMarker.CastShadow = false
		fixedMarker.Position = fixedBasePosition + Vector3.new(fixedOffsetX, fixedOffsetY, fixedOffsetZ)
		fixedMarker.Parent = Workspace
	end
	playSound("12221967")
end)

TextToggle.MouseButton1Click:Connect(function()
	textEnabled = not textEnabled
	if textEnabled then
		turnOffLocalShapes()
		TextToggle.Text = "Super Text  •  On"
		TextToggle.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	else
		TextToggle.Text = "Super Text  •  Off"
		TextToggle.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
	end
	playSound("12221967")
end)

ToggleButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if ringPartsEnabled then
		turnOffLocalShapes()
	else
		turnOffLocalShapes()
		ringPartsEnabled = true
		ToggleButton.Text = "Your Ring  •  On"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	end
	playSound("12221967")
end)

local function setLocalShape(shape)
	turnOffLocalShapes()
	ringPartsEnabled = true
	ToggleButton.Text = "Your Ring  •  On"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 140, 70)

	if shape == "triangle" then
		localSphereEnabled = true
		LocalSphereButton.Text = "Triangle  •  On"
		LocalSphereButton.BackgroundColor3 = Color3.fromRGB(70, 70, 160)
	elseif shape == "square" then
		localSquareEnabled = true
		LocalSquareButton.Text = "Square  •  On"
		LocalSquareButton.BackgroundColor3 = Color3.fromRGB(100, 60, 170)
	elseif shape == "cube" then
		localCubeEnabled = true
		LocalCubeButton.Text = "Cube  •  On"
		LocalCubeButton.BackgroundColor3 = Color3.fromRGB(50, 110, 160)
	elseif shape == "downcone" then
		localDownConeEnabled = true
		LocalDownConeButton.Text = "Down Cone  •  On"
		LocalDownConeButton.BackgroundColor3 = Color3.fromRGB(160, 60, 50)
	elseif shape == "sphere" then
		localBallEnabled = true
		LocalBallButton.Text = "Sphere  •  On"
		LocalBallButton.BackgroundColor3 = Color3.fromRGB(40, 140, 160)
	elseif shape == "hex" then
		localHexEnabled = true
		LocalHexButton.Text = "Hexagon  •  On"
		LocalHexButton.BackgroundColor3 = Color3.fromRGB(130, 70, 180)
	elseif shape == "rect" then
		localRectEnabled = true
		LocalRectButton.Text = "Rectangle  •  On"
		LocalRectButton.BackgroundColor3 = Color3.fromRGB(80, 130, 70)
	elseif shape == "box" then
		localBoxEnabled = true
		LocalBoxButton.Text = "Box  •  On"
		LocalBoxButton.BackgroundColor3 = Color3.fromRGB(150, 90, 50)
	elseif shape == "pyramid" then
		localPyramidEnabled = true
		LocalPyramidButton.Text = "Pyramid  •  On"
		LocalPyramidButton.BackgroundColor3 = Color3.fromRGB(160, 110, 50)
	elseif shape == "cone" then
		localConeEnabled = true
		LocalConeButton.Text = "Cone  •  On"
		LocalConeButton.BackgroundColor3 = Color3.fromRGB(100, 140, 70)
	elseif shape == "octa" then
		localOctaEnabled = true
		LocalOctaButton.Text = "Octahedron  •  On"
		LocalOctaButton.BackgroundColor3 = Color3.fromRGB(70, 120, 150)
	elseif shape == "star" then
		localStarEnabled = true
		LocalStarButton.Text = "Star  •  On"
		LocalStarButton.BackgroundColor3 = Color3.fromRGB(200, 150, 40)
	elseif shape == "pentagon" then
		localPentagonEnabled = true
		LocalPentagonButton.Text = "Pentagon  •  On"
		LocalPentagonButton.BackgroundColor3 = Color3.fromRGB(140, 90, 160)
	elseif shape == "octagon" then
		localOctagonEnabled = true
		LocalOctagonButton.Text = "Octagon  •  On"
		LocalOctagonButton.BackgroundColor3 = Color3.fromRGB(90, 140, 110)
	elseif shape == "diamond" then
		localDiamondEnabled = true
		LocalDiamondButton.Text = "Diamond  •  On"
		LocalDiamondButton.BackgroundColor3 = Color3.fromRGB(160, 80, 120)
	elseif shape == "cross" then
		localCrossEnabled = true
		LocalCrossButton.Text = "Cross  •  On"
		LocalCrossButton.BackgroundColor3 = Color3.fromRGB(130, 130, 70)
	end
end

LocalSphereButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localSphereEnabled then turnOffLocalShapes() else setLocalShape("triangle") end
	playSound("12221967")
end)
LocalSquareButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localSquareEnabled then turnOffLocalShapes() else setLocalShape("square") end
	playSound("12221967")
end)
LocalCubeButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localCubeEnabled then turnOffLocalShapes() else setLocalShape("cube") end
	playSound("12221967")
end)
LocalDownConeButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localDownConeEnabled then turnOffLocalShapes() else setLocalShape("downcone") end
	playSound("12221967")
end)
LocalBallButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localBallEnabled then turnOffLocalShapes() else setLocalShape("sphere") end
	playSound("12221967")
end)
LocalHexButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localHexEnabled then turnOffLocalShapes() else setLocalShape("hex") end
	playSound("12221967")
end)
LocalRectButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localRectEnabled then turnOffLocalShapes() else setLocalShape("rect") end
	playSound("12221967")
end)
LocalBoxButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localBoxEnabled then turnOffLocalShapes() else setLocalShape("box") end
	playSound("12221967")
end)
LocalPyramidButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localPyramidEnabled then turnOffLocalShapes() else setLocalShape("pyramid") end
	playSound("12221967")
end)
LocalConeButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localConeEnabled then turnOffLocalShapes() else setLocalShape("cone") end
	playSound("12221967")
end)
LocalOctaButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localOctaEnabled then turnOffLocalShapes() else setLocalShape("octa") end
	playSound("12221967")
end)
LocalStarButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localStarEnabled then turnOffLocalShapes() else setLocalShape("star") end
	playSound("12221967")
end)
LocalPentagonButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localPentagonEnabled then turnOffLocalShapes() else setLocalShape("pentagon") end
	playSound("12221967")
end)
LocalOctagonButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localOctagonEnabled then turnOffLocalShapes() else setLocalShape("octagon") end
	playSound("12221967")
end)
LocalDiamondButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localDiamondEnabled then turnOffLocalShapes() else setLocalShape("diamond") end
	playSound("12221967")
end)
LocalCrossButton.MouseButton1Click:Connect(function()
	if cursorRingEnabled or textEnabled then return end
	if localCrossEnabled then turnOffLocalShapes() else setLocalShape("cross") end
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
		CursorButton.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	else
		CursorButton.Text = "Cursor Follow  •  Off"
		CursorButton.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
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

function findPlayer(name)
	if not name or name == "" then return nil end
	name = string.lower(name)
	for _, plr in pairs(Players:GetPlayers()) do
		if string.find(string.lower(plr.Name), name, 1, true) or string.find(string.lower(plr.DisplayName), name, 1, true) then
			return plr
		end
	end
	return nil
end

TargetToggle.MouseButton1Click:Connect(function()
	local found = targetPlayer or findPlayer(NameBox.Text)
	if not found then
		StarterGui:SetCore("SendNotification", {Title="Target", Text="Player not found!", Duration=3})
		return
	end
	targetPlayer = found
	if targetRingEnabled then
		turnOffTargetShapes()
	else
		turnOffTargetShapes()
		targetRingEnabled = true
		TargetToggle.Text = "Target Ring  •  On"
		TargetToggle.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
	end
	playSound("12221967")
end)

local function setTargetShape(shape)
	local found = targetPlayer or findPlayer(NameBox.Text)
	if not found then
		StarterGui:SetCore("SendNotification", {Title="Target", Text="Player not found!", Duration=3})
		return
	end
	targetPlayer = found
	turnOffTargetShapes()
	targetRingEnabled = true
	TargetToggle.Text = "Target Ring  •  On"
	TargetToggle.BackgroundColor3 = Color3.fromRGB(40, 140, 70)

	if shape == "triangle" then
		targetSphereEnabled = true
		TargetSphereButton.Text = "Triangle  •  On"
		TargetSphereButton.BackgroundColor3 = Color3.fromRGB(70, 70, 160)
	elseif shape == "square" then
		targetSquareEnabled = true
		TargetSquareButton.Text = "Square  •  On"
		TargetSquareButton.BackgroundColor3 = Color3.fromRGB(100, 60, 170)
	elseif shape == "cube" then
		targetCubeEnabled = true
		TargetCubeButton.Text = "Cube  •  On"
		TargetCubeButton.BackgroundColor3 = Color3.fromRGB(50, 110, 160)
	elseif shape == "downcone" then
		targetDownConeEnabled = true
		TargetDownConeButton.Text = "Down Cone  •  On"
		TargetDownConeButton.BackgroundColor3 = Color3.fromRGB(160, 60, 50)
	elseif shape == "sphere" then
		targetBallEnabled = true
		TargetBallButton.Text = "Sphere  •  On"
		TargetBallButton.BackgroundColor3 = Color3.fromRGB(40, 140, 160)
	elseif shape == "hex" then
		targetHexEnabled = true
		TargetHexButton.Text = "Hexagon  •  On"
		TargetHexButton.BackgroundColor3 = Color3.fromRGB(130, 70, 180)
	elseif shape == "rect" then
		targetRectEnabled = true
		TargetRectButton.Text = "Rectangle  •  On"
		TargetRectButton.BackgroundColor3 = Color3.fromRGB(80, 130, 70)
	elseif shape == "box" then
		targetBoxEnabled = true
		TargetBoxButton.Text = "Box  •  On"
		TargetBoxButton.BackgroundColor3 = Color3.fromRGB(150, 90, 50)
	elseif shape == "pyramid" then
		targetPyramidEnabled = true
		TargetPyramidButton.Text = "Pyramid  •  On"
		TargetPyramidButton.BackgroundColor3 = Color3.fromRGB(160, 110, 50)
	elseif shape == "cone" then
		targetConeEnabled = true
		TargetConeButton.Text = "Cone  •  On"
		TargetConeButton.BackgroundColor3 = Color3.fromRGB(100, 140, 70)
	elseif shape == "octa" then
		targetOctaEnabled = true
		TargetOctaButton.Text = "Octahedron  •  On"
		TargetOctaButton.BackgroundColor3 = Color3.fromRGB(70, 120, 150)
	elseif shape == "star" then
		targetStarEnabled = true
		TargetStarButton.Text = "Star  •  On"
		TargetStarButton.BackgroundColor3 = Color3.fromRGB(200, 150, 40)
	elseif shape == "pentagon" then
		targetPentagonEnabled = true
		TargetPentagonButton.Text = "Pentagon  •  On"
		TargetPentagonButton.BackgroundColor3 = Color3.fromRGB(140, 90, 160)
	elseif shape == "octagon" then
		targetOctagonEnabled = true
		TargetOctagonButton.Text = "Octagon  •  On"
		TargetOctagonButton.BackgroundColor3 = Color3.fromRGB(90, 140, 110)
	elseif shape == "diamond" then
		targetDiamondEnabled = true
		TargetDiamondButton.Text = "Diamond  •  On"
		TargetDiamondButton.BackgroundColor3 = Color3.fromRGB(160, 80, 120)
	elseif shape == "cross" then
		targetCrossEnabled = true
		TargetCrossButton.Text = "Cross  •  On"
		TargetCrossButton.BackgroundColor3 = Color3.fromRGB(130, 130, 70)
	end
end

TargetSphereButton.MouseButton1Click:Connect(function()
	if targetSphereEnabled then turnOffTargetShapes() else setTargetShape("triangle") end
	playSound("12221967")
end)
TargetSquareButton.MouseButton1Click:Connect(function()
	if targetSquareEnabled then turnOffTargetShapes() else setTargetShape("square") end
	playSound("12221967")
end)
TargetCubeButton.MouseButton1Click:Connect(function()
	if targetCubeEnabled then turnOffTargetShapes() else setTargetShape("cube") end
	playSound("12221967")
end)
TargetDownConeButton.MouseButton1Click:Connect(function()
	if targetDownConeEnabled then turnOffTargetShapes() else setTargetShape("downcone") end
	playSound("12221967")
end)
TargetBallButton.MouseButton1Click:Connect(function()
	if targetBallEnabled then turnOffTargetShapes() else setTargetShape("sphere") end
	playSound("12221967")
end)
TargetHexButton.MouseButton1Click:Connect(function()
	if targetHexEnabled then turnOffTargetShapes() else setTargetShape("hex") end
	playSound("12221967")
end)
TargetRectButton.MouseButton1Click:Connect(function()
	if targetRectEnabled then turnOffTargetShapes() else setTargetShape("rect") end
	playSound("12221967")
end)
TargetBoxButton.MouseButton1Click:Connect(function()
	if targetBoxEnabled then turnOffTargetShapes() else setTargetShape("box") end
	playSound("12221967")
end)
TargetPyramidButton.MouseButton1Click:Connect(function()
	if targetPyramidEnabled then turnOffTargetShapes() else setTargetShape("pyramid") end
	playSound("12221967")
end)
TargetConeButton.MouseButton1Click:Connect(function()
	if targetConeEnabled then turnOffTargetShapes() else setTargetShape("cone") end
	playSound("12221967")
end)
TargetOctaButton.MouseButton1Click:Connect(function()
	if targetOctaEnabled then turnOffTargetShapes() else setTargetShape("octa") end
	playSound("12221967")
end)
TargetStarButton.MouseButton1Click:Connect(function()
	if targetStarEnabled then turnOffTargetShapes() else setTargetShape("star") end
	playSound("12221967")
end)
TargetPentagonButton.MouseButton1Click:Connect(function()
	if targetPentagonEnabled then turnOffTargetShapes() else setTargetShape("pentagon") end
	playSound("12221967")
end)
TargetOctagonButton.MouseButton1Click:Connect(function()
	if targetOctagonEnabled then turnOffTargetShapes() else setTargetShape("octagon") end
	playSound("12221967")
end)
TargetDiamondButton.MouseButton1Click:Connect(function()
	if targetDiamondEnabled then turnOffTargetShapes() else setTargetShape("diamond") end
	playSound("12221967")
end)
TargetCrossButton.MouseButton1Click:Connect(function()
	if targetCrossEnabled then turnOffTargetShapes() else setTargetShape("cross") end
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

pcall(function()
	local userId = Players:GetUserIdFromNameAsync("Gabrieltod112")
	local content = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	StarterGui:SetCore("SendNotification", {
		Title = "gabs super ring v2.8",
		Text = "Fixed Pos + X/Y/Z offset sliders!",
		Icon = content,
		Duration = 5
	})
end)


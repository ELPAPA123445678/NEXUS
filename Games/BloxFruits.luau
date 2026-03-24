local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

local GUI_NAME = "rz-warning"
local SERVER_LINK = "discord.gg/redz-hub"
local WARNING_TITLE = "redz Hub is temporarily offline"
local WARNING_MESSAGE = "Join the Discord server for updates and more information."
local COPY_DEFAULT_TEXT = SERVER_LINK
local COPY_SUCCESS_TEXT = "Copied to clipboard"
local COPY_UNAVAILABLE_TEXT = "Clipboard not supported"

local function tween(instance, duration, properties)
	local animation = TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), properties)
	animation:Play()
	return animation
end

local existingGui = CoreGui:FindFirstChild(GUI_NAME)
if existingGui then
	existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = GUI_NAME
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

Debris:AddItem(screenGui, 25)

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(7, 7, 10)
background.BorderSizePixel = 0
background.Parent = screenGui

local backgroundGradient = Instance.new("UIGradient")
backgroundGradient.Rotation = 90
backgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 8)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 28)),
})
backgroundGradient.Parent = background

local card = Instance.new("Frame")
card.Name = "Card"
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.Size = UDim2.fromOffset(520, 260)
card.BackgroundColor3 = Color3.fromRGB(17, 17, 22)
card.BorderSizePixel = 0
card.Parent = background

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 18)
cardCorner.Parent = card

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(52, 52, 64)
cardStroke.Thickness = 1
cardStroke.Transparency = 0.15
cardStroke.Parent = card

local cardPadding = Instance.new("UIPadding")
cardPadding.PaddingTop = UDim.new(0, 24)
cardPadding.PaddingBottom = UDim.new(0, 24)
cardPadding.PaddingLeft = UDim.new(0, 24)
cardPadding.PaddingRight = UDim.new(0, 24)
cardPadding.Parent = card

local cardLayout = Instance.new("UIListLayout")
cardLayout.Padding = UDim.new(0, 12)
cardLayout.SortOrder = Enum.SortOrder.LayoutOrder
cardLayout.Parent = card

local accent = Instance.new("Frame")
accent.Name = "Accent"
accent.Size = UDim2.new(1, 0, 0, 6)
accent.BackgroundColor3 = Color3.fromRGB(225, 72, 72)
accent.BorderSizePixel = 0
accent.Parent = card

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(1, 0)
accentCorner.Parent = accent

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 44)
title.Font = Enum.Font.FredokaOne
title.Text = WARNING_TITLE
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.TextScaled = true
title.TextWrapped = true
title.Parent = card

local message = Instance.new("TextLabel")
message.Name = "Message"
message.BackgroundTransparency = 1
message.Size = UDim2.new(1, 0, 0, 56)
message.Font = Enum.Font.BuilderSans
message.Text = WARNING_MESSAGE
message.TextColor3 = Color3.fromRGB(190, 190, 198)
message.TextSize = 24
message.TextWrapped = true
message.Parent = card

local linkHolder = Instance.new("Frame")
linkHolder.Name = "LinkHolder"
linkHolder.Size = UDim2.new(1, 0, 0, 64)
linkHolder.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
linkHolder.BorderSizePixel = 0
linkHolder.Parent = card

local linkHolderCorner = Instance.new("UICorner")
linkHolderCorner.CornerRadius = UDim.new(0, 14)
linkHolderCorner.Parent = linkHolder

local linkHolderStroke = Instance.new("UIStroke")
linkHolderStroke.Color = Color3.fromRGB(46, 46, 58)
linkHolderStroke.Thickness = 1
linkHolderStroke.Transparency = 0.2
linkHolderStroke.Parent = linkHolder

local copyLink = Instance.new("TextButton")
copyLink.Name = "CopyLink"
copyLink.AnchorPoint = Vector2.new(0.5, 0.5)
copyLink.Position = UDim2.fromScale(0.5, 0.5)
copyLink.Size = UDim2.new(1, -20, 1, -20)
copyLink.AutoButtonColor = false
copyLink.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
copyLink.BorderSizePixel = 0
copyLink.Font = Enum.Font.FredokaOne
copyLink.Text = COPY_DEFAULT_TEXT
copyLink.TextColor3 = Color3.fromRGB(225, 225, 232)
copyLink.TextScaled = true
copyLink.Parent = linkHolder

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 12)
copyCorner.Parent = copyLink

local copyStroke = Instance.new("UIStroke")
copyStroke.Color = Color3.fromRGB(70, 70, 90)
copyStroke.Thickness = 1
copyStroke.Transparency = 0.2
copyStroke.Parent = copyLink

local helper = Instance.new("TextLabel")
helper.Name = "Helper"
helper.BackgroundTransparency = 1
helper.Size = UDim2.new(1, 0, 0, 20)
helper.Font = Enum.Font.BuilderSans
helper.Text = "Tap the link to copy it"
helper.TextColor3 = Color3.fromRGB(140, 140, 150)
helper.TextSize = 18
helper.Parent = card

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.Position = UDim2.new(1, 0, 0, 0)
closeButton.Size = UDim2.fromOffset(42, 42)
closeButton.AutoButtonColor = false
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.FredokaOne
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 120, 120)
closeButton.TextSize = 24
closeButton.Parent = card

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(320, 220)
sizeConstraint.MaxSize = Vector2.new(520, 260)
sizeConstraint.Parent = card

local scale = Instance.new("UIScale")
scale.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.X / 1280, 0.72, 1)
scale.Parent = card

tween(background, 0.35, {BackgroundTransparency = 0})
card.Size = UDim2.fromOffset(480, 220)
card.BackgroundTransparency = 1
tween(card, 0.4, {Size = UDim2.fromOffset(520, 260), BackgroundTransparency = 0})

local copyResetToken = 0

local function setCopyState(text, color)
	copyLink.Text = text
	copyLink.TextColor3 = color
end

local function resetCopyState(token)
	task.delay(2, function()
		if copyResetToken ~= token or not copyLink.Parent then
			return
		end

		setCopyState(COPY_DEFAULT_TEXT, Color3.fromRGB(225, 225, 232))
	end)
end

copyLink.MouseEnter:Connect(function()
	tween(copyLink, 0.18, {BackgroundColor3 = Color3.fromRGB(34, 34, 44)})
end)

copyLink.MouseLeave:Connect(function()
	tween(copyLink, 0.18, {BackgroundColor3 = Color3.fromRGB(26, 26, 34)})
end)

copyLink.Activated:Connect(function()
	copyResetToken += 1
	local currentToken = copyResetToken

	if type(setclipboard) == "function" then
		local ok = pcall(setclipboard, SERVER_LINK)
		if ok then
			setCopyState(COPY_SUCCESS_TEXT, Color3.fromRGB(132, 235, 160))
		else
			setCopyState(COPY_UNAVAILABLE_TEXT, Color3.fromRGB(255, 170, 120))
		end
	else
		setCopyState(COPY_UNAVAILABLE_TEXT, Color3.fromRGB(255, 170, 120))
	end

	resetCopyState(currentToken)
end)

closeButton.MouseEnter:Connect(function()
	tween(closeButton, 0.18, {BackgroundColor3 = Color3.fromRGB(42, 42, 54)})
end)

closeButton.MouseLeave:Connect(function()
	tween(closeButton, 0.18, {BackgroundColor3 = Color3.fromRGB(30, 30, 38)})
end)

closeButton.Activated:Connect(function()
	screenGui:Destroy()
end)on()
	ScreenGui:Destroy()
end)

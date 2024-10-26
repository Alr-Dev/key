
local validKeys = { "SPJ-REACH-0xNF0AN5-NZU7RL-HQUZQD" }
local PaidKeys = {
	'SPJ-REACH-VU8VRZQH-LGOKMQ-CW5800'
}

print('========\\//========')
print('==================')
print('Loading Key Verification...')

local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local function verifyApiKey(apiKey, callback)
	apiKey = apiKey:gsub("^%s*(.-)%s*$", "%1") 

	for _, key in pairs(validKeys) do
		if key == apiKey then
			callback(true)  
			return
		end
	end

	for _, key in pairs(PaidKeys) do
		if key == apiKey then
			callback(true)  
			return
		end
	end

	callback(false) 
end

local function createLoadingScreen()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "LoadingScreenGui"
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0.698, 0, 0.643, 0)
	frame.Position = UDim2.new(0.142, 0, 0.177, 0)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui


	local loadingLabel = Instance.new("TextLabel")
	loadingLabel.Text = "SPJ Reach"
	loadingLabel.Font = Enum.Font.Gotham
	loadingLabel.TextSize = 40
	loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadingLabel.Position = UDim2.new(0.5, -150, 0.5, -40)
	loadingLabel.Size = UDim2.new(0, 300, 0, 40)
	loadingLabel.BackgroundTransparency = 1
	loadingLabel.Parent = frame

	local loadingSubLabel = Instance.new("TextLabel")
	loadingSubLabel.Text = "Loading System..."
	loadingSubLabel.Font = Enum.Font.Gotham
	loadingSubLabel.TextSize = 20
	loadingSubLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadingSubLabel.Position = UDim2.new(0.5, -100, 0.5, 0)
	loadingSubLabel.Size = UDim2.new(0, 200, 0, 30)
	loadingSubLabel.BackgroundTransparency = 1
	loadingSubLabel.Parent = frame


	local loadingBarBackground = Instance.new("Frame")
	loadingBarBackground.Size = UDim2.new(0, 577, 0, 10)  
	loadingBarBackground.Position = UDim2.new(0.5, -288, 0.75, 0)  
	loadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	loadingBarBackground.BorderSizePixel = 0
	loadingBarBackground.Parent = frame

	local loadingBar = Instance.new("Frame")
	loadingBar.Size = UDim2.new(0, 0, 1, 0)  
	loadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	loadingBar.BorderSizePixel = 0
	loadingBar.Parent = loadingBarBackground

	local loadingBarCorner = Instance.new("UICorner")
	loadingBarCorner.CornerRadius = UDim.new(0, 5)
	loadingBarCorner.Parent = loadingBar

	local function updateLoadingBar()
		for i = 1, 100 do
			loadingBar:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Linear", 0.05)
			wait(0.05)
		end
	end

	updateLoadingBar()


	local skipButton = Instance.new("TextButton")
	skipButton.Text = "Skip Loading"
	skipButton.Font = Enum.Font.Gotham
	skipButton.TextSize = 18
	skipButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	skipButton.Size = UDim2.new(0, 150, 0, 30)
	skipButton.Position = UDim2.new(0.5, -75, 0.85, 0)
	skipButton.BackgroundTransparency = 1
	skipButton.Parent = frame

	skipButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
		
	end)

	if screenGui == nil then
		
	end
	
end
local function createKeyGui()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KeyVerificationGui"
	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 350, 0, 152)
	frame.Position = UDim2.new(0.5, -175, 0.5, -76) 
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 9)
	frameCorner.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Text = "Enter API Key"
	titleLabel.Font = Enum.Font.Gotham 
	titleLabel.TextSize = 24 
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.Size = UDim2.new(1, 0, 0, 40)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Parent = frame

	local textBox = Instance.new("TextBox")
	textBox.PlaceholderText = "Enter your API key here"
	textBox.Font = Enum.Font.Gotham 
	textBox.TextSize = 18
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255) 
	textBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200) 
	textBox.Size = UDim2.new(1, -30, 0, 40)
	textBox.Position = UDim2.new(0, 15, 0, 40)
	textBox.BackgroundColor3 = Color3.fromRGB(16, 16, 16) 
	textBox.BorderSizePixel = 0
	textBox.Parent = frame

	local textBoxCorner = Instance.new("UICorner")
	textBoxCorner.CornerRadius = UDim.new(0, 8)
	textBoxCorner.Parent = textBox

	local submitButton = Instance.new("TextButton")
	submitButton.Text = "Submit"
	submitButton.Font = Enum.Font.Gotham
	submitButton.TextSize = 18
	submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	submitButton.Size = UDim2.new(0, 100, 0, 40)
	submitButton.Position = UDim2.new(0.25, -50, 0, 90)
	submitButton.BackgroundColor3 = Color3.fromRGB(17, 16, 16) 
	submitButton.Parent = frame

	local submitButtonCorner = Instance.new("UICorner")
	submitButtonCorner.CornerRadius = UDim.new(0, 8)
	submitButtonCorner.Parent = submitButton

	local copyButton = Instance.new("TextButton")
	copyButton.Text = "Copy Key Link"
	copyButton.Font = Enum.Font.Gotham
	copyButton.TextSize = 18
	copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	copyButton.Size = UDim2.new(0, 130, 0, 40)
	copyButton.Position = UDim2.new(0.75, -65, 0, 90)
	copyButton.BackgroundColor3 = Color3.fromRGB(17, 16, 16)
	copyButton.Parent = frame

	local copyButtonCorner = Instance.new("UICorner")
	copyButtonCorner.CornerRadius = UDim.new(0, 8)
	copyButtonCorner.Parent = copyButton

	submitButton.MouseButton1Click:Connect(function()
		local inputKey = textBox.Text

		verifyApiKey(inputKey, function(isValid)
			if isValid then
				game.StarterGui:SetCore("SendNotification", {
					Title = "API Key Valid",
					Text = "Access Granted. Loading script...",
					Duration = 2
				})
				screenGui:Destroy()
				createLoadingScreen()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Alr-Dev/key/refs/heads/main/spjreach.lua", true))()
			else
				game.StarterGui:SetCore("SendNotification", {
					Title = "Invalid API Key",
					Text = "Please try again.",
					Duration = 2
				})
			end
		end)
	end)

	copyButton.MouseButton1Click:Connect(function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Link Copied",
			Text = "You can now paste it in your browser.",
			Duration = 2
		})
		setclipboard('https://link-hub.net/1222082/key-spj-reach')
	end)
end
createKeyGui()

local validKeys = { "SPJ-REACH-0x8G02SD-RJW302-E8PJSO" }

print('========\\//========')
print('==================')
print('Loading Key Verification...')


local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer


local function verifyApiKey(apiKey, callback)

    apiKey = apiKey:gsub("%s+", "") 

    for _, key in pairs(validKeys) do
        if key == apiKey then
            callback(true)  
            return
        end
    end
    callback(false)  
end


local function createKeyGui()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyVerificationGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")


    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui


    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "Enter API Key"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = frame


    local textBox = Instance.new("TextBox")
    textBox.PlaceholderText = "Enter your API key here"
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 18
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    textBox.Size = UDim2.new(1, -20, 0, 40)
    textBox.Position = UDim2.new(0, 10, 0, 40)
    textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Parent = frame

    local submitButton = Instance.new("TextButton")
    submitButton.Text = "Submit"
    submitButton.Font = Enum.Font.SourceSansBold
    submitButton.TextSize = 18
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Size = UDim2.new(0, 100, 0, 40)
    submitButton.Position = UDim2.new(0.5, -50, 0, 90)
    submitButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    submitButton.Parent = frame


    submitButton.MouseButton1Click:Connect(function()
        local inputKey = textBox.Text

    
        verifyApiKey(inputKey, function(isValid)
            if isValid then
                StarterGui:SetCore("SendNotification", {
                    Title = "API Key Valid",
                    Text = "Access Granted. Loading script...",
                    Duration = 2
                })
               
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Alr-Dev/key/refs/heads/main/spjreach.lua", true))()

                
                screenGui:Destroy()
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "Invalid API Key",
                    Text = "Please try again.",
                    Duration = 2
                })
            end
        end)
    end)
end


createKeyGui()
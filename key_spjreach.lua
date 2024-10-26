local validKeys = { "SPJ-REACH-0x50CNSX-ZULTLX-CF6IR5" }
local PaidKeys = {
    'SPJ-REACH-5CEHIDCJ-OBAEAI-UYS0O2',
'SPJ-REACH-ZGKHHOF5-FTEZRP-BIP630',
'SPJ-REACH-JZRBRL7S-DYCRJX-VXXTW7',
'SPJ-REACH-9B0L1WJX-DVHEQJ-HUYX6S',
'SPJ-REACH-E86X4VBS-TISQWV-7AYKMS',
'SPJ-REACH-58CNGA39-FUBCUR-M8C73W',
'SPJ-REACH-893O7CTT-LMDBVJ-U36UFF',
'SPJ-REACH-FK05GAHJ-XIUYHP-SBPAU7',
'SPJ-REACH-A94ZC17D-MXYCHP-2RRW3W',
'SPJ-REACH-0QCJ8QEC-VTJLTD-LPKVJY',
'SPJ-REACH-KRMQNWZ1-PFJUWE-FWM6LI',
'SPJ-REACH-WWRGVC02-JIOTOU-SFHU9Z',
'SPJ-REACH-XBELF0EE-XDYOOC-8JI8BP',
'SPJ-REACH-5DBUB9ZR-BBFTOU-TO1GEC',
'SPJ-REACH-3CQZJU3Y-QOGXAN-XK0I08',
'SPJ-REACH-4RVXLY0U-GVDQCC-SRS4UA',
'SPJ-REACH-G4RLASIN-BVQUNF-LPKP7U',
'SPJ-REACH-IA1AOFLJ-BPBWRA-M7HXEM',
'SPJ-REACH-LLOX2YE8-XBPODH-0A7J4T',
'SPJ-REACH-KG8W7G0R-YPJPJI-4K77RI',
'SPJ-REACH-BGTLH5D9-FCYQVZ-HX1A10',
'SPJ-REACH-CQ14S6QO-FSUDZK-Q9HSZ1',
'SPJ-REACH-6KY9SOBK-XRCKCB-29CVH5',
'SPJ-REACH-IL42FM0L-JLWKZU-STTI3D',
'SPJ-REACH-NZ46ZD73-HPNDKU-WISXO3',
'SPJ-REACH-NFCVPN53-IIMHJI-KHJSWZ',
'SPJ-REACH-CVUSQI88-FHYAYM-O8JZYM',
'SPJ-REACH-FZZ3KE4C-VJCIHA-2W1AKK',
'SPJ-REACH-AO1ZPIKF-GXKRTQ-9H0AJV',
'SPJ-REACH-D2VW3LS7-DDEINP-YY9TPC',
'SPJ-REACH-OKD4VBG5-QQREUL-KSTYIT',
'SPJ-REACH-LPEHBA2E-FJVAHX-32CBQ7',
'SPJ-REACH-VSWKFSGC-GOZASX-05I57Z',
'SPJ-REACH-3OKSZGC3-IMZEZO-2GTU75',
'SPJ-REACH-JC9PJUBT-GCFPJR-AZ568Y',
'SPJ-REACH-B0NRJ4NZ-QNJKCE-PQ18DF',
'SPJ-REACH-CGO3QJLH-RGLKTC-38Y8KQ',
'SPJ-REACH-GB58RRJ4-TODZUW-26MZ9E',
'SPJ-REACH-WA1MB2TL-RAIOTL-V0E5ZD'
}

print('========\\//========')
print('==================')
print('Loading Key Verification...')

local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function verifyApiKey(apiKey, callback)
    -- Remove any leading or trailing spaces
    apiKey = apiKey:gsub("^%s*(.-)%s*$", "%1") 

    -- Verifica as validKeys
    for _, key in pairs(validKeys) do
        if key == apiKey then
            callback(true)  
            return
        end
    end
    
    -- Verifica as PaidKeys
    for _, key in pairs(PaidKeys) do
        if key == apiKey then
            callback(true)  
            return
        end
    end

    -- Caso a key não seja válida
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
                screenGui:Destroy()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Alr-Dev/key/refs/heads/main/spjreach.lua", true))()

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
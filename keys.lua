local validKeys = {"key_0a9xb1p2918k192m"}

print('========\\//========')
print('==================')
print('Loading Key Verification...')


local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui") 
local OrionLib1 = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 




local function verifyApiKey(apiKey, callback)
    for _, key in pairs(validKeys) do
        if key == apiKey then
            callback(true)
            return
        end
    end
    callback(false)
end


local function createKeyWindow()
    local Window13 = OrionLib1:MakeWindow({
        Name = "API KEY",
        HidePremium = false,
        SaveConfig = false,
        ConfigFolder = "OrionTest",
        IntroEnabled = true,  
        IntroText = "Welcome to API Key Verification!",  
        IntroIcon = "rbxassetid://4483345998"  
    })

    local Tab = Window13:MakeTab({
        Name = "Key Input",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    Tab:AddTextbox({
        Name = "Enter API Key",
        Default = "",
        TextDisappear = true,
        Callback = function(apiKey)
            verifyApiKey(apiKey, function(isValid)
                if isValid then
                    StarterGui:SetCore("SendNotification", {
                        Title = "API Key Valid",
                        Text = "Access Granted. Loading script...",
                        Duration = 2
                    })
                    OrionLib1:Destroy()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/viografiko/-/refs/heads/main/pLkAmQpnEwUi.lua"))()

                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "404 error: API Key Invalid",
                        Text = "Invalid API Key. Please try again.",
                        Duration = 2
                    })
                end
            end)
        end
    })
end

createKeyWindow()

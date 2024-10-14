game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
wait(3)
    local Filters = {
    '░██████╗██████╗░░░░░░██╗  ░█████╗░██╗███╗░░░███╗', -- ASCII art needs color red.
    '██╔════╝██╔══██╗░░░░░██║  ██╔══██╗██║████╗░████║',
    '╚█████╗░██████╔╝░░░░░██║  ███████║██║██╔████╔██║',
    '░╚═══██╗██╔═══╝░██╗░░██║  ██╔══██║██║██║╚██╔╝██║',
    '██████╔╝██║░░░░░╚█████╔╝  ██║░░██║██║██║░╚═╝░██║',
    '╚═════╝░╚═╝░░░░░░╚════╝░  ╚═╝░░╚═╝╚═╝╚═╝░░░░░╚═╝',
    'Getting Latest version',
	'Updating',
    'Setting Functions',
    'Setting variables',
    'Setting UI elements',
    'Finished',
     'New update avaiable!',
    '1.3.9',
    'Loading modules', -- Color orange
    'Fetching drawing API', -- Color orange
    'Loading scripts', -- Color orange
    'Getting cursor lock API', -- Color orange
    'Loading functions', -- Color orange
    'Getting Latest version', -- Color orange
    'Up to date', -- Color yellow
    'Starting', -- Color green
    'Script loaded', -- Color green
    'Info', -- Color yellow
    'Instances', -- Color yellow
    'Variables', -- Color yellow
    'ModuleScripts', -- Color yellow
    'Functions', -- Color yellow
    'UI elements', -- Color yellow
    'Closing in', -- Color yellow
};

local CoreGui = game:GetService('CoreGui')
local DevConsoleUI = CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI

local function FindString(str)
    local Found = {}
    for i = 1, #Filters do
        if string.find(str, Filters[i]) then
            table.insert(Found, Filters[i])
        end
    end
    return Found
end

DevConsoleUI.DescendantAdded:Connect(function(ins)
    if ins:IsA('TextLabel') then
        local Found = FindString(ins.Text)
        if #Found ~= 0 then
            ins.RichText = true
            for i = 1, #Found do
                local color = "#e8f31d" -- Default color (yellow)
                if string.find(Found[i], '░██████╗██████╗░░░░░░██╗') or string.find(Found[i], '██╔════╝██╔══██╗░░░░░██║') or string.find(Found[i], '╚█████╗░██████╔╝░░░░░██║') or string.find(Found[i], '░╚═══██╗██╔═══╝░██╗░░██║') or string.find(Found[i], '██████╔╝██║░░░░░╚█████╔╝') or string.find(Found[i], '╚═════╝░╚═╝░░░░░░╚════╝░') then
                    color = "#ff0000" -- Red for ASCII art
                elseif string.find(Found[i], 'Loading modules') or string.find(Found[i], 'Fetching drawing API') or string.find(Found[i], 'Loading scripts') or string.find(Found[i], 'Getting cursor lock API') or string.find(Found[i], 'Loading functions') then
                    color = "#ffa500" -- Orange for loading messages
                elseif string.find(Found[i], 'Starting') or string.find(Found[i], 'Script loaded') or string.find(Found[i], '1.3.9') or string.find(Found[i], 'Updating') or string.find(Found[i], 'Finished') or string.find(Found[i], 'New update avaiable!') or string.find(Found[i], 'Getting Latest version') or string.find(Found[i], 'New update avaiable!') or string.find(Found[i], 'Setting Functions') or string.find(Found[i], 'Setting Variables') or string.find(Found[i], 'Setting UI elements') then
                    color = "#00ff00" -- Green for starting messages
                end
                ins.Text = string.gsub(ins.Text, Found[i], '<font color="'..color..'">'..Found[i]..'</font>')
            end
        end
    end
end)
print('░██████╗██████╗░░░░░░██╗  ░█████╗░██╗███╗░░░███╗')
print('██╔════╝██╔══██╗░░░░░██║  ██╔══██╗██║████╗░████║')
print('╚█████╗░██████╔╝░░░░░██║  ███████║██║██╔████╔██║')
print('░╚═══██╗██╔═══╝░██╗░░██║  ██╔══██║██║██║╚██╔╝██║')
print('██████╔╝██║░░░░░╚█████╔╝  ██║░░██║██║██║░╚═╝░██║')
print('╚═════╝░╚═╝░░░░░░╚════╝░  ╚═╝░░╚═╝╚═╝╚═╝░░░░░╚═╝')
print('​version​ 0.2.2')
warn('[-] Loading modules..')
wait(1)
warn('[-] Loading scripts..')
wait(1)
warn('[-] Loading functions..')
wait(1)
warn('[-] Up to date..')
wait(1)
warn('[-] Started')
wait(1)
game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
-- SPJ Reach
-- Version 0.2.2
-- Variables
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local balls = {}
local lastRefreshTime = os.time()
local reach = 10
local ballOwners = {}
local reachCircle = nil
local ballOwnerEnabled = false
local plagEnabled = false
local plagTouchCount = 0
local plagMaxTouches = 2
local ballColor = Color3.new(1, 0, 0)
local reachColor = Color3.new(0, 0, 1)
local ballNames = {"TPS", "ESA", "MRS", "PRS", "MPS", "XYZ", "ABC", "LMN", "TRS"}
local CurveValue = game:GetService("ReplicatedStorage").Values.CurveMultiplier
-- Functions
local function refreshBalls(force)
    if not force and lastRefreshTime + 2 > os.time() then
        print(translate("refreshTooEarly"))
        return
    end
    lastRefreshTime = os.time()
    table.clear(balls)
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and table.find(ballNames, v.Name) then
            table.insert(balls, v)
            v.Color = ballColor
        end
    end
end

local function moveCircleSmoothly(targetPosition)
    if not reachCircle then
        return
    end

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tweenGoal = {Position = targetPosition}
    local tween = TweenService:Create(reachCircle, tweenInfo, tweenGoal)

    tween:Play()
end

local function createReachCircle()
    if reachCircle then
        reachCircle.Size = Vector3.new(reach * 2, reach * 2, reach * 2)
    else
        reachCircle = Instance.new("Part")
        reachCircle.Parent = Workspace
        reachCircle.Shape = Enum.PartType.Ball
        reachCircle.Size = Vector3.new(reach * 2, reach * 2, reach * 2)
        reachCircle.Anchored = true
        reachCircle.CanCollide = false
        reachCircle.Transparency = 0.8
        reachCircle.Material = Enum.Material.ForceField
        reachCircle.Color = reachColor

        RunService.RenderStepped:Connect(
            function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPosition = player.Character.HumanoidRootPart.Position
                    moveCircleSmoothly(targetPosition)
                end
            end
        )
    end
end

-- Function to handle quantum input
local function onQuantumInputBegan(input, gameProcessedEvent)
    local ignoredKeys = {
        [Enum.KeyCode.W] = true,
        [Enum.KeyCode.A] = true,
        [Enum.KeyCode.S] = true,
        [Enum.KeyCode.D] = true,
        [Enum.KeyCode.Space] = true,
        [Enum.KeyCode.Slash] = true,
        [Enum.KeyCode.Semicolon] = true
    }

    if
        input.UserInputType == Enum.UserInputType.Keyboard and
            (input.KeyCode == Enum.KeyCode.Slash or input.KeyCode == Enum.KeyCode.Semicolon)
     then
        return
    end

    if ignoredKeys[input.KeyCode] then
        return
    end

    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.Comma then
            reach = math.max(1, reach - 1)
            StarterGui:SetCore(
                "SendNotification",
                {
                    Title = "SPJ Reach",
                    Text = translate("reachSetTo") .. reach,
                    Duration = 0.5
                }
            )
            createReachCircle()
        elseif input.KeyCode == Enum.KeyCode.Period then
            reach = reach + 1
            StarterGui:SetCore(
                "SendNotification",
                {
                    Title = "SPJ Reach",
                    Text = translate("reachSetTo") .. reach,
                    Duration = 0.5
                }
            )
            createReachCircle()
        else
            refreshBalls(false)
            for _, legName in pairs({"Right Leg", "Left Leg"}) do
                local leg = player.Character:FindFirstChild(legName)
                if leg then
                    for _, v in pairs(leg:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            for _, e in pairs(balls) do
                                if (e.Position - leg.Position).magnitude < reach then
                                    if ballOwnerEnabled or (not ballOwners[e] or ballOwners[e] == player) then
                                        if plagEnabled then
                                            if plagTouchCount >= plagMaxTouches then
                                                reach = 10
                                                plagTouchCount = 0
                                                StarterGui:SetCore(
                                                    "SendNotification",
                                                    {
                                                        Title = "SPJ Plag",
                                                        Text = "plagMaxReached",
                                                        Duration = 2
                                                    }
                                                )
                                                break
                                            else
                                                plagTouchCount = plagTouchCount + 1
                                            end
                                        end
                                        if not ballOwners[e] then
                                            ballOwners[e] = player
                                        end
                                        firetouchinterest(e, v.Parent, 0)
                                        firetouchinterest(e, v.Parent, 1)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
local AutoGKEnabled = false
local detectionDistance = 10 -- Maximum distance to react to the ball
local smallStep = 2 -- Small step to take before a jump or defense
local minimumDistanceToBall = 1 -- Minimum distance before reacting
-- TABS
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("SPJ Reach", "Default")
local Tab = DrRayLibrary.newTab("Configs", "ImageIdHere")
local EspTab = DrRayLibrary.newTab("Esp", "ImageIdHere")
local Fun = DrRayLibrary.newTab("Fun", "ImageIdHere")
local Auto = DrRayLibrary.newTab("Auto-Farm", "ImageIdHere")
local AutoGK = DrRayLibrary.newTab("Auto-GK", "ImageIdHere")
-- Toggles
AutoGK.newToggle("Auto-GK", "Enables Auto-GK", true, function(toggleState)
    if toggleState then
        AutoGKEnabled = true
    else
        AutoGKEnabled = false
    end
end)
Tab.newSlider("Detection Distance", "", 20, false, function(Value)
    detectionDistance = Value
end)
Tab.newSlider("smallStep", "", 20, false, function(Value)
    smallStep = Value
end)
Tab.newSlider("Minium Distance to ball", "", 5, false, function(Value)
    minimumDistanceToBall = Value
end)
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")

-- Equip GK tool automatically
local function equipGKTool()
    local backpack = player.Backpack
    local gkTool = backpack:FindFirstChild("GKTool") -- Change to the exact name of the GK tool
    if gkTool then
        humanoid:EquipTool(gkTool)
    end
end

-- Press key instantly
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    wait(0.01) -- Short delay for immediate press and release
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

-- Move the player slightly before a jump using humanoid movement (natural walking)
local function moveToSide(side)
    if side == "right" then
        humanoid:Move(Vector3.new(smallStep, 0, 0), true) -- Small step right
        wait(0.1) -- Short delay to allow movement
    elseif side == "left" then
        humanoid:Move(Vector3.new(-smallStep, 0, 0), true) -- Small step left
        wait(0.1)
    end
end

-- Function to find the closest ball
local function getClosestBall()
    local balls = workspace.Balls:GetChildren()
    local closestBall = nil
    local closestDistance = math.huge
    
    for _, ball in ipairs(balls) do
        if ball:IsA("Part") then
            local distance = (ball.Position - rootPart.Position).Magnitude
            if distance < closestDistance then
                closestBall = ball
                closestDistance = distance
            end
        end
    end
    
    return closestBall, closestDistance
end

-- Function to detect ball position (side and height)
local function detectBallPosition(ball)
    if not ball then return nil, nil end
    
    local relativePos = ball.Position - rootPart.Position
    local side, height
    
    -- Detect side
    if relativePos.X > 2 then
        side = "right"
    elseif relativePos.X < -2 then
        side = "left"
    else
        side = "middle"
    end
    
    -- Detect height
    if relativePos.Y > 6 then
        height = "high"
    elseif relativePos.Y < 1 then
        height = "low"
    else
        height = "medium"
    end
    
    return side, height
end

-- Perform the defense action based on ball position
local function performDefense(side, height, distanceToBall)
    -- Only react if the ball is within the detection distance and Auto-GK is enabled
    if not AutoGKEnabled or distanceToBall > detectionDistance or distanceToBall < minimumDistanceToBall then
        return
    end
    
    if height == "high" then
        if side == "right" then
            moveToSide("right") -- Step right
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- Jump
            wait(0.1)
            pressKey(Enum.KeyCode.Q) -- High right jump
        elseif side == "left" then
            moveToSide("left") -- Step left
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- Jump
            wait(0.1)
            pressKey(Enum.KeyCode.E) -- High left jump
        else
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- Jump straight up
            wait(0.1)
            pressKey(Enum.KeyCode.X) -- High middle jump
        end
    elseif height == "low" then
        if side == "right" then
            moveToSide("right") -- Step right
            pressKey(Enum.KeyCode.C) -- Low right defense
        elseif side == "left" then
            moveToSide("left") -- Step left
            pressKey(Enum.KeyCode.Z) -- Low left defense
        else
            pressKey(Enum.KeyCode.V) -- Low middle defense (no side movement)
        end
    else
        if side == "right" then
            moveToSide("right") -- Step right
            pressKey(Enum.KeyCode.Q) -- Medium right defense
        elseif side == "left" then
            moveToSide("left") -- Step left
            pressKey(Enum.KeyCode.E) -- Medium left defense
        else
            pressKey(Enum.KeyCode.V) -- Medium middle defense
        end
    end
end

-- Main loop for real-time tracking and instant defense
local function autoGK()
    equipGKTool() -- Equip GK tool
    
    RunService.Heartbeat:Connect(function()
        local closestBall, distanceToBall = getClosestBall()
        
        if closestBall and distanceToBall <= detectionDistance then
            local side, height = detectBallPosition(closestBall)
            if side and height then
                performDefense(side, height, distanceToBall)
            end
        end
    end)
end

-- Start the Auto-GK
autoGK()
Tab.newToggle("BallOwner", "BallOwner (make u get the ball first)", true, function(toggleState)
    if toggleState then
        ballOwnerEnabled = true
    else
        ballOwnerEnabled = false
    end
end)

Tab.newToggle("Plag", 'Set max touchs on reach', true, function(toggleState)
    if toggleState then
        plagEnabled = true
    else
        plagEnabled = false
    end
end)
Tab.newSlider("Plag", "Set max touchs on reach, 5 = default (no max touch)", 5, false, function(Value)
    plagMaxTouches = Value
end)
Tab.newSlider("Reach", "Set reach default = 1000 (no reach, change for get a reach)", 1000, false, function(Value)
    reach = Value
    createReachCircle()
end)
Tab.newSlider("Change ball curve", "Set ball curve, 20 = default ", 20, false, function(Value)
    CurveValue = Value
end)

-- Auto-Farm
local yOffsetBelowMap = -5 -- Default Y offset below the map
local ballRespawnWaitTime = 5 -- Default ball respawn wait time
local autoFarmEnabled = false

-- Function to start Auto-Farm
local function startAutoFarm()
    local Teams = game:GetService("Teams")
    local Players = game:GetService("Players")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local player = Players.LocalPlayer
    local paths = {
        Away = workspace.BallZones.AwayGoalZone,
        Home = workspace.BallZones.HomeGoalZone
    }
    local ball = workspace:WaitForChild("Balls"):WaitForChild("TPS")
    local goalZone = nil

    -- Determine the correct goal zone
    if player.Team == Teams["Away FC"] then
        goalZone = paths.Home -- Away team targets Home goal
    elseif player.Team == Teams["Home FC"] then
        goalZone = paths.Away -- Home team targets Away goal
    end

    if not goalZone then
        warn("Could not determine the goal zone for the player's team.")
        return
    end

    local originalPosition = player.Character.HumanoidRootPart.CFrame

    local function createNotification(message)
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Ball Status",
                Text = message,
                Duration = 5
            }
        )
    end

    -- Equip the 'Shoot' tool
    local shootTool = player.Backpack:FindFirstChild("Shoot")
    if shootTool then
        player.Character.Humanoid:EquipTool(shootTool)
    end

    local lastBallPosition = ball.Position
    local function isBallStuck()
        local currentBallPosition = ball.Position
        local distanceMoved = (currentBallPosition - lastBallPosition).magnitude
        lastBallPosition = currentBallPosition
        return distanceMoved < 1
    end

    local function enableShiftLock()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    end

    local function rotatePlayerToFaceBall()
        local ballPosition = ball.Position
        local playerPosition = player.Character.HumanoidRootPart.Position
        player.Character.HumanoidRootPart.CFrame = CFrame.lookAt(playerPosition, ballPosition)
    end

    local function teleportPlayerToCorrectPosition(ballPosition, goalPosition)
        local directionToGoal = (goalPosition - ballPosition).unit
        local teleportPosition = ballPosition - (directionToGoal * 5)
        player.Character.HumanoidRootPart.CFrame =
            CFrame.new(teleportPosition.X, teleportPosition.Y + yOffsetBelowMap, teleportPosition.Z)
        rotatePlayerToFaceBall()
    end

    -- Main loop for auto-farm
    enableShiftLock()
    while autoFarmEnabled and (ball.Position - goalZone.Position).magnitude > 5 do
        if ball.Parent == nil then
            local ballRestored = false
            for i = 1, ballRespawnWaitTime do
                wait(1)
                if workspace:FindFirstChild("Balls") and workspace.Balls:FindFirstChild("TPS") then
                    ball = workspace.Balls:FindFirstChild("TPS")
                    ballRestored = true
                    break
                end
            end
            if not ballRestored then
                player.Character.HumanoidRootPart.CFrame = originalPosition
                createNotification("Ball is equal to nil")
                return
            end
        end

        teleportPlayerToCorrectPosition(ball.Position, goalZone.Position)

        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- Mouse button down
        wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) -- Mouse button up

        if isBallStuck() then
            createNotification("Ball is stuck! Adjusting position...")
            teleportPlayerToCorrectPosition(ball.Position, goalZone.Position)
        end

        wait(0.2)
    end

    createNotification("Ball reached the goal!")
end
Auto.newToggle("Enable Auto-Farm", "Auto-Farm", true, function(toggleState)
    if toggleState then
        autoFarmEnabled = true
        if autoFarmEnabled then
            startAutoFarm()
        end
    else
        autoFarmEnabled = false
    end
end)
Auto.newSlider("Change ball wait time respawn", "", 20, false, function(Value)
    ballRespawnWaitTime = Value
end)
Auto.newSlider("Change ball wait time ", "", 20, false, function(Value)
    ballWaitTime = Value
end)
Auto.newSlider("Y Offset Below Map", "", 20, false, function(Value)
    yOffsetBelowMap = Value
end)
-- Fun
local Targets = {"All"} -- Add "All" option for targeting
local AllBool = false

local function GetPlayer(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers, Player) then
            table.remove(GetPlayers, table.find(GetPlayers, Player))
        end
        return GetPlayers[math.random(#GetPlayers)]
    else
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^" .. Name) or x.DisplayName:lower():match("^" .. Name) then
                    return x
                end
            end
        end
    end
end

local function Message(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local function SkidFling(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart
    local THead = TCharacter and TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Targeting is sitting", 5)
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(
                            BasePart,
                            CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                        FPos(
                            BasePart,
                            CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                        FPos(
                            BasePart,
                            CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                        FPos(
                            BasePart,
                            CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                        FPos(
                            BasePart,
                            CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                        FPos(
                            BasePart,
                            CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,
                            CFrame.Angles(math.rad(Angle), 0, 0)
                        )
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or not TargetPlayer.Character or TargetPlayer.Parent ~= Players or
                not TargetPlayer.Character == TCharacter or
                THumanoid.Sit or
                Humanoid.Health <= 0 or
                tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0 / 0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(
                Character:GetChildren(),
                function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end
            )
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
        BV:Destroy()
    else
        return Message("Error Occurred", "Random error", 5)
    end
end
Fun.newDropdown("Dropdown", "Select", {"All"}, function(Value)
    Targets[1] = Value
end)
Fun.newButton("Fling", "", function()
    if AllBool then
        for _, x in next, Players:GetPlayers() do
            SkidFling(x)
        end
    else
        for _, x in next, Targets do
            if GetPlayer(x) and GetPlayer(x) ~= Player then
                if GetPlayer(x).UserId ~= 1414978355 then
                    local TPlayer = GetPlayer(x)
                    if TPlayer then
                        SkidFling(TPlayer)
                    end
                else
                    Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
                end
            elseif not GetPlayer(x) and not AllBool then
                Message("Error Occurred", "Username Invalid", 5)
            end
        end
    end
end)
-- Esp
local ballESP = Drawing.new("Circle")
local tracerESP = Drawing.new("Line")
local distanceLabel = Drawing.new("Text")

-- Configure ESP
ballESP.Size = 0.3
ballESP.Color = Color3.fromRGB(255, 0, 0)
ballESP.Thickness = 1
ballESP.Transparency = 0.1
ballESP.Filled = true

tracerESP.Thickness = 2
tracerESP.Color = Color3.fromRGB(0, 255, 0)
tracerESP.Transparency = 0.5

distanceLabel.Size = 20
distanceLabel.Color = Color3.fromRGB(255, 255, 255)
distanceLabel.Center = true
distanceLabel.Outline = true

local espEnabled = false
local tracersEnabled = false
local distanceEnabled = false

EspTab.newToggle("Enable Esp", "", true, function(toggleState)
    if toggleState then
        espEnabled = true
        ballESP.Visible = espEnabled
        tracerESP.Visible = tracersEnabled and espEnabled
        distanceLabel.Visible = distanceEnabled and espEnabled
    else
        espEnabled = false
    end
end)
EspTab.newToggle("Enable Tracers", "", true, function(toggleState)
    if toggleState then
        tracersEnabled = true
        tracerESP.Visible = tracersEnabled and espEnabled
    else
        tracersEnabled = false
    end
end)
EspTab.newToggle("Enable distance play", "", true, function(toggleState)
    if toggleState then
        distanceEnabled = true
        distanceLabel.Visible = distanceEnabled and espEnabled
    else
        distanceEnabled = false
    end
end)
local function getClosestBall()
    local closestBall = nil
    local closestDistance = math.huge

    for _, ball in pairs(workspace.Balls:GetChildren()) do
        if ball:IsA("Part") then
            local distance = (ball.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestBall = ball
            end
        end
    end

    return closestBall
end

game:GetService("RunService").RenderStepped:Connect(
    function()
        if not espEnabled then
            return
        end

        local closestBall = getClosestBall()

        if closestBall then
            -- Update ball ESP
            local ballPosition, onScreen = workspace.CurrentCamera:WorldToViewportPoint(closestBall.Position)

            if onScreen then
                -- Update drawings
                ballESP.Position = Vector2.new(ballPosition.X, ballPosition.Y)
                ballESP.Visible = espEnabled

                tracerESP.From =
                    Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                tracerESP.To = Vector2.new(ballPosition.X, ballPosition.Y)
                tracerESP.Visible = tracersEnabled

                -- Calculate distance
                local distance = (closestBall.Position - player.Character.HumanoidRootPart.Position).Magnitude

                -- Get the owner of the ball
                local owner = closestBall:FindFirstChild("Owner")
                local ownerName = owner and owner.Value or "Unknown" -- Default to "Unknown" if owner is nil

                -- Ensure ownerName is a string
                if type(ownerName) ~= "string" then
                    ownerName = tostring(ownerName) -- Convert to string if it's not
                end

                -- Update distance label with owner information
                distanceLabel.Position = Vector2.new(ballPosition.X, ballPosition.Y + 20) -- Offset for visibility
                distanceLabel.Text = string.format("Owner: %s\nDistance: %.2f m", ownerName, distance) -- Format the text
                distanceLabel.Visible = distanceEnabled
            else
                -- Hide drawings if not on screen
                ballESP.Visible = false
                tracerESP.Visible = false
                distanceLabel.Visible = false
            end
        else
            -- Hide drawings if no ball is found
            ballESP.Visible = false
            tracerESP.Visible = false
            distanceLabel.Visible = false
        end
    end
)

-- Clean up drawings when the script ends
function cleanup()
    ballESP:Remove()
    tracerESP:Remove()
    distanceLabel:Remove()
end

-- Connect cleanup to the exit
game:GetService("Players").LocalPlayer.AncestryChanged:Connect(
    function(_, parent)
        if not parent then
            cleanup()
        end
    end
)

-- Other
UserInputService.InputBegan:Connect(onQuantumInputBegan)

RunService.RenderStepped:Connect(
    function()
        for _, legName in pairs({"Right Leg", "Left Leg"}) do
            local leg = player.Character:FindFirstChild(legName)
            if leg then
                for _, v in pairs(leg:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        for _, e in pairs(balls) do
                            if (e.Position - leg.Position).magnitude < reach then
                                if not ballOwners[e] then
                                    ballOwners[e] = player
                                    firetouchinterest(e, v.Parent, 0)
                                    firetouchinterest(e, v.Parent, 1)
                                elseif ballOwners[e] == player then
                                    firetouchinterest(e, v.Parent, 0)
                                    firetouchinterest(e, v.Parent, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)

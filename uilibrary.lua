local Library = {}

-- Function to create a window
function Library:CreateWindow(args)
    local window = {
        Name = args.Name or "Window",
        Tabs = {},
        StartY = 100, -- Starting Y position
    }

    -- Function to create a tab
    function window:CreateTab(args)
        local tab = {
            Name = args.Name or "Tab",
            Elements = {},
            StartY = window.StartY, -- Use window's starting Y position
        }

        -- Add the tab to the window
        table.insert(self.Tabs, tab)

        -- Return the tab so elements can be added
        return tab
    end

    -- Return the window object
    return window
end

-- Auto-position elements inside a tab
local function AutoPosition(tab)
    local padding = 10
    for _, element in ipairs(tab.Elements) do
        -- Set the element's position relative to the start
        element.Position = UDim2.new(0, 20, 0, tab.StartY)
        tab.StartY = tab.StartY + (element.Size and element.Size.Y.Offset or 30) + padding
    end
end

-- Button creation
function CreateButton(args)
    local button = {
        Name = args.Name or "Button",
        Size = UDim2.new(0, 200, 0, 30),
        Position = UDim2.new(0, 0, 0, 0), -- Will be auto-positioned
        CallBack = args.CallBack or function() end,
        Background = Drawing.new("Square"),
        Text = Drawing.new("Text")
    }

    -- Setup button properties
    button.Background.Size = Vector2.new(button.Size.X.Offset, button.Size.Y.Offset)
    button.Background.Color = Color3.fromRGB(50, 50, 50)
    button.Background.Position = Vector2.new(button.Position.X.Offset, button.Position.Y.Offset)
    button.Background.Filled = true

    button.Text.Text = button.Name
    button.Text.Size = 16
    button.Text.Color = Color3.fromRGB(255, 255, 255)
    button.Text.Position = Vector2.new(button.Position.X.Offset + 10, button.Position.Y.Offset + 5)

    -- Detect clicks on the button
    function button:Click()
        self.Background.Color = Color3.fromRGB(100, 100, 100)  -- Visual feedback
        self.CallBack()  -- Trigger callback
        wait(0.1)
        self.Background.Color = Color3.fromRGB(50, 50, 50)  -- Reset color
    end

    return button
end

-- Add CreateButton to tabs
function tab:CreateButton(args)
    local button = CreateButton(args)
    table.insert(self.Elements, button)
    AutoPosition(self)
    return button
end

-- Toggle creation
function CreateToggle(args)
    local toggle = {
        Name = args.Name or "Toggle",
        State = args.State or false,
        Size = UDim2.new(0, 200, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        CallBack = args.CallBack or function() end,
        Background = Drawing.new("Square"),
        CheckMark = Drawing.new("Square"),
        Text = Drawing.new("Text")
    }

    -- Setup toggle properties
    toggle.Background.Size = Vector2.new(toggle.Size.X.Offset, toggle.Size.Y.Offset)
    toggle.Background.Color = Color3.fromRGB(50, 50, 50)
    toggle.Background.Position = Vector2.new(toggle.Position.X.Offset, toggle.Position.Y.Offset)
    toggle.Background.Filled = true

    toggle.Text.Text = toggle.Name
    toggle.Text.Size = 16
    toggle.Text.Color = Color3.fromRGB(255, 255, 255)
    toggle.Text.Position = Vector2.new(toggle.Position.X.Offset + 10, toggle.Position.Y.Offset + 5)

    -- Toggle state display
    toggle.CheckMark.Size = Vector2.new(20, 20)
    toggle.CheckMark.Color = toggle.State and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggle.CheckMark.Position = Vector2.new(toggle.Position.X.Offset + 170, toggle.Position.Y.Offset + 5)
    toggle.CheckMark.Filled = true

    -- Detect clicks on the toggle
    function toggle:Click()
        self.State = not self.State
        self.CheckMark.Color = self.State and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        self.CallBack(self.State)  -- Trigger callback with the new state
    end

    return toggle
end

-- Add CreateToggle to tabs
function tab:CreateToggle(args)
    local toggle = CreateToggle(args)
    table.insert(self.Elements, toggle)
    AutoPosition(self)
    return toggle
end

-- Slider creation
function CreateSlider(args)
    local slider = {
        Name = args.Name or "Slider",
        Min = args.Min or 0,
        Max = args.Max or 100,
        Value = args.Value or args.Min,
        Size = UDim2.new(0, 200, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        CallBack = args.CallBack or function() end,
        Background = Drawing.new("Square"),
        Fill = Drawing.new("Square"),
        Text = Drawing.new("Text")
    }

    -- Setup slider properties
    slider.Background.Size = Vector2.new(slider.Size.X.Offset, slider.Size.Y.Offset)
    slider.Background.Color = Color3.fromRGB(50, 50, 50)
    slider.Background.Position = Vector2.new(slider.Position.X.Offset, slider.Position.Y.Offset)
    slider.Background.Filled = true

    slider.Fill.Size = Vector2.new((slider.Value / slider.Max) * slider.Size.X.Offset, slider.Size.Y.Offset)
    slider.Fill.Color = Color3.fromRGB(0, 255, 0)
    slider.Fill.Position = Vector2.new(slider.Position.X.Offset, slider.Position.Y.Offset)
    slider.Fill.Filled = true

    slider.Text.Text = slider.Name .. ": " .. slider.Value
    slider.Text.Size = 16
    slider.Text.Color = Color3.fromRGB(255, 255, 255)
    slider.Text.Position = Vector2.new(slider.Position.X.Offset + 10, slider.Position.Y.Offset + 5)

    -- Function to set the slider value
    function slider:SetValue(newValue)
        self.Value = math.clamp(newValue, self.Min, self.Max)
        self.Fill.Size = Vector2.new((self.Value / self.Max) * self.Size.X.Offset, self.Size.Y.Offset)
        self.Text.Text = self.Name .. ": " .. self.Value
        self.CallBack(self.Value)  -- Trigger callback with the new value
    end

    return slider
end

-- Add CreateSlider to tabs
function tab:CreateSlider(args)
    local slider = CreateSlider(args)
    table.insert(self.Elements, slider)
    AutoPosition(self)
    return slider
end

-- TextBox creation
function CreateTextBox(args)
    local textBox = {
        Name = args.Name or "TextBox",
        Placeholder = args.Placeholder or "Enter text...",
        Size = UDim2.new(0, 200, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        Text = args.Text or "",
        CallBack = args.CallBack or function() end,
        Background = Drawing.new("Square"),
        Text = Drawing.new("Text")
    }

    -- Setup text box properties
    textBox.Background.Size = Vector2.new(textBox.Size.X.Offset, textBox.Size.Y.Offset)
    textBox.Background.Color = Color3.fromRGB(50, 50, 50)
    textBox.Background.Position = Vector2.new(textBox.Position.X.Offset, textBox.Position.Y.Offset)
    textBox.Background.Filled = true

    textBox.Text.Text = textBox.Placeholder
    textBox.Text.Size = 16
    textBox.Text.Color = Color3.fromRGB(255, 255, 255)
    textBox.Text.Position = Vector2.new(textBox.Position.X.Offset + 10, textBox.Position.Y.Offset + 5)

    -- Function to submit text
    function textBox:Submit(inputText)
        self.Text = inputText
        self.CallBack(self.Text)  -- Trigger callback with the text input
    end

    return textBox
end

-- Add CreateTextBox to tabs
function tab:CreateTextBox(args)
    local textBox = CreateTextBox(args)
    table.insert(self.Elements, textBox)
    AutoPosition(self)
    return textBox
end

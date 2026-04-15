-- [[ Akbarshox-UI v12.9 - UNIVERSAL VERSION ]] --

local Library = {}
local ts = game:GetService("TweenService")
local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(name, animSpeed)
    if pgui:FindFirstChild("AkbarshoxUI") then
        pgui:FindFirstChild("AkbarshoxUI"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", pgui)
    ScreenGui.Name = "AkbarshoxUI"
    ScreenGui.ResetOnSpawn = false
-- [[ Akbarshox-UI v13.0 - PRO VERSION ]] --

local Library = {}
local ts = game:GetService("TweenService")
local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(name, animSpeed)
    if pgui:FindFirstChild("AkbarshoxUI") then
        pgui:FindFirstChild("AkbarshoxUI"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", pgui)
    ScreenGui.Name = "AkbarshoxUI"
    ScreenGui.ResetOnSpawn = false
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.Position = UDim2.new(0.5, -130, 0.5, -130)
    Main.Size = UDim2.new(0, 260, 0, 0)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true
    Main.BackgroundTransparency = 1
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    
    local UIGrad = Instance.new("UIGradient", Main)
    UIGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    UIGrad.Rotation = 45
    
    local running = true
    task.spawn(function()
        while running do
            local t = ts:Create(UIGrad, TweenInfo.new(3, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 1)})
            t:Play()
            t.Completed:Wait()
            UIGrad.Offset = Vector2.new(-1, -1)
        end
    end)

    ts:Create(Main, TweenInfo.new(animSpeed or 0.8, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 260, 0, 320), BackgroundTransparency = 0}):Play()

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0.08, 0, 0, 0)
    Title.Text = name or "Akbarshox-UI"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Content = Instance.new("ScrollingFrame", Main)
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -10, 1, -55)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.ScrollBarThickness = 2
    Content.ScrollBarImageColor3 = Color3.fromRGB(220, 0, 0)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.BorderSizePixel = 0
    
    local layout = Instance.new("UIListLayout", Content)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 8)
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    -- Кнопки управления (Закрыть/Свернуть)
    local function CreateHeadBtn(text, pos, color, callback)
        local btn = Instance.new("TextButton", TopBar)
        btn.Size = UDim2.new(0, 35, 0, 35)
        btn.Position = pos
        btn.Text = text
        btn.TextColor3 = color
        btn.BackgroundTransparency = 1
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 22
        btn.MouseButton1Click:Connect(callback)
    end

    CreateHeadBtn("×", UDim2.new(0.85, 0, 0, 5), Color3.fromRGB(255, 60, 60), function() 
        running = false
        ScreenGui:Destroy()
    end)

    local WindowFunctions = {}

    -- [[ 1. BUTTON ]] --
    function WindowFunctions:CreateButton(text, callback)
        local btn = Instance.new("TextButton", Content)
        btn.Size = UDim2.new(0.9, 0, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(callback)
    end

    -- [[ 2. TOGGLE ]] --
    function WindowFunctions:CreateToggle(text, callback)
        local state = false
        local togFrame = Instance.new("TextButton", Content)
        togFrame.Size = UDim2.new(0.9, 0, 0, 38)
        togFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        togFrame.Text = "  " .. text
        togFrame.TextColor3 = Color3.new(1, 1, 1)
        togFrame.Font = Enum.Font.GothamMedium
        togFrame.TextSize = 14
        togFrame.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", togFrame).CornerRadius = UDim.new(0, 8)

        local indicator = Instance.new("Frame", togFrame)
        indicator.Size = UDim2.new(0, 20, 0, 20)
        indicator.Position = UDim2.new(0.85, 0, 0.25, 0)
        indicator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

        togFrame.MouseButton1Click:Connect(function()
            state = not state
            ts:Create(indicator, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(220, 0, 0) or Color3.fromRGB(60, 60, 60)}):Play()
            callback(state)
        end)
    end

    -- [[ 3. SLIDER ]] --
    function WindowFunctions:CreateSlider(text, min, max, callback)
        local sliderFrame = Instance.new("Frame", Content)
        sliderFrame.Size = UDim2.new(0.9, 0, 0, 45)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 8)

        local label = Instance.new("TextLabel", sliderFrame)
        label.Size = UDim2.new(1, 0, 0, 25)
        label.Text = "  " .. text
        label.TextColor3 = Color3.new(1, 1, 1)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left

        local bar = Instance.new("Frame", sliderFrame)
        bar.Size = UDim2.new(0.8, 0, 0, 4)
        bar.Position = UDim2.new(0.1, 0, 0.7, 0)
        bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(220, 0, 0)

        local button = Instance.new("TextButton", bar)
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundTransparency = 1
        button.Text = ""

        local function update()
            local mousePos = game:GetService("UserInputService"):GetMouseLocation().X
            local barPos = bar.AbsolutePosition.X
            local barSize = bar.AbsoluteSize.X
            local percent = math.clamp((mousePos - barPos) / barSize, 0, 1)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            local value = math.floor(min + (max - min) * percent)
            label.Text = "  " .. text .. ": " .. tostring(value)
            callback(value)
        end

        button.MouseButton1Down

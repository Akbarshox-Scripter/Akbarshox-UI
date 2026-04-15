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
    
    local speed = animSpeed or 0.8
    local info = TweenInfo.new(speed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
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

    ts:Create(Main, info, {
        Size = UDim2.new(0, 260, 0, 280),
        BackgroundTransparency = 0
    }):Play()

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
        local close = ts:Create(Main, info, {Size = UDim2.new(0, 260, 0, 0), BackgroundTransparency = 1})
        close:Play()
        close.Completed:Connect(function() ScreenGui:Destroy() end)
    end)

    local minimized = false
    CreateHeadBtn("-", UDim2.new(0.72, 0, 0, 5), Color3.new(1, 1, 1), function()
        minimized = not minimized
        ts:Create(Main, info, {
            Size = minimized and UDim2.new(0, 260, 0, 45) or UDim2.new(0, 260, 0, 280)
        }):Play()
        Content.Visible = not minimized
    end)

    local WindowFunctions = {}

    function WindowFunctions:AddLabel(text)
        local lab = Instance.new("TextLabel", Content)
        lab.Size = UDim2.new(0.9, 0, 0, 25)
        lab.BackgroundTransparency = 1
        lab.Text = text
        lab.TextColor3 = Color3.fromRGB(200, 200, 200)
        lab.Font = Enum.Font.Gotham
        lab.TextSize = 12
    end

    function WindowFunctions:CreateButton(text, callback)
        local btn = Instance.new("TextButton", Content)
        btn.Size = UDim2.new(0.9, 0, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(callback)
    end

    function WindowFunctions:CreateTextBox(placeholder, callback)
        local box = Instance.new("TextBox", Content)
        box.Size = UDim2.new(0.9, 0, 0, 38)
        box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        box.PlaceholderText = placeholder
        box.Text = ""
        box.TextColor3 = Color3.new(1, 1, 1)
        box.Font = Enum.Font.Gotham
        box.TextSize = 13
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        box.FocusLost:Connect(function(ep) if ep then callback(box.Text) box.Text = "" end end)
    end

    return WindowFunctions
end

-- Этот блок проверяет: если ты запустил код в Executor, меню откроется. 
-- Если через loadstring — сработает return Library.
if not getgenv().Executed_Akbarshox then
    Library:CreateWindow("Akbarshox-UI", 0.8)
end

return Library

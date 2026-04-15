-- [[ Akbarshox-UI v13.2 - SLIDER & BOX FIX ]] --

local Library = {}
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(name, animSpeed)
    if pgui:FindFirstChild("AkbarshoxUI") then pgui:FindFirstChild("AkbarshoxUI"):Destroy() end

    local ScreenGui = Instance.new("ScreenGui", pgui)
    ScreenGui.Name = "AkbarshoxUI"
    ScreenGui.ResetOnSpawn = false
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.Position = UDim2.new(0.5, -130, 0.5, -130)
    Main.Size = UDim2.new(0, 260, 0, 0)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    
    local UIGrad = Instance.new("UIGradient", Main)
    UIGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    UIGrad.Rotation = 45
    
    task.spawn(function()
        while Main.Parent do
            ts:Create(UIGrad, TweenInfo.new(3, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 1)}):Play()
            task.wait(3)
            UIGrad.Offset = Vector2.new(-1, -1)
        end
    end)

    ts:Create(Main, TweenInfo.new(animSpeed or 0.8, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 260, 0, 320)}):Play()

    local Content = Instance.new("ScrollingFrame", Main)
    Content.Size = UDim2.new(1, -10, 1, -55)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 2
    
    local layout = Instance.new("UIListLayout", Content)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 8)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0.08, 0, 0, 0)
    Title.Text = name or "Akbarshox UI"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local WindowFunctions = {}

    function WindowFunctions:AddLabel(text)
        local l = Instance.new("TextLabel", Content)
        l.Size = UDim2.new(0.9, 0, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(180, 180, 180)
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        return l
    end

    function WindowFunctions:CreateButton(text, callback)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.9, 0, 0, 35)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.Text = text
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamMedium
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(callback)
        return b
    end

    function WindowFunctions:CreateToggle(text, callback)
        local s = false
        local t = Instance.new("TextButton", Content)
        t.Size = UDim2.new(0.9, 0, 0, 35)
        t.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        t.Text = "  " .. text
        t.TextColor3 = Color3.new(1,1,1)
        t.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 6)

        local ind = Instance.new("Frame", t)
        ind.Size = UDim2.new(0, 16, 0, 16)
        ind.Position = UDim2.new(1, -25, 0.5, -8)
        ind.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

        t.MouseButton1Click:Connect(function()
            s = not s
            ts:Create(ind, TweenInfo.new(0.2), {BackgroundColor3 = s and Color3.fromRGB(220, 0, 0) or Color3.fromRGB(60, 60, 60)}):Play()
            callback(s)
        end)
        return t
    end

    function WindowFunctions:CreateSlider(text, min, max, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(0.9, 0, 0, 45)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

        local lab = Instance.new("TextLabel", frame)
        lab.Size = UDim2.new(1, 0, 0, 25)
        lab.Text = "  "..text..": "..min
        lab.TextColor3 = Color3.new(1,1,1)
        lab.BackgroundTransparency = 1
        lab.TextXAlignment = Enum.TextXAlignment.Left

        local bg = Instance.new("Frame", frame)
        bg.Size = UDim2.new(0.85, 0, 0, 4)
        bg.Position = UDim2.new(0.07, 0, 0.7, 0)
        bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

        local fill = Instance.new("Frame", bg)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(220, 0, 0)

        local dragging = false
        local function update()
            local inputPos = uis:GetMouseLocation().X
            local relPos = math.clamp((inputPos - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(relPos, 0, 1, 0)
            local val = math.floor(min + (max - min) * relPos)
            lab.Text = "  "..text..": "..val
            callback(val)
        end

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
        end)
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        uis.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update() end
        end)
        return frame
    end

    function WindowFunctions:CreateTextBox(placeholder, callback)
        local b = Instance.new("TextBox", Content)
        b.Size = UDim2.new(0.9, 0, 0, 35)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.PlaceholderText = placeholder
        b.Text = ""
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.Gotham
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        
        b.FocusLost:Connect(function(enter)
            if enter then 
                callback(b.Text)
                b.Text = "" -- Очищаем после ввода
            end
        end)
        return b
    end

    return WindowFunctions
end

return Library

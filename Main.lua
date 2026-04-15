-- [[ Akbarshox-UI v13.4 - MOBILE PREMIUM FIX ]] --

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
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    UIGrad.Rotation = 45
    
    task.spawn(function()
        while Main.Parent do
            local t = ts:Create(UIGrad, TweenInfo.new(3, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 1)})
            t:Play()
            t.Completed:Wait()
            UIGrad.Offset = Vector2.new(-1, -1)
        end
    end)

    ts:Create(Main, TweenInfo.new(animSpeed or 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 260, 0, 320),
        BackgroundTransparency = 0
    }):Play()

    local Content = Instance.new("ScrollingFrame", Main)
    Content.Size = UDim2.new(1, -10, 1, -55)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 2
    Content.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    
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
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0.08, 0, 0, 0)
    Title.Text = name or "Akbarshox UI"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- === ВОТ ОНИ, ВЕРНУВШИЕСЯ КНОПКИ ЗАКРЫТИЯ === --
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
        ScreenGui:Destroy()
    end)

    local minimized = false
    CreateHeadBtn("-", UDim2.new(0.72, 0, 0, 5), Color3.new(1, 1, 1), function()
        minimized = not minimized
        ts:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Size = minimized and UDim2.new(0, 260, 0, 45) or UDim2.new(0, 260, 0, 320)
        }):Play()
        Content.Visible = not minimized
    end)
    -- ============================================= --

    local WindowFunctions = {}

    local function ApplyStyle(obj)
        obj.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        obj.BackgroundTransparency = 0.2
        Instance.new("UICorner", obj).CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", obj)
        stroke.Color = Color3.fromRGB(255, 0, 0)
        stroke.Thickness = 0.5
        stroke.Transparency = 0.6
    end

    function WindowFunctions:AddLabel(text)
        local l = Instance.new("TextLabel", Content)
        l.Size = UDim2.new(0.9, 0, 0, 25)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.fromRGB(200, 200, 200)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 11
        return l
    end

    function WindowFunctions:CreateButton(text, callback)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.9, 0, 0, 35)
        b.Text = text
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 13
        ApplyStyle(b)
        b.MouseButton1Click:Connect(function()
            ts:Create(b, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
            task.wait(0.1)
            ts:Create(b, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()
            callback()
        end)
        return b
    end

    function WindowFunctions:CreateToggle(text, callback)
        local s = false
        local t = Instance.new("TextButton", Content)
        t.Size = UDim2.new(0.9, 0, 0, 35)
        t.Text = "  " .. text
        t.TextColor3 = Color3.new(1,1,1)
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.Font = Enum.Font.GothamMedium
        ApplyStyle(t)

        local ind = Instance.new("Frame", t)
        ind.Size = UDim2.new(0, 24, 0, 12)
        ind.Position = UDim2.new(1, -35, 0.5, -6)
        ind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

        local dot = Instance.new("Frame", ind)
        dot.Size = UDim2.new(0, 10, 0, 10)
        dot.Position = UDim2.new(0, 1, 0.5, -5)
        dot.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        t.MouseButton1Click:Connect(function()
            s = not s
            ts:Create(dot, TweenInfo.new(0.2), {Position = s and UDim2.new(1, -11, 0.5, -5) or UDim2.new(0, 1, 0.5, -5)}):Play()
            ts:Create(ind, TweenInfo.new(0.2), {BackgroundColor3 = s and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 50, 50)}):Play()
            callback(s)
        end)
        return t
    end

    function WindowFunctions:CreateSlider(text, min, max, callback)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.9, 0, 0, 45)
        ApplyStyle(f)

        local lab = Instance.new("TextLabel", f)
        lab.Size = UDim2.new(1, 0, 0, 25)
        lab.Text = "  "..text..": "..min
        lab.TextColor3 = Color3.new(1,1,1)
        lab.BackgroundTransparency = 1
        lab.Font = Enum.Font.Gotham
        lab.TextXAlignment = Enum.TextXAlignment.Left

        local bg = Instance.new("Frame", f)
        bg.Size = UDim2.new(0.85, 0, 0, 4)
        bg.Position = UDim2.new(0.07, 0, 0.75, 0)
        bg.BackgroundColor3 = Color3.fromRGB(50, 50

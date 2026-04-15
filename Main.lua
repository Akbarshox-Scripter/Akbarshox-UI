-- [[ Akbarshox-UI v14.0 - PREMIUM MOBILE FIX ]] --
local Library = {}
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(name)
    if pgui:FindFirstChild("AkbarshoxUI") then pgui:FindFirstChild("AkbarshoxUI"):Destroy() end

    local ScreenGui = Instance.new("ScreenGui", pgui)
    ScreenGui.Name = "AkbarshoxUI"
    ScreenGui.ResetOnSpawn = false
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Main.Position = UDim2.new(0.5, -130, 0.5, -130)
    Main.Size = UDim2.new(0, 260, 0, 320)
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    
    -- ПРЕМИУМ ЭФФЕКТ (ОБВОДКА)
    local UIStroke = Instance.new("UIStroke", Main)
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local UIGrad = Instance.new("UIGradient", UIStroke)
    UIGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Text = name or "Akbarshox Hub"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- КНОПКИ УПРАВЛЕНИЯ
    local btns = Instance.new("Frame", TopBar)
    btns.Size = UDim2.new(0, 80, 1, 0)
    btns.Position = UDim2.new(1, -85, 0, 0)
    btns.BackgroundTransparency = 1

    local function CreateHeadBtn(text, color, callback)
        local b = Instance.new("TextButton", btns)
        b.Size = UDim2.new(0, 35, 0, 35)
        b.BackgroundTransparency = 1
        b.Text = text
        b.TextColor3 = color
        b.TextSize = 25
        b.Font = Enum.Font.GothamBold
        b.MouseButton1Click:Connect(callback)
        return b
    end

    local close = CreateHeadBtn("×", Color3.fromRGB(255, 50, 50), function() ScreenGui:Destroy() end)
    close.Position = UDim2.new(0.5, 5, 0.1, 0)

    local minimize = CreateHeadBtn("-", Color3.fromRGB(255, 255, 255), function()
        local state = Main.Size.Y.Offset > 50
        ts:Create(Main, TweenInfo.new(0.3), {Size = state and UDim2.new(0, 260, 0, 45) or UDim2.new(0, 260, 0, 320)}):Play()
    end)
    minimize.Position = UDim2.new(0, 0, 0.1, 0)

    local Content = Instance.new("ScrollingFrame", Main)
    Content.Size = UDim2.new(1, -10, 1, -55)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.ScrollBarThickness = 0
    Content.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    local layout = Instance.new("UIListLayout", Content)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 10)

    local Funcs = {}

    function Funcs:CreateButton(text, callback)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.9, 0, 0, 40)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(callback)
    end

    function Funcs:CreateSlider(text, min, max, callback)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.9, 0, 0, 55)
        f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        local lab = Instance.new("TextLabel", f)
        lab.Size = UDim2.new(1, 0, 0, 30)
        lab.Text = text..": "..min
        lab.TextColor3 = Color3.new(1,1,1)
        lab.BackgroundTransparency = 1
        local bg = Instance.new("Frame", f)
        bg.Size = UDim2.new(0.8, 0, 0, 4)
        bg.Position = UDim2.new(0.1, 0, 0.7, 0)
        bg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        local fill = Instance.new("Frame", bg)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        local function update(input)
            local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            lab.Text = text..": "..val
            callback(val)
        end
        local dragging = false
        f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true update(i) end end)
        uis.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
        uis.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
    end

    function Funcs:CreateTextBox(placeholder, callback)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.9, 0, 0, 40)
        f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
        
        local t = Instance.new("TextBox", f)
        t.Size = UDim2.new(1, -20, 1, 0)
        t.Position = UDim2.new(0, 10, 0, 0)
        t.BackgroundTransparency = 1
        t.PlaceholderText = placeholder
        t.Text = ""
        t.TextColor3 = Color3.new(1, 1, 1)
        t.ClearTextOnFocus = true
        
        -- ПОЧИНКА ТЕКСТБОКСА ДЛЯ МОБИЛКИ
        t.FocusLost:Connect(function(enter)
            if t.Text ~= "" then
                callback(t.Text)
                print("Applied:", t.Text)
            end
        end)
    end

    return Funcs
end
return Library

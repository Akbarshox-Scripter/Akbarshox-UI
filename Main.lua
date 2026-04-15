-- [[ Akbarshox-UI v13.6 - EMERGENCY FIX ]] --
local Library = {}
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(name)
    -- Удаляем старое меню, если оно есть
    if pgui:FindFirstChild("AkbarshoxUI") then pgui:FindFirstChild("AkbarshoxUI"):Destroy() end

    local ScreenGui = Instance.new("ScreenGui", pgui)
    ScreenGui.Name = "AkbarshoxUI"
    ScreenGui.ResetOnSpawn = false
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "Main"
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.Position = UDim2.new(0.5, -130, 0.5, -130)
    Main.Size = UDim2.new(0, 260, 0, 320) -- Фиксированный размер для теста
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    
    local UIGrad = Instance.new("UIGradient", Main)
    UIGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    UIGrad.Rotation = 45

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0.1, 0, 0, 0)
    Title.Text = name or "Akbarshox UI"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Кнопка закрытия
    local close = Instance.new("TextButton", TopBar)
    close.Size = UDim2.new(0, 35, 0, 35)
    close.Position = UDim2.new(0.85, 0, 0, 5)
    close.Text = "×"
    close.TextColor3 = Color3.fromRGB(255, 60, 60)
    close.BackgroundTransparency = 1
    close.TextSize = 25
    close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Content = Instance.new("ScrollingFrame", Main)
    Content.Size = UDim2.new(1, -10, 1, -55)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    local layout = Instance.new("UIListLayout", Content)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 8)

    local WindowFunctions = {}

    function WindowFunctions:CreateButton(text, callback)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.9, 0, 0, 35)
        b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(callback)
        return b
    end

    function WindowFunctions:CreateSlider(text, min, max, callback)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.9, 0, 0, 50)
        f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

        local lab = Instance.new("TextLabel", f)
        lab.Size = UDim2.new(1, 0, 0, 25)
        lab.Text = "  "..text..": "..min
        lab.TextColor3 = Color3.new(1, 1, 1)
        lab.BackgroundTransparency = 1

        local bg = Instance.new("Frame", f)
        bg.Size = UDim2.new(0.8, 0, 0, 6)
        bg.Position = UDim2.new(0.1, 0, 0.7, 0)
        bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

        local fill = Instance.new("Frame", bg)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

        local dragging = false
        local function UpdateSlider(input)
            local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            lab.Text = "  "..text..": "..val
            callback(val)
        end

        f.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                UpdateSlider(input)
            end
        end)
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                UpdateSlider(input)
            end
        end)
        return f
    end

    return WindowFunctions
end

return Library

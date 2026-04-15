# Akbarshox-UI
# 🔴 Akbarshox-UI Framework v1.0
> **Premium, lightweight, and mobile-friendly UI library for Roblox.**

---

## 📖 Library Documentation (API Guide)

This guide explains how to use each function in the **Akbarshox-UI** framework to build your own scripts.

### 1. Booting the Library
Always put this line at the very top of your script to load the UI from GitHub:

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Akbarshox-Scripter/Akbarshox-UI/main/Main.lua'))()

### 2. Creating a Window (CreateWindow)
This function creates the main frame of your menu.
* **name** — The title shown at the top.
* **speed** — Animation opening speed (Recommended: 0.7).

local Win = Library:CreateWindow('Akbarshox UI', 0.7)

### 3. Adding Labels (AddLabel)
Use this for non-clickable text, like version info or credits.

Win:AddLabel('Status: Active')

### 4. Creating Buttons (CreateButton)
The callback (the code inside) runs every time the button is clicked.

Win:CreateButton('Set WalkSpeed 100', function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

### 5. Creating TextBoxes (CreateTextBox)
Allows users to type in their own values (numbers or text).

Win:CreateTextBox('Enter JumpPower...', function(text)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(text)
end)

---

## 🚀 Full Template (Example)

Copy this code to see a working example of the UI in action:

local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Akbarshox-Scripter/Akbarshox-UI/main/Main.lua'))()
local Main = Lib:CreateWindow('My Script', 0.6)

Main:AddLabel('Welcome to my script!')

Main:CreateButton('Destroy UI', function()
    game:GetService('CoreGui').AkbarshoxUI_Premium:Destroy()
end)

Main:CreateTextBox('Custom FOV...', function(val)
    game.Workspace.CurrentCamera.FieldOfView = tonumber(val)
end)

---

## 👤 Developer
* **Creator:** Akbarshox-Scripter
* **Platform:** Roblox (Luau)
* **License:** MIT

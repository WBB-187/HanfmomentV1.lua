--[[
    Script: omamilch V5 (Ultimate Fix)
    User: HanfmomentV1
    Key: HanfmomentV1
]]

local vs = game:GetService("VirtualUser")
local player = game.Players.LocalPlayer
shared.stop = false

-- Falls noch eine alte GUI da ist, weg damit
if player.PlayerGui:FindFirstChild("OmamilchV5_GUI") then
    player.PlayerGui.OmamilchV5_GUI:Destroy()
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "OmamilchV5_GUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 320)
Main.Position = UDim2.new(0.5, -125, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "omamilch V5 - ULTIMATE FIX"
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold für HanfmomentV1

local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0.9, 0, 0, 150)
Input.Position = UDim2.new(0.05, 0, 0.15, 0)
Input.Text = "hlz[zt] [xo] [xd] o s|lzx[zuh] [va] [vf]"
Input.PlaceholderText = "Sheets hier rein..."
Input.TextWrapped = true
Input.ClearTextOnFocus = false

-- SPEED SLIDER (Neu hinzugefügt für German Voice)
local SpeedLabel = Instance.new("TextLabel", Main)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0.65, 0)
SpeedLabel.Text = "Tempo: 280s (Standard)"
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

-- FUNKTION: Taste drücken (Angepasst an German Voice PC)
local function press(key)
    if not key or key == "" then return end
    -- Wir senden KeyDown UND einen Virtual Click, um sicherzugehen
    vs:CaptureController()
    vs:TypeKey(key:lower()) -- Nutzt TypeKey statt nur KeyDown (oft stabiler auf PC)
    -- Zusätzlicher kleiner Delay für die Spiel-Engine
    task.wait(0.03) 
end

local function play()
    local sheet = Input.Text
    local ftime = 280 -- Sekunden für den Song
    local nstr = string.gsub(sheet, "[[\]\n]", "")
    local delay = ftime / (string.len(nstr) / 1.05)

    local i = 1
    while i <= #sheet do
        if shared.stop then break end
        local c = sheet:sub(i, i)

        if c == "[" then
            -- Akkord Start
            local chord = ""
            i = i + 1
            while sheet:sub(i, i) ~= "]" and i <= #sheet do
                chord = chord .. sheet:sub(i, i)
                i = i + 1
            end
            -- Akkord abspielen
            for j = 1, #chord do
                task.spawn(function() press(chord:sub(j, j)) end)
            end
            task.wait(delay)
        elseif c == " " then
            task.wait(delay)
        elseif c == "|" then
            task.wait(delay * 2)
        else
            -- Einzelnote
            press(c)
            task.wait(delay)
        end
        i = i + 1
    end
end

-- BUTTONS
local Start = Instance.new("TextButton", Main)
Start.Size = UDim2.new(0.4, 0, 0, 40)
Start.Position = UDim2.new(0.05, 0, 0.8, 0)
Start.Text = "START"
Start.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
Start.MouseButton1Click:Connect(function()
    shared.stop = false
    task.spawn(play)
end)

local Stop = Instance.new("TextButton", Main)
Stop.Size = UDim2.new(0.4, 0, 0, 40)
Stop.Position = UDim2.new(0.55, 0, 0.8, 0)
Stop.Text = "STOP"
Stop.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Stop.MouseButton1Click:Connect(function()
    shared.stop = true
end)

print("omamilch V5 Ultimate Fix wurde geladen!")

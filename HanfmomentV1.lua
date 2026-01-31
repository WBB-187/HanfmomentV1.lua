--[[
    Script: omamilch V5 (Internal GUI)
    User: HanfmomentV1
    Key: HanfmomentV1
]]

-- Konfiguration
shared.stop = false
shared.ftime = 280
shared.scr = "hlz[zt] [xo] [xd] o s|lzx[zuh] [va] [vf] a h" -- Test Song

local vs = game:GetService("VirtualUser")
local player = game.Players.LocalPlayer

-- UI ERSTELLUNG (Keine externe Library nötig)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartBtn = Instance.new("TextButton")
local StopBtn = Instance.new("TextButton")
local InputBox = Instance.new("TextBox")

ScreenGui.Name = "OmamilchV5_GUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Du kannst das Fenster ziehen

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "omamilch V5 | HanfmomentV1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

InputBox.Parent = MainFrame
InputBox.PlaceholderText = "Noten hier einfuegen..."
InputBox.Size = UDim2.new(0.9, 0, 0, 100)
InputBox.Position = UDim2.new(0.05, 0, 0.2, 0)
InputBox.Text = shared.scr
InputBox.TextWrapped = true

-- PLAYER LOGIK
local function playSong()
    local str = InputBox.Text
    local nstr = string.gsub(str, "[[\]\n]", "")
    local delay = shared.ftime / (string.len(nstr) / 1.05)
    
    local queue = ""
    local rem = true

    for i = 1, #str do
        if shared.stop then break end
        local c = str:sub(i, i)
        
        if c == "[" then
            rem = false
            continue
        elseif c == "]" then
            rem = true
            for ii = 1, #queue do
                vs:SetKeyDown(queue:sub(ii, ii))
                task.wait()
            end
            task.wait()
            for ii = 1, #queue do
                vs:SetKeyUp(queue:sub(ii, ii))
                task.wait()
            end
            queue = ""
            task.wait(delay)
            continue
        elseif c == " " then
            task.wait(delay)
            continue
        end
        
        if not rem then
            queue = queue .. c
            continue
        end
        
        vs:SetKeyDown(c)
        task.wait()
        vs:SetKeyUp(c)
        task.wait(delay)
    end
end

-- BUTTONS
StartBtn.Parent = MainFrame
StartBtn.Text = "START"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartBtn.Size = UDim2.new(0.4, 0, 0, 40)
StartBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
StartBtn.MouseButton1Click:Connect(function()
    shared.stop = false
    task.spawn(playSong)
end)

StopBtn.Parent = MainFrame
StopBtn.Text = "STOP"
StopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
StopBtn.Size = UDim2.new(0.4, 0, 0, 40)
StopBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
StopBtn.MouseButton1Click:Connect(function()
    shared.stop = true
end)

print("omamilch V5 stabil geladen für HanfmomentV1!")

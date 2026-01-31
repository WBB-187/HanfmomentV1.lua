--[[
    Script: omamilch V5 (PC FIX)
    User: HanfmomentV1
    Key: HanfmomentV1
]]

-- Globale Einstellungen
shared.stop = false
shared.ftime = 280
shared.scr = "hlz[zt] [xo] [xd] o s|lzx[zuh] [va] [vf] a h" 

local vs = game:GetService("VirtualUser")
local player = game.Players.LocalPlayer

-- UI ENTFERNEN FALLS VORHANDEN
if player.PlayerGui:FindFirstChild("OmamilchV5_GUI") then
    player.PlayerGui.OmamilchV5_GUI:Destroy()
end

-- UI ERSTELLUNG
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
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -150)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "omamilch V5 | PC FIXED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)

InputBox.Parent = MainFrame
InputBox.PlaceholderText = "Sheets hier rein..."
InputBox.Size = UDim2.new(0.9, 0, 0, 120)
InputBox.Position = UDim2.new(0.05, 0, 0.2, 0)
InputBox.Text = shared.scr
InputBox.ClearTextOnFocus = false
InputBox.TextWrapped = true

-- VERBESSERTE PLAYER LOGIK FÜR PC
local function playSong()
    local str = InputBox.Text
    -[span_0](start_span)- Berechne Delay basierend auf dem Original-Script[span_0](end_span)
    local nstr = string.gsub(str, "[[\]\n]", "")
    local delay = shared.ftime / (string.len(nstr) / 1.05)
    
    local queue = ""
    local inChord = false

    for i = 1, #str do
        if shared.stop then break end
        local c = str:sub(i, i)
        
        if c == "[" then
            inChord = true
            continue
        elseif c == "]" then
            inChord = false
            -[span_1](start_span)- Akkord abspielen (Alle Tasten gleichzeitig runter, dann hoch)[span_1](end_span)
            for ii = 1, #queue do
                vs:CaptureController() -- Fokus auf Fenster erzwingen
                vs:SetKeyDown(queue:sub(ii, ii))
            end
            task.wait(0.05) -- Kurze Haltezeit für PC Registrierung
            for ii = 1, #queue do
                vs:SetKeyUp(queue:sub(ii, ii))
            end
            queue = ""
            task.wait(delay)
            continue
        elseif c == " " then
            task.wait(delay)
            continue
        elseif c == "|" then
            task.wait(delay * 2)
            continue
        end
        
        if inChord then
            queue = queue .. c
            continue
        end
        
        -- Einzelnote mit CaptureController für besseren Fokus
        vs:CaptureController()
        vs:SetKeyDown(c)
        task.wait(0.02) -- Wichtig für PC: Taste muss kurz gehalten werden
        vs:SetKeyUp(c)
        task.wait(delay)
    end
end

-- BUTTON EVENTS
StartBtn.Parent = MainFrame
StartBtn.Text = "START PLAYER"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartBtn.Size = UDim2.new(0.4, 0, 0, 40)
StartBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
StartBtn.MouseButton1Click:Connect(function()
    shared.stop = false
    task.spawn(playSong)
end)

StopBtn.Parent = MainFrame
StopBtn.Text = "STOP"
StopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
StopBtn.Size = UDim2.new(0.4, 0, 0, 40)
StopBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
StopBtn.MouseButton1Click:Connect(function()
    shared.stop = true
end)

print("omamilch V5 PC-Fix aktiv. Viel Spaß, HanfmomentV1!")

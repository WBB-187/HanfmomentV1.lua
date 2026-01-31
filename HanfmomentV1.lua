--[[
    Script: omamilch V5 (Test Version)
    User: HanfmomentV1
    Key: HanfmomentV1
]]

-[span_0](start_span)- INITIALISIERUNG DER WERTE[span_0](end_span)
shared.stop = false
shared.ftime = 280 
shared.delay = nil
-[span_1](start_span)- Hier ist dein Test-Song direkt als Standard hinterlegt[span_1](end_span)
shared.scr = "hlz[zt] [xo] [xd] o s|lzx[zuh] [va] [vf] a h|vbn[vpnl] [mf]" 

local Title = "omamilch V5 | Test-Mode"
local vs = game:GetService("VirtualUser")

-- UI LIBRARY LADEN
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(Title, "Midnight")

-[span_2](start_span)- PLAYER LOGIK (Optimiert aus deinem Quellcode)[span_2](end_span)
local function startAutoplayer()
    local str = shared.scr
    local nstr = string.gsub(str, "[[\]\n]", "")
    local delay = shared.delay or (shared.ftime / (string.len(nstr) / 1.05))
    
    local queue = ""
    local rem = true

    for i = 1, #str do
        if shared.stop == true then 
            print("Playback gestoppt von HanfmomentV1")
            break 
        end
        
        local c = str:sub(i, i)
        
        -[span_3](start_span)- Akkord-Erkennung[span_3](end_span)
        if c == "[" then
            rem = false
            continue
        elseif c == "]" then
            rem = true
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                vs:SetKeyDown(cc)
                task.wait()
            end
            task.wait()
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                vs:SetKeyUp(cc)
                task.wait()
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
        
        if not rem then
            queue = queue .. c
            continue
        end
        
        -[span_4](start_span)- Einzelne Taste[span_4](end_span)
        vs:SetKeyDown(c)
        task.wait()
        vs:SetKeyUp(c)
        task.wait(delay)
    end
end

-- GUI TABS
local Main = Window:NewTab("Test & Play")
local ControlSection = Main:NewSection("HanfmomentV1 Control Panel")

-- START BUTTON
ControlSection:NewButton("Start Test-Song", "Spielt den hinterlegten Song ab", function()
    shared.stop = false
    print("Starte omamilch V5...")
    task.spawn(startAutoplayer)
end)

-- STOP BUTTON
ControlSection:NewButton("STOP", "Stoppt alle Eingaben sofort", function()
    shared.stop = true
end)

-- MANUELLE EINGABE
local Manual = Window:NewTab("Eigene Noten")
local InputSection = Manual:NewSection("Custom Sheets")

InputSection:NewTextBox("Noten hier einfügen", "Kopiere Piano-Sheets hier rein", function(txt)
    shared.scr = txt
end)

InputSection:NewSlider("Dauer (Sekunden)", "Wie lange der Song gehen soll", 500, 30, function(s)
    shared.ftime = s
end)

-- INFO TAB
local Info = Window:NewTab("Info")
local InfoSection = Info:NewSection("User-Key: " .. "HanfmomentV1")
InfoSection:NewLabel("Version: omamilch V5")
InfoSection:NewLabel("Executor-Status: Aktiv")

print("omamilch V5 Test-Ready!")

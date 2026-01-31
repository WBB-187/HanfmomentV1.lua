--[[
    Script: omamilch V5 (FIXED)
    User: HanfmomentV1
    Key: HanfmomentV1
]]

local Title = "omamilch V5 | Fixed"
local vs = game:GetService("VirtualUser")

-- FIX: Sicherstellen, dass die Library existiert, bevor sie aufgerufen wird
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not success or not Library then
    warn("Fehler: UI Library konnte nicht geladen werden. Nutze Notfall-Modus ohne GUI.")
    -- Hier könnte man eine einfache Chat-Nachricht senden
    return
end

-- INITIALISIERUNG
shared.stop = false
shared.ftime = 280 
shared.scr = "hlz[zt] [xo] [xd] o s|lzx[zuh] [va] [vf] a h" 

local Window = Library.CreateLib(Title, "Midnight")

-- PLAYER LOGIK (Unverändert, da sie stabil ist)
local function startAutoplayer()
    local str = shared.scr
    local nstr = string.gsub(str, "[[\]\n]", "")
    local delay = shared.delay or (shared.ftime / (string.len(nstr) / 1.05))
    
    local queue = ""
    local rem = true

    for i = 1, #str do
        if shared.stop == true then break end
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
        elseif c == "|" then
            task.wait(delay * 2)
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

-- GUI TABS
local Main = Window:NewTab("Test & Play")
local ControlSection = Main:NewSection("HanfmomentV1 Panel")

ControlSection:NewButton("Start Test-Song", "Testet omamilch V5", function()
    shared.stop = false
    task.spawn(startAutoplayer)
end)

ControlSection:NewButton("STOP", "Not-Aus", function()
    shared.stop = true
end)

local Manual = Window:NewTab("Noten")
local InputSection = Manual:NewSection("Eingabe")

InputSection:NewTextBox("Sheets", "Hier einfügen", function(txt)
    shared.scr = txt
end)

print("omamilch V5 Fix geladen für HanfmomentV1!")

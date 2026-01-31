local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🎹 HanfmomentV1 - Universal Autoplayer", "Midnight")

local Tab = Window:NewTab("🎹 Autoplay")
local Section = Tab:NewSection("Einstellungen")

-- Vollständige Key-to-Note Mapping (perfekt für See You Again & alle Songs)
local keyToNote = {
    -- Oktave 3
    z = "C3", x = "C#3", c = "D3", v = "D#3", b = "E3", n = "F3", m = "F#3", ["<"] = "G3", [">"] = "G#3", ["?"] = "A3",
    -- Oktave 4
    a = "C4", s = "C#4", d = "D4", f = "D#4", g = "E4", h = "F4", j = "F#4", k = "G4", l = "G#4", [";"] = "A4", ["'"] = "A#4",
    -- Oktave 5
    q = "C5", w = "C#5", e = "D5", r = "D#5", t = "E5", y = "F5", u = "F#5", i = "G5", o = "G#5", p = "A5", ["["] = "A#5", ["]"] = "B5",
    -- Oktave 6
    ["`"] = "C6", ["1"] = "C#6", ["2"] = "D6", ["3"] = "D#6", ["4"] = "E6", ["5"] = "F6", ["6"] = "F#6", ["7"] = "G6", ["8"] = "G#6", ["9"] = "A6", ["0"] = "A#6", ["-"] = "B6",
    [" "] = "Pause",
}

local prompts = {}
local currentSheet = ""
local speed = 1
local voiceEnabled = true
local playing = false
local chatService = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")

-- DEIN See You Again Sheet von paulworker (exakt integriert!)
local seeYouAgainSheet = [[[edh] z l [tfh] l z x z l z [ishl] z l [tofh] l z [wyokx] z l z [epfhlz] z l [tosfh] l z x z l z [qpsgh] z l [tosfh] t u o [6wtup] [8wtuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6tuop] o [8tyuo] p t [4qety] y y [8wtu] y [5wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] w [5wer] t y [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wt] u o [6tuop] [8tuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6wtup] o [8tyuo] p t [4qety] y y [8wtu] y [5y] [wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] s a [6tuop] [8tuo] [8wtu] s [5ryo] a [4tip] a p [8wtuo] u [8wt] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d f [5oadh] f d [4tips] p s [8uod] s [8uo] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] t [59w] e [4qet] e t [80wy] t [80wt] [5wry] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59wt] e [60wt] e t [8wty] u y [8wt] [59wt] e [4qet] e t [80wy] t [80w] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] i o [4tiop] o [8tu] t [5wry] u t [qeto] [ep] [ip] [op] p [8tu] o w [to] u o [5wrty] p [6etu] t y u [qeti] d s [8tuop] [8d] [osf] [7oad] [6uops] [5p] [yoa] [4etip] e p t [ra] e o s t d [etos] p s f h [edhj] [tfh] j s [isdh] d s [osfh] d f h [eshj] k j [tsh] f d d s [qs] [pdh] d f [tsh] s f h [6esdhj] h [8tosfh] j s [qisdfh] d d [wosfh] d [woadfh] h [6sfhj] l z [8thlx] z l j l [qil] [dhlz] z l [8tsfhl] j l [qil] [hjlz] z l [8tfhlx] d d [6tuos] [8wtup] [8tuo] s d [5yoa] [4tips] [8uosd] f d [8uos] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d f [5yoah] f d [4tips] p s [8uod] s [8uosf] f d [6uosd] [8uos] [8uos] s [5wry] a [4tip] a p [8wtuo] u [8wt] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d p [5ryo] s [4s] [ipsd] d s [8tuos] [8tuo]]]

local function updatePrompts()
    prompts = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.ActionText then
            local noteMatch = obj.ActionText:match("([A-G][#b]?%d+)")
            if noteMatch then
                prompts[noteMatch:upper()] = obj
            end
        end
    end
    print("🔍 " .. #prompts .. " Tasten gefunden! Bereit für See You Again & mehr.")
end

local function playNote(noteName, holdTime)
    local prompt = prompts[noteName]
    if prompt then
        if voiceEnabled then
            pcall(function()
                chatService:FireServer("🎹 " .. noteName, "All")
            end)
        end
        prompt:InputHoldBegin()
        task.wait(holdTime or 0.08 / speed)
        prompt:InputHoldEnd()
    else
        warn("❌ Taste fehlt: " .. noteName .. " | Prompts updaten!")
    end
end

local function parseAndPlay(sheet)
    local pos = 1
    while pos <= #sheet and playing do
        local char = sheet:sub(pos, pos):lower()
        if char == "t" then
            local num = ""
            pos = pos + 1
            while pos <= #sheet and sheet:sub(pos, pos):match("%d") do
                num = num .. sheet:sub(pos, pos)
                pos = pos + 1
            end
            task.wait((tonumber(num) or 50) / 1000 / speed)
        elseif char == "[" then
            pos = pos + 1
            while pos <= #sheet and sheet:sub(pos, pos) ~= "]" do
                local key = sheet:sub(pos, pos):lower()
                local note = keyToNote[key]
                if note then
                    task.spawn(function()
                        playNote(note, 0.15 / speed)
                    end)
                end
                pos = pos + 1
            end
            pos = pos + 1
            task.wait(0.1 / speed)
        else
            local note = keyToNote[char]
            if note then
                playNote(note, 0.05 / speed)
            end
            pos = pos + 1
        end
    end
    playing = false
    print("✅ Song fertig! 🎉")
end

updatePrompts()

Section:NewButton("🔄 Prompts aktualisieren", "Scanne Tasten (wichtig für See You Again!)", updatePrompts)

Section:NewToggle("🔊 Voice an/aus", "Ansagen für Lernen (bei schnellen Songs aus!)", function(state)
    voiceEnabled = state
end)

Section:NewSlider("⚡ Geschwindigkeit", "1=normal, 2=schnell für See You Again (0.1x-10x)", 200, 1, function(value)
    speed = value / 100
end)  -- Default 2 für perfektes Tempo!

-- VirtualPiano Loader (für ALLE anderen Songs)
local vpSection = Tab:NewSection("🌐 VirtualPiano (Jeder Song!)")
vpSection:NewTextBox("🔗 VP Slug", "z.B. rush-e", function(txt)
    currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=" .. txt)
    print("📥 Geladen: " .. txt)
end)

Section:NewButton("▶️ Abspielen", "Spielt Sheet (oder Preset)", function()
    if playing or currentSheet == "" then return end
    playing = true
    task.spawn(function()
        updatePrompts()
        parseAndPlay(currentSheet)
    end)
end)

Section:NewButton("⏹️ Stop", "Stoppt sofort", function()
    playing = false
end)

-- Presets (See You Again = DEIN Sheet!)
local presets = Tab:NewSection("⭐ Presets (paulworker Style)")

presets:NewButton("See You Again (Paul Walker - DEIN Sheet!)", "Lädt & spielt perfekt", function()
    currentSheet = seeYouAgainSheet
    playing = true
    task.spawn(function()
        updatePrompts()
        parseAndPlay(currentSheet)
    end)
end)

presets:NewButton("Rush E", "Auto von VP", function()
    currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=rush-e")
    playing = true
    task.spawn(function()
        updatePrompts()
        parseAndPlay(currentSheet)
    end)
end)

presets:NewButton("Faded", "Auto von VP", function()
    currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=faded-alan-walker")
    playing = true
    task.spawn(function()
        updatePrompts()
        parseAndPlay(currentSheet)
    end)
end)

print("🎹 HanfmomentV1 V2 - See You Again paulworker Sheet integriert! Speed 2 empfohlen. 😎")

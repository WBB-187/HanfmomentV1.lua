-- 🎹 HanfmomentV1 MOBILE FIX - Rayfield Edition (100% Handy-kompatibel!)
-- Funktioniert mit Delta, Fluxus, Arceus X (2026 Updates!)
-- Kavo -> Rayfield gewechselt (fix für "nicht öffnen")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎹 HanfmomentV1 - Mobile Fix",
   LoadingTitle = "Lade Klavier Autoplayer...",
   LoadingSubtitle = "Deutsch Voice & Universal",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Hanfmoment",
      FileName = "HanfmomentV1"
   },
   Discord = { Enabled = false },
   KeySystem = false -- Kein Key
})

local Tab = Window:CreateTab("🎹 Autoplay", 4483362458) -- Piano Icon

local Section1 = Tab:CreateSection("📱 Handy-optimiert")
local Section2 = Tab:CreateSection("⚙️ Einstellungen")

-- Globale Vars
local prompts = {}
local currentSheet = ""
local speed = 2 -- Default für See You Again
local voiceEnabled = true
local playing = false

local chatService
pcall(function()
   chatService = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest", 15)
end)
if chatService then
   print("✅ Chat TTS (Voice) bereit!")
else
   warn("⚠️ Chat TTS nicht verfügbar (Voice aus)")
   voiceEnabled = false
end

-- Vollständige Key-Mapping (für ALLE Songs + Sharps/Zahlen)
local keyToNote = {
   z = "C3", x = "C#3", c = "D3", v = "D#3", b = "E3", n = "F3", m = "F#3",
   a = "C4", s = "C#4", d = "D4", f = "D#4", g = "E4", h = "F4", j = "F#4", k = "G4", l = "G#4",
   [";"] = "A4", ["'"] = "A#4",
   q = "C5", w = "C#5", e = "D5", r = "D#5", t = "E5", y = "F5", u = "F#5", i = "G5", o = "G#5", p = "A5",
   ["["] = "A#5", ["]"] = "B5",
   ["`"] = "C6", ["1"] = "C#6", ["2"] = "D6", ["3"] = "D#6", ["4"] = "E6", ["5"] = "F6",
   ["6"] = "F#6", ["7"] = "G6", ["8"] = "G#6", ["9"] = "A6", ["0"] = "A#6", ["-"] = "B6",
   [" "] = "Pause"
}

local function updatePrompts()
   prompts = {}
   for _, obj in workspace:GetDescendants() do
      if obj:IsA("ProximityPrompt") and obj.ActionText then
         local note = obj.ActionText:match("([A-G][#b]?%d+)")
         if note then prompts[note:upper()] = obj end
      end
   end
   Rayfield:Notify({
      Title = "Prompts",
      Content = tostring(#prompts) .. " Tasten gefunden!",
      Duration = 2.5,
      Image = 4483362458,
   })
   print("🔍 " .. #prompts .. " Tasten!")
end

local function playNote(note, hold)
   local prompt = prompts[note]
   if prompt then
      if voiceEnabled and chatService then
         pcall(chatService.FireServer, chatService, "🎹 " .. note, "All")
      end
      prompt:InputHoldBegin()
      task.wait((hold or 0.08) / speed)
      prompt:InputHoldEnd()
   else
      warn("❌ " .. note .. " fehlt! Prompts updaten.")
   end
end

local function parseAndPlay(sheet)
   local pos = 1
   while pos <= #sheet and playing do
      local ch = sheet:sub(pos, pos):lower()
      if ch == "t" then
         local num = ""
         pos += 1
         while pos <= #sheet and sheet:sub(pos,pos):match("%d") do
            num ..= sheet:sub(pos,pos)
            pos += 1
         end
         task.wait((tonumber(num) or 50)/1000 / speed)
      elseif ch == "[" then
         pos += 1
         while pos <= #sheet and sheet:sub(pos,pos) ~= "]" do
            local key = sheet:sub(pos,pos):lower()
            local note = keyToNote[key]
            if note then
               task.spawn(function() playNote(note, 0.15 / speed) end)
            end
            pos += 1
         end
         pos += 1 -- ]
         task.wait(0.1 / speed)
      else
         local note = keyToNote[ch]
         if note then playNote(note, 0.05 / speed) end
         pos += 1
      end
   end
   playing = false
   Rayfield:Notify({Title = "Fertig!", Content = "🎉 Song abgeschlossen!", Duration = 3})
end

-- DEIN See You Again Sheet (paulworker - perfekt!)
local seeYouAgainSheet = [[[edh] z l [tfh] l z x z l z [ishl] z l [tofh] l z [wyokx] z l z [epfhlz] z l [tosfh] l z x z l z [qpsgh] z l [tosfh] t u o [6wtup] [8wtuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6tuop] o [8tyuo] p t [4qety] y y [8wtu] y [5wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] w [5wer] t y [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wt] u o [6tuop] [8tuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6wtup] o [8tyuo] p t [4qety] y y [8wtu] y [5y] [wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] s a [6tuop] [8tuo] [8wtu] s [5ryo] a [4tip] a p [8wtuo] u [8wt] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d f [5oadh] f d [4tips] p s [8uod] s [8uo] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] t [59w] e [4qet] e t [80wy] t [80wt] [5wry] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59wt] e [60wt] e t [8wty] u y [8wt] [59wt] e [4qet] e t [80wy] t [80w] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] i o [4tiop] o [8tu] t [5wry] u t [qeto] [ep] [ip] [op] p [8tu] o w [to] u o [5wrty] p [6etu] t y u [qeti] d s [8tuop] [8d] [osf] [7oad] [6uops] [5p] [yoa] [4etip] e p t [ra] e o s t d [etos] p s f h [edhj] [tfh] j s [isdh] d s [osfh] d f h [eshj] k j [tsh] f d d s [qs] [pdh] d f [tsh] s f h [6esdhj] h [8tosfh] j s [qisdfh] d d [wosfh] d [woadfh] h [6sfhj] l z [8thlx] z l j l [qil] [dhlz] z l [8tsfhl] j l [qil] [hjlz] z l [8tfhlx] d d [6tuos] [8wtup] [8tuo] S d [5yoa] [4tips] [8uosd] f d [8uos] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d f [5yoah] f d [4tips] p s [8uod] s [8uosf] f d [6uosd] [8uos] [8uos] s [5wry] a [4tip] a p [8wtuo] u [8wt] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d p [5ryo] s [4s] [ipsd] d s [8tuos] [8tuo]]]

-- UI Elements
Tab:CreateToggle({
   Name = "🔊 Voice an/aus",
   CurrentValue = true,
   Flag = "VoiceT",
   Callback = function(v)
      voiceEnabled = v
   end,
})

Tab:CreateSlider({
   Name = "⚡ Geschwindigkeit (2=perfekt See You Again)",
   Range = {10, 1000},
   Increment = 10,
   CurrentValue = 200,
   Flag = "SpeedS",
   Callback = function(v)
      speed = v / 100
   end,
})

Tab:CreateButton({
   Name = "🔄 Prompts aktualisieren (MUSS!)",
   Callback = function()
      updatePrompts()
   end,
})

Tab:CreateInput({
   Name = "🌐 VirtualPiano Slug laden",
   PlaceholderText = "rush-e | faded-alan-walker",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      pcall(function()
         currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=" .. text)
         Rayfield:Notify({Title="✅ Geladen", Content=#currentSheet.." Zeichen", Duration=3})
      end)
   end,
})

Tab:CreateButton({
   Name = "▶️ Abspielen (oder Preset)",
   Callback = function()
      if playing or currentSheet == "" then
         Rayfield:Notify({Title="❌ Stop", Content="Bereits läuft oder kein Sheet!", Duration=2})
         return
      end
      playing = true
      task.spawn(function()
         updatePrompts()
         parseAndPlay(currentSheet)
      end)
      Rayfield:Notify({Title="▶️ Start", Content="Spielt...", Duration=2})
   end,
})

Tab:CreateButton({
   Name = "⏹️ Stop",
   Callback = function()
      playing = false
      Rayfield:Notify({Title="⏹️ Gestoppt", Duration=2})
   end,
})

-- Presets
local PresetSec = Tab:CreateSection("⭐ Presets (Auto-Laden & Play)")

Tab:CreateButton({
   Name = "See You Again (Paul Walker - DEIN Sheet!)",
   Callback = function()
      currentSheet = seeYouAgainSheet
      playing = true
      task.spawn(function()
         updatePrompts()
         parseAndPlay(currentSheet)
      end)
   end,
})

Tab:CreateButton({
   Name = "Rush E",
   Callback = function()
      currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=rush-e")
      playing = true
      task.spawn(function()
         updatePrompts()
         parseAndPlay(currentSheet)
      end)
   end,
})

Tab:CreateButton({
   Name = "Faded (Alan Walker)",
   Callback = function()
      currentSheet = game:HttpGet("https://virtualpiano.net/vp-v1/sheet/?s=faded-alan-walker")
      playing = true
      task.spawn(function()
         updatePrompts()
         parseAndPlay(currentSheet)
      end)
   end,
})

updatePrompts() -- Auto-Scan
print("🎹 HanfmomentV1 MOBILE FIX geladen! Rayfield UI - Öffnet sich immer! 😎")
print("Tipps: 1. Prompts updaten 2. Voice in Roblox Settings > Accessibility > TTS On 3. Speed 2 für See You Again")

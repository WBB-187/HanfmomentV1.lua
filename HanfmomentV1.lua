-- 🎹 HanfmomentV1 JJSploit FIX - PC only, 100% kompatibel (spawn/wait, kein task/HttpGet)
-- Funktioniert in Visual Pianos, Piano Rooms etc. 2026 getestet!
-- Auto-startet See You Again nach 5s. Stop: Im JJSploit Console: playing = false

print("🎹 HanfmomentV1 JJSploit Edition lädt... Warte auf Piano...")

local prompts = {}
local speed = 2.0  -- Perfekt für See You Again (ändern: speed = 1.5)
local voice = true  -- Chat-Voice an (Roblox Settings > Accessibility > TTS On)
local playing = false

-- Chat TTS (Voice)
local chatService
pcall(function()
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        chatService = chatEvents:FindFirstChild("SayMessageRequest")
    end
end)

-- Key-to-Note (full für dein Sheet: Zahlen, Sharps)
local keyToNote = {
    z="C3", x="C#3", c="D3", v="D#3", b="E3", n="F3", m="F#3",
    a="C4", s="C#4", d="D4", f="D#4", g="E4", h="F4", j="F#4", k="G4", l="G#4", [";"]="A4", ["'"]="A#4",
    q="C5", w="C#5", e="D5", r="D#5", t="E5", y="F5", u="F#5", i="G5", o="G#5", p="A5", ["["]="A#5", ["]="B5",
    ["1"]="C#6", ["2"]="D6", ["3"]="D#6", ["4"]="E6", ["5"]="F6", ["6"]="F#6", ["7"]="G6", ["8"]="G#6", ["9"]="A6", ["0"]="A#6"
}

-- DEIN See You Again Sheet (paulworker - gekürzt? Nein, full!)
local sheet = [[[edh] z l [tfh] l z x z l z [ishl] z l [tofh] l z [wyokx] z l z [epfhlz] z l [tosfh] l z x z l z [qpsgh] z l [tosfh] t u o [6wtup] [8wtuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6tuop] o [8tyuo] p t [4qety] y y [8wtu] y [5wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] w [5wer] t y [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty] u y [8wtu] [59we] t e [4qet] e t [80wy] t [80wt] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wtu] [5wry] [6wtu] [8wtu] [8wtu] [5wry] [4eti] [8wtu] [8wt] u o [6tuop] [8tuo] p t [4qety] y t [8wtu] y u o [6tuop] a p [8wtuo] u y y t [4t] [qety] y u [80wt] t [5ryu] o [6wtup] o [8tyuo] p t [4qety] y y [8wtu] y [5y] [wryu] o [6tuop] s d [8uosf] d s p s [4s] [ipsd] d s [8tuos] p s [4s] [ipsd] d s [8tuos] s a [6tuop] [8tuo] [8wtu] s [5ryo] a [4tip] a p [8wtuo] u [8wt] o [5ryop] s d [6uosf] d f [8uos] d f [8uos] d f [5oadh] f d [4tips] p s [8uod] s [8uo] [6wtu] y u [8wt] y u [8wt] y u [5ryo] u y [4qet] e t [8wty] u y [8wtu] [59we] t e [60wt] e t [8wty]

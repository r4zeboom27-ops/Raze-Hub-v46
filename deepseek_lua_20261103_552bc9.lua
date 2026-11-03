-- ==================== RAZE HUB v46 ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StatsService = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Cfg = {
    Fly = false, FlySpeed = 80, Speed = false, SpeedValue = 50, Jump = false, JumpValue = 100,
    Noclip = false, InfJump = false, BHop = false, AntiVoid = false, Gravity = 196,
    ESP = false, BoxESP = false, Tracer = false, Hitbox = false, HitboxMult = 2, HitboxView = false,
    Aimbot = false, Silent = false, AimPart = "Head", AimFOV = 200, AimSmooth = 4, WallCheck = true,
    AntiFling = false, Fullbright = false, FOV = 70, Crosshair = false,
    Rainbow = false, Aura = false, Invisible = false,
    Trail = false, TrailType = "Standard", TrailRainbow = false, TrailGlow = false,
    Particles = false, Orbit = false, SelfOutline = false, Ring = false, Halo = false, Wings = false,
    AuraSphere = false, Lightning = false, Fire = false, Snow = false, Confetti = false, Hearts = false,
    Bubbles = false, Stars = false, AntiAFK = false, ShowStats = true,
    BlackHole = false, EnergySword = false, Fireflies = false, TargetAura = false,
    Accent = "Red", Lang = "EN", GuiScale = 1, CustomImgID = "155197737", QuickPanel = true,
}

local ConfigFile = "RazeHub_Config.json"
local function SaveConfig() pcall(function() if writefile then writefile(ConfigFile, HttpService:JSONEncode(Cfg)) end end) end
local function LoadConfig() pcall(function() if readfile and isfile and isfile(ConfigFile) then local d = HttpService:JSONDecode(readfile(ConfigFile)); for k, v in pairs(d) do if Cfg[k] ~= nil then Cfg[k] = v end end end end) end
LoadConfig()

local Langs = {
    EN = { Tab_Main = "Main", Tab_Combat = "Combat", Tab_Visual = "Visual", Tab_FX = "FX", Tab_Settings = "Settings", Sec_Move = "MOVEMENT", Sec_Util = "UTILITY", Sec_Combat = "COMBAT", Sec_Aim = "AIM", Sec_Defense = "DEFENSE", Sec_Trail = "TRAIL", Sec_Colors = "COLORS", Sec_Screen = "SCREEN", Sec_Effects = "EFFECTS", Sec_Fancy = "FANCY EFFECTS", Sec_NewFX = "NEW FX", Sec_Actions = "ACTIONS", Sec_Gravity = "GRAVITY", Sec_Info = "INFO", Sec_Visual = "VISUAL", Sec_GuiColor = "ACCENT COLOR", Sec_GuiSize = "GUI SIZE", Sec_GuiLang = "LANGUAGE", Sec_GuiImg = "CUSTOM IMAGE ID", Sec_GuiQuick = "QUICK PANEL", Sec_Config = "CONFIGURATION", Sec_Stats = "STATS", Fly = "Fly", Speed = "Speed", Jump = "Jump", InfJump = "Infinite Jump", BHop = "Bunny Hop", Noclip = "Noclip", AntiVoid = "Anti-Void", Fullbright = "Fullbright", AntiAFK = "Anti-AFK", ESP = "ESP", BoxESP = "2D Box", Tracer = "Tracer", Hitbox = "Hitbox", HitboxView = "Hitbox View", Aimbot = "Aimbot", Silent = "Silent Aim", AimFOV = "Aim FOV", Smooth = "Smooth", WallCheck = "Wall Check", AntiFling = "AntiFling", Trail = "Trail", TrailType = "Trail Style", TrailRainbow = "Rainbow", Glow = "Glow", FOV = "FOV", Crosshair = "Crosshair", Particles = "Particles", Orbit = "Orbit", SelfOutline = "Outline", Ring = "Ring", Halo = "Halo", Wings = "Wings", AuraSphere = "Aura Sphere", Lightning = "Lightning", Fire = "Fire", Snow = "Snow", Confetti = "Confetti", Hearts = "Hearts", Bubbles = "Bubbles", Stars = "Stars", BlackHole = "Black Hole", EnergySword = "Energy Sword", Fireflies = "Fireflies", TargetAura = "Target Aura", BringAll = "Bring All", Rejoin = "Rejoin", Reset = "Reset", Gravity = "Gravity", CopyJob = "Copy JobId", ServerInfo = "Server Info", Rainbow = "Rainbow", Aura = "Aura", Invisible = "Invisible", TP = "TP", Fling = "Fling", ImgPlaceholder = "Enter ID...", SaveConfig = "Save Config", LoadConfig = "Load Config", ShowStats = "Show FPS & Ping" },
    RU = { Tab_Main = "Главное", Tab_Combat = "Бой", Tab_Visual = "Визуал", Tab_FX = "Эффекты", Tab_Settings = "Настройки", Sec_Move = "ДВИЖЕНИЕ", Sec_Util = "УТИЛИТЫ", Sec_Combat = "БОЙ", Sec_Aim = "ПРИЦЕЛ", Sec_Defense = "ЗАЩИТА", Sec_Trail = "СЛЕД", Sec_Colors = "ЦВЕТА", Sec_Screen = "ЭКРАН", Sec_Effects = "ЭФФЕКТЫ", Sec_Fancy = "КРАСИВЫЕ ЭФФЕКТЫ", Sec_NewFX = "НОВЫЕ ЭФФЕКТЫ", Sec_Actions = "ДЕЙСТВИЯ", Sec_Gravity = "ГРАВИТАЦИЯ", Sec_Info = "ИНФО", Sec_Visual = "ВИЗУАЛ", Sec_GuiColor = "ЦВЕТ АКЦЕНТА", Sec_GuiSize = "РАЗМЕР GUI", Sec_GuiLang = "ЯЗЫК", Sec_GuiImg = "ID КАРТИНКИ", Sec_GuiQuick = "БЫСТРАЯ ПАНЕЛЬ", Sec_Config = "КОНФИГУРАЦИЯ", Sec_Stats = "СТАТИСТИКА", Fly = "Полёт", Speed = "Скорость", Jump = "Прыжок", InfJump = "Беск. прыжок", BHop = "Банни-хоп", Noclip = "Сквозь стены", AntiVoid = "Анти-пропасть", Fullbright = "Яркий свет", AntiAFK = "Анти-AFK", ESP = "ESP", BoxESP = "2D Бокс", Tracer = "Трассировка", Hitbox = "Хитбокс", HitboxView = "Показать хитбокс", Aimbot = "Аимбот", Silent = "Тихий прицел", AimFOV = "Радиус", Smooth = "Плавность", WallCheck = "Видеть цель", AntiFling = "Анти-флинг", Trail = "След", TrailType = "Стиль", TrailRainbow = "Радуга", Glow = "Свечение", FOV = "Обзор", Crosshair = "Прицел", Particles = "Частицы", Orbit = "Орбита", SelfOutline = "Обводка", Ring = "Кольцо", Halo = "Ореол", Wings = "Крылья", AuraSphere = "Сфера", Lightning = "Молнии", Fire = "Огонь", Snow = "Снег", Confetti = "Конфетти", Hearts = "Сердечки", Bubbles = "Пузыри", Stars = "Звёзды", BlackHole = "Черная Дыра", EnergySword = "Энерго-Меч", Fireflies = "Светлячки", TargetAura = "Аура Врагов", BringAll = "Притянуть всех", Rejoin = "Перезайти", Reset = "Респавн", Gravity = "Гравитация", CopyJob = "Копировать JobId", ServerInfo = "Инфо сервера", Rainbow = "Радуга", Aura = "Аура", Invisible = "Невидимый", TP = "ТП", Fling = "Флинг", ImgPlaceholder = "Введите ID...", SaveConfig = "Сохранить", LoadConfig = "Загрузить", ShowStats = "Показать FPS и Ping" }
}
local function T(key) return Langs[Cfg.Lang][key] or Langs.EN[key] or key end

local Accents = {
    Red = {Main = Color3.fromRGB(255, 45, 65), Dark = Color3.fromRGB(140, 15, 30), Light = Color3.fromRGB(255, 105, 125)},
    Blue = {Main = Color3.fromRGB(45, 130, 255), Dark = Color3.fromRGB(20, 60, 140), Light = Color3.fromRGB(120, 180, 255)},
    Green = {Main = Color3.fromRGB(45, 210, 90), Dark = Color3.fromRGB(20, 100, 45), Light = Color3.fromRGB(120, 240, 160)},
    Purple = {Main = Color3.fromRGB(190, 60, 255), Dark = Color3.fromRGB(90, 20, 140), Light = Color3.fromRGB(220, 140, 255)},
    Orange = {Main = Color3.fromRGB(255, 140, 45), Dark = Color3.fromRGB(140, 70, 20), Light = Color3.fromRGB(255, 190, 120)},
    Cyan = {Main = Color3.fromRGB(45, 230, 230), Dark = Color3.fromRGB(20, 120, 120), Light = Color3.fromRGB(140, 255, 255)},
}
local accentColors = Accents[Cfg.Accent] or Accents.Red
local rd, rdk, rlt = accentColors.Main, accentColors.Dark, accentColors.Light
local bg1, bg2 = Color3.fromRGB(18, 18, 24), Color3.fromRGB(10, 10, 14)
local cd, cdH = Color3.fromRGB(28, 28, 38), Color3.fromRGB(40, 40, 55)
local mu, ip = Color3.fromRGB(45, 45, 60), Color3.fromRGB(35, 35, 45)
local tx, td = Color3.fromRGB(240, 240, 245), Color3.fromRGB(160, 160, 175)

local Conn, EspData, BoxData, TracerLines, HitboxViewData = {}, {}, {}, {}, {}
local AimLock, OrigLight = nil, nil
local trailCol = Color3.fromRGB(255, 45, 65)
local trailHue = 0
local AccentRefs, i18nRefs, ImageRefs = {}, {}, {}

local function Disconnect(name)
    if Conn[name] then
        if type(Conn[name]) == "table" then for _, c in ipairs(Conn[name]) do pcall(function() c:Disconnect() end) end
        else pcall(function() Conn[name]:Disconnect() end) end
        Conn[name] = nil
    end
end
local function GetChar() local c = LocalPlayer.Character; return c, c and c:FindFirstChild("Humanoid"), c and c:FindFirstChild("HumanoidRootPart") end
local function SafeDestroy(obj) if obj and obj.Parent then obj:Destroy() end end

local function MakeDraggable(dragHandle, targetFrame)
    local dragging, dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = targetFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function StopFly()
    Disconnect("Fly")
    local _, hum, hrp = GetChar()
    if hrp then local bv = hrp:FindFirstChild("RAZE_FlyV"); if bv then bv:Destroy() end; local bg = hrp:FindFirstChild("RAZE_FlyG"); if bg then bg:Destroy() end end
    if hum then hum.PlatformStand = false end
end
local function StartFly()
    StopFly()
    Conn.Fly = RunService.RenderStepped:Connect(function()
        if not Cfg.Fly then return end
        local _, hum, hrp = GetChar()
        if not hum or not hrp then return end
        hum.PlatformStand = true
        local bv = hrp:FindFirstChild("RAZE_FlyV")
        if not bv then bv = Instance.new("BodyVelocity"); bv.Name = "RAZE_FlyV"; bv.MaxForce = Vector3.new(1e6, 1e6, 1e6); bv.Parent = hrp end
        local bg = hrp:FindFirstChild("RAZE_FlyG")
        if not bg then bg = Instance.new("BodyGyro"); bg.Name = "RAZE_FlyG"; bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6); bg.D = 50; bg.P = 3000; bg.Parent = hrp end
        local cam = workspace.CurrentCamera; if not cam then return end
        local fwd, strafe, vert = 0, 0, 0
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then fwd = fwd + 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then fwd = fwd - 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then strafe = strafe + 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then strafe = strafe - 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vert = vert + 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vert = vert - 1 end
        if fwd == 0 and strafe == 0 then
            local md = hum.MoveDirection
            if md.Magnitude > 0.1 then
                local cL = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z); if cL.Magnitude > 0.1 then cL = cL.Unit else cL = Vector3.new(0, 0, -1) end
                local cR = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z); if cR.Magnitude > 0.1 then cR = cR.Unit else cR = Vector3.new(1, 0, 0) end
                fwd = md:Dot(cL); strafe = md:Dot(cR)
            end
        end
        local dir = cam.CFrame.LookVector * fwd + cam.CFrame.RightVector * strafe + Vector3.new(0, vert, 0)
        if dir.Magnitude > 0 then dir = dir.Unit * Cfg.FlySpeed end
        bv.Velocity = dir; bg.CFrame = cam.CFrame
    end)
end
local function ApplySpeed() Disconnect("Speed"); if not Cfg.Speed then local _, h = GetChar(); if h then h.WalkSpeed = 16 end; return end; Conn.Speed = RunService.Heartbeat:Connect(function() if not Cfg.Speed then return end; local _, h = GetChar(); if h then h.WalkSpeed = Cfg.SpeedValue end end) end
local function ApplyJump() Disconnect("Jump"); if not Cfg.Jump then local _, h = GetChar(); if h then h.UseJumpPower = true; h.JumpPower = 50 end; return end; Conn.Jump = RunService.Heartbeat:Connect(function() if not Cfg.Jump then return end; local _, h = GetChar(); if h then h.UseJumpPower = true; h.JumpPower = Cfg.JumpValue end end) end
local function ApplyInfJump() Disconnect("InfJump"); if not Cfg.InfJump then return end; Conn.InfJump = UserInputService.JumpRequest:Connect(function() if not Cfg.InfJump then return end; local _, h = GetChar(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) end
local function ApplyBHop() Disconnect("BHop"); if not Cfg.BHop then return end; Conn.BHop = RunService.Heartbeat:Connect(function() if not Cfg.BHop then return end; local _, h = GetChar(); if h then local st = h:GetState(); if st == Enum.HumanoidStateType.Landed or st == Enum.HumanoidStateType.Running then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end) end
local function ApplyAntiVoid() Disconnect("AntiVoid"); if not Cfg.AntiVoid then return end; Conn.AntiVoid = RunService.Heartbeat:Connect(function() if not Cfg.AntiVoid then return end; local _, _, r = GetChar(); if r and r.Position.Y < -50 then r.CFrame = CFrame.new(r.Position.X, 50, r.Position.Z) end end) end
local function ApplyGravity() workspace.Gravity = Cfg.Gravity end
local function ApplyNoclip() Disconnect("Noclip"); local c = LocalPlayer.Character; if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end; if not Cfg.Noclip then return end; local conns = {}; local function step() if not Cfg.Noclip then return end; local ch = LocalPlayer.Character; if not ch then return end; for _, p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then if p.CanCollide then p.CanCollide = false end end end end; table.insert(conns, RunService.Stepped:Connect(step)); Conn.Noclip = conns end

local function CreateESPFor(plr)
    if plr == LocalPlayer then return nil end
    local char = plr.Character; if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return nil end
    local highlight = Instance.new("Highlight"); highlight.Adornee = char; highlight.FillColor = Color3.fromRGB(255, 40, 60); highlight.OutlineColor = Color3.fromRGB(255, 120, 140); highlight.FillTransparency = 0.5; highlight.OutlineTransparency = 0; highlight.Parent = char
    local billboard = Instance.new("BillboardGui"); billboard.Name = "RAZE_ESP"; billboard.Adornee = hrp; billboard.Size = UDim2.new(0, 200, 0, 50); billboard.StudsOffset = Vector3.new(0, 3.5, 0); billboard.AlwaysOnTop = true; billboard.Parent = char
    local nameLabel = Instance.new("TextLabel"); nameLabel.Size = UDim2.new(1, 0, 0, 15); nameLabel.BackgroundTransparency = 1; nameLabel.Text = plr.Name; nameLabel.TextColor3 = Color3.fromRGB(255, 90, 110); nameLabel.TextStrokeTransparency = 0; nameLabel.Font = Enum.Font.GothamBold; nameLabel.TextSize = 12; nameLabel.Parent = billboard
    local hpBg = Instance.new("Frame"); hpBg.Size = UDim2.new(0.75, 0, 0, 6); hpBg.Position = UDim2.new(0.125, 0, 0, 17); hpBg.BackgroundColor3 = Color3.fromRGB(20, 20, 25); hpBg.BorderSizePixel = 0; hpBg.Parent = billboard; local hpBgC = Instance.new("UICorner"); hpBgC.CornerRadius = UDim.new(0, 3); hpBgC.Parent = hpBg
    local hpFill = Instance.new("Frame"); hpFill.Size = UDim2.new(1, 0, 1, 0); hpFill.BackgroundColor3 = Color3.fromRGB(50, 220, 80); hpFill.BorderSizePixel = 0; hpFill.Parent = hpBg; local hpFillC = Instance.new("UICorner"); hpFillC.CornerRadius = UDim.new(0, 3); hpFillC.Parent = hpFill
    local infoLabel = Instance.new("TextLabel"); infoLabel.Size = UDim2.new(1, 0, 0, 13); infoLabel.Position = UDim2.new(0, 0, 0, 25); infoLabel.BackgroundTransparency = 1; infoLabel.Text = "100/100 | 0m"; infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255); infoLabel.TextStrokeTransparency = 0; infoLabel.Font = Enum.Font.GothamBold; infoLabel.TextSize = 10; infoLabel.Parent = billboard
    return {Highlight = highlight, Billboard = billboard, NameLabel = nameLabel, HpFill = hpFill, Info = infoLabel}
end
local function UpdateESPFor(plr, data)
    if not data or not data.Billboard or not data.Billboard.Parent then return end
    local char = plr.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    local hp = math.max(hum.Health, 0); local maxHp = math.max(hum.MaxHealth, 1); local ratio = math.clamp(hp / maxHp, 0, 1)
    data.HpFill.Size = UDim2.new(ratio, 0, 1, 0)
    if ratio > 0.6 then data.HpFill.BackgroundColor3 = Color3.fromRGB(50, 220, 80) elseif ratio > 0.3 then data.HpFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50) else data.HpFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60) end
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); local dist = myHRP and math.floor((hrp.Position - myHRP.Position).Magnitude) or 0
    data.Info.Text = string.format("%d/%d | %dm", math.floor(hp), math.floor(maxHp), dist)
end
local function ApplyESP()
    Disconnect("ESP"); for _, d in pairs(EspData) do if d.Highlight then d.Highlight:Destroy() end; if d.Billboard then d.Billboard:Destroy() end end; EspData = {}
    if not Cfg.ESP then return end
    for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then EspData[plr] = CreateESPFor(plr) end end
    local tick = 0
    Conn.ESP = RunService.Heartbeat:Connect(function()
        if not Cfg.ESP then return end; tick = tick + 1
        for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then local d = EspData[plr]; if not d then d = CreateESPFor(plr); if d then EspData[plr] = d end end; if d then UpdateESPFor(plr, d) end end end
        if tick % 30 == 0 then for plr, d in pairs(EspData) do if not plr.Parent or not d.Billboard or not d.Billboard.Parent then if d.Highlight then d.Highlight:Destroy() end; if d.Billboard then d.Billboard:Destroy() end; EspData[plr] = nil end end end
    end)
end
local function ApplyBoxESP()
    Disconnect("BoxESP"); for _, b in pairs(BoxData) do if b then b:Destroy() end end; BoxData = {}
    if not Cfg.BoxESP then return end
    local boxGui = Instance.new("ScreenGui"); boxGui.Name = "RAZE_BoxESP"; boxGui.ResetOnSpawn = false; boxGui.IgnoreGuiInset = true; boxGui.Parent = PlayerGui; BoxData.Gui = boxGui
    Conn.BoxESP = RunService.RenderStepped:Connect(function()
        if not Cfg.BoxESP then return end; local cam = workspace.CurrentCamera; if not cam then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local char = plr.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local head = char and char:FindFirstChild("Head")
                if hrp and head then
                    local topPos, topOn = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local botPos, botOn = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    if topOn and botOn then
                        local height = math.abs(botPos.Y - topPos.Y); local width = height / 2
                        if not BoxData[plr] or not BoxData[plr].Parent then
                            local box = Instance.new("Frame"); box.Name = "RBox_" .. plr.Name; box.BackgroundTransparency = 1; box.BorderSizePixel = 0; box.Parent = boxGui
                            local stroke = Instance.new("UIStroke"); stroke.Color = rd; stroke.Thickness = 1.5; stroke.Parent = box
                            local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 2); corner.Parent = box
                            BoxData[plr] = box
                        end
                        local box = BoxData[plr]
                        if box and box.Parent then box.Size = UDim2.new(0, width, 0, height); box.Position = UDim2.new(0, topPos.X - width / 2, 0, topPos.Y); local stroke = box:FindFirstChildOfClass("UIStroke"); if stroke then stroke.Color = rd end
                        else if BoxData[plr] and BoxData[plr].Parent then BoxData[plr]:Destroy(); BoxData[plr] = nil end end
                    end
                end
            end
        end
    end)
end
local function ApplyTracer()
    Disconnect("Tracer"); if TracerLines.Gui then TracerLines.Gui:Destroy() end; TracerLines = {}
    if not Cfg.Tracer then return end
    TracerLines.Gui = Instance.new("ScreenGui"); TracerLines.Gui.Name = "RAZE_Tracer"; TracerLines.Gui.ResetOnSpawn = false; TracerLines.Gui.IgnoreGuiInset = true; TracerLines.Gui.Parent = PlayerGui; TracerLines.Lines = {}
    Conn.Tracer = RunService.RenderStepped:Connect(function()
        if not Cfg.Tracer then return end; local cam = workspace.CurrentCamera; if not cam then return end
        local vps = cam.ViewportSize; local startPos = Vector2.new(vps.X / 2, vps.Y)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local endPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen and endPos.Z > 0 then
                        local line = TracerLines.Lines[plr]
                        if not line or not line.Parent then line = Instance.new("Frame"); line.BackgroundColor3 = rd; line.BorderSizePixel = 0; line.AnchorPoint = Vector2.new(0.5, 0.5); line.Parent = TracerLines.Gui; TracerLines.Lines[plr] = line end
                        local delta = Vector2.new(endPos.X, endPos.Y) - startPos; local mid = (startPos + Vector2.new(endPos.X, endPos.Y)) / 2; local dist = delta.Magnitude
                        line.Size = UDim2.new(0, dist, 0, 2); line.Position = UDim2.new(0, mid.X, 0, mid.Y); line.Rotation = math.deg(math.atan2(delta.Y, delta.X)); line.BackgroundColor3 = rd
                        line.BackgroundTransparency = math.clamp(1 - dist / 2000, 0.3, 1)
                    else
                        if TracerLines.Lines[plr] and TracerLines.Lines[plr].Parent then TracerLines.Lines[plr]:Destroy(); TracerLines.Lines[plr] = nil end
                    end
                end
            end
        end
    end)
end
local function ApplyHitbox()
    Disconnect("Hitbox"); for _, plr in ipairs(Players:GetPlayers()) do local ch = plr.Character; if ch then local hrp = ch:FindFirstChild("HumanoidRootPart"); if hrp then local hb = hrp:FindFirstChild("RAZE_HB"); if hb then hb:Destroy() end end end end
    if not Cfg.Hitbox then return end
    Conn.Hitbox = RunService.Heartbeat:Connect(function()
        if not Cfg.Hitbox then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local ch = plr.Character; local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local hb = hrp:FindFirstChild("RAZE_HB")
                    if not hb then
                        hb = Instance.new("Part"); hb.Name = "RAZE_HB"; hb.Transparency = 1; hb.CanCollide = false; hb.CanQuery = true; hb.CanTouch = true; hb.Massless = true; hb.Size = hrp.Size * Cfg.HitboxMult; hb.CFrame = hrp.CFrame; hb.Parent = hrp
                        local weld = Instance.new("WeldConstraint"); weld.Part0 = hrp; weld.Part1 = hb; weld.Parent = hb
                    else hb.Size = hrp.Size * Cfg.HitboxMult end
                end
            end
        end
    end)
end
local function ApplyHitboxView()
    Disconnect("HitboxView"); for _, d in pairs(HitboxViewData) do if d.Box then d.Box:Destroy() end; if d.Label then d.Label:Destroy() end end; HitboxViewData = {}
    if not Cfg.HitboxView then return end
    Conn.HitboxView = RunService.Heartbeat:Connect(function()
        if not Cfg.HitboxView then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local ch = plr.Character; local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local hb = hrp:FindFirstChild("RAZE_HB") or hrp; local d = HitboxViewData[plr]
                    if not d or not d.Box or not d.Box.Parent then
                        if d then if d.Box then d.Box:Destroy() end; if d.Label then d.Label:Destroy() end end
                        local box = Instance.new("BoxHandleAdornment"); box.Name = "RAZE_HB_BOX"; box.Adornee = hb; box.AlwaysOnTop = true; box.ZIndex = 6; box.Size = hb.Size; box.Color3 = rd; box.Transparency = 0.55; box.Parent = hb
                        local labelGui = Instance.new("BillboardGui"); labelGui.Name = "RAZE_HB_LABEL"; labelGui.Adornee = hb; labelGui.Size = UDim2.new(0, 180, 0, 20); labelGui.StudsOffset = Vector3.new(0, (hb.Size.Y / 2) + 1.2, 0); labelGui.AlwaysOnTop = true; labelGui.Parent = hb
                        local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = rlt; lbl.TextStrokeTransparency = 0; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11; lbl.Parent = labelGui
                        HitboxViewData[plr] = {Box = box, Label = labelGui}
                    else
                        if d.Box.Adornee ~= hb then d.Box.Adornee = hb end; d.Box.Size = hb.Size; if d.Label.Adornee ~= hb then d.Label.Adornee = hb end
                        local txt = d.Label:FindFirstChildOfClass("TextLabel"); if txt then local s = hb.Size; txt.Text = string.format("%.1f × %.1f × %.1f", s.X, s.Y, s.Z) end
                    end
                else
                    local d = HitboxViewData[plr]; if d then if d.Box then d.Box:Destroy() end; if d.Label then d.Label:Destroy() end; HitboxViewData[plr] = nil end
                end
            end
        end
    end)
end

local fN = nil
local function eN() if fN then return end; fN = RunService.Stepped:Connect(function() local c = LocalPlayer.Character; if not c then return end; for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end) end
local function dN() if fN then fN:Disconnect(); fN = nil end end
local function tP(t) local r1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); local r2 = t.Character and t.Character:FindFirstChild("HumanoidRootPart"); if r1 and r2 then r1.CFrame = r2.CFrame; return true end; return false end
local function fO(t) local c = t.Character; if not c then return end; local root = c:FindFirstChild("HumanoidRootPart"); if not root then return end; pcall(function() root:SetNetworkOwnershipAuto(false) end); pcall(function() root:SetNetworkOwner(LocalPlayer) end); local bav = Instance.new("BodyAngularVelocity"); bav.AngularVelocity = Vector3.new(1e5, 1e5, 1e5); bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); bav.Parent = root; local bv = Instance.new("BodyVelocity"); bv.Velocity = Vector3.new(80000, 80000, 80000); bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bv.Parent = root; task.wait(1); SafeDestroy(bav); SafeDestroy(bv) end
local function fW(t) local c = t.Character; if not c then return end; local root = c:FindFirstChild("HumanoidRootPart"); if not root then return end; local spin = Instance.new("Part"); spin.Size = Vector3.new(4, 4, 4); spin.Transparency = 1; spin.CanCollide = false; pcall(function() spin.CustomPhysicalProperties = PhysicalProperties.new(200, 0.3, 0.5, 1, 1) end); spin.CFrame = root.CFrame; spin.Parent = workspace; pcall(function() spin:SetNetworkOwner(LocalPlayer) end); local w = Instance.new("Weld"); w.Part0 = spin; w.Part1 = root; w.Parent = spin; for i = 1, 60 do pcall(function() spin.AssemblyAngularVelocity = Vector3.new(1e5, 1e5, 1e5); spin.AssemblyLinearVelocity = Vector3.new(0, 500000, 0); spin.CFrame = spin.CFrame * CFrame.Angles(0.5, 0.5, 0.5) end); task.wait(0.01) end; w:Destroy(); spin:Destroy() end
local function fOv(t) local mc = LocalPlayer.Character; local tc = t.Character; if not mc or not tc then return end; local r1 = mc:FindFirstChild("HumanoidRootPart"); local r2 = tc:FindFirstChild("HumanoidRootPart"); if not r1 or not r2 then return end; for i = 1, 40 do r1.CFrame = r2.CFrame * CFrame.new(math.random(-20, 20) / 10, 0, math.random(-20, 20) / 10); r1.AssemblyLinearVelocity = Vector3.new(math.random(-5000, 5000), 5000, math.random(-5000, 5000)); task.wait(0.02) end end
local FLY_fB, FLY_fG, FLY_conn = nil, nil, nil
local function fFlyStart() if FLY_fB then return end; local c = LocalPlayer.Character; if not c then return end; local r = c:FindFirstChild("HumanoidRootPart"); if not r then return end; local t = c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso") or r; FLY_fB = Instance.new("BodyVelocity"); FLY_fB.MaxForce = Vector3.new(1e9, 1e9, 1e9); FLY_fB.Velocity = Vector3.zero; FLY_fB.Parent = t; FLY_fG = Instance.new("BodyGyro"); FLY_fG.MaxTorque = Vector3.new(1e9, 1e9, 1e9); FLY_fG.P = 9e4; FLY_fG.Parent = t; local h = c:FindFirstChildOfClass("Humanoid"); FLY_conn = RunService.RenderStepped:Connect(function() if not FLY_fB or not FLY_fB.Parent then return end; local ca = workspace.CurrentCamera.CFrame; local m = h and h.MoveDirection or Vector3.zero; local dir = ca.LookVector * m.Z + ca.RightVector * m.X; if dir.Magnitude < 0.01 then dir = Vector3.zero else dir = dir.Unit end; FLY_fB.Velocity = dir * 70; FLY_fG.CFrame = ca end) end
local function fFlyStop() if FLY_conn then FLY_conn:Disconnect(); FLY_conn = nil end; if FLY_fB then FLY_fB:Destroy(); FLY_fB = nil end; if FLY_fG then FLY_fG:Destroy(); FLY_fG = nil end end
local function FL(tg, bt) if not tg then return end; local tc = tg.Character; if not tc then return end; local tr = tc:FindFirstChild("HumanoidRootPart"); local mc = LocalPlayer.Character; local mr = mc and mc:FindFirstChild("HumanoidRootPart"); if not tr or not mr then return end; if (tr.Position - mr.Position).Magnitude > 100 then if bt then bt.Text = "!far" end; task.wait(1.2); if bt then bt.Text = T("Fling") end; return end; if bt then bt.Text = "..." end; task.spawn(function() eN(); fFlyStart(); task.wait(0.15); if not tP(tg) then dN(); fFlyStop(); if bt then bt.Text = T("Fling") end; return end; task.wait(0.1); task.spawn(function() fO(tg) end); task.spawn(function() fW(tg) end); task.spawn(function() fOv(tg) end); task.wait(1.2); dN(); fFlyStop(); if bt then bt.Text = T("Fling") end end) end

local function ApplyAntiFling() Disconnect("AntiFling"); if not Cfg.AntiFling then return end; Conn.AntiFling = RunService.Heartbeat:Connect(function() if not Cfg.AntiFling then return end; local _, _, r = GetChar(); if r then if r.AssemblyLinearVelocity.Magnitude > 250 then r.AssemblyLinearVelocity = Vector3.zero end; if r.AssemblyAngularVelocity.Magnitude > 20 then r.AssemblyAngularVelocity = Vector3.zero end end end) end

local function PickTarget() local cam = workspace.CurrentCamera; if not cam then return nil end; local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2); local best, bestDist = nil, Cfg.AimFOV; for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then local c = plr.Character; if c then local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health > 0 then local pt = c:FindFirstChild(Cfg.AimPart) or c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart"); if pt then local ps, on = cam:WorldToViewportPoint(pt.Position); if on and ps.Z > 0 then local d = (Vector2.new(ps.X, ps.Y) - center).Magnitude; if d < bestDist then local visible = true; if Cfg.WallCheck then local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances = {LocalPlayer.Character, cam}; local ray = workspace:Raycast(cam.CFrame.Position, pt.Position - cam.CFrame.Position, rp); if ray and not ray.Instance:IsDescendantOf(c) then visible = false end end; if visible then bestDist = d; best = pt end end end end end end end end return best end
local function IsValid(part) if not part or not part.Parent then return false end; local cam = workspace.CurrentCamera; if not cam then return false end; local ps, on = cam:WorldToViewportPoint(part.Position); if not on or ps.Z <= 0 then return false end; local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2); if (Vector2.new(ps.X, ps.Y) - center).Magnitude > Cfg.AimFOV then return false end; local h = part.Parent and part.Parent:FindFirstChildOfClass("Humanoid"); if h and h.Health <= 0 then return false end; if Cfg.WallCheck then local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances = {LocalPlayer.Character, cam}; local ray = workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, rp); if ray and not ray.Instance:IsDescendantOf(part.Parent) then return false end end; return true end
local function ApplyAimbot() Disconnect("Aimbot"); AimLock = nil; if not Cfg.Aimbot then return end; Conn.Aimbot = RunService.RenderStepped:Connect(function() if not Cfg.Aimbot then return end; local cam = workspace.CurrentCamera; if not cam then return end; if AimLock and not IsValid(AimLock) then AimLock = nil end; if not AimLock then AimLock = PickTarget() end; if not AimLock then return end; local targetCF = CFrame.new(cam.CFrame.Position, AimLock.Position); local sm = math.max(Cfg.AimSmooth, 1); cam.CFrame = sm <= 1 and targetCF or cam.CFrame:Lerp(targetCF, 1 / sm) end) end
local function ApplySilent() Disconnect("Silent"); if not Cfg.Silent then return end; Conn.Silent = UserInputService.InputBegan:Connect(function(inp, gp) if gp then return end; if inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end; if not Cfg.Silent then return end; local tgt = PickTarget(); if not tgt then return end; local cam = workspace.CurrentCamera; if not cam then return end; local orig = cam.CFrame; cam.CFrame = CFrame.new(cam.CFrame.Position, tgt.Position); task.wait(0.015); cam.CFrame = orig end) end

local function ApplyFullbright() Disconnect("Fullbright"); if not Cfg.Fullbright then if OrigLight then pcall(function() game.Lighting.Brightness = OrigLight.B end); pcall(function() game.Lighting.ClockTime = OrigLight.C end); pcall(function() game.Lighting.FogEnd = OrigLight.F end); pcall(function() game.Lighting.Ambient = OrigLight.A end); pcall(function() game.Lighting.OutdoorAmbient = OrigLight.O end); OrigLight = nil end; return end; if not OrigLight then OrigLight = {B = game.Lighting.Brightness, C = game.Lighting.ClockTime, F = game.Lighting.FogEnd, A = game.Lighting.Ambient, O = game.Lighting.OutdoorAmbient} end; Conn.Fullbright = RunService.Heartbeat:Connect(function() if not Cfg.Fullbright then return end; pcall(function() game.Lighting.Brightness = 2 end); pcall(function() game.Lighting.ClockTime = 14 end); pcall(function() game.Lighting.FogEnd = 1e5 end); pcall(function() game.Lighting.Ambient = Color3.fromRGB(180, 180, 180) end); pcall(function() game.Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180) end) end) end
local function ApplyRainbow() Disconnect("Rainbow"); if not Cfg.Rainbow then return end; local hue = 0; Conn.Rainbow = RunService.Heartbeat:Connect(function() if not Cfg.Rainbow then return end; hue = (hue + 0.01) % 1; local col = Color3.fromHSV(hue, 1, 1); local ch = LocalPlayer.Character; if ch then for _, p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.Color = col end end end end) end
local function ApplyAura() Disconnect("Aura"); if not Cfg.Aura then return end; Conn.Aura = RunService.Heartbeat:Connect(function() if not Cfg.Aura then return end; local _, _, r = GetChar(); if not r then return end; local e = Instance.new("Explosion"); e.Position = r.Position + Vector3.new(math.random(-4, 4), 0, math.random(-4, 4)); e.BlastRadius = 2; e.BlastPressure = 0; e.DestroyJointRadiusPercent = 0; e.Parent = workspace; game:GetService("Debris"):AddItem(e, 0.1) end) end
local function ApplyInvisible(on) local ch = LocalPlayer.Character; if not ch then return end; for _, p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then if on then if not p:GetAttribute("OT") then p:SetAttribute("OT", p.Transparency) end; p.Transparency = 1 else local o = p:GetAttribute("OT"); if o then p.Transparency = o end end end end end

local function ApplyTrail() 
    local _, _, hrp = GetChar(); 
    if hrp then local a0 = hrp:FindFirstChild("RAZE_TA0"); if a0 then a0:Destroy() end; local a1 = hrp:FindFirstChild("RAZE_TA1"); if a1 then a1:Destroy() end; local tr = hrp:FindFirstChild("RAZE_Trail"); if tr then tr:Destroy() end; local pt = hrp:FindFirstChild("RAZE_TrailPrt"); if pt then pt:Destroy() end end; 
    if not Cfg.Trail or not hrp then return end
    local a0 = Instance.new("Attachment"); a0.Name = "RAZE_TA0"; a0.Position = Vector3.new(0, -2, 0); a0.Parent = hrp
    local a1 = Instance.new("Attachment"); a1.Name = "RAZE_TA1"; a1.Position = Vector3.new(0, 2, 0); a1.Parent = hrp
    local tr = Instance.new("Trail"); tr.Name = "RAZE_Trail"; tr.Attachment0 = a0; tr.Attachment1 = a1; tr.Lifetime = 0.5; tr.MinLength = 0.1
    if Cfg.TrailType == "Lightning" then tr.Texture = "rbxassetid://9305978346"; tr.TextureMode = Enum.TextureMode.Stretch; tr.TextureLength = 4; tr.Color = ColorSequence.new(Color3.fromRGB(0, 200, 255)); tr.LightEmission = 1; local prt = Instance.new("ParticleEmitter"); prt.Name = "RAZE_TrailPrt"; prt.Texture = "rbxasset://textures/particles/sparkles_main.dds"; prt.Color = ColorSequence.new(Color3.fromRGB(100, 255, 255)); prt.Rate = 100; prt.Lifetime = NumberRange.new(0.2, 0.5); prt.Speed = NumberRange.new(5, 10); prt.Size = NumberSequence.new(0.3, 0); prt.LightEmission = 1; prt.Parent = hrp
    elseif Cfg.TrailType == "Fire" then tr.Texture = "rbxassetid://4469010593"; tr.TextureMode = Enum.TextureMode.Stretch; tr.TextureLength = 3; tr.Color = ColorSequence.new(Color3.fromRGB(255, 100, 0)); tr.LightEmission = 1; local prt = Instance.new("ParticleEmitter"); prt.Name = "RAZE_TrailPrt"; prt.Texture = "rbxasset://textures/particles/fire_main.dds"; prt.Color = ColorSequence.new(Color3.fromRGB(255, 150, 0)); prt.Rate = 80; prt.Lifetime = NumberRange.new(0.3, 0.6); prt.Speed = NumberRange.new(2, 5); prt.Size = NumberSequence.new(0.5, 0); prt.LightEmission = 1; prt.Parent = hrp
    else tr.Color = ColorSequence.new(trailCol); tr.LightEmission = Cfg.TrailGlow and 1 or 0 end
    tr.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)}); tr.Parent = hrp 
end
local function ApplyTrailRainbow() Disconnect("TrailRB"); if not Cfg.TrailRainbow or not Cfg.Trail then return end; Conn.TrailRB = RunService.Heartbeat:Connect(function() if not Cfg.TrailRainbow or not Cfg.Trail then return end; trailHue = (trailHue + 0.02) % 1; trailCol = Color3.fromHSV(trailHue, 1, 1); local _, _, hrp = GetChar(); if hrp then local tr = hrp:FindFirstChild("RAZE_Trail"); if tr and Cfg.TrailType == "Standard" then tr.Color = ColorSequence.new(trailCol) end end end) end
local function UpdateTrailColor() local _, _, hrp = GetChar(); if hrp then local tr = hrp:FindFirstChild("RAZE_Trail"); if tr and not Cfg.TrailRainbow and Cfg.TrailType == "Standard" then tr.Color = ColorSequence.new(trailCol) end end end

local function MakeAreaEffect(name, texture, color, rate, lifetime, speed, size, accel, emitDir) local old = workspace:FindFirstChild(name); if old then old:Destroy() end; local part = Instance.new("Part"); part.Name = name; part.Size = Vector3.new(150, 1, 150); part.Transparency = 1; part.CanCollide = false; part.Anchored = true; part.Parent = workspace; local emitter = Instance.new("ParticleEmitter"); emitter.Texture = texture; emitter.Color = ColorSequence.new(color); emitter.Rate = rate; emitter.Lifetime = NumberRange.new(lifetime[1], lifetime[2]); emitter.Speed = NumberRange.new(speed[1], speed[2]); emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size[1]), NumberSequenceKeypoint.new(1, size[2])}); emitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)}); emitter.Acceleration = accel; emitter.Shape = Enum.ParticleEmitterShape.Box; emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume; emitter.EmissionDirection = emitDir; emitter.Parent = part; return part, emitter end
local function ApplySnow() local part = workspace:FindFirstChild("RAZE_SnowArea"); if part then part:Destroy() end; if not Cfg.Snow then return end; local p, e = MakeAreaEffect("RAZE_SnowArea", "rbxasset://textures/particles/smoke_main.dds", Color3.fromRGB(255,255,255), 200, {3, 5}, {5, 10}, {0.5, 0.2}, Vector3.new(0, -10, 0), Enum.NormalId.Bottom); Conn.Snow = RunService.Heartbeat:Connect(function() if not Cfg.Snow then return end; local char = LocalPlayer.Character; if char and char:FindFirstChild("HumanoidRootPart") then p.CFrame = CFrame.new(char.HumanoidRootPart.Position + Vector3.new(0, 40, 0)) end end) end
local function ApplyConfetti() local part = workspace:FindFirstChild("RAZE_ConfettiArea"); if part then part:Destroy() end; if not Cfg.Confetti then return end; local p, e = MakeAreaEffect("RAZE_ConfettiArea", "rbxasset://textures/particles/sparkles_main.dds", Color3.fromRGB(255,100,100), 150, {2, 4}, {5, 10}, {0.6, 0.2}, Vector3.new(0, -5, 0), Enum.NormalId.Bottom); e.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(50, 255, 50)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(50, 50, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 50))}; Conn.Confetti = RunService.Heartbeat:Connect(function() if not Cfg.Confetti then return end; local char = LocalPlayer.Character; if char and char:FindFirstChild("HumanoidRootPart") then p.CFrame = CFrame.new(char.HumanoidRootPart.Position + Vector3.new(0, 40, 0)) end end) end
local function ApplyStars() local part = workspace:FindFirstChild("RAZE_StarsArea"); if part then part:Destroy() end; if not Cfg.Stars then return end; local p, e = MakeAreaEffect("RAZE_StarsArea", "rbxasset://textures/particles/sparkles_main.dds", Color3.fromRGB(255,220,80), 100, {2, 4}, {4, 8}, {0.5, 0.1}, Vector3.new(0, -6, 0), Enum.NormalId.Bottom); Conn.Stars = RunService.Heartbeat:Connect(function() if not Cfg.Stars then return end; local char = LocalPlayer.Character; if char and char:FindFirstChild("HumanoidRootPart") then p.CFrame = CFrame.new(char.HumanoidRootPart.Position + Vector3.new(0, 40, 0)) end end) end

local function MakeParticle(name, texture, color, rate, lifeMin, lifeMax, spdMin, spdMax, sizeMin, sizeMax) local _, _, hrp = GetChar(); if not hrp then return end; local old = hrp:FindFirstChild(name); if old then old:Destroy() end; local prt = Instance.new("ParticleEmitter"); prt.Name = name; prt.Texture = texture; prt.Rate = rate; prt.Lifetime = NumberRange.new(lifeMin, lifeMax); prt.Speed = NumberRange.new(spdMin, spdMax); prt.SpreadAngle = Vector2.new(360, 360); prt.Color = ColorSequence.new(color); prt.LightEmission = 1; prt.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, sizeMin), NumberSequenceKeypoint.new(1, sizeMax)}); prt.Parent = hrp; return prt end
local function ApplyParticles() local _, _, hrp = GetChar(); if hrp then local old = hrp:FindFirstChild("RAZE_Prt"); if old then old:Destroy() end end; if not Cfg.Particles or not hrp then return end; MakeParticle("RAZE_Prt", "rbxasset://textures/particles/sparkles_main.dds", trailCol, 60, 0.5, 1, 2, 5, 0.5, 0) end
local function ApplyHearts() local _, _, hrp = GetChar(); if hrp then local old = hrp:FindFirstChild("RAZE_Heart"); if old then old:Destroy() end end; if not Cfg.Hearts or not hrp then return end; local p = MakeParticle("RAZE_Heart", "rbxasset://textures/particles/sparkles_main.dds", Color3.fromRGB(255, 100, 150), 30, 1, 2, 2, 4, 0.6, 0); if p then p.Acceleration = Vector3.new(0, 2, 0) end end
local function ApplyBubbles() local _, _, hrp = GetChar(); if hrp then local old = hrp:FindFirstChild("RAZE_Bub"); if old then old:Destroy() end end; if not Cfg.Bubbles or not hrp then return end; local p = MakeParticle("RAZE_Bub", "rbxasset://textures/particles/smoke_main.dds", Color3.fromRGB(120, 200, 255), 40, 1.5, 3, 3, 6, 0.4, 0); if p then p.Acceleration = Vector3.new(0, 2, 0); p.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)}) end end
local function ApplyOrbit() Disconnect("Orbit"); local _, _, hrp = GetChar(); if hrp then local old = hrp:FindFirstChild("RAZE_Orb"); if old then old:Destroy() end end; if not Cfg.Orbit or not hrp then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_Orb"; folder.Parent = hrp; local balls = {}; for i = 1, 6 do local b = Instance.new("Part"); b.Shape = Enum.PartType.Ball; b.Size = Vector3.new(0.8, 0.8, 0.8); b.Material = Enum.Material.Neon; b.Color = trailCol; b.CanCollide = false; b.Anchored = true; b.Parent = folder; table.insert(balls, b) end; Conn.Orbit = RunService.Heartbeat:Connect(function() if not Cfg.Orbit or not hrp.Parent then return end; local t = os.clock() * 2; for i, b in ipairs(balls) do local a = t + (i - 1) * (math.pi * 2 / 6); b.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(a) * 4, math.sin(t) * 0.5, math.sin(a) * 4)); b.Color = trailCol end end) end
local function ApplySelfOutline() local ch = LocalPlayer.Character; if not ch then return end; local old = ch:FindFirstChild("RAZE_SelfOutline"); if old then old:Destroy() end; if not Cfg.SelfOutline then return end; local hl = Instance.new("Highlight"); hl.Name = "RAZE_SelfOutline"; hl.Adornee = ch; hl.FillColor = trailCol; hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.FillTransparency = 0.7; hl.OutlineTransparency = 0; hl.Parent = ch end
local function ApplyRing() local _, _, hrp = GetChar(); local old = workspace:FindFirstChild("RAZE_Ring"); if old then old:Destroy() end; if not Cfg.Ring or not hrp then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_Ring"; folder.Parent = workspace; local rings = {}; for i = 1, 2 do local ring = Instance.new("Part"); ring.Shape = Enum.PartType.Cylinder; ring.Size = Vector3.new(0.15, 5 + i, 5 + i); ring.Material = Enum.Material.Neon; ring.Color = trailCol; ring.CanCollide = false; ring.Anchored = true; ring.Transparency = 0.3; ring.Parent = folder; table.insert(rings, {Part = ring, Idx = i}) end; Conn.Ring = RunService.Heartbeat:Connect(function() if not Cfg.Ring or not hrp.Parent then return end; local t = os.clock(); for _, rd2 in ipairs(rings) do local p = rd2.Part; local dir = rd2.Idx == 1 and 1 or -1; p.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 2.5 + rd2.Idx * 0.2, 0)) * CFrame.Angles(0, 0, math.rad(90)) * CFrame.Angles(0, t * dir, 0); p.Color = trailCol end end) end
local function ApplyHalo() local _, _, hrp = GetChar(); local old = workspace:FindFirstChild("RAZE_Halo"); if old then old:Destroy() end; if not Cfg.Halo or not hrp then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_Halo"; folder.Parent = workspace; local orbs = {}; for i = 1, 12 do local b = Instance.new("Part"); b.Shape = Enum.PartType.Ball; b.Size = Vector3.new(0.4, 0.4, 0.4); b.Material = Enum.Material.Neon; b.Color = trailCol; b.CanCollide = false; b.Anchored = true; b.Parent = folder; table.insert(orbs, b) end; Conn.Halo = RunService.Heartbeat:Connect(function() if not Cfg.Halo or not hrp.Parent then return end; local t = os.clock(); for i, b in ipairs(orbs) do local ang = (i - 1) * (math.pi * 2 / 12) + t * 1.5; local rad = 2 + math.sin(t * 2) * 0.2; local y = math.sin(t * 3 + i * 0.5) * 0.15; b.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(ang) * rad, 4 + y, math.sin(ang) * rad)); local sz = 0.4 + math.sin(t * 4 + i * 0.5) * 0.15; b.Size = Vector3.new(sz, sz, sz); b.Color = trailCol end end) end
local function ApplyWings() local _, _, hrp = GetChar(); local old = workspace:FindFirstChild("RAZE_Wings"); if old then old:Destroy() end; if not Cfg.Wings or not hrp then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_Wings"; folder.Parent = workspace; local feathers = {}; for side = -1, 1, 2 do for i = 1, 8 do local f = Instance.new("Part"); local len = 3 + i * 0.4; local thick = 1.5 - i * 0.1; f.Size = Vector3.new(0.2, len, thick); f.Material = Enum.Material.Neon; f.Color = trailCol; f.CanCollide = false; f.Anchored = true; f.Transparency = 0.2 - i * 0.02; f.Parent = folder; table.insert(feathers, {Part = f, Side = side, Idx = i}) end end; Conn.Wings = RunService.Heartbeat:Connect(function() if not Cfg.Wings or not hrp.Parent then return end; local t = os.clock() * 3; local flap = math.sin(t) * 0.5; for _, fd in ipairs(feathers) do local p = fd.Part; local s = fd.Side; local idx = fd.Idx; local ang = (idx - 1) * 12 + flap * 25 + 15; local offX = s * (1 + idx * 0.5); local offY = 1.5 + idx * 0.4; local offZ = -idx * 0.4; local rot = CFrame.Angles(0, 0, s * math.rad(ang)) * CFrame.Angles(0, s * math.rad(25), 0); p.CFrame = hrp.CFrame * CFrame.new(offX, offY, offZ) * rot; p.Color = trailCol end end) end
local function ApplyAuraSphere() local _, _, hrp = GetChar(); local old = workspace:FindFirstChild("RAZE_AuraSphere"); if old then old:Destroy() end; if not Cfg.AuraSphere or not hrp then return end; local sph = Instance.new("Part"); sph.Name = "RAZE_AuraSphere"; sph.Shape = Enum.PartType.Ball; sph.Size = Vector3.new(5, 5, 5); sph.Material = Enum.Material.ForceField; sph.Color = trailCol; sph.Transparency = 0.7; sph.CanCollide = false; sph.Anchored = true; sph.Parent = workspace; Conn.AuraSphere = RunService.Heartbeat:Connect(function() if not Cfg.AuraSphere or not hrp.Parent then return end; local t = os.clock(); local sz = 5 + math.sin(t * 3) * 1; sph.Size = Vector3.new(sz, sz, sz); sph.CFrame = hrp.CFrame; sph.Color = trailCol end) end
local function ApplyLightning() local _, _, hrp = GetChar(); local old = workspace:FindFirstChild("RAZE_LN"); if old then old:Destroy() end; if not Cfg.Lightning or not hrp then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_LN"; folder.Parent = workspace; local bolts = {}; for i = 1, 10 do local p = Instance.new("Part"); p.Size = Vector3.new(0.15, 0.15, 0.15); p.Material = Enum.Material.Neon; p.Color = trailCol; p.CanCollide = false; p.Anchored = true; p.Parent = folder; table.insert(bolts, p) end; Conn.Lightning = RunService.Heartbeat:Connect(function() if not Cfg.Lightning or not hrp.Parent then return end; local t = os.clock(); for i, b in ipairs(bolts) do local ang = (t * 3 + i * 0.6) % (math.pi * 2); local rad = 3 + math.sin(t * 5 + i) * 1; local y = math.sin(t * 4 + i) * 2; b.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(ang) * rad, y, math.sin(ang) * rad)); b.Size = Vector3.new(0.15 + math.random() * 0.1, 0.15, 0.15); b.Color = trailCol end end) end
local function ApplyFire() local _, _, hrp = GetChar(); if hrp then local o = hrp:FindFirstChild("RAZE_Fire"); if o then o:Destroy() end end; if not Cfg.Fire or not hrp then return end; local fire = Instance.new("Fire"); fire.Name = "RAZE_Fire"; fire.Size = 5; fire.Heat = 5; fire.Color = trailCol; fire.SecondaryColor = Color3.fromRGB(255, 150, 0); fire.Parent = hrp end
local function ApplyAntiAFK() Disconnect("AntiAFK"); if not Cfg.AntiAFK then return end; pcall(function() if getconnections then for _, c in ipairs(getconnections(LocalPlayer.Idled)) do c:Disconnect() end end end); Conn.AntiAFK = LocalPlayer.Idled:Connect(function() if not Cfg.AntiAFK then return end; pcall(function() if VirtualUser then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end end) end) end
local function ApplyCrosshair() Disconnect("Crosshair"); if Conn.CrosshairGUI then Conn.CrosshairGUI:Destroy(); Conn.CrosshairGUI = nil end; if not Cfg.Crosshair then return end; local cross = Instance.new("ScreenGui"); cross.Name = "RAZE_Cross"; cross.ResetOnSpawn = false; cross.IgnoreGuiInset = true; cross.Parent = PlayerGui; Conn.CrosshairGUI = cross; local h = Instance.new("Frame"); h.Size = UDim2.new(0, 2, 0, 20); h.Position = UDim2.new(0.5, -1, 0.5, -10); h.BackgroundColor3 = trailCol; h.BorderSizePixel = 0; h.Parent = cross; local v = Instance.new("Frame"); v.Size = UDim2.new(0, 20, 0, 2); v.Position = UDim2.new(0.5, -10, 0.5, -1); v.BackgroundColor3 = trailCol; v.BorderSizePixel = 0; v.Parent = cross; local dot = Instance.new("Frame"); dot.Size = UDim2.new(0, 4, 0, 4); dot.Position = UDim2.new(0.5, -2, 0.5, -2); dot.BackgroundColor3 = trailCol; dot.BorderSizePixel = 0; dot.Parent = cross end
local function BringAll() local _, _, mr = GetChar(); if not mr then return end; for _, pl in ipairs(Players:GetPlayers()) do if pl ~= LocalPlayer and pl.Character then local hr = pl.Character:FindFirstChild("HumanoidRootPart"); if hr then hr.CFrame = mr.CFrame + Vector3.new(math.random(-4, 4), 3, math.random(-4, 4)) end end end end

local function ApplyBlackHole() Disconnect("BlackHole"); local old = workspace:FindFirstChild("RAZE_BH"); if old then old:Destroy() end; if not Cfg.BlackHole then return end; local folder = Instance.new("Folder"); folder.Name = "RAZE_BH"; folder.Parent = workspace; local core = Instance.new("Part"); core.Shape = Enum.PartType.Ball; core.Size = Vector3.new(3,3,3); core.Material = Enum.Material.ForceField; core.Color = Color3.fromRGB(0,0,0); core.Transparency = 0.2; core.CanCollide = false; core.Anchored = true; core.Parent = folder; local ring = Instance.new("Part"); ring.Shape = Enum.PartType.Cylinder; ring.Size = Vector3.new(0.2, 5, 5); ring.Material = Enum.Material.Neon; ring.Color = trailCol; ring.Transparency = 0.5; ring.CanCollide = false; ring.Anchored = true; ring.Parent = folder; local prt = Instance.new("ParticleEmitter"); prt.Texture = "rbxassetid://244221440"; prt.Rate = 200; prt.Lifetime = NumberRange.new(0.5, 1); prt.Speed = NumberRange.new(5, 10); prt.Size = NumberSequence.new(0.1, 0); prt.Color = ColorSequence.new(trailCol); prt.LightEmission = 1; prt.Parent = core; Conn.BlackHole = RunService.Heartbeat:Connect(function() if not Cfg.BlackHole then return end; local _, _, hrp = GetChar(); if hrp then local t = os.clock() * 2; core.CFrame = hrp.CFrame * CFrame.new(0, 3, -4); ring.CFrame = core.CFrame * CFrame.Angles(math.rad(90), t, 0); ring.Color = trailCol end end) end
local function ApplyEnergySword() Disconnect("EnergySword"); local char = LocalPlayer.Character; if not char then return end; local old = char:FindFirstChild("RAZE_Sword"); if old then old:Destroy() end; if not Cfg.EnergySword then return end; local hrp = char:FindFirstChild("HumanoidRootPart"); local hand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"); if not hand then return end; local sword = Instance.new("Part"); sword.Name = "RAZE_Sword"; sword.Size = Vector3.new(0.5, 6, 0.5); sword.Material = Enum.Material.Neon; sword.Color = trailCol; sword.CanCollide = false; sword.Massless = true; sword.Parent = char; local weld = Instance.new("Weld"); weld.Part0 = hand; weld.Part1 = sword; weld.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(90), 0, 0); weld.Parent = sword; local tr = Instance.new("Trail"); local a0 = Instance.new("Attachment"); a0.Position = Vector3.new(0, -3, 0); a0.Parent = sword; local a1 = Instance.new("Attachment"); a1.Position = Vector3.new(0, 3, 0); a1.Parent = sword; tr.Attachment0 = a0; tr.Attachment1 = a1; tr.Color = ColorSequence.new(trailCol); tr.Lifetime = 0.3; tr.LightEmission = 1; tr.Parent = sword end
local function ApplyFireflies() Disconnect("Fireflies"); local _, _, hrp = GetChar(); if hrp then local old = hrp:FindFirstChild("RAZE_FF"); if old then old:Destroy() end end; if not Cfg.Fireflies or not hrp then return end; local prt = Instance.new("ParticleEmitter"); prt.Name = "RAZE_FF"; prt.Texture = "rbxasset://textures/particles/sparkles_main.dds"; prt.Rate = 20; prt.Lifetime = NumberRange.new(2, 4); prt.Speed = NumberRange.new(1, 3); prt.SpreadAngle = Vector2.new(360, 360); prt.Color = ColorSequence.new(Color3.fromRGB(255, 255, 100)); prt.LightEmission = 1; prt.Size = NumberSequence.new(0.2, 0); prt.Parent = hrp end
local function ApplyTargetAura() Disconnect("TargetAura"); for _, p in ipairs(Players:GetPlayers()) do if p.Character then local old = p.Character:FindFirstChild("RAZE_TargetAura"); if old then old:Destroy() end end end; if not Cfg.TargetAura then return end; Conn.TargetAura = RunService.Heartbeat:Connect(function() if not Cfg.TargetAura then return end; for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hrp = p.Character:FindFirstChild("HumanoidRootPart"); if hrp then local old = p.Character:FindFirstChild("RAZE_TargetAura"); if not old then local sph = Instance.new("Part"); sph.Name = "RAZE_TargetAura"; sph.Shape = Enum.PartType.Ball; sph.Size = Vector3.new(6,6,6); sph.Material = Enum.Material.ForceField; sph.Color = Color3.fromRGB(255, 0, 0); sph.Transparency = 0.8; sph.CanCollide = false; sph.Anchored = true; sph.Parent = p.Character; end end end end end) end

-- ==================== STATS (FPS/PING) ====================
local StatsGui = Instance.new("TextLabel")
StatsGui.Name = "RazeStats"
StatsGui.Size = UDim2.new(0, 180, 0, 30)
StatsGui.Position = UDim2.new(0, 15, 0, 15)
StatsGui.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
StatsGui.BackgroundTransparency = 0.3
StatsGui.TextColor3 = Color3.fromRGB(50, 255, 100)
StatsGui.Font = Enum.Font.GothamBold
StatsGui.TextSize = 14
StatsGui.Text = "FPS: 60 | Ping: 0 ms"
StatsGui.TextXAlignment = Enum.TextXAlignment.Center
StatsGui.Visible = Cfg.ShowStats
StatsGui.ZIndex = 999
StatsGui.Parent = PlayerGui

local StatsCorner = Instance.new("UICorner"); StatsCorner.CornerRadius = UDim.new(0, 8); StatsCorner.Parent = StatsGui
local StatsStroke = Instance.new("UIStroke"); StatsStroke.Color = Color3.fromRGB(80, 80, 100); StatsStroke.Thickness = 1.5; StatsStroke.Parent = StatsGui

local fpsCount = 0
local lastTime = tick()
RunService.RenderStepped:Connect(function()
    fpsCount = fpsCount + 1
    local now = tick()
    if now - lastTime >= 1 then
        local fps = math.floor(fpsCount / (now - lastTime))
        local ping = 0
        pcall(function() ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        if Cfg.ShowStats then
            StatsGui.Visible = true
            StatsGui.Text = string.format("FPS: %d | Ping: %d ms", fps, ping)
            if ping < 80 then StatsGui.TextColor3 = Color3.fromRGB(50, 255, 100)
            elseif ping < 150 then StatsGui.TextColor3 = Color3.fromRGB(255, 200, 50)
            else StatsGui.TextColor3 = Color3.fromRGB(255, 50, 50) end
        else StatsGui.Visible = false end
        fpsCount = 0; lastTime = now
    end
end)

-- ==================== UI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RazeHub"; ScreenGui.ResetOnSpawn = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.Parent = PlayerGui

local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(400, 800)
local UIScale = Instance.new("UIScale"); UIScale.Parent = ScreenGui
local function ApplyGuiScale() local base = 1; if vp.X < 360 then base = 0.78 elseif vp.Y < 600 then base = 0.88 end; UIScale.Scale = base * Cfg.GuiScale end
ApplyGuiScale()

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420); MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210); MainFrame.BackgroundColor3 = bg1; MainFrame.BorderSizePixel = 0; MainFrame.Active = true; MainFrame.ClipsDescendants = true; MainFrame.Parent = ScreenGui
MakeDraggable(MainFrame, MainFrame)
local MFC = Instance.new("UICorner"); MFC.CornerRadius = UDim.new(0, 16); MFC.Parent = MainFrame
local MFS = Instance.new("UIStroke"); MFS.Color = rd; MFS.Thickness = 2; MFS.Transparency = 0; MFS.Parent = MainFrame
local MFSGrad = Instance.new("UIGradient")
MFSGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
}
MFSGrad.Parent = MFS

local BG_Grad = Instance.new("UIGradient"); BG_Grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, bg1), ColorSequenceKeypoint.new(1, bg2)}; BG_Grad.Rotation = 90; BG_Grad.Parent = MainFrame

local TitleBar = Instance.new("Frame"); TitleBar.Size = UDim2.new(1, 0, 0, 40); TitleBar.BackgroundColor3 = rdk; TitleBar.BorderSizePixel = 0; TitleBar.Parent = MainFrame
local TBC = Instance.new("UICorner"); TBC.CornerRadius = UDim.new(0, 16); TBC.Parent = TitleBar
local TBCover = Instance.new("Frame"); TBCover.Size = UDim2.new(1, 0, 0, 14); TBCover.Position = UDim2.new(0, 0, 1, -14); TBCover.BackgroundColor3 = rdk; TBCover.BorderSizePixel = 0; TBCover.Parent = TitleBar
local TBGrad = Instance.new("UIGradient"); TBGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, rd), ColorSequenceKeypoint.new(0.5, rdk), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 10, 20))}; TBGrad.Parent = TitleBar
local TitleLabel = Instance.new("TextLabel"); TitleLabel.Size = UDim2.new(1, -64, 1, 0); TitleLabel.Position = UDim2.new(0, 16, 0, 0); TitleLabel.BackgroundTransparency = 1; TitleLabel.Text = "RAZE HUB"; TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255); TitleLabel.Font = Enum.Font.GothamBold; TitleLabel.TextSize = 15; TitleLabel.TextXAlignment = Enum.TextXAlignment.Left; TitleLabel.Parent = TitleBar
local TitleDot = Instance.new("Frame"); TitleDot.Size = UDim2.new(0, 8, 0, 8); TitleDot.Position = UDim2.new(0, 8, 0, 16); TitleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255); TitleDot.BorderSizePixel = 0; TitleDot.Parent = TitleBar; local TDC = Instance.new("UICorner"); TDC.CornerRadius = UDim.new(1, 0); TDC.Parent = TitleDot
local HideBtn = Instance.new("TextButton"); HideBtn.Size = UDim2.new(0, 26, 0, 26); HideBtn.Position = UDim2.new(1, -34, 0, 7); HideBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0); HideBtn.BackgroundTransparency = 0.5; HideBtn.BorderSizePixel = 0; HideBtn.Text = "−"; HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255); HideBtn.Font = Enum.Font.GothamBold; HideBtn.TextSize = 18; HideBtn.Parent = TitleBar; local HBC = Instance.new("UICorner"); HBC.CornerRadius = UDim.new(0, 8); HBC.Parent = HideBtn

RunService.RenderStepped:Connect(function() MFSGrad.Rotation = (MFSGrad.Rotation + 1) % 360 end)

local FloatContainer = Instance.new("Frame"); FloatContainer.Size = UDim2.new(0, 260, 0, 400); FloatContainer.Position = UDim2.new(1, -280, 0.5, -200); FloatContainer.BackgroundColor3 = bg1; FloatContainer.BorderSizePixel = 0; FloatContainer.Visible = false; FloatContainer.Parent = ScreenGui
local FLCorner = Instance.new("UICorner"); FLCorner.CornerRadius = UDim.new(0, 12); FLCorner.Parent = FloatContainer
local FLStroke = Instance.new("UIStroke"); FLStroke.Color = rd; FLStroke.Thickness = 1.5; FLStroke.Parent = FloatContainer
local FLScroll = Instance.new("ScrollingFrame"); FLScroll.Size = UDim2.new(1, -10, 1, -20); FLScroll.Position = UDim2.new(0, 5, 0, 10); FLScroll.BackgroundTransparency = 1; FLScroll.BorderSizePixel = 0; FLScroll.ScrollBarThickness = 3; FLScroll.ScrollBarImageColor3 = rd; FLScroll.CanvasSize = UDim2.new(0, 0, 0, 0); FLScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; FLScroll.Parent = FloatContainer
local FLLayout = Instance.new("UIListLayout"); FLLayout.Padding = UDim.new(0, 5); FLLayout.Parent = FLScroll

local ShowBtn = Instance.new("TextButton"); ShowBtn.Size = UDim2.new(0, 50, 0, 50); ShowBtn.Position = UDim2.new(1, -70, 0.5, -25); ShowBtn.BackgroundColor3 = rdk; ShowBtn.BorderSizePixel = 0; ShowBtn.Text = ""; ShowBtn.Active = true; ShowBtn.Parent = ScreenGui
local SBC = Instance.new("UICorner"); SBC.CornerRadius = UDim.new(0, 12); SBC.Parent = ShowBtn
local SBS = Instance.new("UIStroke"); SBS.Color = rd; SBS.Thickness = 2; SBS.Parent = ShowBtn
local BtnImg = Instance.new("ImageLabel"); BtnImg.Size = UDim2.new(1, -6, 1, -6); BtnImg.Position = UDim2.new(0, 3, 0, 3); BtnImg.BackgroundTransparency = 1; BtnImg.Image = "rbxassetid://" .. Cfg.CustomImgID; BtnImg.ScaleType = Enum.ScaleType.Crop; BtnImg.Parent = ShowBtn
local BtnImgC = Instance.new("UICorner"); BtnImgC.CornerRadius = UDim.new(0, 9); BtnImgC.Parent = BtnImg; table.insert(ImageRefs, BtnImg)
MakeDraggable(ShowBtn, ShowBtn)

local function AddQuickBtn(name, cfgKey, callback)
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(1, 0, 0, 30); btn.BackgroundColor3 = Cfg[cfgKey] and rd or cd; btn.BorderSizePixel = 0; btn.Text = name; btn.TextColor3 = tx; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.Parent = FLScroll
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 6); bc.Parent = btn
    btn.MouseButton1Click:Connect(function()
        Cfg[cfgKey] = not Cfg[cfgKey]
        btn.BackgroundColor3 = Cfg[cfgKey] and rd or cd
        callback(Cfg[cfgKey])
        task.spawn(SaveConfig)
    end)
end

AddQuickBtn("Fly", "Fly", function(e) if e then StartFly() else StopFly() end end)
AddQuickBtn("Speed", "Speed", function(e) ApplySpeed() end)
AddQuickBtn("Noclip", "Noclip", function(e) ApplyNoclip() end)
AddQuickBtn("ESP", "ESP", function(e) ApplyESP() end)
AddQuickBtn("Aimbot", "Aimbot", function(e) ApplyAimbot() end)
AddQuickBtn("Hitbox", "Hitbox", function(e) ApplyHitbox() end)
AddQuickBtn("Black Hole", "BlackHole", function(e) ApplyBlackHole() end)
AddQuickBtn("Energy Sword", "EnergySword", function(e) ApplyEnergySword() end)
AddQuickBtn("Fireflies", "Fireflies", function(e) ApplyFireflies() end)
AddQuickBtn("Target Aura", "TargetAura", function(e) ApplyTargetAura() end)

local TabBar = Instance.new("Frame"); TabBar.Size = UDim2.new(1, 0, 0, 36); TabBar.Position = UDim2.new(0, 0, 0, 40); TabBar.BackgroundColor3 = bg2; TabBar.BorderSizePixel = 0; TabBar.Parent = MainFrame
local TabKeys = {"Tab_Main", "Tab_Combat", "Tab_Visual", "Tab_FX", "Tab_Settings"}; local TabButtons = {}; local TabContent = {}
local Underline = Instance.new("Frame"); Underline.Size = UDim2.new(1/5 - 0.02, 0, 0, 2); Underline.Position = UDim2.new(0.01, 0, 1, -3); Underline.BackgroundColor3 = rd; Underline.BorderSizePixel = 0; Underline.Parent = TabBar; local UC = Instance.new("UICorner"); UC.CornerRadius = UDim.new(1, 0); UC.Parent = Underline
for i, key in ipairs(TabKeys) do
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(1/5, -4, 1, -6); btn.Position = UDim2.new((i - 1) / 5 + 0.005, 0, 0, 3); btn.BackgroundColor3 = cd; btn.BorderSizePixel = 0; btn.Text = T(key); btn.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or td; btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = TabBar
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = btn; TabButtons[i] = btn; i18nRefs[key] = btn
    local scroll = Instance.new("ScrollingFrame"); scroll.Size = UDim2.new(1, -12, 1, -86); scroll.Position = UDim2.new(0, 6, 0, 80); scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = rd; scroll.CanvasSize = UDim2.new(0, 0, 0, 0); scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; scroll.Visible = i == 1; scroll.Parent = MainFrame
    local lay = Instance.new("UIListLayout"); lay.Padding = UDim.new(0, 4); lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Parent = scroll; TabContent[i] = scroll
    btn.MouseButton1Click:Connect(function() for j, bb in ipairs(TabButtons) do TweenService:Create(bb, TweenInfo.new(0.15), {TextColor3 = j == i and Color3.fromRGB(255, 255, 255) or td}):Play(); TabContent[j].Visible = j == i end; TweenService:Create(Underline, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new((i - 1) / 5 + 0.008, 0, 1, -3)}):Play() end)
end

local function Section(parent, textKey) local f = Instance.new("Frame"); f.Size = UDim2.new(1, -4, 0, 18); f.BackgroundTransparency = 1; f.Parent = parent; local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, -8, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0); lbl.BackgroundTransparency = 1; lbl.Text = T(textKey); lbl.TextColor3 = rlt; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = f; i18nRefs[textKey] = lbl end
local function Toggle(parent, textKey, default, callback) local row = Instance.new("Frame"); row.Size = UDim2.new(1, -4, 0, 34); row.BackgroundColor3 = cd; row.BorderSizePixel = 0; row.Parent = parent; local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row; local dot = Instance.new("Frame"); dot.Size = UDim2.new(0, 3, 0, 16); dot.Position = UDim2.new(0, 0, 0, 9); dot.BackgroundColor3 = rd; dot.BorderSizePixel = 0; dot.Parent = row; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot; table.insert(AccentRefs, {Obj = dot, Prop = "BackgroundColor3", Kind = "main"}); local label = Instance.new("TextLabel"); label.Size = UDim2.new(1, -64, 1, 0); label.Position = UDim2.new(0, 18, 0, 0); label.BackgroundTransparency = 1; label.Text = T(textKey); label.TextColor3 = tx; label.Font = Enum.Font.GothamMedium; label.TextSize = 12; label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = row; i18nRefs[textKey] = label; local track = Instance.new("Frame"); track.Size = UDim2.new(0, 40, 0, 22); track.Position = UDim2.new(1, -48, 0, 6); track.BackgroundColor3 = default and rd or mu; track.BorderSizePixel = 0; track.Parent = row; local trc = Instance.new("UICorner"); trc.CornerRadius = UDim.new(1, 0); trc.Parent = track; table.insert(AccentRefs, {Obj = track, Prop = "BackgroundColor3", Kind = "state", State = default}); local knob = Instance.new("Frame"); knob.Size = UDim2.new(0, 18, 0, 18); knob.Position = default and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2); knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.Parent = track; local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1, 0); kc.Parent = knob; local enabled = default; local click = Instance.new("TextButton"); click.Size = UDim2.new(1, 0, 1, 0); click.BackgroundTransparency = 1; click.Text = ""; click.Parent = row; click.MouseEnter:Connect(function() TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = cdH}):Play() end); click.MouseLeave:Connect(function() TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = cd}):Play() end); click.MouseButton1Click:Connect(function() enabled = not enabled; TweenService:Create(track, TweenInfo.new(0.22), {BackgroundColor3 = enabled and rd or mu}):Play(); TweenService:Create(knob, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = enabled and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play(); for _, ref in ipairs(AccentRefs) do if ref.Obj == track then ref.State = enabled end end; callback(enabled); task.spawn(SaveConfig) end) end
local function ToggleWithValue(parent, textKey, default, defValue, callback) local row = Instance.new("Frame"); row.Size = UDim2.new(1, -4, 0, 34); row.BackgroundColor3 = cd; row.BorderSizePixel = 0; row.Parent = parent; local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row; local dot = Instance.new("Frame"); dot.Size = UDim2.new(0, 3, 0, 16); dot.Position = UDim2.new(0, 0, 0, 9); dot.BackgroundColor3 = rd; dot.BorderSizePixel = 0; dot.Parent = row; local dc = Instance.new("UICorner"); dc.CornerRadius = UDim.new(1, 0); dc.Parent = dot; table.insert(AccentRefs, {Obj = dot, Prop = "BackgroundColor3", Kind = "main"}); local label = Instance.new("TextLabel"); label.Size = UDim2.new(1, -112, 1, 0); label.Position = UDim2.new(0, 18, 0, 0); label.BackgroundTransparency = 1; label.Text = T(textKey); label.TextColor3 = tx; label.Font = Enum.Font.GothamMedium; label.TextSize = 12; label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = row; i18nRefs[textKey] = label; local box = Instance.new("TextBox"); box.Size = UDim2.new(0, 40, 0, 22); box.Position = UDim2.new(1, -96, 0, 6); box.BackgroundColor3 = ip; box.BorderSizePixel = 0; box.Text = tostring(defValue); box.TextColor3 = rlt; box.Font = Enum.Font.GothamBold; box.TextSize = 12; box.ClearTextOnFocus = false; box.Parent = row; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 6); bc.Parent = box; local track = Instance.new("Frame"); track.Size = UDim2.new(0, 40, 0, 22); track.Position = UDim2.new(1, -48, 0, 6); track.BackgroundColor3 = default and rd or mu; track.BorderSizePixel = 0; track.Parent = row; local trc = Instance.new("UICorner"); trc.CornerRadius = UDim.new(1, 0); trc.Parent = track; table.insert(AccentRefs, {Obj = track, Prop = "BackgroundColor3", Kind = "state", State = default}); local knob = Instance.new("Frame"); knob.Size = UDim2.new(0, 18, 0, 18); knob.Position = default and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2); knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.Parent = track; local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1, 0); kc.Parent = knob; local enabled = default; local value = defValue; local click = Instance.new("TextButton"); click.Size = UDim2.new(0, 40, 0, 22); click.Position = UDim2.new(1, -48, 0, 6); click.BackgroundTransparency = 1; click.Text = ""; click.Parent = row; click.MouseButton1Click:Connect(function() enabled = not enabled; TweenService:Create(track, TweenInfo.new(0.22), {BackgroundColor3 = enabled and rd or mu}):Play(); TweenService:Create(knob, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = enabled and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play(); for _, ref in ipairs(AccentRefs) do if ref.Obj == track then ref.State = enabled end end; callback(enabled, value); task.spawn(SaveConfig) end); box.FocusLost:Connect(function() local n = tonumber(box.Text); if n then value = n else box.Text = tostring(value) end; callback(enabled, value); task.spawn(SaveConfig) end) end
local function Button(parent, textKey, callback) local btn = Instance.new("TextButton"); btn.Size = UDim2.new(1, -4, 0, 30); btn.BackgroundColor3 = rdk; btn.BorderSizePixel = 0; btn.Text = T(textKey); btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.Parent = parent; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = btn; table.insert(AccentRefs, {Obj = btn, Prop = "BackgroundColor3", Kind = "dark"}); i18nRefs[textKey] = btn; btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = rd}):Play() end); btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = rdk}):Play() end); btn.MouseButton1Click:Connect(function() callback(btn) end) end
local function CycleButton(parent, textKey, options, default, callback) local row = Instance.new("Frame"); row.Size = UDim2.new(1, -4, 0, 34); row.BackgroundColor3 = cd; row.BorderSizePixel = 0; row.Parent = parent; local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = row; local label = Instance.new("TextLabel"); label.Size = UDim2.new(1, -80, 1, 0); label.Position = UDim2.new(0, 18, 0, 0); label.BackgroundTransparency = 1; label.Text = T(textKey); label.TextColor3 = tx; label.Font = Enum.Font.GothamMedium; label.TextSize = 12; label.TextXAlignment = Enum.TextXAlignment.Left; label.Parent = row; i18nRefs[textKey] = label; local btn = Instance.new("TextButton"); btn.Size = UDim2.new(0, 64, 0, 22); btn.Position = UDim2.new(1, -70, 0, 6); btn.BackgroundColor3 = ip; btn.BorderSizePixel = 0; btn.Text = default; btn.TextColor3 = rlt; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.Parent = row; local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 6); bc.Parent = btn; local idx = 1; for i, v in ipairs(options) do if v == default then idx = i break end end; btn.MouseButton1Click:Connect(function() idx = idx + 1; if idx > #options then idx = 1 end; btn.Text = options[idx]; callback(options[idx]); task.spawn(SaveConfig) end) end

Section(TabContent[1], "Sec_Move")
ToggleWithValue(TabContent[1], "Fly", Cfg.Fly, Cfg.FlySpeed, function(e, v) Cfg.Fly = e; Cfg.FlySpeed = v; if e then StartFly() else StopFly() end end)
ToggleWithValue(TabContent[1], "Speed", Cfg.Speed, Cfg.SpeedValue, function(e, v) Cfg.Speed = e; Cfg.SpeedValue = v; ApplySpeed() end)
ToggleWithValue(TabContent[1], "Jump", Cfg.Jump, Cfg.JumpValue, function(e, v) Cfg.Jump = e; Cfg.JumpValue = v; ApplyJump() end)
Toggle(TabContent[1], "InfJump", Cfg.InfJump, function(e) Cfg.InfJump = e; ApplyInfJump() end)
Toggle(TabContent[1], "BHop", Cfg.BHop, function(e) Cfg.BHop = e; ApplyBHop() end)
Toggle(TabContent[1], "Noclip", Cfg.Noclip, function(e) Cfg.Noclip = e; ApplyNoclip() end)
Section(TabContent[1], "Sec_Util")
Toggle(TabContent[1], "AntiVoid", Cfg.AntiVoid, function(e) Cfg.AntiVoid = e; ApplyAntiVoid() end)
Toggle(TabContent[1], "Fullbright", Cfg.Fullbright, function(e) Cfg.Fullbright = e; ApplyFullbright() end)
Toggle(TabContent[1], "AntiAFK", Cfg.AntiAFK, function(e) Cfg.AntiAFK = e; ApplyAntiAFK() end)
Section(TabContent[2], "Sec_Combat")
Toggle(TabContent[2], "ESP", Cfg.ESP, function(e) Cfg.ESP = e; ApplyESP() end)
Toggle(TabContent[2], "BoxESP", Cfg.BoxESP, function(e) Cfg.BoxESP = e; ApplyBoxESP() end)
Toggle(TabContent[2], "Tracer", Cfg.Tracer, function(e) Cfg.Tracer = e; ApplyTracer() end)
ToggleWithValue(TabContent[2], "Hitbox", Cfg.Hitbox, Cfg.HitboxMult, function(e, v) Cfg.Hitbox = e; Cfg.HitboxMult = v; ApplyHitbox() end)
Toggle(TabContent[2], "HitboxView", Cfg.HitboxView, function(e) Cfg.HitboxView = e; ApplyHitboxView() end)
Section(TabContent[2], "Sec_Aim")
Toggle(TabContent[2], "Aimbot", Cfg.Aimbot, function(e) Cfg.Aimbot = e; ApplyAimbot() end)
Toggle(TabContent[2], "Silent", Cfg.Silent, function(e) Cfg.Silent = e; ApplySilent() end)
Toggle(TabContent[2], "WallCheck", Cfg.WallCheck, function(e) Cfg.WallCheck = e end)
ToggleWithValue(TabContent[2], "AimFOV", false, Cfg.AimFOV, function(_, v) Cfg.AimFOV = v end)
ToggleWithValue(TabContent[2], "Smooth", false, Cfg.AimSmooth, function(_, v) Cfg.AimSmooth = v end)
Section(TabContent[2], "Sec_Defense")
Toggle(TabContent[2], "AntiFling", Cfg.AntiFling, function(e) Cfg.AntiFling = e; ApplyAntiFling() end)
Section(TabContent[3], "Sec_Trail")
Toggle(TabContent[3], "Trail", Cfg.Trail, function(e) Cfg.Trail = e; ApplyTrail(); if e and Cfg.TrailRainbow then ApplyTrailRainbow() end end)
CycleButton(TabContent[3], "TrailType", {"Standard", "Lightning", "Fire"}, Cfg.TrailType, function(v) Cfg.TrailType = v; ApplyTrail() end)
Toggle(TabContent[3], "TrailRainbow", Cfg.TrailRainbow, function(e) Cfg.TrailRainbow = e; ApplyTrailRainbow() end)
Toggle(TabContent[3], "Glow", Cfg.TrailGlow, function(e) Cfg.TrailGlow = e; ApplyTrail() end)
Section(TabContent[3], "Sec_Colors")
local colorRow = Instance.new("Frame"); colorRow.Size = UDim2.new(1, -4, 0, 36); colorRow.BackgroundColor3 = cd; colorRow.BorderSizePixel = 0; colorRow.Parent = TabContent[3]; local colorRowC = Instance.new("UICorner"); colorRowC.CornerRadius = UDim.new(0, 8); colorRowC.Parent = colorRow
local trailColors = {Color3.fromRGB(255, 45, 65), Color3.fromRGB(45, 120, 255), Color3.fromRGB(45, 200, 80), Color3.fromRGB(200, 45, 255), Color3.fromRGB(255, 220, 45), Color3.fromRGB(255, 255, 255)}
for i, col in ipairs(trailColors) do local cb = Instance.new("TextButton"); cb.Size = UDim2.new(0, 38, 0, 24); cb.Position = UDim2.new(0, 8 + (i - 1) * 42, 0, 6); cb.BackgroundColor3 = col; cb.BorderSizePixel = 0; cb.Text = ""; cb.Parent = colorRow; local cbc = Instance.new("UICorner"); cbc.CornerRadius = UDim.new(0, 6); cbc.Parent = cb; cb.MouseButton1Click:Connect(function() trailCol = col; Cfg.TrailRainbow = false; UpdateTrailColor(); ApplyParticles(); ApplySelfOutline(); if Cfg.Fire then ApplyFire() end; if Cfg.Snow then ApplySnow() end; if Cfg.Confetti then ApplyConfetti() end; if Cfg.Hearts then ApplyHearts() end; if Cfg.Bubbles then ApplyBubbles() end; if Cfg.Stars then ApplyStars() end; if Cfg.BlackHole then ApplyBlackHole() end; if Cfg.EnergySword then ApplyEnergySword() end; if Cfg.Fireflies then ApplyFireflies() end; task.spawn(SaveConfig) end) end
Section(TabContent[3], "Sec_Screen")
ToggleWithValue(TabContent[3], "FOV", false, Cfg.FOV, function(_, v) Cfg.FOV = v; workspace.CurrentCamera.FieldOfView = v end)
Toggle(TabContent[3], "Crosshair", Cfg.Crosshair, function(e) Cfg.Crosshair = e; ApplyCrosshair() end)
Section(TabContent[3], "Sec_Effects")
Toggle(TabContent[3], "Particles", Cfg.Particles, function(e) Cfg.Particles = e; ApplyParticles() end)
Toggle(TabContent[3], "Orbit", Cfg.Orbit, function(e) Cfg.Orbit = e; ApplyOrbit() end)
Toggle(TabContent[3], "SelfOutline", Cfg.SelfOutline, function(e) Cfg.SelfOutline = e; ApplySelfOutline() end)
Section(TabContent[4], "Sec_Fancy")
Toggle(TabContent[4], "Ring", Cfg.Ring, function(e) Cfg.Ring = e; ApplyRing() end)
Toggle(TabContent[4], "Halo", Cfg.Halo, function(e) Cfg.Halo = e; ApplyHalo() end)
Toggle(TabContent[4], "Wings", Cfg.Wings, function(e) Cfg.Wings = e; ApplyWings() end)
Toggle(TabContent[4], "AuraSphere", Cfg.AuraSphere, function(e) Cfg.AuraSphere = e; ApplyAuraSphere() end)
Toggle(TabContent[4], "Lightning", Cfg.Lightning, function(e) Cfg.Lightning = e; ApplyLightning() end)
Toggle(TabContent[4], "Fire", Cfg.Fire, function(e) Cfg.Fire = e; ApplyFire() end)
Section(TabContent[4], "Sec_NewFX")
Toggle(TabContent[4], "Snow", Cfg.Snow, function(e) Cfg.Snow = e; ApplySnow() end)
Toggle(TabContent[4], "Confetti", Cfg.Confetti, function(e) Cfg.Confetti = e; ApplyConfetti() end)
Toggle(TabContent[4], "Hearts", Cfg.Hearts, function(e) Cfg.Hearts = e; ApplyHearts() end)
Toggle(TabContent[4], "Bubbles", Cfg.Bubbles, function(e) Cfg.Bubbles = e; ApplyBubbles() end)
Toggle(TabContent[4], "Stars", Cfg.Stars, function(e) Cfg.Stars = e; ApplyStars() end)
Section(TabContent[4], "NEW VISUALS")
Toggle(TabContent[4], "BlackHole", Cfg.BlackHole, function(e) Cfg.BlackHole = e; ApplyBlackHole() end)
Toggle(TabContent[4], "EnergySword", Cfg.EnergySword, function(e) Cfg.EnergySword = e; ApplyEnergySword() end)
Toggle(TabContent[4], "Fireflies", Cfg.Fireflies, function(e) Cfg.Fireflies = e; ApplyFireflies() end)
Toggle(TabContent[4], "TargetAura", Cfg.TargetAura, function(e) Cfg.TargetAura = e; ApplyTargetAura() end)

Section(TabContent[5], "Sec_Stats")
Toggle(TabContent[5], "ShowStats", Cfg.ShowStats, function(e) Cfg.ShowStats = e; StatsGui.Visible = e end)
Section(TabContent[5], "Sec_Config")
Button(TabContent[5], "SaveConfig", function() task.spawn(SaveConfig) end)
Button(TabContent[5], "LoadConfig", function() LoadConfig() Notify("Config Loaded! (Restart UI to apply)", Color3.fromRGB(50, 200, 80)) end)
Section(TabContent[5], "Sec_GuiImg")
local imgRow = Instance.new("Frame"); imgRow.Size = UDim2.new(1, -4, 0, 36); imgRow.BackgroundColor3 = cd; imgRow.BorderSizePixel = 0; imgRow.Parent = TabContent[5]; local imgRowC = Instance.new("UICorner"); imgRowC.CornerRadius = UDim.new(0, 8); imgRowC.Parent = imgRow
local imgInput = Instance.new("TextBox"); imgInput.Size = UDim2.new(1, -20, 1, -8); imgInput.Position = UDim2.new(0, 10, 0, 4); imgInput.BackgroundColor3 = ip; imgInput.BorderSizePixel = 0; imgInput.Text = Cfg.CustomImgID; imgInput.TextColor3 = rlt; imgInput.Font = Enum.Font.GothamBold; imgInput.TextSize = 12; imgInput.ClearTextOnFocus = false; imgInput.PlaceholderText = T("ImgPlaceholder"); imgInput.Parent = imgRow; local imgInputC = Instance.new("UICorner"); imgInputC.CornerRadius = UDim.new(0, 5); imgInputC.Parent = imgInput
imgInput.FocusLost:Connect(function() local val = tostring(imgInput.Text); Cfg.CustomImgID = val; BtnImg.Image = "rbxassetid://" .. val; task.spawn(SaveConfig) end)
Section(TabContent[5], "Sec_GuiQuick")
Toggle(TabContent[5], "QuickPanel", Cfg.QuickPanel, function(e) Cfg.QuickPanel = e; FloatContainer.Visible = e and FloatContainer.Visible or false end)
Section(TabContent[5], "Sec_GuiColor")
local accentRow = Instance.new("Frame"); accentRow.Size = UDim2.new(1, -4, 0, 42); accentRow.BackgroundColor3 = cd; accentRow.BorderSizePixel = 0; accentRow.Parent = TabContent[5]; local accentRowC = Instance.new("UICorner"); accentRowC.CornerRadius = UDim.new(0, 8); accentRowC.Parent = accentRow
local accentPreset = {{Name = "Red", Color = Accents.Red.Main}, {Name = "Blue", Color = Accents.Blue.Main}, {Name = "Green", Color = Accents.Green.Main}, {Name = "Purple", Color = Accents.Purple.Main}, {Name = "Orange", Color = Accents.Orange.Main}, {Name = "Cyan", Color = Accents.Cyan.Main}}
for i, a in ipairs(accentPreset) do local cb = Instance.new("TextButton"); cb.Size = UDim2.new(0, 38, 0, 26); cb.Position = UDim2.new(0, 8 + (i - 1) * 42, 0, 8); cb.BackgroundColor3 = a.Color; cb.BorderSizePixel = 0; cb.Text = ""; cb.Parent = accentRow; local cbc = Instance.new("UICorner"); cbc.CornerRadius = UDim.new(0, 6); cbc.Parent = cb; cb.MouseButton1Click:Connect(function() Cfg.Accent = a.Name; local ac = Accents[a.Name]; for _, ref in ipairs(AccentRefs) do if ref.Obj and ref.Obj.Parent then if ref.Kind == "main" then ref.Obj[ref.Prop] = ac.Main elseif ref.Kind == "dark" then ref.Obj[ref.Prop] = ac.Dark elseif ref.Kind == "state" then ref.Obj[ref.Prop] = ref.State and ac.Main or mu end end end; MFS.Color = ac.Main; SBS.Color = ac.Main; Underline.BackgroundColor3 = ac.Main; TitleBar.BackgroundColor3 = ac.Dark; TBCover.BackgroundColor3 = ac.Dark; TBGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ac.Main), ColorSequenceKeypoint.new(0.5, ac.Dark), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 10, 20))}; for _, qb in ipairs({QuickFly, QuickSpeed, QuickESP, QuickAim}) do local qbs = qb:FindFirstChildOfClass("UIStroke"); if qbs then qbs.Color = ac.Main end; if qb.BackgroundColor3 == rd or qb.BackgroundColor3 == ac.Main then qb.BackgroundColor3 = ac.Main end end; task.spawn(SaveConfig) end) end
Section(TabContent[5], "Sec_GuiSize")
local sizeRow = Instance.new("Frame"); sizeRow.Size = UDim2.new(1, -4, 0, 36); sizeRow.BackgroundColor3 = cd; sizeRow.BorderSizePixel = 0; sizeRow.Parent = TabContent[5]; local sizeRowC = Instance.new("UICorner"); sizeRowC.CornerRadius = UDim.new(0, 8); sizeRowC.Parent = sizeRow
local sizes = {{Name = "S", Scale = 0.8}, {Name = "M", Scale = 1.0}, {Name = "L", Scale = 1.2}}
for i, s in ipairs(sizes) do local cb = Instance.new("TextButton"); cb.Size = UDim2.new(0, 60, 0, 26); cb.Position = UDim2.new(0, 8 + (i - 1) * 65, 0, 5); cb.BackgroundColor3 = Cfg.GuiScale == s.Scale and rdk or mu; cb.BorderSizePixel = 0; cb.Text = s.Name; cb.TextColor3 = Color3.fromRGB(255, 255, 255); cb.Font = Enum.Font.GothamBold; cb.TextSize = 11; cb.Parent = sizeRow; local cbc = Instance.new("UICorner"); cbc.CornerRadius = UDim.new(0, 5); cbc.Parent = cb; cb.MouseButton1Click:Connect(function() Cfg.GuiScale = s.Scale; ApplyGuiScale(); for j, btn in ipairs(sizeRow:GetChildren()) do if btn:IsA("TextButton") then btn.BackgroundColor3 = btn == cb and rdk or mu end end; task.spawn(SaveConfig) end) end
Section(TabContent[5], "Sec_GuiLang")
local langRow = Instance.new("Frame"); langRow.Size = UDim2.new(1, -4, 0, 36); langRow.BackgroundColor3 = cd; langRow.BorderSizePixel = 0; langRow.Parent = TabContent[5]; local langRowC = Instance.new("UICorner"); langRowC.CornerRadius = UDim.new(0, 8); langRowC.Parent = langRow
local langsList = {{Code = "EN", Label = "English"}, {Code = "RU", Label = "Русский"}}
for i, l in ipairs(langsList) do local cb = Instance.new("TextButton"); cb.Size = UDim2.new(0, 85, 0, 26); cb.Position = UDim2.new(0, 8 + (i - 1) * 90, 0, 5); cb.BackgroundColor3 = l.Code == Cfg.Lang and rdk or mu; cb.BorderSizePixel = 0; cb.Text = l.Label; cb.TextColor3 = Color3.fromRGB(255, 255, 255); cb.Font = Enum.Font.GothamBold; cb.TextSize = 10; cb.Parent = langRow; local cbc = Instance.new("UICorner"); cbc.CornerRadius = UDim.new(0, 5); cbc.Parent = cb; cb.MouseButton1Click:Connect(function() Cfg.Lang = l.Code; for key, el in pairs(i18nRefs) do if el and el.Parent then el.Text = T(key) end end; for j, b in ipairs(langRow:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = b == cb and rdk or mu end end; task.spawn(SaveConfig) end) end
Section(TabContent[5], "Sec_Actions")
Button(TabContent[5], "BringAll", function() BringAll() end)
Button(TabContent[5], "Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end)
Button(TabContent[5], "Reset", function() local _, h = GetChar(); if h then h.Health = 0 end end)
Section(TabContent[5], "Sec_Gravity")
ToggleWithValue(TabContent[5], "Gravity", false, Cfg.Gravity, function(_, v) Cfg.Gravity = v; ApplyGravity() end)
Section(TabContent[5], "Sec_Info")
Button(TabContent[5], "CopyJob", function() pcall(function() setclipboard(game.JobId) end) Notify("JobId Copied!", Color3.fromRGB(50, 200, 80)) end)
Button(TabContent[5], "ServerInfo", function() Notify(string.format("Place: %d | Players: %d\nJobId: %s", game.PlaceId, #Players:GetPlayers(), game.JobId), Color3.fromRGB(50, 100, 200)) end)
Section(TabContent[5], "Sec_Visual")
Toggle(TabContent[5], "Rainbow", Cfg.Rainbow, function(e) Cfg.Rainbow = e; ApplyRainbow() end)
Toggle(TabContent[5], "Aura", Cfg.Aura, function(e) Cfg.Aura = e; ApplyAura() end)
Toggle(TabContent[5], "Invisible", Cfg.Invisible, function(e) Cfg.Invisible = e; ApplyInvisible(e) end)

local PlayerList = Instance.new("ScrollingFrame"); PlayerList.Size = UDim2.new(1, -4, 0, 180); PlayerList.BackgroundColor3 = Color3.fromRGB(8, 8, 12); PlayerList.BorderSizePixel = 0; PlayerList.ScrollBarThickness = 3; PlayerList.ScrollBarImageColor3 = rd; PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0); PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y; PlayerList.Parent = TabContent[5]
local PLC = Instance.new("UICorner"); PLC.CornerRadius = UDim.new(0, 8); PLC.Parent = PlayerList
local PLL = Instance.new("UIListLayout"); PLL.Padding = UDim.new(0, 3); PLL.SortOrder = Enum.SortOrder.LayoutOrder; PLL.Parent = PlayerList
local PLP = Instance.new("UIPadding"); PLP.PaddingTop = UDim.new(0, 4); PLP.PaddingLeft = UDim.new(0, 4); PLP.PaddingRight = UDim.new(0, 4); PLP.Parent = PlayerList
local function UpdatePlayerList() for _, ch in ipairs(PlayerList:GetChildren()) do if ch:IsA("Frame") then ch:Destroy() end end; for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer then local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 44); row.BackgroundColor3 = cd; row.BorderSizePixel = 0; row.Parent = PlayerList; local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 7); rc.Parent = row; local nameLbl = Instance.new("TextLabel"); nameLbl.Size = UDim2.new(1, -6, 0, 18); nameLbl.Position = UDim2.new(0, 6, 0, 2); nameLbl.BackgroundTransparency = 1; nameLbl.Text = plr.Name; nameLbl.TextColor3 = tx; nameLbl.Font = Enum.Font.GothamBold; nameLbl.TextSize = 11; nameLbl.TextXAlignment = Enum.TextXAlignment.Left; nameLbl.TextTruncate = Enum.TextTruncate.AtEnd; nameLbl.Parent = row; local tpBtn = Instance.new("TextButton"); tpBtn.Size = UDim2.new(0, 60, 0, 20); tpBtn.Position = UDim2.new(0, 4, 0, 21); tpBtn.BackgroundColor3 = rdk; tpBtn.BorderSizePixel = 0; tpBtn.Text = T("TP"); tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 10; tpBtn.Parent = row; local tpC = Instance.new("UICorner"); tpC.CornerRadius = UDim.new(0, 5); tpC.Parent = tpBtn; local fl = Instance.new("TextButton"); fl.Size = UDim2.new(0, 60, 0, 20); fl.Position = UDim2.new(0, 68, 0, 21); fl.BackgroundColor3 = rd; fl.BorderSizePixel = 0; fl.Text = T("Fling"); fl.TextColor3 = Color3.fromRGB(255, 255, 255); fl.Font = Enum.Font.GothamBold; fl.TextSize = 10; fl.Parent = row; local flC = Instance.new("UICorner"); flC.CornerRadius = UDim.new(0, 5); flC.Parent = fl; tpBtn.MouseButton1Click:Connect(function() local c = LocalPlayer.Character; local tc = plr.Character; if c and tc then local h = c:FindFirstChild("HumanoidRootPart"); local th = tc:FindFirstChild("HumanoidRootPart"); if h and th then h.CFrame = th.CFrame + Vector3.new(0, 3, 0) end end end); fl.MouseButton1Click:Connect(function() FL(plr, fl) end) end end end
Players.PlayerAdded:Connect(UpdatePlayerList); Players.PlayerRemoving:Connect(function(p) if EspData[p] then local d = EspData[p]; if d.Highlight then d.Highlight:Destroy() end; if d.Billboard then d.Billboard:Destroy() end; EspData[p] = nil end; if BoxData[p] and BoxData[p].Parent then BoxData[p]:Destroy(); BoxData[p] = nil end; if TracerLines.Lines and TracerLines.Lines[p] then TracerLines.Lines[p]:Destroy(); TracerLines.Lines[p] = nil end; if HitboxViewData[p] then local h = HitboxViewData[p]; if h.Box then h.Box:Destroy() end; if h.Label then h.Label:Destroy() end; HitboxViewData[p] = nil end; UpdatePlayerList() end); UpdatePlayerList()

LocalPlayer.CharacterAdded:Connect(function() task.wait(0.3); if Cfg.Fly then StartFly() end; if Cfg.Speed then ApplySpeed() end; if Cfg.Jump then ApplyJump() end; if Cfg.Noclip then ApplyNoclip() end; if Cfg.AntiFling then ApplyAntiFling() end; if Cfg.Aimbot then ApplyAimbot() end; if Cfg.InfJump then ApplyInfJump() end; if Cfg.BHop then ApplyBHop() end; if Cfg.AntiVoid then ApplyAntiVoid() end; if Cfg.Trail then ApplyTrail() end; if Cfg.TrailRainbow then ApplyTrailRainbow() end; if Cfg.Particles then ApplyParticles() end; if Cfg.Orbit then ApplyOrbit() end; if Cfg.SelfOutline then ApplySelfOutline() end; if Cfg.Ring then ApplyRing() end; if Cfg.Halo then ApplyHalo() end; if Cfg.Wings then ApplyWings() end; if Cfg.AuraSphere then ApplyAuraSphere() end; if Cfg.Lightning then ApplyLightning() end; if Cfg.Fire then ApplyFire() end; if Cfg.Snow then ApplySnow() end; if Cfg.Confetti then ApplyConfetti() end; if Cfg.Hearts then ApplyHearts() end; if Cfg.Bubbles then ApplyBubbles() end; if Cfg.Stars then ApplyStars() end; if Cfg.BlackHole then ApplyBlackHole() end; if Cfg.EnergySword then ApplyEnergySword() end; if Cfg.Fireflies then ApplyFireflies() end; if Cfg.TargetAura then ApplyTargetAura() end end)

local function OpenMenu() MainFrame.Visible = true; FloatContainer.Visible = false end
local function CloseMenu() task.spawn(SaveConfig); MainFrame.Visible = false; FloatContainer.Visible = true end
HideBtn.MouseButton1Click:Connect(CloseMenu)
ShowBtn.MouseButton1Click:Connect(function() if not ShowBtn.Visible then return end; OpenMenu() end)
OpenMenu()
print("[Raze Hub] Loaded Successfully!")
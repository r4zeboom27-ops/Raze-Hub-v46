-- ==================== СЕРВИСЫ ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StatsService = game:GetService("Stats")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local CfgFile = "RazeHub_Config.json"

-- ==================== КОНФИГ ====================
local Cfg = {
    Fly=false, FlySpeed=80, Speed=false, SpeedValue=50, Jump=false, JumpValue=100,
    Noclip=false, InfJump=false, BHop=false, AntiVoid=false, Gravity=196,
    ESP=false, BoxESP=false, Tracer=false, Hitbox=false, HitboxMult=2, HitboxView=false,
    Aimbot=false, Silent=false, AimPart="Head", AimFOV=200, AimSmooth=4, WallCheck=true,
    AntiFling=false, Fullbright=false, FOV=70, Crosshair=false,
    Rainbow=false, Aura=false, Invisible=false,
    Trail=false, TrailType="Standard", TrailRainbow=false, TrailGlow=false,
    Particles=false, Orbit=false, SelfOutline=false, Ring=false, Halo=false, Wings=false,
    AuraSphere=false, Lightning=false, Fire=false, Snow=false, Confetti=false, Hearts=false,
    Bubbles=false, Stars=false, Starfall=false, AntiAFK=false, ShowStats=true,
    BlackHole=false, EnergySword=false, Fireflies=false, TargetAura=false,
    Accent="Red", Lang="UA", GuiScale=1, CustomImgID="155197737", QuickPanel=true,
}

local function SaveCfg() pcall(function() if writefile then writefile(CfgFile, HttpService:JSONEncode(Cfg)) end end) end
local function LoadCfg() pcall(function() if readfile and isfile and isfile(CfgFile) then local d=HttpService:JSONDecode(readfile(CfgFile)); for k,v in pairs(d) do if Cfg[k]~=nil then Cfg[k]=v end end end end) end
LoadCfg()
Cfg.ShowStats = true -- принудительно

-- ==================== ЛОКАЛИЗАЦИЯ ====================
local Langs = {
    EN = { Tab_Main="Main", Tab_Combat="Combat", Tab_Visual="Visual", Tab_FX="FX", Tab_Settings="Settings", Sec_Move="MOVEMENT", Sec_Util="UTILITY", Sec_Combat="COMBAT", Sec_Aim="AIM", Sec_Defense="DEFENSE", Sec_Trail="TRAIL", Sec_Colors="COLORS", Sec_Screen="SCREEN", Sec_Effects="EFFECTS", Sec_Fancy="FANCY EFFECTS", Sec_NewFX="NEW FX", Sec_Actions="ACTIONS", Sec_Gravity="GRAVITY", Sec_Info="INFO", Sec_Visual="VISUAL", Sec_GuiColor="ACCENT COLOR", Sec_GuiSize="GUI SIZE", Sec_GuiLang="LANGUAGE", Sec_GuiImg="CUSTOM IMAGE", Sec_GuiQuick="QUICK PANEL", Sec_Config="CONFIG", Sec_Stats="STATS", Fly="Fly", Speed="Speed", Jump="Jump", InfJump="Inf Jump", BHop="Bunny Hop", Noclip="Noclip", AntiVoid="Anti-Void", Fullbright="Fullbright", AntiAFK="Anti-AFK", ESP="ESP", BoxESP="2D Box", Tracer="Tracer", Hitbox="Hitbox", HitboxView="HB View", Aimbot="Aimbot", Silent="Silent", AimFOV="FOV", Smooth="Smooth", WallCheck="Wall Check", AntiFling="AntiFling", Trail="Trail", TrailType="Trail Type", TrailRainbow="Rainbow", Glow="Glow", FOV="FOV", Crosshair="Crosshair", Particles="Particles", Orbit="Orbit", SelfOutline="Outline", Ring="Ring", Halo="Halo", Wings="Wings", AuraSphere="Aura", Lightning="Lightning", Fire="Fire", Snow="Snow", Confetti="Confetti", Hearts="Hearts", Bubbles="Bubbles", Stars="Stars", Starfall="Starfall", BlackHole="Black Hole", EnergySword="E.Sword", Fireflies="Fireflies", TargetAura="Target Aura", BringAll="Bring All", Rejoin="Rejoin", Reset="Reset", Gravity="Gravity", CopyJob="Copy JobId", ServerInfo="Server Info", Rainbow="Rainbow", Aura="Aura", Invisible="Invisible", TP="TP", Fling="Fling", ImgPH="Enter ID...", SaveConfig="Save", LoadConfig="Load", ShowStats="Show FPS & Ping" },
    UA = { Tab_Main="Головне", Tab_Combat="Бій", Tab_Visual="Вигляд", Tab_FX="Ефекти", Tab_Settings="Налашт.", Sec_Move="РУХ", Sec_Util="УТИЛІТИ", Sec_Combat="БІЙ", Sec_Aim="ПРИЦІЛ", Sec_Defense="ЗАХИСТ", Sec_Trail="СЛІД", Sec_Colors="КОЛЬОРИ", Sec_Screen="ЕКРАН", Sec_Effects="ЕФЕКТИ", Sec_Fancy="КРАСИВІ", Sec_NewFX="НОВІ", Sec_Actions="ДІЇ", Sec_Gravity="ГРАВІТАЦІЯ", Sec_Info="ІНФО", Sec_Visual="ВІЗУАЛ", Sec_GuiColor="КОЛІР", Sec_GuiSize="РОЗМІР", Sec_GuiLang="МОВА", Sec_GuiImg="ID КАРТИНКИ", Sec_GuiQuick="ПАНЕЛЬ", Sec_Config="КОНФІГ", Sec_Stats="СТАТИСТИКА", Fly="Політ", Speed="Швидкість", Jump="Стрибок", InfJump="Беск. стрибок", BHop="Банні-хоп", Noclip="Крізь стіни", AntiVoid="Анти-провалля", Fullbright="Яскраве світло", AntiAFK="Анти-AFK", ESP="ESP", BoxESP="2D Бокс", Tracer="Трасування", Hitbox="Хітбокс", HitboxView="Показати ХБ", Aimbot="Аімбот", Silent="Тихий", AimFOV="Радіус", Smooth="Плавність", WallCheck="Бачити", AntiFling="Анти-флінг", Trail="Слід", TrailType="Стиль", TrailRainbow="Веселка", Glow="Світіння", FOV="Огляд", Crosshair="Приціл", Particles="Частинки", Orbit="Орбіта", SelfOutline="Обведення", Ring="Кільце", Halo="Ореол", Wings="Крила", AuraSphere="Аура", Lightning="Блискавки", Fire="Вогонь", Snow="Сніг", Confetti="Конфеті", Hearts="Сердечка", Bubbles="Бульбашки", Stars="Зірки", Starfall="Зорепад", BlackHole="Діра", EnergySword="Е.Меч", Fireflies="Світлячки", TargetAura="Аура ворогів", BringAll="Притягнути всіх", Rejoin="Перезайти", Reset="Респавн", Gravity="Гравітація", CopyJob="Коп. JobId", ServerInfo="Інфо", Rainbow="Веселка", Aura="Аура", Invisible="Невидимий", TP="ТП", Fling="Флінг", ImgPH="Введіть ID...", SaveConfig="Зберегти", LoadConfig="Завантажити", ShowStats="Показати FPS і Ping" },
    RU = { Tab_Main="Главное", Tab_Combat="Бой", Tab_Visual="Визуал", Tab_FX="Эффекты", Tab_Settings="Настройки", Sec_Move="ДВИЖЕНИЕ", Sec_Util="УТИЛИТЫ", Sec_Combat="БОЙ", Sec_Aim="ПРИЦЕЛ", Sec_Defense="ЗАЩИТА", Sec_Trail="СЛЕД", Sec_Colors="ЦВЕТА", Sec_Screen="ЭКРАН", Sec_Effects="ЭФФЕКТЫ", Sec_Fancy="КРАСИВЫЕ", Sec_NewFX="НОВЫЕ", Sec_Actions="ДЕЙСТВИЯ", Sec_Gravity="ГРАВИТАЦИЯ", Sec_Info="ИНФО", Sec_Visual="ВИЗУАЛ", Sec_GuiColor="ЦВЕТ", Sec_GuiSize="РАЗМЕР", Sec_GuiLang="ЯЗЫК", Sec_GuiImg="ID КАРТИНКИ", Sec_GuiQuick="ПАНЕЛЬ", Sec_Config="КОНФИГ", Sec_Stats="СТАТИСТИКА", Fly="Полёт", Speed="Скорость", Jump="Прыжок", InfJump="Беск. прыжок", BHop="Банни-хоп", Noclip="Сквозь стены", AntiVoid="Анти-пропасть", Fullbright="Яркий свет", AntiAFK="Анти-AFK", ESP="ESP", BoxESP="2D Бокс", Tracer="Трассировка", Hitbox="Хитбокс", HitboxView="Показать ХБ", Aimbot="Аимбот", Silent="Тихий", AimFOV="Радиус", Smooth="Плавность", WallCheck="Видеть", AntiFling="Анти-флинг", Trail="След", TrailType="Стиль", TrailRainbow="Радуга", Glow="Свечение", FOV="Обзор", Crosshair="Прицел", Particles="Частицы", Orbit="Орбита", SelfOutline="Обводка", Ring="Кольцо", Halo="Ореол", Wings="Крылья", AuraSphere="Аура", Lightning="Молнии", Fire="Огонь", Snow="Снег", Confetti="Конфетти", Hearts="Сердечки", Bubbles="Пузыри", Stars="Звёзды", Starfall="Звездопад", BlackHole="Дыра", EnergySword="Э.Меч", Fireflies="Светлячки", TargetAura="Аура врагов", BringAll="Притянуть всех", Rejoin="Перезайти", Reset="Респавн", Gravity="Гравитация", CopyJob="Коп. JobId", ServerInfo="Инфо", Rainbow="Радуга", Aura="Аура", Invisible="Невидимый", TP="ТП", Fling="Флинг", ImgPH="Введите ID...", SaveConfig="Сохранить", LoadConfig="Загрузить", ShowStats="Показать FPS и Ping" }
}
local function T(k) return Langs[Cfg.Lang][k] or Langs.EN[k] or k end

-- ==================== ЦВЕТА ====================
local Accents = {
    Red={Main=Color3.fromRGB(255,45,65),Dark=Color3.fromRGB(140,15,30),Light=Color3.fromRGB(255,105,125)},
    Blue={Main=Color3.fromRGB(45,130,255),Dark=Color3.fromRGB(20,60,140),Light=Color3.fromRGB(120,180,255)},
    Green={Main=Color3.fromRGB(45,210,90),Dark=Color3.fromRGB(20,100,45),Light=Color3.fromRGB(120,240,160)},
    Purple={Main=Color3.fromRGB(190,60,255),Dark=Color3.fromRGB(90,20,140),Light=Color3.fromRGB(220,140,255)},
    Orange={Main=Color3.fromRGB(255,140,45),Dark=Color3.fromRGB(140,70,20),Light=Color3.fromRGB(255,190,120)},
    Cyan={Main=Color3.fromRGB(45,230,230),Dark=Color3.fromRGB(20,120,120),Light=Color3.fromRGB(140,255,255)},
}
local ac = Accents[Cfg.Accent] or Accents.Red
local rd, rdk, rlt = ac.Main, ac.Dark, ac.Light
local bg1, bg2 = Color3.fromRGB(18,18,24), Color3.fromRGB(10,10,14)
local cd, cdH = Color3.fromRGB(28,28,38), Color3.fromRGB(40,40,55)
local mu, ip = Color3.fromRGB(45,45,60), Color3.fromRGB(35,35,45)
local tx, td = Color3.fromRGB(240,240,245), Color3.fromRGB(160,160,175)

-- ==================== СОСТОЯНИЕ ====================
local Conn, EspData, BoxData, TracerLines, HitboxViewData = {}, {}, {}, {}, {}
local AimLock, OrigLight = nil, nil
local trailCol = Color3.fromRGB(255,45,65)
local trailHue = 0
local AccentRefs, i18nRefs, ImageRefs = {}, {}, {}

local function Disc(n) if Conn[n] then if type(Conn[n])=="table" then for _,c in ipairs(Conn[n]) do pcall(function()c:Disconnect()end) end else pcall(function()Conn[n]:Disconnect()end) end Conn[n]=nil end end
local function GC() local c=LP.Character; return c,c and c:FindFirstChild("Humanoid"),c and c:FindFirstChild("HumanoidRootPart") end
local function SD(o) if o and o.Parent then o:Destroy() end end

local function Drag(h, f)
    local drg, dIn, dS, sP
    h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drg=true; dS=i.Position; sP=f.Position; i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drg=false end end) end end)
    h.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then dIn=i end end)
    UIS.InputChanged:Connect(function(i) if i==dIn and drg then local d=i.Position-dS; f.Position=UDim2.new(sP.X.Scale,sP.X.Offset+d.X,sP.Y.Scale,sP.Y.Offset+d.Y) end end)
end

-- ==================== ДВИЖЕНИЕ ====================
local function StopFly()
    Disc("Fly")
    local _,h,r=GC()
    if r then local b=r:FindFirstChild("RFV"); if b then b:Destroy() end; local g=r:FindFirstChild("RFG"); if g then g:Destroy() end end
    if h then h.PlatformStand=false end
end
local function StartFly()
    StopFly()
    Conn.Fly = RunService.RenderStepped:Connect(function()
        if not Cfg.Fly then return end
        local _,h,r=GC(); if not h or not r then return end
        h.PlatformStand=true
        local b=r:FindFirstChild("RFV"); if not b then b=Instance.new("BodyVelocity"); b.Name="RFV"; b.MaxForce=Vector3.new(1e6,1e6,1e6); b.Parent=r end
        local g=r:FindFirstChild("RFG"); if not g then g=Instance.new("BodyGyro"); g.Name="RFG"; g.MaxTorque=Vector3.new(1e6,1e6,1e6); g.D=50; g.P=3000; g.Parent=r end
        local cam=workspace.CurrentCamera; if not cam then return end
        local f,s,v=0,0,0
        if UIS:IsKeyDown(Enum.KeyCode.W) then f=f+1 end
        if UIS:IsKeyDown(Enum.KeyCode.S) then f=f-1 end
        if UIS:IsKeyDown(Enum.KeyCode.D) then s=s+1 end
        if UIS:IsKeyDown(Enum.KeyCode.A) then s=s-1 end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then v=v+1 end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then v=v-1 end
        if f==0 and s==0 then
            local m=h.MoveDirection
            if m.Magnitude>0.1 then
                local cL=Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z); if cL.Magnitude>0.1 then cL=cL.Unit else cL=Vector3.new(0,0,-1) end
                local cR=Vector3.new(cam.CFrame.RightVector.X,0,cam.CFrame.RightVector.Z); if cR.Magnitude>0.1 then cR=cR.Unit else cR=Vector3.new(1,0,0) end
                f=m:Dot(cL); s=m:Dot(cR)
            end
        end
        local d=cam.CFrame.LookVector*f+cam.CFrame.RightVector*s+Vector3.new(0,v,0)
        if d.Magnitude>0 then d=d.Unit*Cfg.FlySpeed end
        b.Velocity=d; g.CFrame=cam.CFrame
    end)
end
local function ASpeed() Disc("Speed"); if not Cfg.Speed then local _,h=GC(); if h then h.WalkSpeed=16 end return end; Conn.Speed=RunService.Heartbeat:Connect(function() if not Cfg.Speed then return end; local _,h=GC(); if h then h.WalkSpeed=Cfg.SpeedValue end end) end
local function AJump() Disc("Jump"); if not Cfg.Jump then local _,h=GC(); if h then h.UseJumpPower=true; h.JumpPower=50 end return end; Conn.Jump=RunService.Heartbeat:Connect(function() if not Cfg.Jump then return end; local _,h=GC(); if h then h.UseJumpPower=true; h.JumpPower=Cfg.JumpValue end end) end
local function AInfJump() Disc("InfJump"); if not Cfg.InfJump then return end; Conn.InfJump=UIS.JumpRequest:Connect(function() if not Cfg.InfJump then return end; local _,h=GC(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) end
local function ABHop() Disc("BHop"); if not Cfg.BHop then return end; Conn.BHop=RunService.Heartbeat:Connect(function() if not Cfg.BHop then return end; local _,h=GC(); if h then local st=h:GetState(); if st==Enum.HumanoidStateType.Landed or st==Enum.HumanoidStateType.Running then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end) end
local function AAVoid() Disc("AntiVoid"); if not Cfg.AntiVoid then return end; Conn.AntiVoid=RunService.Heartbeat:Connect(function() if not Cfg.AntiVoid then return end; local _,_,r=GC(); if r and r.Position.Y<-50 then r.CFrame=CFrame.new(r.Position.X,50,r.Position.Z) end end) end
local function AGrav() workspace.Gravity=Cfg.Gravity end
local function ANoclip() Disc("Noclip"); local c=LP.Character; if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end; if not Cfg.Noclip then return end; local cn={}; local function step() if not Cfg.Noclip then return end; local ch=LP.Character; if not ch then return end; for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then if p.CanCollide then p.CanCollide=false end end end end; table.insert(cn,RunService.Stepped:Connect(step)); Conn.Noclip=cn end

-- ==================== ESP / COMBAT ====================
local function CreateESP(plr)
    if plr==LP then return nil end
    local ch=plr.Character; if not ch then return nil end
    local hrp=ch:FindFirstChild("HumanoidRootPart"); if not hrp then return nil end
    local hl=Instance.new("Highlight"); hl.Adornee=ch; hl.FillColor=rd; hl.OutlineColor=Color3.fromRGB(255,255,255); hl.FillTransparency=0.5; hl.OutlineTransparency=0; hl.Parent=ch
    local bb=Instance.new("BillboardGui"); bb.Name="RE"; bb.Adornee=hrp; bb.Size=UDim2.new(0,200,0,50); bb.StudsOffset=Vector3.new(0,3.5,0); bb.AlwaysOnTop=true; bb.Parent=ch
    local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,0,0,15); nl.BackgroundTransparency=1; nl.Text=plr.Name; nl.TextColor3=Color3.fromRGB(255,90,110); nl.TextStrokeTransparency=0; nl.Font=Enum.Font.GothamBold; nl.TextSize=12; nl.Parent=bb
    local hb=Instance.new("Frame"); hb.Size=UDim2.new(0.75,0,0,6); hb.Position=UDim2.new(0.125,0,0,17); hb.BackgroundColor3=Color3.fromRGB(20,20,25); hb.BorderSizePixel=0; hb.Parent=bb
    local hc=Instance.new("UICorner"); hc.CornerRadius=UDim.new(0,3); hc.Parent=hb
    local hf=Instance.new("Frame"); hf.Size=UDim2.new(1,0,1,0); hf.BackgroundColor3=Color3.fromRGB(50,220,80); hf.BorderSizePixel=0; hf.Parent=hb
    local hfc=Instance.new("UICorner"); hfc.CornerRadius=UDim.new(0,3); hfc.Parent=hf
    local il=Instance.new("TextLabel"); il.Size=UDim2.new(1,0,0,13); il.Position=UDim2.new(0,0,0,25); il.BackgroundTransparency=1; il.Text="100/100 | 0m"; il.TextColor3=Color3.fromRGB(255,255,255); il.TextStrokeTransparency=0; il.Font=Enum.Font.GothamBold; il.TextSize=10; il.Parent=bb
    return {H=hl,B=bb,Hp=hf,I=il}
end
local function UpdateESP(plr,d)
    if not d or not d.B or not d.B.Parent then return end
    local ch=plr.Character; if not ch then return end
    local hrp=ch:FindFirstChild("HumanoidRootPart"); local h=ch:FindFirstChildOfClass("Humanoid")
    if not hrp or not h then return end
    local hp=math.max(h.Health,0); local mx=math.max(h.MaxHealth,1); local r=math.clamp(hp/mx,0,1)
    d.Hp.Size=UDim2.new(r,0,1,0)
    if r>0.6 then d.Hp.BackgroundColor3=Color3.fromRGB(50,220,80) elseif r>0.3 then d.Hp.BackgroundColor3=Color3.fromRGB(255,200,50) else d.Hp.BackgroundColor3=Color3.fromRGB(255,60,60) end
    local mh=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart"); local ds=mh and math.floor((hrp.Position-mh.Position).Magnitude) or 0
    d.I.Text=string.format("%d/%d | %dm",math.floor(hp),math.floor(mx),ds)
end
local function AESP()
    Disc("ESP"); for _,d in pairs(EspData) do if d.H then d.H:Destroy() end; if d.B then d.B:Destroy() end end; EspData={}
    if not Cfg.ESP then return end
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP then EspData[p]=CreateESP(p) end end
    local tk=0
    Conn.ESP=RunService.Heartbeat:Connect(function()
        if not Cfg.ESP then return end; tk=tk+1
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP then local d=EspData[p]; if not d then d=CreateESP(p); if d then EspData[p]=d end end; if d then UpdateESP(p,d) end end end
        if tk%30==0 then for p,d in pairs(EspData) do if not p.Parent or not d.B or not d.B.Parent then if d.H then d.H:Destroy() end; if d.B then d.B:Destroy() end; EspData[p]=nil end end end
    end)
end
local function ABoxESP()
    Disc("BoxESP"); for _,b in pairs(BoxData) do if b then b:Destroy() end end; BoxData={}
    if not Cfg.BoxESP then return end
    local g=Instance.new("ScreenGui"); g.Name="RBX"; g.ResetOnSpawn=false; g.IgnoreGuiInset=true; g.Parent=PG; BoxData.G=g
    Conn.BoxESP=RunService.RenderStepped:Connect(function()
        if not Cfg.BoxESP then return end; local cam=workspace.CurrentCamera; if not cam then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP then
                local ch=p.Character; local hrp=ch and ch:FindFirstChild("HumanoidRootPart"); local hd=ch and ch:FindFirstChild("Head")
                if hrp and hd then
                    local tp,to=cam:WorldToViewportPoint(hd.Position+Vector3.new(0,0.5,0))
                    local bp,bo=cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
                    if to and bo then
                        local h=math.abs(bp.Y-tp.Y); local w=h/2
                        if not BoxData[p] or not BoxData[p].Parent then
                            local b=Instance.new("Frame"); b.Name="B_"..p.Name; b.BackgroundTransparency=1; b.BorderSizePixel=0; b.Parent=g
                            local s=Instance.new("UIStroke"); s.Color=rd; s.Thickness=1.5; s.Parent=b
                            local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,2); c.Parent=b
                            BoxData[p]=b
                        end
                        local b=BoxData[p]
                        if b and b.Parent then b.Size=UDim2.new(0,w,0,h); b.Position=UDim2.new(0,tp.X-w/2,0,tp.Y); local s=b:FindFirstChildOfClass("UIStroke"); if s then s.Color=rd end
                        else if BoxData[p] and BoxData[p].Parent then BoxData[p]:Destroy(); BoxData[p]=nil end end
                    end
                end
            end
        end
    end)
end
local function ATracer()
    Disc("Tracer"); if TracerLines.G then TracerLines.G:Destroy() end; TracerLines={}
    if not Cfg.Tracer then return end
    TracerLines.G=Instance.new("ScreenGui"); TracerLines.G.Name="RT"; TracerLines.G.ResetOnSpawn=false; TracerLines.G.IgnoreGuiInset=true; TracerLines.G.Parent=PG; TracerLines.L={}
    Conn.Tracer=RunService.RenderStepped:Connect(function()
        if not Cfg.Tracer then return end; local cam=workspace.CurrentCamera; if not cam then return end
        local vp=cam.ViewportSize; local sp=Vector2.new(vp.X/2,vp.Y)
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local ep,os=cam:WorldToViewportPoint(hrp.Position)
                    if os and ep.Z>0 then
                        local l=TracerLines.L[p]
                        if not l or not l.Parent then l=Instance.new("Frame"); l.BackgroundColor3=rd; l.BorderSizePixel=0; l.AnchorPoint=Vector2.new(0.5,0.5); l.Parent=TracerLines.G; TracerLines.L[p]=l end
                        local d=Vector2.new(ep.X,ep.Y)-sp; local m=(sp+Vector2.new(ep.X,ep.Y))/2; local ds=d.Magnitude
                        l.Size=UDim2.new(0,ds,0,2); l.Position=UDim2.new(0,m.X,0,m.Y); l.Rotation=math.deg(math.atan2(d.Y,d.X)); l.BackgroundColor3=rd
                        l.BackgroundTransparency=math.clamp(1-ds/2000,0.3,1)
                    else
                        if TracerLines.L[p] and TracerLines.L[p].Parent then TracerLines.L[p]:Destroy(); TracerLines.L[p]=nil end
                    end
                end
            end
        end
    end)
end
local function AHitbox()
    Disc("Hitbox"); for _,p in ipairs(Players:GetPlayers()) do local c=p.Character; if c then local h=c:FindFirstChild("HumanoidRootPart"); if h then local hb=h:FindFirstChild("RHB"); if hb then hb:Destroy() end end end end
    if not Cfg.Hitbox then return end
    Conn.Hitbox=RunService.Heartbeat:Connect(function()
        if not Cfg.Hitbox then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP then
                local c=p.Character; local h=c and c:FindFirstChild("HumanoidRootPart")
                if h then
                    local hb=h:FindFirstChild("RHB")
                    if not hb then hb=Instance.new("Part"); hb.Name="RHB"; hb.Transparency=1; hb.CanCollide=false; hb.CanQuery=true; hb.CanTouch=true; hb.Massless=true; hb.Size=h.Size*Cfg.HitboxMult; hb.CFrame=h.CFrame; hb.Parent=h; local w=Instance.new("WeldConstraint"); w.Part0=h; w.Part1=hb; w.Parent=hb
                    else hb.Size=h.Size*Cfg.HitboxMult end
                end
            end
        end
    end)
end
local function AHV()
    Disc("HitboxView"); for _,d in pairs(HitboxViewData) do if d.B then d.B:Destroy() end; if d.L then d.L:Destroy() end end; HitboxViewData={}
    if not Cfg.HitboxView then return end
    Conn.HitboxView=RunService.Heartbeat:Connect(function()
        if not Cfg.HitboxView then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP then
                local c=p.Character; local h=c and c:FindFirstChild("HumanoidRootPart")
                if h then
                    local hb=h:FindFirstChild("RHB") or h; local d=HitboxViewData[p]
                    if not d or not d.B or not d.B.Parent then
                        if d then if d.B then d.B:Destroy() end; if d.L then d.L:Destroy() end end
                        local b=Instance.new("BoxHandleAdornment"); b.Name="RHB"; b.Adornee=hb; b.AlwaysOnTop=true; b.ZIndex=6; b.Size=hb.Size; b.Color3=rd; b.Transparency=0.55; b.Parent=hb
                        local l=Instance.new("BillboardGui"); l.Name="RHL"; l.Adornee=hb; l.Size=UDim2.new(0,180,0,20); l.StudsOffset=Vector3.new(0,(hb.Size.Y/2)+1.2,0); l.AlwaysOnTop=true; l.Parent=hb
                        local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,0,1,0); t.BackgroundTransparency=1; t.TextColor3=rlt; t.TextStrokeTransparency=0; t.Font=Enum.Font.GothamBold; t.TextSize=11; t.Parent=l
                        HitboxViewData[p]={B=b,L=l}
                    else
                        if d.B.Adornee~=hb then d.B.Adornee=hb end; d.B.Size=hb.Size; if d.L.Adornee~=hb then d.L.Adornee=hb end
                        local t=d.L:FindFirstChildOfClass("TextLabel"); if t then local s=hb.Size; t.Text=string.format("%.1f×%.1f×%.1f",s.X,s.Y,s.Z) end
                    end
                else
                    local d=HitboxViewData[p]; if d then if d.B then d.B:Destroy() end; if d.L then d.L:Destroy() end; HitboxViewData[p]=nil end
                end
            end
        end
    end)
end

-- ==================== FLING ====================
local fN=nil
local function eN() if fN then return end; fN=RunService.Stepped:Connect(function() local c=LP.Character; if not c then return end; for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end) end
local function dN() if fN then fN:Disconnect(); fN=nil end end
local function tP(t) local r1=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart"); local r2=t.Character and t.Character:FindFirstChild("HumanoidRootPart"); if r1 and r2 then r1.CFrame=r2.CFrame; return true end; return false end
local function fO(t) local c=t.Character; if not c then return end; local r=c:FindFirstChild("HumanoidRootPart"); if not r then return end; pcall(function() r:SetNetworkOwnershipAuto(false) end); pcall(function() r:SetNetworkOwner(LP) end); local a=Instance.new("BodyAngularVelocity"); a.AngularVelocity=Vector3.new(1e5,1e5,1e5); a.MaxTorque=Vector3.new(math.huge,math.huge,math.huge); a.Parent=r; local v=Instance.new("BodyVelocity"); v.Velocity=Vector3.new(80000,80000,80000); v.MaxForce=Vector3.new(math.huge,math.huge,math.huge); v.Parent=r; task.wait(1); SD(a); SD(v) end
local function fW(t) local c=t.Character; if not c then return end; local r=c:FindFirstChild("HumanoidRootPart"); if not r then return end; local s=Instance.new("Part"); s.Size=Vector3.new(4,4,4); s.Transparency=1; s.CanCollide=false; pcall(function() s.CustomPhysicalProperties=PhysicalProperties.new(200,0.3,0.5,1,1) end); s.CFrame=r.CFrame; s.Parent=workspace; pcall(function() s:SetNetworkOwner(LP) end); local w=Instance.new("Weld"); w.Part0=s; w.Part1=r; w.Parent=s; for i=1,60 do pcall(function() s.AssemblyAngularVelocity=Vector3.new(1e5,1e5,1e5); s.AssemblyLinearVelocity=Vector3.new(0,500000,0); s.CFrame=s.CFrame*CFrame.Angles(0.5,0.5,0.5) end); task.wait(0.01) end; w:Destroy(); s:Destroy() end
local function fOv(t) local mc=LP.Character; local tc=t.Character; if not mc or not tc then return end; local r1=mc:FindFirstChild("HumanoidRootPart"); local r2=tc:FindFirstChild("HumanoidRootPart"); if not r1 or not r2 then return end; for i=1,40 do r1.CFrame=r2.CFrame*CFrame.new(math.random(-20,20)/10,0,math.random(-20,20)/10); r1.AssemblyLinearVelocity=Vector3.new(math.random(-5000,5000),5000,math.random(-5000,5000)); task.wait(0.02) end end
local FfB,FfG,Ffc=nil,nil,nil
local function fFlyStart() if FfB then return end; local c=LP.Character; if not c then return end; local r=c:FindFirstChild("HumanoidRootPart"); if not r then return end; local t=c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso") or r; FfB=Instance.new("BodyVelocity"); FfB.MaxForce=Vector3.new(1e9,1e9,1e9); FfB.Velocity=Vector3.zero; FfB.Parent=t; FfG=Instance.new("BodyGyro"); FfG.MaxTorque=Vector3.new(1e9,1e9,1e9); FfG.P=9e4; FfG.Parent=t; local h=c:FindFirstChildOfClass("Humanoid"); Ffc=RunService.RenderStepped:Connect(function() if not FfB or not FfB.Parent then return end; local ca=workspace.CurrentCamera.CFrame; local m=h and h.MoveDirection or Vector3.zero; local d=ca.LookVector*m.Z+ca.RightVector*m.X; if d.Magnitude<0.01 then d=Vector3.zero else d=d.Unit end; FfB.Velocity=d*70; FfG.CFrame=ca end) end
local function fFlyStop() if Ffc then Ffc:Disconnect(); Ffc=nil end; if FfB then FfB:Destroy(); FfB=nil end; if FfG then FfG:Destroy(); FfG=nil end end
local function FL(tg,bt) if not tg then return end; local tc=tg.Character; if not tc then return end; local tr=tc:FindFirstChild("HumanoidRootPart"); local mc=LP.Character; local mr=mc and mc:FindFirstChild("HumanoidRootPart"); if not tr or not mr then return end; if (tr.Position-mr.Position).Magnitude>100 then if bt then bt.Text="!far" end; task.wait(1.2); if bt then bt.Text=T("Fling") end; return end; if bt then bt.Text="..." end; task.spawn(function() eN(); fFlyStart(); task.wait(0.15); if not tP(tg) then dN(); fFlyStop(); if bt then bt.Text=T("Fling") end; return end; task.wait(0.1); task.spawn(function() fO(tg) end); task.spawn(function() fW(tg) end); task.spawn(function() fOv(tg) end); task.wait(1.2); dN(); fFlyStop(); if bt then bt.Text=T("Fling") end end) end

-- ==================== AIMBOT / АНТИ-ФЛИНГ ====================
local function AAF() Disc("AntiFling"); if not Cfg.AntiFling then return end; Conn.AntiFling=RunService.Heartbeat:Connect(function() if not Cfg.AntiFling then return end; local _,_,r=GC(); if r then if r.AssemblyLinearVelocity.Magnitude>250 then r.AssemblyLinearVelocity=Vector3.zero end; if r.AssemblyAngularVelocity.Magnitude>20 then r.AssemblyAngularVelocity=Vector3.zero end end end) end
local function PT() local cam=workspace.CurrentCamera; if not cam then return nil end; local ce=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2); local b,bd=nil,Cfg.AimFOV; for _,p in ipairs(Players:GetPlayers()) do if p~=LP then local c=p.Character; if c then local h=c:FindFirstChildOfClass("Humanoid"); if h and h.Health>0 then local pt=c:FindFirstChild(Cfg.AimPart) or c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart"); if pt then local ps,on=cam:WorldToViewportPoint(pt.Position); if on and ps.Z>0 then local d=(Vector2.new(ps.X,ps.Y)-ce).Magnitude; if d<bd then local vis=true; if Cfg.WallCheck then local rp=RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances={LP.Character,cam}; local ray=workspace:Raycast(cam.CFrame.Position,pt.Position-cam.CFrame.Position,rp); if ray and not ray.Instance:IsDescendantOf(c) then vis=false end end; if vis then bd=d; b=pt end end end end end end end end return b end
local function IsV(part) if not part or not part.Parent then return false end; local cam=workspace.CurrentCamera; if not cam then return false end; local ps,on=cam:WorldToViewportPoint(part.Position); if not on or ps.Z<=0 then return false end; local ce=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2); if (Vector2.new(ps.X,ps.Y)-ce).Magnitude>Cfg.AimFOV then return false end; local h=part.Parent and part.Parent:FindFirstChildOfClass("Humanoid"); if h and h.Health<=0 then return false end; if Cfg.WallCheck then local rp=RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances={LP.Character,cam}; local ray=workspace:Raycast(cam.CFrame.Position,part.Position-cam.CFrame.Position,rp); if ray and not ray.Instance:IsDescendantOf(part.Parent) then return false end end; return true end
local function AAim() Disc("Aim"); AimLock=nil; if not Cfg.Aimbot then return end; Conn.Aim=RunService.RenderStepped:Connect(function() if not Cfg.Aimbot then return end; local cam=workspace.CurrentCamera; if not cam then return end; if AimLock and not IsV(AimLock) then AimLock=nil end; if not AimLock then AimLock=PT() end; if not AimLock then return end; local tc=CFrame.new(cam.CFrame.Position,AimLock.Position); local sm=math.max(Cfg.AimSmooth,1); cam.CFrame=sm<=1 and tc or cam.CFrame:Lerp(tc,1/sm) end) end
local function ASil() Disc("Silent"); if not Cfg.Silent then return end; Conn.Silent=UIS.InputBegan:Connect(function(inp,gp) if gp then return end; if inp.UserInputType~=Enum.UserInputType.MouseButton1 then return end; if not Cfg.Silent then return end; local tg=PT(); if not tg then return end; local cam=workspace.CurrentCamera; if not cam then return end; local o=cam.CFrame; cam.CFrame=CFrame.new(cam.CFrame.Position,tg.Position); task.wait(0.015); cam.CFrame=o end) end

-- ==================== ВИЗУАЛ ====================
local function AFB() Disc("Fullbright"); if not Cfg.Fullbright then if OrigLight then pcall(function() game.Lighting.Brightness=OrigLight.B end); pcall(function() game.Lighting.ClockTime=OrigLight.C end); pcall(function() game.Lighting.FogEnd=OrigLight.F end); pcall(function() game.Lighting.Ambient=OrigLight.A end); pcall(function() game.Lighting.OutdoorAmbient=OrigLight.O end); OrigLight=nil end return end; if not OrigLight then OrigLight={B=game.Lighting.Brightness,C=game.Lighting.ClockTime,F=game.Lighting.FogEnd,A=game.Lighting.Ambient,O=game.Lighting.OutdoorAmbient} end; Conn.Fullbright=RunService.Heartbeat:Connect(function() if not Cfg.Fullbright then return end; pcall(function() game.Lighting.Brightness=2 end); pcall(function() game.Lighting.ClockTime=14 end); pcall(function() game.Lighting.FogEnd=1e5 end); pcall(function() game.Lighting.Ambient=Color3.fromRGB(180,180,180) end); pcall(function() game.Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180) end) end) end
local function ARB() Disc("Rainbow"); if not Cfg.Rainbow then return end; local h=0; Conn.Rainbow=RunService.Heartbeat:Connect(function() if not Cfg.Rainbow then return end; h=(h+0.01)%1; local col=Color3.fromHSV(h,1,1); local ch=LP.Character; if ch then for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.Color=col end end end end) end
local function AAur() Disc("Aura"); if not Cfg.Aura then return end; Conn.Aura=RunService.Heartbeat:Connect(function() if not Cfg.Aura then return end; local _,_,r=GC(); if not r then return end; local e=Instance.new("Explosion"); e.Position=r.Position+Vector3.new(math.random(-4,4),0,math.random(-4,4)); e.BlastRadius=2; e.BlastPressure=0; e.DestroyJointRadiusPercent=0; e.Parent=workspace; game:GetService("Debris"):AddItem(e,0.1) end) end
local function AInv(on) local ch=LP.Character; if not ch then return end; for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then if on then if not p:GetAttribute("OT") then p:SetAttribute("OT",p.Transparency) end; p.Transparency=1 else local o=p:GetAttribute("OT"); if o then p.Transparency=o end end end end end

local function ATrail()
    local _,_,hrp=GC()
    if hrp then local a0=hrp:FindFirstChild("RTA0"); if a0 then a0:Destroy() end; local a1=hrp:FindFirstChild("RTA1"); if a1 then a1:Destroy() end; local tr=hrp:FindFirstChild("RTrail"); if tr then tr:Destroy() end; local pt=hrp:FindFirstChild("RTP"); if pt then pt:Destroy() end end
    if not Cfg.Trail or not hrp then return end
    local a0=Instance.new("Attachment"); a0.Name="RTA0"; a0.Position=Vector3.new(0,-2,0); a0.Parent=hrp
    local a1=Instance.new("Attachment"); a1.Name="RTA1"; a1.Position=Vector3.new(0,2,0); a1.Parent=hrp
    local tr=Instance.new("Trail"); tr.Name="RTrail"; tr.Attachment0=a0; tr.Attachment1=a1; tr.Lifetime=0.6; tr.MinLength=0.1
    if Cfg.TrailType=="Lightning" then
        tr.Texture="rbxassetid://9305978346"; tr.TextureMode=Enum.TextureMode.Stretch; tr.TextureLength=5
        tr.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(0,200,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,255,255))}
        tr.LightEmission=1
        local prt=Instance.new("ParticleEmitter"); prt.Name="RTP"; prt.Texture="rbxasset://textures/particles/sparkles_main.dds"
        prt.Color=ColorSequence.new(Color3.fromRGB(100,255,255)); prt.Rate=150; prt.Lifetime=NumberRange.new(0.2,0.5)
        prt.Speed=NumberRange.new(5,15); prt.Size=NumberSequence.new(0.4,0); prt.LightEmission=1; prt.Parent=hrp
    elseif Cfg.TrailType=="Fire" then
        tr.Texture="rbxassetid://4469010593"; tr.TextureMode=Enum.TextureMode.Stretch; tr.TextureLength=4
        tr.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,50,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,200,50))}
        tr.LightEmission=1
        local prt=Instance.new("ParticleEmitter"); prt.Name="RTP"; prt.Texture="rbxasset://textures/particles/fire_main.dds"
        prt.Color=ColorSequence.new(Color3.fromRGB(255,150,0)); prt.Rate=120; prt.Lifetime=NumberRange.new(0.3,0.6)
        prt.Speed=NumberRange.new(2,6); prt.Size=NumberSequence.new(0.6,0); prt.LightEmission=1; prt.Parent=hrp
    else
        tr.Color=ColorSequence.new(trailCol); tr.LightEmission=Cfg.TrailGlow and 1 or 0
    end
    tr.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}); tr.Parent=hrp
end
local function ATRB() Disc("TRB"); if not Cfg.TrailRainbow or not Cfg.Trail then return end; Conn.TRB=RunService.Heartbeat:Connect(function() if not Cfg.TrailRainbow or not Cfg.Trail then return end; trailHue=(trailHue+0.02)%1; trailCol=Color3.fromHSV(trailHue,1,1); local _,_,hrp=GC(); if hrp then local tr=hrp:FindFirstChild("RTrail"); if tr and Cfg.TrailType=="Standard" then tr.Color=ColorSequence.new(trailCol) end end end) end
local function UTC() local _,_,hrp=GC(); if hrp then local tr=hrp:FindFirstChild("RTrail"); if tr and not Cfg.TrailRainbow and Cfg.TrailType=="Standard" then tr.Color=ColorSequence.new(trailCol) end end end

local function MArea(name,tex,col,rate,life,spd,size,acc,dir) local o=workspace:FindFirstChild(name); if o then o:Destroy() end; local p=Instance.new("Part"); p.Name=name; p.Size=Vector3.new(150,1,150); p.Transparency=1; p.CanCollide=false; p.Anchored=true; p.Parent=workspace; local e=Instance.new("ParticleEmitter"); e.Texture=tex; e.Color=ColorSequence.new(col); e.Rate=rate; e.Lifetime=NumberRange.new(life[1],life[2]); e.Speed=NumberRange.new(spd[1],spd[2]); e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,size[1]),NumberSequenceKeypoint.new(1,size[2])}); e.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}); e.Acceleration=acc; e.Shape=Enum.ParticleEmitterShape.Box; e.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume; e.EmissionDirection=dir; e.Parent=p; return p,e end
local function ASnow() local p=workspace:FindFirstChild("RSnow"); if p then p:Destroy() end; if not Cfg.Snow then return end; local pt,e=MArea("RSnow","rbxasset://textures/particles/smoke_main.dds",Color3.fromRGB(255,255,255),200,{3,5},{5,10},{0.5,0.2},Vector3.new(0,-10,0),Enum.NormalId.Bottom); Conn.Snow=RunService.Heartbeat:Connect(function() if not Cfg.Snow then return end; local c=LP.Character; if c and c:FindFirstChild("HumanoidRootPart") then pt.CFrame=CFrame.new(c.HumanoidRootPart.Position+Vector3.new(0,40,0)) end end) end
local function AConf() local p=workspace:FindFirstChild("RConf"); if p then p:Destroy() end; if not Cfg.Confetti then return end; local pt,e=MArea("RConf","rbxasset://textures/particles/sparkles_main.dds",Color3.fromRGB(255,100,100),150,{2,4},{5,10},{0.6,0.2},Vector3.new(0,-5,0),Enum.NormalId.Bottom); e.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,50,50)),ColorSequenceKeypoint.new(0.33,Color3.fromRGB(50,255,50)),ColorSequenceKeypoint.new(0.66,Color3.fromRGB(50,50,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,50))}; Conn.Conf=RunService.Heartbeat:Connect(function() if not Cfg.Confetti then return end; local c=LP.Character; if c and c:FindFirstChild("HumanoidRootPart") then pt.CFrame=CFrame.new(c.HumanoidRootPart.Position+Vector3.new(0,40,0)) end end) end
local function AStar() local p=workspace:FindFirstChild("RStar"); if p then p:Destroy() end; if not Cfg.Stars then return end; local pt,e=MArea("RStar","rbxasset://textures/particles/sparkles_main.dds",Color3.fromRGB(255,220,80),100,{2,4},{4,8},{0.5,0.1},Vector3.new(0,-6,0),Enum.NormalId.Bottom); Conn.Star=RunService.Heartbeat:Connect(function() if not Cfg.Stars then return end; local c=LP.Character; if c and c:FindFirstChild("HumanoidRootPart") then pt.CFrame=CFrame.new(c.HumanoidRootPart.Position+Vector3.new(0,40,0)) end end) end
local function AStarfall() local p=workspace:FindFirstChild("RSF"); if p then p:Destroy() end; if not Cfg.Starfall then return end; local pt,e=MArea("RSF","rbxasset://textures/particles/sparkles_main.dds",Color3.fromRGB(255,255,200),150,{1,2},{15,25},{0.8,0.1},Vector3.new(-5,-20,0),Enum.NormalId.Right); Conn.SF=RunService.Heartbeat:Connect(function() if not Cfg.Starfall then return end; local c=LP.Character; if c and c:FindFirstChild("HumanoidRootPart") then pt.CFrame=CFrame.new(c.HumanoidRootPart.Position+Vector3.new(0,60,0)) end end) end

local function MP(name,tex,col,rate,lMin,lMax,sMin,sMax,zMin,zMax) local _,_,hrp=GC(); if not hrp then return end; local o=hrp:FindFirstChild(name); if o then o:Destroy() end; local p=Instance.new("ParticleEmitter"); p.Name=name; p.Texture=tex; p.Rate=rate; p.Lifetime=NumberRange.new(lMin,lMax); p.Speed=NumberRange.new(sMin,sMax); p.SpreadAngle=Vector2.new(360,360); p.Color=ColorSequence.new(col); p.LightEmission=1; p.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,zMin),NumberSequenceKeypoint.new(1,zMax)}); p.Parent=hrp; return p end
local function APart() local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("RPrt"); if o then o:Destroy() end end; if not Cfg.Particles or not hrp then return end; MP("RPrt","rbxasset://textures/particles/sparkles_main.dds",trailCol,60,0.5,1,2,5,0.5,0) end
local function AHeart() local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("RHeart"); if o then o:Destroy() end end; if not Cfg.Hearts or not hrp then return end; local p=MP("RHeart","rbxasset://textures/particles/sparkles_main.dds",Color3.fromRGB(255,100,150),30,1,2,2,4,0.6,0); if p then p.Acceleration=Vector3.new(0,2,0) end end
local function ABub() local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("RBub"); if o then o:Destroy() end end; if not Cfg.Bubbles or not hrp then return end; local p=MP("RBub","rbxasset://textures/particles/smoke_main.dds",Color3.fromRGB(120,200,255),40,1.5,3,3,6,0.4,0); if p then p.Acceleration=Vector3.new(0,2,0); p.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,1)}) end end
local function AOrbit() Disc("Orbit"); local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("ROrb"); if o then o:Destroy() end end; if not Cfg.Orbit or not hrp then return end; local f=Instance.new("Folder"); f.Name="ROrb"; f.Parent=hrp; local balls={}; for i=1,8 do local b=Instance.new("Part"); b.Shape=Enum.PartType.Ball; b.Size=Vector3.new(0.8,0.8,0.8); b.Material=Enum.Material.Neon; b.Color=trailCol; b.CanCollide=false; b.Anchored=true; b.Parent=f; table.insert(balls,b) end; Conn.Orbit=RunService.Heartbeat:Connect(function() if not Cfg.Orbit or not hrp.Parent then return end; local t=os.clock()*2; for i,b in ipairs(balls) do local a=t+(i-1)*(math.pi*2/8); b.CFrame=CFrame.new(hrp.Position+Vector3.new(math.cos(a)*4.5,math.sin(t*1.5+i*0.3)*0.8,math.sin(a)*4.5)); b.Color=Color3.fromHSV((t*0.1+i*0.1)%1,1,1) end end) end
local function AOutline() local ch=LP.Character; if not ch then return end; local o=ch:FindFirstChild("ROutline"); if o then o:Destroy() end; if not Cfg.SelfOutline then return end; local h=Instance.new("Highlight"); h.Name="ROutline"; h.Adornee=ch; h.FillColor=trailCol; h.OutlineColor=Color3.fromRGB(255,255,255); h.FillTransparency=0.7; h.OutlineTransparency=0; h.Parent=ch end
local function ARing() local _,_,hrp=GC(); local o=workspace:FindFirstChild("RRing"); if o then o:Destroy() end; if not Cfg.Ring or not hrp then return end; local f=Instance.new("Folder"); f.Name="RRing"; f.Parent=workspace; local rings={}; for i=1,4 do local r=Instance.new("Part"); r.Shape=Enum.PartType.Cylinder; r.Size=Vector3.new(0.15,4+i*1.5,4+i*1.5); r.Material=Enum.Material.Neon; r.Color=trailCol; r.CanCollide=false; r.Anchored=true; r.Transparency=0.3; r.Parent=f; table.insert(rings,{P=r,I=i}) end; Conn.Ring=RunService.Heartbeat:Connect(function() if not Cfg.Ring or not hrp.Parent then return end; local t=os.clock(); for _,rd2 in ipairs(rings) do local p=rd2.P; local d=rd2.I%2==0 and 1 or -1; p.CFrame=CFrame.new(hrp.Position-Vector3.new(0,2.5+rd2.I*0.3,0))*CFrame.Angles(0,0,math.rad(90))*CFrame.Angles(0,t*d,0); p.Color=Color3.fromHSV((t*0.1+rd2.I*0.15)%1,1,1) end end) end
local function AHalo() local _,_,hrp=GC(); local o=workspace:FindFirstChild("RHalo"); if o then o:Destroy() end; if not Cfg.Halo or not hrp then return end; local f=Instance.new("Folder"); f.Name="RHalo"; f.Parent=workspace; local rings={}; for ring=1,3 do local orbs={}; for i=1,12 do local b=Instance.new("Part"); b.Shape=Enum.PartType.Ball; b.Size=Vector3.new(0.4,0.4,0.4); b.Material=Enum.Material.Neon; b.Color=trailCol; b.CanCollide=false; b.Anchored=true; b.Parent=f; table.insert(orbs,b) end; table.insert(rings,{Orbs=orbs,R=ring}) end; Conn.Halo=RunService.Heartbeat:Connect(function() if not Cfg.Halo or not hrp.Parent then return end; local t=os.clock(); for _,rg in ipairs(rings) do for i,b in ipairs(rg.Orbs) do local ang=(i-1)*(math.pi*2/12)+t*(1.5-rg.R*0.3); local rad=1.5+rg.R*0.8; local y=3+rg.R*0.5+math.sin(t*3+i*0.5)*0.15; b.CFrame=CFrame.new(hrp.Position+Vector3.new(math.cos(ang)*rad,y,math.sin(ang)*rad)); local sz=0.3+math.sin(t*4+i*0.5)*0.15; b.Size=Vector3.new(sz,sz,sz); b.Color=Color3.fromHSV((t*0.15+rg.R*0.1)%1,1,1) end end end) end
local function AWings()
    local _,_,hrp=GC(); local o=workspace:FindFirstChild("RWings"); if o then o:Destroy() end
    if not Cfg.Wings or not hrp then return end
    local f=Instance.new("Folder"); f.Name="RWings"; f.Parent=workspace
    local feathers={}
    for side=-1,1,2 do
        for i=1,12 do
            local len=2.5+i*0.35
            local thick=1.2-i*0.05
            local p=Instance.new("Part")
            p.Size=Vector3.new(0.18,len,thick)
            p.Material=Enum.Material.Neon
            p.Color=trailCol
            p.CanCollide=false
            p.Anchored=true
            p.Transparency=0.15
            p.Parent=f
            local a0=Instance.new("Attachment"); a0.Position=Vector3.new(0,len/2,0); a0.Parent=p
            local a1=Instance.new("Attachment"); a1.Position=Vector3.new(0,-len/2,0); a1.Parent=p
            local tr=Instance.new("Trail")
            tr.Attachment0=a0; tr.Attachment1=a1
            tr.Color=ColorSequence.new(trailCol)
            tr.Lifetime=0.35
            tr.LightEmission=1
            tr.Parent=p
            table.insert(feathers,{P=p,S=side,I=i,T=tr})
        end
    end
    Conn.Wings=RunService.Heartbeat:Connect(function()
        if not Cfg.Wings or not hrp.Parent then return end
        local t=os.clock()*3
        local flap=math.sin(t)*0.5
        for _,fd in ipairs(feathers) do
            local p=fd.P; local s=fd.S; local i=fd.I
            local ang=(i-1)*10+flap*25+18
            local offX=s*(1.2+i*0.45)
            local offY=1.2+i*0.35
            local offZ=-i*0.35
            local rot=CFrame.Angles(0,0,s*math.rad(ang))*CFrame.Angles(0,s*math.rad(25),0)
            p.CFrame=hrp.CFrame*CFrame.new(offX,offY,offZ)*rot
            local col=Color3.fromHSV((os.clock()*0.1+i*0.03)%1,1,1)
            p.Color=col
            fd.T.Color=ColorSequence.new(col)
        end
    end)
end
local function AAuraSph() local _,_,hrp=GC(); local o=workspace:FindFirstChild("RAuraS"); if o then o:Destroy() end; if not Cfg.AuraSphere or not hrp then return end; local f=Instance.new("Folder"); f.Name="RAuraS"; f.Parent=workspace; local sphs={}; for i=1,2 do local s=Instance.new("Part"); s.Shape=Enum.PartType.Ball; s.Size=Vector3.new(4+i*1.5,4+i*1.5,4+i*1.5); s.Material=Enum.Material.ForceField; s.Color=trailCol; s.Transparency=0.75; s.CanCollide=false; s.Anchored=true; s.Parent=f; table.insert(sphs,s) end; Conn.AuraS=RunService.Heartbeat:Connect(function() if not Cfg.AuraSphere or not hrp.Parent then return end; local t=os.clock(); for i,s in ipairs(sphs) do local sz=(4+i*1.5)+math.sin(t*3+i)*0.5; s.Size=Vector3.new(sz,sz,sz); s.CFrame=hrp.CFrame; s.Color=Color3.fromHSV((t*0.1+i*0.2)%1,1,1) end end) end
local function ALightning() local _,_,hrp=GC(); local o=workspace:FindFirstChild("RLN"); if o then o:Destroy() end; if not Cfg.Lightning or not hrp then return end; local f=Instance.new("Folder"); f.Name="RLN"; f.Parent=workspace; local bolts={}; for i=1,15 do local p=Instance.new("Part"); p.Size=Vector3.new(0.15,0.15,0.15); p.Material=Enum.Material.Neon; p.Color=trailCol; p.CanCollide=false; p.Anchored=true; p.Parent=f; table.insert(bolts,p) end; Conn.LN=RunService.Heartbeat:Connect(function() if not Cfg.Lightning or not hrp.Parent then return end; local t=os.clock(); for i,b in ipairs(bolts) do local a=(t*3+i*0.5)%(math.pi*2); local r=3+math.sin(t*5+i)*1.5; local y=math.sin(t*4+i)*2.5; b.CFrame=CFrame.new(hrp.Position+Vector3.new(math.cos(a)*r,y,math.sin(a)*r)); b.Size=Vector3.new(0.15+math.random()*0.1,0.15,0.15); b.Color=Color3.fromHSV((t*0.2+i*0.05)%1,1,1) end end) end
local function AFire() local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("RFire"); if o then o:Destroy() end end; if not Cfg.Fire or not hrp then return end; local fi=Instance.new("Fire"); fi.Name="RFire"; fi.Size=6; fi.Heat=6; fi.Color=trailCol; fi.SecondaryColor=Color3.fromRGB(255,150,0); fi.Parent=hrp end
local function AAntiAFK() Disc("AntiAFK"); if not Cfg.AntiAFK then return end; pcall(function() if getconnections then for _,c in ipairs(getconnections(LP.Idled)) do c:Disconnect() end end end); Conn.AntiAFK=LP.Idled:Connect(function() if not Cfg.AntiAFK then return end; pcall(function() if VirtualUser then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end end) end) end
local function ACross() Disc("Cross"); if Conn.CrossGUI then Conn.CrossGUI:Destroy(); Conn.CrossGUI=nil end; if not Cfg.Crosshair then return end; local cr=Instance.new("ScreenGui"); cr.Name="RCross"; cr.ResetOnSpawn=false; cr.IgnoreGuiInset=true; cr.Parent=PG; Conn.CrossGUI=cr; local h=Instance.new("Frame"); h.Size=UDim2.new(0,2,0,20); h.Position=UDim2.new(0.5,-1,0.5,-10); h.BackgroundColor3=trailCol; h.BorderSizePixel=0; h.Parent=cr; local v=Instance.new("Frame"); v.Size=UDim2.new(0,20,0,2); v.Position=UDim2.new(0.5,-10,0.5,-1); v.BackgroundColor3=trailCol; v.BorderSizePixel=0; v.Parent=cr; local d=Instance.new("Frame"); d.Size=UDim2.new(0,4,0,4); d.Position=UDim2.new(0.5,-2,0.5,-2); d.BackgroundColor3=trailCol; d.BorderSizePixel=0; d.Parent=cr end
local function ABring() local _,_,mr=GC(); if not mr then return end; for _,pl in ipairs(Players:GetPlayers()) do if pl~=LP and pl.Character then local hr=pl.Character:FindFirstChild("HumanoidRootPart"); if hr then hr.CFrame=mr.CFrame+Vector3.new(math.random(-4,4),3,math.random(-4,4)) end end end end

-- ==================== НОВЫЕ ФХ ====================
local function ABH()
    Disc("BlackHole"); local o=workspace:FindFirstChild("RBH"); if o then o:Destroy() end
    if not Cfg.BlackHole then return end
    local f=Instance.new("Folder"); f.Name="RBH"; f.Parent=workspace
    local core=Instance.new("Part"); core.Shape=Enum.PartType.Ball; core.Size=Vector3.new(3,3,3); core.Material=Enum.Material.ForceField; core.Color=Color3.fromRGB(0,0,0); core.Transparency=0.2; core.CanCollide=false; core.Anchored=true; core.Parent=f
    local ring=Instance.new("Part"); ring.Shape=Enum.PartType.Cylinder; ring.Size=Vector3.new(0.2,6,6); ring.Material=Enum.Material.Neon; ring.Color=trailCol; ring.Transparency=0.4; ring.CanCollide=false; ring.Anchored=true; ring.Parent=f
    local prt=Instance.new("ParticleEmitter"); prt.Texture="rbxasset://textures/particles/sparkles_main.dds"; prt.Rate=250; prt.Lifetime=NumberRange.new(0.5,1); prt.Speed=NumberRange.new(8,15); prt.Size=NumberSequence.new(0.2,0); prt.Color=ColorSequence.new(trailCol); prt.LightEmission=1; prt.Parent=core
    Conn.BH=RunService.Heartbeat:Connect(function()
        if not Cfg.BlackHole then return end
        local _,_,hrp=GC()
        if hrp then
            local t=os.clock()*2
            core.CFrame=hrp.CFrame*CFrame.new(0,3,-5)
            ring.CFrame=core.CFrame*CFrame.Angles(math.rad(90),t,0)
            ring.Color=Color3.fromHSV((t*0.2)%1,1,1)
        end
    end)
end
local function AES()
    Disc("EnergySword"); local ch=LP.Character; if not ch then return end
    local o=ch:FindFirstChild("RWord"); if o then o:Destroy() end
    if not Cfg.EnergySword then return end
    local hand=ch:FindFirstChild("RightHand") or ch:FindFirstChild("Right Arm"); if not hand then return end
    local sword=Instance.new("Part"); sword.Name="RWord"; sword.Size=Vector3.new(0.5,7,0.5); sword.Material=Enum.Material.Neon; sword.Color=trailCol; sword.CanCollide=false; sword.Massless=true; sword.Parent=ch
    local w=Instance.new("Weld"); w.Part0=hand; w.Part1=sword; w.C0=CFrame.new(0,-1,0)*CFrame.Angles(math.rad(90),0,0); w.Parent=sword
    local tr=Instance.new("Trail")
    local a0=Instance.new("Attachment"); a0.Position=Vector3.new(0,-3.5,0); a0.Parent=sword
    local a1=Instance.new("Attachment"); a1.Position=Vector3.new(0,3.5,0); a1.Parent=sword
    tr.Attachment0=a0; tr.Attachment1=a1; tr.Color=ColorSequence.new(trailCol); tr.Lifetime=0.3; tr.LightEmission=1; tr.Parent=sword
end
local function AFF() Disc("Fireflies"); local _,_,hrp=GC(); if hrp then local o=hrp:FindFirstChild("RFF"); if o then o:Destroy() end end; if not Cfg.Fireflies or not hrp then return end; local prt=Instance.new("ParticleEmitter"); prt.Name="RFF"; prt.Texture="rbxasset://textures/particles/sparkles_main.dds"; prt.Rate=25; prt.Lifetime=NumberRange.new(2,4); prt.Speed=NumberRange.new(1,3); prt.SpreadAngle=Vector2.new(360,360); prt.Color=ColorSequence.new(Color3.fromRGB(255,255,100)); prt.LightEmission=1; prt.Size=NumberSequence.new(0.25,0); prt.Parent=hrp end
local function ATA() Disc("TargetAura"); for _,p in ipairs(Players:GetPlayers()) do if p.Character then local o=p.Character:FindFirstChild("RTAura"); if o then o:Destroy() end end end; if not Cfg.TargetAura then return end; Conn.TA=RunService.Heartbeat:Connect(function() if not Cfg.TargetAura then return end; for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if hrp then local o=p.Character:FindFirstChild("RTAura"); if not o then local s=Instance.new("Part"); s.Name="RTAura"; s.Shape=Enum.PartType.Ball; s.Size=Vector3.new(6,6,6); s.Material=Enum.Material.ForceField; s.Color=Color3.fromRGB(255,0,0); s.Transparency=0.8; s.CanCollide=false; s.Anchored=true; s.Parent=p.Character end end end end end) end

-- ==================== STATS ====================
local StatsGui = Instance.new("TextLabel")
StatsGui.Name="RStats"
StatsGui.Size=UDim2.new(0,200,0,32)
StatsGui.Position=UDim2.new(0,15,0,15)
StatsGui.BackgroundColor3=Color3.fromRGB(20,20,25)
StatsGui.BackgroundTransparency=0.3
StatsGui.TextColor3=Color3.fromRGB(50,255,100)
StatsGui.Font=Enum.Font.GothamBold
StatsGui.TextSize=14
StatsGui.Text="FPS: 60 | Ping: 0"
StatsGui.TextXAlignment=Enum.TextXAlignment.Center
StatsGui.Visible=Cfg.ShowStats
StatsGui.ZIndex=999
StatsGui.Parent=PG

local SC=Instance.new("UICorner"); SC.CornerRadius=UDim.new(0,8); SC.Parent=StatsGui
local SS=Instance.new("UIStroke"); SS.Color=Color3.fromRGB(80,80,100); SS.Thickness=1.5; SS.Parent=StatsGui

local fpsCount,lastT=0,os.clock()
RunService.RenderStepped:Connect(function()
    fpsCount=fpsCount+1
    local now=os.clock()
    if now-lastT>=1 then
        local fps=math.floor(fpsCount/(now-lastT))
        if fps<5 then pcall(function() fps=math.floor(workspace:GetRealPhysicsFPS()) end) end
        local ping=0
        pcall(function() ping=math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        StatsGui.Text=string.format("FPS: %d | Ping: %d",fps,ping)
        if ping<80 then StatsGui.TextColor3=Color3.fromRGB(50,255,100) elseif ping<150 then StatsGui.TextColor3=Color3.fromRGB(255,200,50) else StatsGui.TextColor3=Color3.fromRGB(255,50,50) end
        StatsGui.Visible=Cfg.ShowStats
        fpsCount=0; lastT=now
    end
end)

-- ==================== UI ====================
local SG=Instance.new("ScreenGui")
SG.Name="RazeHub"; SG.ResetOnSpawn=false; SG.IgnoreGuiInset=true; SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; SG.Parent=PG

local vp=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(400,800)
local UIScale=Instance.new("UIScale"); UIScale.Parent=SG
local function AGS() local base=1; if vp.X<360 then base=0.78 elseif vp.Y<600 then base=0.88 end; UIScale.Scale=base*Cfg.GuiScale end
AGS()

local MF=Instance.new("Frame")
MF.Size=UDim2.new(0,320,0,420); MF.Position=UDim2.new(0.5,-160,0.5,-210); MF.BackgroundColor3=bg1; MF.BorderSizePixel=0; MF.Active=true; MF.ClipsDescendants=true; MF.Parent=SG
Drag(MF,MF)
local MFC=Instance.new("UICorner"); MFC.CornerRadius=UDim.new(0,16); MFC.Parent=MF
local MFS=Instance.new("UIStroke"); MFS.Color=rd; MFS.Thickness=2; MFS.Transparency=0; MFS.Parent=MF
local MFSG=Instance.new("UIGradient")
MFSG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(0.66,Color3.fromRGB(0,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))}
MFSG.Parent=MFS

local BGG=Instance.new("UIGradient"); BGG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,bg1),ColorSequenceKeypoint.new(1,bg2)}; BGG.Rotation=90; BGG.Parent=MF

local TB=Instance.new("Frame"); TB.Size=UDim2.new(1,0,0,40); TB.BackgroundColor3=rdk; TB.BorderSizePixel=0; TB.Parent=MF
local TBC=Instance.new("UICorner"); TBC.CornerRadius=UDim.new(0,16); TBC.Parent=TB
local TBCov=Instance.new("Frame"); TBCov.Size=UDim2.new(1,0,0,14); TBCov.Position=UDim2.new(0,0,1,-14); TBCov.BackgroundColor3=rdk; TBCov.BorderSizePixel=0; TBCov.Parent=TB
local TBG=Instance.new("UIGradient"); TBG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,rd),ColorSequenceKeypoint.new(0.5,rdk),ColorSequenceKeypoint.new(1,Color3.fromRGB(80,10,20))}; TBG.Parent=TB
local TTL=Instance.new("TextLabel"); TTL.Size=UDim2.new(1,-64,1,0); TTL.Position=UDim2.new(0,16,0,0); TTL.BackgroundTransparency=1; TTL.Text="RAZE HUB"; TTL.TextColor3=Color3.fromRGB(255,255,255); TTL.Font=Enum.Font.GothamBold; TTL.TextSize=15; TTL.TextXAlignment=Enum.TextXAlignment.Left; TTL.Parent=TB
local TDot=Instance.new("Frame"); TDot.Size=UDim2.new(0,8,0,8); TDot.Position=UDim2.new(0,8,0,16); TDot.BackgroundColor3=Color3.fromRGB(255,255,255); TDot.BorderSizePixel=0; TDot.Parent=TB
local TDC=Instance.new("UICorner"); TDC.CornerRadius=UDim.new(1,0); TDC.Parent=TDot
local HideBtn=Instance.new("TextButton"); HideBtn.Size=UDim2.new(0,26,0,26); HideBtn.Position=UDim2.new(1,-34,0,7); HideBtn.BackgroundColor3=Color3.fromRGB(0,0,0); HideBtn.BackgroundTransparency=0.5; HideBtn.BorderSizePixel=0; HideBtn.Text="−"; HideBtn.TextColor3=Color3.fromRGB(255,255,255); HideBtn.Font=Enum.Font.GothamBold; HideBtn.TextSize=18; HideBtn.Parent=TB
local HBC=Instance.new("UICorner"); HBC.CornerRadius=UDim.new(0,8); HBC.Parent=HideBtn

RunService.RenderStepped:Connect(function() MFSG.Rotation=(MFSG.Rotation+1)%360 end)

-- ==================== QUICK PANEL (GRID) ====================
local FC=Instance.new("Frame"); FC.Size=UDim2.new(0,240,0,360); FC.Position=UDim2.new(1,-260,0.5,-180); FC.BackgroundColor3=bg1; FC.BorderSizePixel=0; FC.Visible=false; FC.Parent=SG
local FCC=Instance.new("UICorner"); FCC.CornerRadius=UDim.new(0,12); FCC.Parent=FC
local FCS=Instance.new("UIStroke"); FCS.Color=rd; FCS.Thickness=1.5; FCS.Parent=FC
local FTitle=Instance.new("TextLabel"); FTitle.Size=UDim2.new(1,0,0,25); FTitle.BackgroundTransparency=1; FTitle.Text="QUICK PANEL"; FTitle.TextColor3=rlt; FTitle.Font=Enum.Font.GothamBold; FTitle.TextSize=12; FTitle.Parent=FC

local FScroll=Instance.new("ScrollingFrame"); FScroll.Size=UDim2.new(1,-10,1,-32); FScroll.Position=UDim2.new(0,5,0,28); FScroll.BackgroundTransparency=1; FScroll.BorderSizePixel=0; FScroll.ScrollBarThickness=3; FScroll.ScrollBarImageColor3=rd; FScroll.CanvasSize=UDim2.new(0,0,0,0); FScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; FScroll.Parent=FC

local FGrid=Instance.new("UIGridLayout"); FGrid.CellSize=UDim2.new(0,108,0,55); FGrid.CellPadding=UDim2.new(0,5,0,5); FGrid.Parent=FScroll

local ShowBtn=Instance.new("TextButton"); ShowBtn.Size=UDim2.new(0,55,0,55); ShowBtn.Position=UDim2.new(1,-75,0.5,-27); ShowBtn.BackgroundColor3=rdk; ShowBtn.BorderSizePixel=0; ShowBtn.Text=""; ShowBtn.Parent=SG
local SBC=Instance.new("UICorner"); SBC.CornerRadius=UDim.new(0,14); SBC.Parent=ShowBtn
local SBS=Instance.new("UIStroke"); SBS.Color=rd; SBS.Thickness=2; SBS.Parent=ShowBtn
local BImg=Instance.new("ImageLabel"); BImg.Size=UDim2.new(1,-8,1,-8); BImg.Position=UDim2.new(0,4,0,4); BImg.BackgroundTransparency=1; BImg.Image="rbxassetid://"..Cfg.CustomImgID; BImg.ScaleType=Enum.ScaleType.Crop; BImg.Parent=ShowBtn
local BIC=Instance.new("UICorner"); BIC.CornerRadius=UDim.new(0,10); BIC.Parent=BImg; table.insert(ImageRefs,BImg)
Drag(ShowBtn,ShowBtn)

-- Функция создания квадратной кнопки в сетке
local function AddSquare(name,cfgKey,cb)
    local b=Instance.new("TextButton")
    b.BackgroundColor3=Cfg[cfgKey] and rd or cd
    b.BorderSizePixel=0
    b.Text=name
    b.TextColor3=tx
    b.Font=Enum.Font.GothamBold
    b.TextSize=11
    b.TextWrapped=true
    b.Parent=FScroll
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,10); c.Parent=b
    local s=Instance.new("UIStroke"); s.Color=rd; s.Thickness=1; s.Transparency=0.5; s.Parent=b
    b.MouseButton1Click:Connect(function()
        Cfg[cfgKey]=not Cfg[cfgKey]
        b.BackgroundColor3=Cfg[cfgKey] and rd or cd
        cb(Cfg[cfgKey])
        task.spawn(SaveCfg)
    end)
end

AddSquare("FLY","Fly",function(e) if e then StartFly() else StopFly() end end)
AddSquare("SPEED","Speed",function() ASpeed() end)
AddSquare("JUMP","Jump",function() AJump() end)
AddSquare("NOCLIP","Noclip",function() ANoclip() end)
AddSquare("ESP","ESP",function() AESP() end)
AddSquare("BOX","BoxESP",function() ABoxESP() end)
AddSquare("AIM","Aimbot",function() AAim() end)
AddSquare("HITBOX","Hitbox",function() AHitbox() end)
AddSquare("BLACK HOLE","BlackHole",function() ABH() end)
AddSquare("E.SWORD","EnergySword",function() AES() end)
AddSquare("FIREFLY","Fireflies",function() AFF() end)
AddSquare("T.AURA","TargetAura",function() ATA() end)
AddSquare("TRAIL","Trail",function() ATrail() end)
AddSquare("WINGS","Wings",function() AWings() end)
AddSquare("HALO","Halo",function() AHalo() end)
AddSquare("RING","Ring",function() ARing() end)

-- ==================== TABS ====================
local TabBar=Instance.new("Frame"); TabBar.Size=UDim2.new(1,0,0,36); TabBar.Position=UDim2.new(0,0,0,40); TabBar.BackgroundColor3=bg2; TabBar.BorderSizePixel=0; TabBar.Parent=MF
local TabKeys={"Tab_Main","Tab_Combat","Tab_Visual","Tab_FX","Tab_Settings"}; local TabBtns={}; local TabContent={}
local UL=Instance.new("Frame"); UL.Size=UDim2.new(1/5-0.02,0,0,2); UL.Position=UDim2.new(0.01,0,1,-3); UL.BackgroundColor3=rd; UL.BorderSizePixel=0; UL.Parent=TabBar
local UC=Instance.new("UICorner"); UC.CornerRadius=UDim.new(1,0); UC.Parent=UL
for i,key in ipairs(TabKeys) do
    local b=Instance.new("TextButton"); b.Size=UDim2.new(1/5,-4,1,-6); b.Position=UDim2.new((i-1)/5+0.005,0,0,3); b.BackgroundColor3=cd; b.BorderSizePixel=0; b.Text=T(key); b.TextColor3=i==1 and Color3.fromRGB(255,255,255) or td; b.Font=Enum.Font.GothamBold; b.TextSize=10; b.Parent=TabBar
    local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,8); bc.Parent=b; TabBtns[i]=b; i18nRefs[key]=b
    local sc=Instance.new("ScrollingFrame"); sc.Size=UDim2.new(1,-12,1,-86); sc.Position=UDim2.new(0,6,0,80); sc.BackgroundTransparency=1; sc.BorderSizePixel=0; sc.ScrollBarThickness=3; sc.ScrollBarImageColor3=rd; sc.CanvasSize=UDim2.new(0,0,0,0); sc.AutomaticCanvasSize=Enum.AutomaticSize.Y; sc.Visible=i==1; sc.Parent=MF
    local lay=Instance.new("UIListLayout"); lay.Padding=UDim.new(0,4); lay.SortOrder=Enum.SortOrder.LayoutOrder; lay.Parent=sc; TabContent[i]=sc
    b.MouseButton1Click:Connect(function() for j,bb in ipairs(TabBtns) do TweenService:Create(bb,TweenInfo.new(0.15),{TextColor3=j==i and Color3.fromRGB(255,255,255) or td}):Play(); TabContent[j].Visible=j==i end; TweenService:Create(UL,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new((i-1)/5+0.008,0,1,-3)}):Play() end)
end

-- ==================== HELPERS ====================
local function SEC(p,key) local f=Instance.new("Frame"); f.Size=UDim2.new(1,-4,0,18); f.BackgroundTransparency=1; f.Parent=p; local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,-8,1,0); l.Position=UDim2.new(0,10,0,0); l.BackgroundTransparency=1; l.Text=T(key); l.TextColor3=rlt; l.Font=Enum.Font.GothamBold; l.TextSize=10; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=f; i18nRefs[key]=l end
local function TOG(p,key,def,cb) local row=Instance.new("Frame"); row.Size=UDim2.new(1,-4,0,34); row.BackgroundColor3=cd; row.BorderSizePixel=0; row.Parent=p; local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=row; local dot=Instance.new("Frame"); dot.Size=UDim2.new(0,3,0,16); dot.Position=UDim2.new(0,0,0,9); dot.BackgroundColor3=rd; dot.BorderSizePixel=0; dot.Parent=row; local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=dot; table.insert(AccentRefs,{O=dot,P="BackgroundColor3",K="main"}); local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,-64,1,0); l.Position=UDim2.new(0,18,0,0); l.BackgroundTransparency=1; l.Text=T(key); l.TextColor3=tx; l.Font=Enum.Font.GothamMedium; l.TextSize=12; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=row; i18nRefs[key]=l; local tr=Instance.new("Frame"); tr.Size=UDim2.new(0,40,0,22); tr.Position=UDim2.new(1,-48,0,6); tr.BackgroundColor3=def and rd or mu; tr.BorderSizePixel=0; tr.Parent=row; local trc=Instance.new("UICorner"); trc.CornerRadius=UDim.new(1,0); trc.Parent=tr; table.insert(AccentRefs,{O=tr,P="BackgroundColor3",K="state",S=def}); local kn=Instance.new("Frame"); kn.Size=UDim2.new(0,18,0,18); kn.Position=def and UDim2.new(1,-20,0,2) or UDim2.new(0,2,0,2); kn.BackgroundColor3=Color3.fromRGB(255,255,255); kn.BorderSizePixel=0; kn.Parent=tr; local kc=Instance.new("UICorner"); kc.CornerRadius=UDim.new(1,0); kc.Parent=kn; local en=def; local cl=Instance.new("TextButton"); cl.Size=UDim2.new(1,0,1,0); cl.BackgroundTransparency=1; cl.Text=""; cl.Parent=row; cl.MouseEnter:Connect(function() TweenService:Create(row,TweenInfo.new(0.15),{BackgroundColor3=cdH}):Play() end); cl.MouseLeave:Connect(function() TweenService:Create(row,TweenInfo.new(0.15),{BackgroundColor3=cd}):Play() end); cl.MouseButton1Click:Connect(function() en=not en; TweenService:Create(tr,TweenInfo.new(0.22),{BackgroundColor3=en and rd or mu}):Play(); TweenService:Create(kn,TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=en and UDim2.new(1,-20,0,2) or UDim2.new(0,2,0,2)}):Play(); for _,r in ipairs(AccentRefs) do if r.O==tr then r.S=en end end; cb(en); task.spawn(SaveCfg) end) end
local function TOGV(p,key,def,dv,cb) local row=Instance.new("Frame"); row.Size=UDim2.new(1,-4,0,34); row.BackgroundColor3=cd; row.BorderSizePixel=0; row.Parent=p; local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=row; local dot=Instance.new("Frame"); dot.Size=UDim2.new(0,3,0,16); dot.Position=UDim2.new(0,0,0,9); dot.BackgroundColor3=rd; dot.BorderSizePixel=0; dot.Parent=row; local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=dot; table.insert(AccentRefs,{O=dot,P="BackgroundColor3",K="main"}); local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,-112,1,0); l.Position=UDim2.new(0,18,0,0); l.BackgroundTransparency=1; l.Text=T(key); l.TextColor3=tx; l.Font=Enum.Font.GothamMedium; l.TextSize=12; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=row; i18nRefs[key]=l; local bx=Instance.new("TextBox"); bx.Size=UDim2.new(0,40,0,22); bx.Position=UDim2.new(1,-96,0,6); bx.BackgroundColor3=ip; bx.BorderSizePixel=0; bx.Text=tostring(dv); bx.TextColor3=rlt; bx.Font=Enum.Font.GothamBold; bx.TextSize=12; bx.ClearTextOnFocus=false; bx.Parent=row; local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,6); bc.Parent=bx; local tr=Instance.new("Frame"); tr.Size=UDim2.new(0,40,0,22); tr.Position=UDim2.new(1,-48,0,6); tr.BackgroundColor3=def and rd or mu; tr.BorderSizePixel=0; tr.Parent=row; local trc=Instance.new("UICorner"); trc.CornerRadius=UDim.new(1,0); trc.Parent=tr; table.insert(AccentRefs,{O=tr,P="BackgroundColor3",K="state",S=def}); local kn=Instance.new("Frame"); kn.Size=UDim2.new(0,18,0,18); kn.Position=def and UDim2.new(1,-20,0,2) or UDim2.new(0,2,0,2); kn.BackgroundColor3=Color3.fromRGB(255,255,255); kn.BorderSizePixel=0; kn.Parent=tr; local kc=Instance.new("UICorner"); kc.CornerRadius=UDim.new(1,0); kc.Parent=kn; local en=def; local v=dv; local cl=Instance.new("TextButton"); cl.Size=UDim2.new(0,40,0,22); cl.Position=UDim2.new(1,-48,0,6); cl.BackgroundTransparency=1; cl.Text=""; cl.Parent=row; cl.MouseButton1Click:Connect(function() en=not en; TweenService:Create(tr,TweenInfo.new(0.22),{BackgroundColor3=en and rd or mu}):Play(); TweenService:Create(kn,TweenInfo.new(0.22,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=en and UDim2.new(1,-20,0,2) or UDim2.new(0,2,0,2)}):Play(); for _,r in ipairs(AccentRefs) do if r.O==tr then r.S=en end end; cb(en,v); task.spawn(SaveCfg) end); bx.FocusLost:Connect(function() local n=tonumber(bx.Text); if n then v=n else bx.Text=tostring(v) end; cb(en,v); task.spawn(SaveCfg) end) end
local function BTN(p,key,cb) local b=Instance.new("TextButton"); b.Size=UDim2.new(1,-4,0,30); b.BackgroundColor3=rdk; b.BorderSizePixel=0; b.Text=T(key); b.TextColor3=Color3.fromRGB(255,255,255); b.Font=Enum.Font.GothamBold; b.TextSize=11; b.Parent=p; local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,8); bc.Parent=b; table.insert(AccentRefs,{O=b,P="BackgroundColor3",K="dark"}); i18nRefs[key]=b; b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=rd}):Play() end); b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=rdk}):Play() end); b.MouseButton1Click:Connect(function() cb(b) end) end
local function CYB(p,key,opts,def,cb) local row=Instance.new("Frame"); row.Size=UDim2.new(1,-4,0,34); row.BackgroundColor3=cd; row.BorderSizePixel=0; row.Parent=p; local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,8); rc.Parent=row; local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,-80,1,0); l.Position=UDim2.new(0,18,0,0); l.BackgroundTransparency=1; l.Text=T(key); l.TextColor3=tx; l.Font=Enum.Font.GothamMedium; l.TextSize=12; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=row; i18nRefs[key]=l; local b=Instance.new("TextButton"); b.Size=UDim2.new(0,64,0,22); b.Position=UDim2.new(1,-70,0,6); b.BackgroundColor3=ip; b.BorderSizePixel=0; b.Text=def; b.TextColor3=rlt; b.Font=Enum.Font.GothamBold; b.TextSize=11; b.Parent=row; local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(0,6); bc.Parent=b; local i=1; for j,v in ipairs(opts) do if v==def then i=j break end end; b.MouseButton1Click:Connect(function() i=i+1; if i>#opts then i=1 end; b.Text=opts[i]; cb(opts[i]); task.spawn(SaveCfg) end) end

-- ==================== КОНТЕНТ ====================
SEC(TabContent[1],"Sec_Move")
TOGV(TabContent[1],"Fly",Cfg.Fly,Cfg.FlySpeed,function(e,v) Cfg.Fly=e; Cfg.FlySpeed=v; if e then StartFly() else StopFly() end end)
TOGV(TabContent[1],"Speed",Cfg.Speed,Cfg.SpeedValue,function(e,v) Cfg.Speed=e; Cfg.SpeedValue=v; ASpeed() end)
TOGV(TabContent[1],"Jump",Cfg.Jump,Cfg.JumpValue,function(e,v) Cfg.Jump=e; Cfg.JumpValue=v; AJump() end)
TOG(TabContent[1],"InfJump",Cfg.InfJump,function(e) Cfg.InfJump=e; AInfJump() end)
TOG(TabContent[1],"BHop",Cfg.BHop,function(e) Cfg.BHop=e; ABHop() end)
TOG(TabContent[1],"Noclip",Cfg.Noclip,function(e) Cfg.Noclip=e; ANoclip() end)
SEC(TabContent[1],"Sec_Util")
TOG(TabContent[1],"AntiVoid",Cfg.AntiVoid,function(e) Cfg.AntiVoid=e; AAVoid() end)
TOG(TabContent[1],"Fullbright",Cfg.Fullbright,function(e) Cfg.Fullbright=e; AFB() end)
TOG(TabContent[1],"AntiAFK",Cfg.AntiAFK,function(e) Cfg.AntiAFK=e; AAntiAFK() end)
SEC(TabContent[2],"Sec_Combat")
TOG(TabContent[2],"ESP",Cfg.ESP,function(e) Cfg.ESP=e; AESP() end)
TOG(TabContent[2],"BoxESP",Cfg.BoxESP,function(e) Cfg.BoxESP=e; ABoxESP() end)
TOG(TabContent[2],"Tracer",Cfg.Tracer,function(e) Cfg.Tracer=e; ATracer() end)
TOGV(TabContent[2],"Hitbox",Cfg.Hitbox,Cfg.HitboxMult,function(e,v) Cfg.Hitbox=e; Cfg.HitboxMult=v; AHitbox() end)
TOG(TabContent[2],"HitboxView",Cfg.HitboxView,function(e) Cfg.HitboxView=e; AHV() end)
SEC(TabContent[2],"Sec_Aim")
TOG(TabContent[2],"Aimbot",Cfg.Aimbot,function(e) Cfg.Aimbot=e; AAim() end)
TOG(TabContent[2],"Silent",Cfg.Silent,function(e) Cfg.Silent=e; ASil() end)
TOG(TabContent[2],"WallCheck",Cfg.WallCheck,function(e) Cfg.WallCheck=e end)
TOGV(TabContent[2],"AimFOV",false,Cfg.AimFOV,function(_,v) Cfg.AimFOV=v end)
TOGV(TabContent[2],"Smooth",false,Cfg.AimSmooth,function(_,v) Cfg.AimSmooth=v end)
SEC(TabContent[2],"Sec_Defense")
TOG(TabContent[2],"AntiFling",Cfg.AntiFling,function(e) Cfg.AntiFling=e; AAF() end)
SEC(TabContent[3],"Sec_Trail")
TOG(TabContent[3],"Trail",Cfg.Trail,function(e) Cfg.Trail=e; ATrail(); if e and Cfg.TrailRainbow then ATRB() end end)
CYB(TabContent[3],"TrailType",{"Standard","Lightning","Fire"},Cfg.TrailType,function(v) Cfg.TrailType=v; ATrail() end)
TOG(TabContent[3],"TrailRainbow",Cfg.TrailRainbow,function(e) Cfg.TrailRainbow=e; ATRB() end)
TOG(TabContent[3],"Glow",Cfg.TrailGlow,function(e) Cfg.TrailGlow=e; ATrail() end)
SEC(TabContent[3],"Sec_Colors")
local cRow=Instance.new("Frame"); cRow.Size=UDim2.new(1,-4,0,36); cRow.BackgroundColor3=cd; cRow.BorderSizePixel=0; cRow.Parent=TabContent[3]; local cRC=Instance.new("UICorner"); cRC.CornerRadius=UDim.new(0,8); cRC.Parent=cRow
local tCols={Color3.fromRGB(255,45,65),Color3.fromRGB(45,120,255),Color3.fromRGB(45,200,80),Color3.fromRGB(200,45,255),Color3.fromRGB(255,220,45),Color3.fromRGB(255,255,255)}
for i,col in ipairs(tCols) do local cb=Instance.new("TextButton"); cb.Size=UDim2.new(0,38,0,24); cb.Position=UDim2.new(0,8+(i-1)*42,0,6); cb.BackgroundColor3=col; cb.BorderSizePixel=0; cb.Text=""; cb.Parent=cRow; local cbc=Instance.new("UICorner"); cbc.CornerRadius=UDim.new(0,6); cbc.Parent=cb; cb.MouseButton1Click:Connect(function() trailCol=col; Cfg.TrailRainbow=false; UTC(); APart(); AOutline(); if Cfg.Fire then AFire() end; if Cfg.Snow then ASnow() end; if Cfg.Confetti then AConf() end; if Cfg.Hearts then AHeart() end; if Cfg.Bubbles then ABub() end; if Cfg.Stars then AStar() end; if Cfg.Starfall then AStarfall() end; if Cfg.BlackHole then ABH() end; if Cfg.EnergySword then AES() end; if Cfg.Fireflies then AFF() end; task.spawn(SaveCfg) end) end
SEC(TabContent[3],"Sec_Screen")
TOGV(TabContent[3],"FOV",false,Cfg.FOV,function(_,v) Cfg.FOV=v; workspace.CurrentCamera.FieldOfView=v end)
TOG(TabContent[3],"Crosshair",Cfg.Crosshair,function(e) Cfg.Crosshair=e; ACross() end)
SEC(TabContent[3],"Sec_Effects")
TOG(TabContent[3],"Particles",Cfg.Particles,function(e) Cfg.Particles=e; APart() end)
TOG(TabContent[3],"Orbit",Cfg.Orbit,function(e) Cfg.Orbit=e; AOrbit() end)
TOG(TabContent[3],"SelfOutline",Cfg.SelfOutline,function(e) Cfg.SelfOutline=e; AOutline() end)
SEC(TabContent[4],"Sec_Fancy")
TOG(TabContent[4],"Ring",Cfg.Ring,function(e) Cfg.Ring=e; ARing() end)
TOG(TabContent[4],"Halo",Cfg.Halo,function(e) Cfg.Halo=e; AHalo() end)
TOG(TabContent[4],"Wings",Cfg.Wings,function(e) Cfg.Wings=e; AWings() end)
TOG(TabContent[4],"AuraSphere",Cfg.AuraSphere,function(e) Cfg.AuraSphere=e; AAuraSph() end)
TOG(TabContent[4],"Lightning",Cfg.Lightning,function(e) Cfg.Lightning=e; ALightning() end)
TOG(TabContent[4],"Fire",Cfg.Fire,function(e) Cfg.Fire=e; AFire() end)
SEC(TabContent[4],"Sec_NewFX")
TOG(TabContent[4],"Snow",Cfg.Snow,function(e) Cfg.Snow=e; ASnow() end)
TOG(TabContent[4],"Confetti",Cfg.Confetti,function(e) Cfg.Confetti=e; AConf() end)
TOG(TabContent[4],"Hearts",Cfg.Hearts,function(e) Cfg.Hearts=e; AHeart() end)
TOG(TabContent[4],"Bubbles",Cfg.Bubbles,function(e) Cfg.Bubbles=e; ABub() end)
TOG(TabContent[4],"Stars",Cfg.Stars,function(e) Cfg.Stars=e; AStar() end)
TOG(TabContent[4],"Starfall",Cfg.Starfall,function(e) Cfg.Starfall=e; AStarfall() end)
SEC(TabContent[4],"NEW VISUALS")
TOG(TabContent[4],"BlackHole",Cfg.BlackHole,function(e) Cfg.BlackHole=e; ABH() end)
TOG(TabContent[4],"EnergySword",Cfg.EnergySword,function(e) Cfg.EnergySword=e; AES() end)
TOG(TabContent[4],"Fireflies",Cfg.Fireflies,function(e) Cfg.Fireflies=e; AFF() end)
TOG(TabContent[4],"TargetAura",Cfg.TargetAura,function(e) Cfg.TargetAura=e; ATA() end)

SEC(TabContent[5],"Sec_Stats")
TOG(TabContent[5],"ShowStats",Cfg.ShowStats,function(e) Cfg.ShowStats=e; StatsGui.Visible=e end)
SEC(TabContent[5],"Sec_Config")
BTN(TabContent[5],"SaveConfig",function() task.spawn(SaveCfg) end)
BTN(TabContent[5],"LoadConfig",function() LoadCfg() end)
SEC(TabContent[5],"Sec_GuiImg")
local imgRow=Instance.new("Frame"); imgRow.Size=UDim2.new(1,-4,0,36); imgRow.BackgroundColor3=cd; imgRow.BorderSizePixel=0; imgRow.Parent=TabContent[5]; local imgRC=Instance.new("UICorner"); imgRC.CornerRadius=UDim.new(0,8); imgRC.Parent=imgRow
local imgIn=Instance.new("TextBox"); imgIn.Size=UDim2.new(1,-20,1,-8); imgIn.Position=UDim2.new(0,10,0,4); imgIn.BackgroundColor3=ip; imgIn.BorderSizePixel=0; imgIn.Text=Cfg.CustomImgID; imgIn.TextColor3=rlt; imgIn.Font=Enum.Font.GothamBold; imgIn.TextSize=12; imgIn.ClearTextOnFocus=false; imgIn.PlaceholderText=T("ImgPH"); imgIn.Parent=imgRow; local imgInC=Instance.new("UICorner"); imgInC.CornerRadius=UDim.new(0,5); imgInC.Parent=imgIn
imgIn.FocusLost:Connect(function() local v=tostring(imgIn.Text); Cfg.CustomImgID=v; BImg.Image="rbxassetid://"..v; task.spawn(SaveCfg) end)
SEC(TabContent[5],"Sec_GuiQuick")
TOG(TabContent[5],"QuickPanel",Cfg.QuickPanel,function(e) Cfg.QuickPanel=e end)
SEC(TabContent[5],"Sec_GuiColor")
local acRow=Instance.new("Frame"); acRow.Size=UDim2.new(1,-4,0,42); acRow.BackgroundColor3=cd; acRow.BorderSizePixel=0; acRow.Parent=TabContent[5]; local acRC=Instance.new("UICorner"); acRC.CornerRadius=UDim.new(0,8); acRC.Parent=acRow
local acP={{N="Red",C=Accents.Red.Main},{N="Blue",C=Accents.Blue.Main},{N="Green",C=Accents.Green.Main},{N="Purple",C=Accents.Purple.Main},{N="Orange",C=Accents.Orange.Main},{N="Cyan",C=Accents.Cyan.Main}}
for i,a in ipairs(acP) do local cb=Instance.new("TextButton"); cb.Size=UDim2.new(0,38,0,26); cb.Position=UDim2.new(0,8+(i-1)*42,0,8); cb.BackgroundColor3=a.C; cb.BorderSizePixel=0; cb.Text=""; cb.Parent=acRow; local cbc=Instance.new("UICorner"); cbc.CornerRadius=UDim.new(0,6); cbc.Parent=cb; cb.MouseButton1Click:Connect(function() Cfg.Accent=a.N; local ac2=Accents[a.N]; for _,r in ipairs(AccentRefs) do if r.O and r.O.Parent then if r.K=="main" then r.O[r.P]=ac2.Main elseif r.K=="dark" then r.O[r.P]=ac2.Dark elseif r.K=="state" then r.O[r.P]=r.S and ac2.Main or mu end end end; MFS.Color=ac2.Main; SBS.Color=ac2.Main; UL.BackgroundColor3=ac2.Main; TB.BackgroundColor3=ac2.Dark; TBCov.BackgroundColor3=ac2.Dark; task.spawn(SaveCfg) end) end
SEC(TabContent[5],"Sec_GuiSize")
local szRow=Instance.new("Frame"); szRow.Size=UDim2.new(1,-4,0,36); szRow.BackgroundColor3=cd; szRow.BorderSizePixel=0; szRow.Parent=TabContent[5]; local szRC=Instance.new("UICorner"); szRC.CornerRadius=UDim.new(0,8); szRC.Parent=szRow
local szs={{N="S",S=0.8},{N="M",S=1.0},{N="L",S=1.2}}
for i,s in ipairs(szs) do local cb=Instance.new("TextButton"); cb.Size=UDim2.new(0,60,0,26); cb.Position=UDim2.new(0,8+(i-1)*65,0,5); cb.BackgroundColor3=Cfg.GuiScale==s.S and rdk or mu; cb.BorderSizePixel=0; cb.Text=s.N; cb.TextColor3=Color3.fromRGB(255,255,255); cb.Font=Enum.Font.GothamBold; cb.TextSize=11; cb.Parent=szRow; local cbc=Instance.new("UICorner"); cbc.CornerRadius=UDim.new(0,5); cbc.Parent=cb; cb.MouseButton1Click:Connect(function() Cfg.GuiScale=s.S; AGS(); for j,b in ipairs(szRow:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3=b==cb and rdk or mu end end; task.spawn(SaveCfg) end) end
SEC(TabContent[5],"Sec_GuiLang")
local lgRow=Instance.new("Frame"); lgRow.Size=UDim2.new(1,-4,0,36); lgRow.BackgroundColor3=cd; lgRow.BorderSizePixel=0; lgRow.Parent=TabContent[5]; local lgRC=Instance.new("UICorner"); lgRC.CornerRadius=UDim.new(0,8); lgRC.Parent=lgRow
local lgL={{C="EN",L="English"},{C="UA",L="Українська"},{C="RU",L="Русский"}}
for i,l in ipairs(lgL) do local cb=Instance.new("TextButton"); cb.Size=UDim2.new(0,85,0,26); cb.Position=UDim2.new(0,8+(i-1)*90,0,5); cb.BackgroundColor3=l.C==Cfg.Lang and rdk or mu; cb.BorderSizePixel=0; cb.Text=l.L; cb.TextColor3=Color3.fromRGB(255,255,255); cb.Font=Enum.Font.GothamBold; cb.TextSize=10; cb.Parent=lgRow; local cbc=Instance.new("UICorner"); cbc.CornerRadius=UDim.new(0,5); cbc.Parent=cb; cb.MouseButton1Click:Connect(function() Cfg.Lang=l.C; for k,el in pairs(i18nRefs) do if el and el.Parent then el.Text=T(k) end end; for j,b in ipairs(lgRow:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3=b==cb and rdk or mu end end; task.spawn(SaveCfg) end) end
SEC(TabContent[5],"Sec_Actions")
BTN(TabContent[5],"BringAll",function() ABring() end)
BTN(TabContent[5],"Rejoin",function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end)
BTN(TabContent[5],"Reset",function() local _,h=GC(); if h then h.Health=0 end end)
SEC(TabContent[5],"Sec_Gravity")
TOGV(TabContent[5],"Gravity",false,Cfg.Gravity,function(_,v) Cfg.Gravity=v; AGrav() end)
SEC(TabContent[5],"Sec_Info")
BTN(TabContent[5],"CopyJob",function() pcall(function() setclipboard(game.JobId) end) end)
BTN(TabContent[5],"ServerInfo",function() end)
SEC(TabContent[5],"Sec_Visual")
TOG(TabContent[5],"Rainbow",Cfg.Rainbow,function(e) Cfg.Rainbow=e; ARB() end)
TOG(TabContent[5],"Aura",Cfg.Aura,function(e) Cfg.Aura=e; AAur() end)
TOG(TabContent[5],"Invisible",Cfg.Invisible,function(e) Cfg.Invisible=e; AInv(e) end)

local PL=Instance.new("ScrollingFrame"); PL.Size=UDim2.new(1,-4,0,180); PL.BackgroundColor3=Color3.fromRGB(8,8,12); PL.BorderSizePixel=0; PL.ScrollBarThickness=3; PL.ScrollBarImageColor3=rd; PL.CanvasSize=UDim2.new(0,0,0,0); PL.AutomaticCanvasSize=Enum.AutomaticSize.Y; PL.Parent=TabContent[5]
local PLC=Instance.new("UICorner"); PLC.CornerRadius=UDim.new(0,8); PLC.Parent=PL
local PLL=Instance.new("UIListLayout"); PLL.Padding=UDim.new(0,3); PLL.SortOrder=Enum.SortOrder.LayoutOrder; PLL.Parent=PL
local PLP=Instance.new("UIPadding"); PLP.PaddingTop=UDim.new(0,4); PLP.PaddingLeft=UDim.new(0,4); PLP.PaddingRight=UDim.new(0,4); PLP.Parent=PL
local function UPL() for _,ch in ipairs(PL:GetChildren()) do if ch:IsA("Frame") then ch:Destroy() end end; for _,pl in ipairs(Players:GetPlayers()) do if pl~=LP then local r=Instance.new("Frame"); r.Size=UDim2.new(1,0,0,44); r.BackgroundColor3=cd; r.BorderSizePixel=0; r.Parent=PL; local rc=Instance.new("UICorner"); rc.CornerRadius=UDim.new(0,7); rc.Parent=r; local n=Instance.new("TextLabel"); n.Size=UDim2.new(1,-6,0,18); n.Position=UDim2.new(0,6,0,2); n.BackgroundTransparency=1; n.Text=pl.Name; n.TextColor3=tx; n.Font=Enum.Font.GothamBold; n.TextSize=11; n.TextXAlignment=Enum.TextXAlignment.Left; n.TextTruncate=Enum.TextTruncate.AtEnd; n.Parent=r; local tp=Instance.new("TextButton"); tp.Size=UDim2.new(0,60,0,20); tp.Position=UDim2.new(0,4,0,21); tp.BackgroundColor3=rdk; tp.BorderSizePixel=0; tp.Text=T("TP"); tp.TextColor3=Color3.fromRGB(255,255,255); tp.Font=Enum.Font.GothamBold; tp.TextSize=10; tp.Parent=r; local tpc=Instance.new("UICorner"); tpc.CornerRadius=UDim.new(0,5); tpc.Parent=tp; local fl=Instance.new("TextButton"); fl.Size=UDim2.new(0,60,0,20); fl.Position=UDim2.new(0,68,0,21); fl.BackgroundColor3=rd; fl.BorderSizePixel=0; fl.Text=T("Fling"); fl.TextColor3=Color3.fromRGB(255,255,255); fl.Font=Enum.Font.GothamBold; fl.TextSize=10; fl.Parent=r; local flc=Instance.new("UICorner"); flc.CornerRadius=UDim.new(0,5); flc.Parent=fl; tp.MouseButton1Click:Connect(function() local c=LP.Character; local tc=pl.Character; if c and tc then local h=c:FindFirstChild("HumanoidRootPart"); local th=tc:FindFirstChild("HumanoidRootPart"); if h and th then h.CFrame=th.CFrame+Vector3.new(0,3,0) end end end); fl.MouseButton1Click:Connect(function() FL(pl,fl) end) end end end
Players.PlayerAdded:Connect(UPL); Players.PlayerRemoving:Connect(function(p) if EspData[p] then local d=EspData[p]; if d.H then d.H:Destroy() end; if d.B then d.B:Destroy() end; EspData[p]=nil end; if BoxData[p] and BoxData[p].Parent then BoxData[p]:Destroy(); BoxData[p]=nil end; if TracerLines.L and TracerLines.L[p] then TracerLines.L[p]:Destroy(); TracerLines.L[p]=nil end; if HitboxViewData[p] then local h=HitboxViewData[p]; if h.B then h.B:Destroy() end; if h.L then h.L:Destroy() end; HitboxViewData[p]=nil end; UPL() end); UPL()

LP.CharacterAdded:Connect(function() task.wait(0.3); if Cfg.Fly then StartFly() end; if Cfg.Speed then ASpeed() end; if Cfg.Jump then AJump() end; if Cfg.Noclip then ANoclip() end; if Cfg.AntiFling then AAF() end; if Cfg.Aimbot then AAim() end; if Cfg.InfJump then AInfJump() end; if Cfg.BHop then ABHop() end; if Cfg.AntiVoid then AAVoid() end; if Cfg.Trail then ATrail() end; if Cfg.TrailRainbow then ATRB() end; if Cfg.Particles then APart() end; if Cfg.Orbit then AOrbit() end; if Cfg.SelfOutline then AOutline() end; if Cfg.Ring then ARing() end; if Cfg.Halo then AHalo() end; if Cfg.Wings then AWings() end; if Cfg.AuraSphere then AAuraSph() end; if Cfg.Lightning then ALightning() end; if Cfg.Fire then AFire() end; if Cfg.Snow then ASnow() end; if Cfg.Confetti then AConf() end; if Cfg.Hearts then AHeart() end; if Cfg.Bubbles then ABub() end; if Cfg.Stars then AStar() end; if Cfg.Starfall then AStarfall() end; if Cfg.BlackHole then ABH() end; if Cfg.EnergySword then AES() end; if Cfg.Fireflies then AFF() end; if Cfg.TargetAura then ATA() end end)

local function OpenM() MF.Visible=true; FC.Visible=false end
local function CloseM() task.spawn(SaveCfg); MF.Visible=false; FC.Visible=true end
HideBtn.MouseButton1Click:Connect(CloseM)
ShowBtn.MouseButton1Click:Connect(function() if not ShowBtn.Visible then return end; OpenM() end)
OpenM()
print("[Raze Hub v47] Loaded Successfully!")
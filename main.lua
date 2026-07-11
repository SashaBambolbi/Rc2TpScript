local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local isOpen = false
local page = 1
local points = {}
local binds = {}
local H = game:GetService("HttpService")

-- ============================================
-- СОХРАНЕНИЕ В ФАЙЛ (Arceus X)
-- ============================================
local function getConfigPath()
    local username = player.Name
    local path = "/sdcard/Arceus X/TeleportPoints/" .. username .. ".json"
    return path
end

local function load()
    local path = getConfigPath()
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(path))
    end)
    
    if success and data then
        points = data.points or {}
        binds = data.binds or {}
    else
        points = {}
        binds = {}
    end
end

local function save()
    local data = {
        points = points,
        binds = binds
    }
    local json = H:JSONEncode(data)
    local path = getConfigPath()
    pcall(function()
        writefile(path, json)
    end)
end

-- ============================================
-- ОСТАЛЬНОЙ КОД (без изменений)
-- ============================================
local function addPoint(n)
    local p = root.Position
    points[n] = {
        X = math.floor(p.X * 10) / 10,
        Y = math.floor(p.Y * 10) / 10,
        Z = math.floor(p.Z * 10) / 10
    }
    save()
    update()
end

local function tp(n)
    local d = points[n]
    if d then
        root.CFrame = CFrame.new(Vector3.new(d.X, d.Y, d.Z) + Vector3.new(0, 3, 0))
    end
end

local keys = {
    [Enum.KeyCode.One] = "1", [Enum.KeyCode.Two] = "2", [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4", [Enum.KeyCode.Five] = "5", [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7", [Enum.KeyCode.Eight] = "8", [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.Q] = "Q", [Enum.KeyCode.E] = "E", [Enum.KeyCode.R] = "R",
    [Enum.KeyCode.T] = "T", [Enum.KeyCode.Y] = "Y", [Enum.KeyCode.U] = "U",
    [Enum.KeyCode.I] = "I", [Enum.KeyCode.O] = "O", [Enum.KeyCode.P] = "P",
    [Enum.KeyCode.A] = "A", [Enum.KeyCode.S] = "S", [Enum.KeyCode.D] = "D",
    [Enum.KeyCode.F] = "F", [Enum.KeyCode.G] = "G", [Enum.KeyCode.H] = "H",
    [Enum.KeyCode.J] = "J", [Enum.KeyCode.K] = "K", [Enum.KeyCode.L] = "L",
    [Enum.KeyCode.Z] = "Z", [Enum.KeyCode.X] = "X", [Enum.KeyCode.C] = "C",
    [Enum.KeyCode.V] = "V", [Enum.KeyCode.B] = "B", [Enum.KeyCode.N] = "N",
    [Enum.KeyCode.M] = "M",
}

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if g then return end
    local k = i.KeyCode
    for n, b in pairs(binds) do
        if k == b then tp(n) end
    end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "TP"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 500)
main.Position = UDim2.new(0.5, -175, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(80, 80, 120)
main.Visible = false
main.Parent = gui

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = main

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, 0, 0, 45)
t.Text = "📌 ТОЧКИ"
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
t.BackgroundTransparency = 0.5
t.Font = Enum.Font.GothamBold
t.TextSize = 20
t.Parent = main

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0, 12)
tc.Parent = t

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -45, 0, 5)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.BackgroundTransparency = 1
close.Font = Enum.Font.GothamBold
close.TextSize = 22
close.Parent = main
close.MouseButton1Click:Connect(function()
    main.Visible = false
    isOpen = false
end)

local pb = Instance.new("Frame")
pb.Size = UDim2.new(1, 0, 0, 35)
pb.Position = UDim2.new(0, 0, 0, 45)
pb.BackgroundTransparency = 1
pb.Parent = main

local p1 = Instance.new("TextButton")
p1.Size = UDim2.new(0.5, -5, 1, 0)
p1.Text = "📍 ТОЧКИ"
p1.TextColor3 = Color3.fromRGB(255, 255, 255)
p1.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
p1.BorderSizePixel = 0
p1.Font = Enum.Font.GothamBold
p1.TextSize = 13
p1.Parent = pb

local p1c = Instance.new("UICorner")
p1c.CornerRadius = UDim.new(0, 6)
p1c.Parent = p1

local p2 = Instance.new("TextButton")
p2.Size = UDim2.new(0.5, -5, 1, 0)
p2.Position = UDim2.new(0.5, 5, 0, 0)
p2.Text = "⚙️ КОНФИГ"
p2.TextColor3 = Color3.fromRGB(200, 200, 200)
p2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
p2.BorderSizePixel = 0
p2.Font = Enum.Font.GothamBold
p2.TextSize = 13
p2.Parent = pb

local p2c = Instance.new("UICorner")
p2c.CornerRadius = UDim.new(0, 6)
p2c.Parent = p2

local cont = Instance.new("ScrollingFrame")
cont.Size = UDim2.new(1, -10, 1, -135)
cont.Position = UDim2.new(0, 5, 0, 80)
cont.BackgroundTransparency = 1
cont.CanvasSize = UDim2.new(0, 0, 0, 0)
cont.ScrollBarThickness = 5
cont.Parent = main

local y = 0

function update()
    for _, c in pairs(cont:GetChildren()) do c:Destroy() end
    y = 0
    if page == 1 then
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -10, 0, 35)
        b.Position = UDim2.new(0, 5, 0, y)
        b.Text = "💾 СОХРАНИТЬ"
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        b.BorderSizePixel = 0
        b.Font = Enum.Font.GothamBold
        b.TextSize = 13
        b.Parent = cont
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 6)
        bc.Parent = b
        b.MouseButton1Click:Connect(function()
            addPoint("Точка_" .. (#points + 1))
        end)
        y = y + 42
        local ib = Instance.new("TextBox")
        ib.Size = UDim2.new(0.65, -5, 0, 32)
        ib.Position = UDim2.new(0, 5, 0, y)
        ib.PlaceholderText = "Название..."
        ib.TextColor3 = Color3.fromRGB(255, 255, 255)
        ib.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        ib.BorderSizePixel = 1
        ib.BorderColor3 = Color3.fromRGB(60, 60, 80)
        ib.Font = Enum.Font.Gotham
        ib.TextSize = 13
        ib.Parent = cont
        local ibc = Instance.new("UICorner")
        ibc.CornerRadius = UDim.new(0, 6)
        ibc.Parent = ib
        local sb = Instance.new("TextButton")
        sb.Size = UDim2.new(0.3, -5, 0, 32)
        sb.Position = UDim2.new(0.68, 0, 0, y)
        sb.Text = "✅ СОХР"
        sb.TextColor3 = Color3.fromRGB(255, 255, 255)
        sb.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
        sb.BorderSizePixel = 0
        sb.Font = Enum.Font.GothamBold
        sb.TextSize = 11
        sb.Parent = cont
        local sbc = Instance.new("UICorner")
        sbc.CornerRadius = UDim.new(0, 6)
        sbc.Parent = sb
        sb.MouseButton1Click:Connect(function()
            local n = ib.Text
            if n ~= "" then addPoint(n) ib.Text = "" end
        end)
        y = y + 40 + 5
        if next(points) then
            for n, d in pairs(points) do
                local b2 = Instance.new("TextButton")
                b2.Size = UDim2.new(0.45, -5, 0, 32)
                b2.Position = UDim2.new(0, 5, 0, y)
                b2.Text = "📍 " .. n
                b2.TextColor3 = Color3.fromRGB(255, 255, 255)
                b2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                b2.BorderSizePixel = 1
                b2.BorderColor3 = Color3.fromRGB(50, 50, 70)
                b2.Font = Enum.Font.Gotham
                b2.TextSize = 12
                b2.TextXAlignment = Enum.TextXAlignment.Left
                b2.Parent = cont
                local b2c = Instance.new("UICorner")
                b2c.CornerRadius = UDim.new(0, 6)
                b2c.Parent = b2
                b2.MouseButton1Click:Connect(function() tp(n) end)
                local kb = Instance.new("TextButton")
                kb.Size = UDim2.new(0.2, -5, 0, 32)
                kb.Position = UDim2.new(0.48, 0, 0, y)
                local ck = binds[n]
                kb.Text = ck and keys[ck] or "🔑"
                kb.TextColor3 = Color3.fromRGB(255, 255, 255)
                kb.BackgroundColor3 = ck and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(40, 40, 60)
                kb.BorderSizePixel = 1
                kb.BorderColor3 = Color3.fromRGB(60, 60, 80)
                kb.Font = Enum.Font.GothamBold
                kb.TextSize = 13
                kb.Parent = cont
                local kbc = Instance.new("UICorner")
                kbc.CornerRadius = UDim.new(0, 6)
                kbc.Parent = kb
                kb.MouseButton1Click:Connect(function()
                    kb.Text = "..."
                    kb.BackgroundColor3 = Color3.fromRGB(200, 200, 60)
                    local conn
                    conn = game:GetService("UserInputService").InputBegan:Connect(function(i, g)
                        if g then return end
                        local k = i.KeyCode
                        if k and k ~= Enum.KeyCode.Unknown then
                            for n2, k2 in pairs(binds) do if k2 == k then binds[n2] = nil end end
                            binds[n] = k
                            save()
                            conn:Disconnect()
                            update()
                        end
                    end)
                    task.delay(5, function() if conn then conn:Disconnect() update() end end)
                end)
                local db = Instance.new("TextButton")
                db.Size = UDim2.new(0.15, -5, 0, 32)
                db.Position = UDim2.new(0.83, 0, 0, y)
                db.Text = "✕"
                db.TextColor3 = Color3.fromRGB(255, 80, 80)
                db.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
                db.BorderSizePixel = 1
                db.BorderColor3 = Color3.fromRGB(60, 30, 30)
                db.Font = Enum.Font.GothamBold
                db.TextSize = 15
                db.Parent = cont
                local dbc = Instance.new("UICorner")
                dbc.CornerRadius = UDim.new(0, 6)
                dbc.Parent = db
                db.MouseButton1Click:Connect(function()
                    points[n] = nil
                    binds[n] = nil
                    save()
                    update()
                end)
                y = y + 38
            end
            y = y + 5
            local cl = Instance.new("TextButton")
            cl.Size = UDim2.new(1, -10, 0, 32)
            cl.Position = UDim2.new(0, 5, 0, y)
            cl.Text = "🗑️ ОЧИСТИТЬ ВСЁ"
            cl.TextColor3 = Color3.fromRGB(255, 255, 255)
            cl.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
            cl.BorderSizePixel = 0
            cl.Font = Enum.Font.GothamBold
            cl.TextSize = 13
            cl.Parent = cont
            local clc = Instance.new("UICorner")
            clc.CornerRadius = UDim.new(0, 6)
            clc.Parent = cl
            cl.MouseButton1Click:Connect(function()
                points = {}
                binds = {}
                save()
                update()
            end)
            y = y + 40
        else
            local em = Instance.new("TextLabel")
            em.Size = UDim2.new(1, 0, 0, 35)
            em.Position = UDim2.new(0, 0, 0, y)
            em.Text = "Нет точек"
            em.TextColor3 = Color3.fromRGB(150, 150, 170)
            em.BackgroundTransparency = 1
            em.Font = Enum.Font.Gotham
            em.TextSize = 14
            em.Parent = cont
            y = y + 42
        end
    else
        local t2 = Instance.new("TextLabel")
        t2.Size = UDim2.new(1, 0, 0, 35)
        t2.Position = UDim2.new(0, 0, 0, y)
        t2.Text = "⚙️ КОНФИГ"
        t2.TextColor3 = Color3.fromRGB(255, 255, 255)
        t2.BackgroundTransparency = 1
        t2.Font = Enum.Font.GothamBold
        t2.TextSize = 15
        t2.Parent = cont
        y = y + 40
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, 0, 0, 40)
        info.Position = UDim2.new(0, 0, 0, y)
        info.Text = "📁 Путь: /sdcard/Arceus X/TeleportPoints/"
        info.TextColor3 = Color3.fromRGB(150, 150, 170)
        info.BackgroundTransparency = 1
        info.Font = Enum.Font.Gotham
        info.TextSize = 12
        info.Parent = cont
        y = y + 45
        
        local sb2 = Instance.new("TextButton")
        sb2.Size = UDim2.new(1, -10, 0, 40)
        sb2.Position = UDim2.new(0, 5, 0, y)
        sb2.Text = "💾 СОХРАНИТЬ КОНФИГ"
        sb2.TextColor3 = Color3.fromRGB(255, 255, 255)
        sb2.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        sb2.BorderSizePixel = 0
        sb2.Font = Enum.Font.GothamBold
        sb2.TextSize = 14
        sb2.Parent = cont
        local sb2c = Instance.new("UICorner")
        sb2c.CornerRadius = UDim.new(0, 6)
        sb2c.Parent = sb2
        sb2.MouseButton1Click:Connect(save)
        y = y + 48
        
        local lb = Instance.new("TextButton")
        lb.Size = UDim2.new(1, -10, 0, 40)
        lb.Position = UDim2.new(0, 5, 0, y)
        lb.Text = "📂 ЗАГРУЗИТЬ КОНФИГ"
        lb.TextColor3 = Color3.fromRGB(255, 255, 255)
        lb.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
        lb.BorderSizePixel = 0
        lb.Font = Enum.Font.GothamBold
        lb.TextSize = 14
        lb.Parent = cont
        local lbc = Instance.new("UICorner")
        lbc.CornerRadius = UDim.new(0, 6)
        lbc.Parent = lb
        lb.MouseButton1Click:Connect(function() load() update() end)
        y = y + 48
        
        local pathBtn = Instance.new("TextButton")
        pathBtn.Size = UDim2.new(1, -10, 0, 35)
        pathBtn.Position = UDim2.new(0, 5, 0, y)
        pathBtn.Text = "📋 ПОКАЗАТЬ ПУТЬ"
        pathBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pathBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        pathBtn.BorderSizePixel = 0
        pathBtn.Font = Enum.Font.Gotham
        pathBtn.TextSize = 13
        pathBtn.Parent = cont
        local pathCorner = Instance.new("UICorner")
        pathCorner.CornerRadius = UDim.new(0, 6)
        pathCorner.Parent = pathBtn
        pathBtn.MouseButton1Click:Connect(function()
            info.Text = "📁 " .. getConfigPath()
            task.wait(2)
            info.Text = "📁 /sdcard/Arceus X/TeleportPoints/"
        end)
        y = y + 43
    end
    cont.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

p1.MouseButton1Click:Connect(function()
    page = 1
    p1.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    p1.TextColor3 = Color3.fromRGB(255, 255, 255)
    p2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p2.TextColor3 = Color3.fromRGB(200, 200, 200)
    update()
end)

p2.MouseButton1Click:Connect(function()
    page = 2
    p2.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    p2.TextColor3 = Color3.fromRGB(255, 255, 255)
    p1.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p1.TextColor3 = Color3.fromRGB(200, 200, 200)
    update()
end)

local open = Instance.new("ImageButton")
open.Size = UDim2.new(0, 50, 0, 50)
open.Position = UDim2.new(0, 15, 0, 100)
open.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
open.BackgroundTransparency = 0.2
open.BorderSizePixel = 1
open.BorderColor3 = Color3.fromRGB(80, 80, 100)
open.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(0, 10)
oc.Parent = open

local ic = Instance.new("TextLabel")
ic.Size = UDim2.new(1, 0, 1, 0)
ic.Text = "📌"
ic.TextColor3 = Color3.fromRGB(255, 255, 255)
ic.BackgroundTransparency = 1
ic.Font = Enum.Font.GothamBold
ic.TextSize = 26
ic.Parent = open

local phone = Instance.new("ImageButton")
phone.Size = UDim2.new(0, 60, 0, 60)
phone.Position = UDim2.new(0.5, -30, 1, -80)
phone.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
phone.BackgroundTransparency = 0.3
phone.BorderSizePixel = 2
phone.BorderColor3 = Color3.fromRGB(80, 80, 120)
phone.Parent = gui
phone.ZIndex = 10

local phc = Instance.new("UICorner")
phc.CornerRadius = UDim.new(0, 14)
phc.Parent = phone

local phi = Instance.new("TextLabel")
phi.Size = UDim2.new(1, 0, 1, 0)
phi.Text = "📍"
phi.TextColor3 = Color3.fromRGB(255, 255, 255)
phi.BackgroundTransparency = 1
phi.Font = Enum.Font.GothamBold
phi.TextSize = 32
phi.Parent = phone

phone.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    main.Visible = isOpen
    if isOpen then load() update() end
end)

local drag = false
local ds = nil
local sp = nil

open.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        ds = i.Position
        sp = open.Position
    end
end)

open.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - ds
        open.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

open.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
    end
end)

open.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    main.Visible = isOpen
    if isOpen then load() update() end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.P then
        isOpen = not isOpen
        main.Visible = isOpen
        if isOpen then load() update() end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.S and i.KeyCode == Enum.KeyCode.LeftControl then
        addPoint("Точка_" .. (#points + 1))
    end
end)

load()
update()

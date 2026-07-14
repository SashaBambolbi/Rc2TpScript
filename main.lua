local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local isOpen = false
local page = 1
local binds = {}
local savedPoints = {}

local points = {
    ["База 1"] = {X = 1565.7, Y = 30, Z = -525},
    ["База 2"] = {X = 963.3, Y = 63.8, Z = -198.6},
    ["База 3"] = {X = 1978.9, Y = 3.1, Z = -955.6},
    ["База 8"] = {X = 53.9, Y = 63.8, Z = -469.8},
    ["Вис Логик"] = {X = -5136.2, Y = 59.6, Z = -2813.8},
    ["Продажа"] = {X = 925.7, Y = 29.8, Z = -701.8},
    ["Пещера Клауд"] = {X = -7216.6, Y = 755, Z = -2959.9},
    ["Костер Клауд"] = {X = -7241.5, Y = 761, Z = -3245.4},
    ["Кристалы Моря 1"] = {X = -7553, Y = -636.6, Z = 1278.8},
    ["Кристалы Моря 2"] = {X = -7357.2, Y = -638.8, Z = 994.5},
    ["Кристалы"] = {X = -6611.5, Y = -593.1, Z = 859},
    ["Блюмун"] = {X = -6398.3, Y = 256.9, Z = 5130},
    ["Замок"] = {X = -3839, Y = -1509.8, Z = 4055.9},
    ["Одити 1"] = {X = -5417.3, Y = -172.7, Z = 5268.9},
    ["Одити 2"] = {X = -5699.9, Y = -178.7, Z = 5385.7},
}

local meteors = {
    ["Метеор Сакура"] = {X = -5023, Y = 180.1, Z = 5197.5},
    ["Метеор Гора"] = {X = -7459.1, Y = 761, Z = -3306.7},
    ["Метеор Джунгли"] = {X = 737.1, Y = 150.6, Z = 2875.7},
    ["Магазин метеорита"] = {X = -6151.8, Y = 12.1, Z = -1948.2},
}

local keyNames = {
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

local function tp(n)
    local d = points[n]
    if d then
        root.CFrame = CFrame.new(Vector3.new(d.X, d.Y, d.Z) + Vector3.new(0, 3, 0))
    end
end

local function tpMeteor(n)
    local d = meteors[n]
    if d then
        root.CFrame = CFrame.new(Vector3.new(d.X, d.Y, d.Z) + Vector3.new(0, 3, 0))
    end
end

local function tpSaved(n)
    local d = savedPoints[n]
    if d then
        root.CFrame = CFrame.new(Vector3.new(d.X, d.Y, d.Z) + Vector3.new(0, 3, 0))
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if g then return end
    local k = i.KeyCode
    for n, b in pairs(binds) do
        if k == b then
            if points[n] then
                tp(n)
            elseif meteors[n] then
                tpMeteor(n)
            elseif savedPoints[n] then
                tpSaved(n)
            end
        end
    end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "TP"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 500)
main.Position = UDim2.new(0.5, -160, 0.5, -250)
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
t.Position = UDim2.new(0, 0, 0, 0)
t.Text = "📍 ТЕЛЕПОРТЫ"
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
p1.Size = UDim2.new(0.33, -5, 1, 0)
p1.Text = "🏠 БАЗЫ"
p1.TextColor3 = Color3.fromRGB(255, 255, 255)
p1.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
p1.BorderSizePixel = 0
p1.Font = Enum.Font.GothamBold
p1.TextSize = 12
p1.Parent = pb

local p1c = Instance.new("UICorner")
p1c.CornerRadius = UDim.new(0, 6)
p1c.Parent = p1

local p2 = Instance.new("TextButton")
p2.Size = UDim2.new(0.33, -5, 1, 0)
p2.Position = UDim2.new(0.34, 0, 0, 0)
p2.Text = "☄️ МЕТЕОРЫ"
p2.TextColor3 = Color3.fromRGB(200, 200, 200)
p2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
p2.BorderSizePixel = 0
p2.Font = Enum.Font.GothamBold
p2.TextSize = 12
p2.Parent = pb

local p2c = Instance.new("UICorner")
p2c.CornerRadius = UDim.new(0, 6)
p2c.Parent = p2

local p3 = Instance.new("TextButton")
p3.Size = UDim2.new(0.33, -5, 1, 0)
p3.Position = UDim2.new(0.67, 5, 0, 0)
p3.Text = "⭐ ВСЁ"
p3.TextColor3 = Color3.fromRGB(200, 200, 200)
p3.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
p3.BorderSizePixel = 0
p3.Font = Enum.Font.GothamBold
p3.TextSize = 12
p3.Parent = pb

local p3c = Instance.new("UICorner")
p3c.CornerRadius = UDim.new(0, 6)
p3c.Parent = p3

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
        local colors = {
            Color3.fromRGB(60, 200, 60),
            Color3.fromRGB(70, 130, 200),
            Color3.fromRGB(200, 150, 60),
            Color3.fromRGB(200, 60, 200),
            Color3.fromRGB(60, 200, 200),
            Color3.fromRGB(200, 100, 60),
            Color3.fromRGB(150, 100, 200),
            Color3.fromRGB(200, 60, 100),
            Color3.fromRGB(60, 180, 200),
            Color3.fromRGB(100, 150, 255),
            Color3.fromRGB(150, 255, 100),
            Color3.fromRGB(200, 200, 60),
            Color3.fromRGB(200, 100, 150),
            Color3.fromRGB(255, 150, 100),
            Color3.fromRGB(150, 100, 255),
        }
        
        local i = 0
        for n, d in pairs(points) do
            i = i + 1
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 40)
            frame.Position = UDim2.new(0, 5, 0, y)
            frame.BackgroundTransparency = 1
            frame.Parent = cont
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.7, -5, 1, 0)
            btn.Position = UDim2.new(0, 0, 0, 0)
            btn.Text = n
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundColor3 = colors[(i-1) % #colors + 1]
            btn.BackgroundTransparency = 0.2
            btn.BorderSizePixel = 1
            btn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 13
            btn.Parent = frame
            local btnc = Instance.new("UICorner")
            btnc.CornerRadius = UDim.new(0, 6)
            btnc.Parent = btn
            btn.MouseButton1Click:Connect(function()
                tp(n)
            end)
            
            local bindBtn = Instance.new("TextButton")
            bindBtn.Size = UDim2.new(0.25, -5, 1, 0)
            bindBtn.Position = UDim2.new(0.73, 0, 0, 0)
            local currentKey = binds[n]
            bindBtn.Text = currentKey and keyNames[currentKey] or "🔑"
            bindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            bindBtn.BackgroundColor3 = currentKey and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(40, 40, 60)
            bindBtn.BorderSizePixel = 1
            bindBtn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            bindBtn.Font = Enum.Font.GothamBold
            bindBtn.TextSize = 13
            bindBtn.Parent = frame
            local bindc = Instance.new("UICorner")
            bindc.CornerRadius = UDim.new(0, 6)
            bindc.Parent = bindBtn
            
            bindBtn.MouseButton1Click:Connect(function()
                bindBtn.Text = "..."
                bindBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 60)
                local conn
                conn = game:GetService("UserInputService").InputBegan:Connect(function(i, g)
                    if g then return end
                    local k = i.KeyCode
                    if k and k ~= Enum.KeyCode.Unknown then
                        for n2, k2 in pairs(binds) do
                            if k2 == k then binds[n2] = nil end
                        end
                        binds[n] = k
                        conn:Disconnect()
                        update()
                    end
                end)
                task.delay(5, function()
                    if conn then
                        conn:Disconnect()
                        update()
                    end
                end)
            end)
            
            y = y + 45
        end
    elseif page == 2 then
        local colors2 = {
            Color3.fromRGB(200, 100, 60),
            Color3.fromRGB(200, 60, 200),
            Color3.fromRGB(60, 180, 200),
            Color3.fromRGB(200, 200, 60),
            Color3.fromRGB(60, 200, 150),
        }
        
        local i = 0
        for n, d in pairs(meteors) do
            i = i + 1
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 40)
            frame.Position = UDim2.new(0, 5, 0, y)
            frame.BackgroundTransparency = 1
            frame.Parent = cont
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.7, -5, 1, 0)
            btn.Position = UDim2.new(0, 0, 0, 0)
            btn.Text = "☄️ " .. n
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundColor3 = colors2[(i-1) % #colors2 + 1]
            btn.BackgroundTransparency = 0.2
            btn.BorderSizePixel = 1
            btn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 13
            btn.Parent = frame
            local btnc = Instance.new("UICorner")
            btnc.CornerRadius = UDim.new(0, 6)
            btnc.Parent = btn
            btn.MouseButton1Click:Connect(function()
                tpMeteor(n)
            end)
            
            local bindBtn = Instance.new("TextButton")
            bindBtn.Size = UDim2.new(0.25, -5, 1, 0)
            bindBtn.Position = UDim2.new(0.73, 0, 0, 0)
            local currentKey = binds["meteor_" .. n]
            bindBtn.Text = currentKey and keyNames[currentKey] or "🔑"
            bindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            bindBtn.BackgroundColor3 = currentKey and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(40, 40, 60)
            bindBtn.BorderSizePixel = 1
            bindBtn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            bindBtn.Font = Enum.Font.GothamBold
            bindBtn.TextSize = 13
            bindBtn.Parent = frame
            local bindc = Instance.new("UICorner")
            bindc.CornerRadius = UDim.new(0, 6)
            bindc.Parent = bindBtn
            
            bindBtn.MouseButton1Click:Connect(function()
                bindBtn.Text = "..."
                bindBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 60)
                local conn
                conn = game:GetService("UserInputService").InputBegan:Connect(function(i, g)
                    if g then return end
                    local k = i.KeyCode
                    if k and k ~= Enum.KeyCode.Unknown then
                        for n2, k2 in pairs(binds) do
                            if k2 == k then binds[n2] = nil end
                        end
                        binds["meteor_" .. n] = k
                        conn:Disconnect()
                        update()
                    end
                end)
                task.delay(5, function()
                    if conn then
                        conn:Disconnect()
                        update()
                    end
                end)
            end)
            
            y = y + 45
        end
    else
        local coordLabel = Instance.new("TextLabel")
        coordLabel.Size = UDim2.new(1, -10, 0, 30)
        coordLabel.Position = UDim2.new(0, 5, 0, y)
        coordLabel.Text = "📍 " .. string.format("%.1f, %.1f, %.1f", root.Position.X, root.Position.Y, root.Position.Z)
        coordLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        coordLabel.BackgroundTransparency = 1
        coordLabel.Font = Enum.Font.GothamBold
        coordLabel.TextSize = 13
        coordLabel.Parent = cont
        y = y + 35
        
        local saveBtn = Instance.new("TextButton")
        saveBtn.Size = UDim2.new(1, -10, 0, 40)
        saveBtn.Position = UDim2.new(0, 5, 0, y)
        saveBtn.Text = "💾 СОХРАНИТЬ ПОЗИЦИЮ"
        saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        saveBtn.BorderSizePixel = 0
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.TextSize = 14
        saveBtn.Parent = cont
        local savec = Instance.new("UICorner")
        savec.CornerRadius = UDim.new(0, 6)
        savec.Parent = saveBtn
        saveBtn.MouseButton1Click:Connect(function()
            local name = "Точка_" .. (#savedPoints + 1)
            local p = root.Position
            savedPoints[name] = {X = math.floor(p.X * 10) / 10, Y = math.floor(p.Y * 10) / 10, Z = math.floor(p.Z * 10) / 10}
            update()
        end)
        
        y = y + 48
        
        local inputBox = Instance.new("TextBox")
        inputBox.Size = UDim2.new(0.65, -5, 0, 32)
        inputBox.Position = UDim2.new(0, 5, 0, y)
        inputBox.PlaceholderText = "Название..."
        inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        inputBox.BorderSizePixel = 1
        inputBox.BorderColor3 = Color3.fromRGB(60, 60, 80)
        inputBox.Font = Enum.Font.Gotham
        inputBox.TextSize = 13
        inputBox.Parent = cont
        local ibc = Instance.new("UICorner")
        ibc.CornerRadius = UDim.new(0, 6)
        ibc.Parent = inputBox
        
        local saveNameBtn = Instance.new("TextButton")
        saveNameBtn.Size = UDim2.new(0.3, -5, 0, 32)
        saveNameBtn.Position = UDim2.new(0.68, 0, 0, y)
        saveNameBtn.Text = "✅ СОХР"
        saveNameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveNameBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
        saveNameBtn.BorderSizePixel = 0
        saveNameBtn.Font = Enum.Font.GothamBold
        saveNameBtn.TextSize = 11
        saveNameBtn.Parent = cont
        local snc = Instance.new("UICorner")
        snc.CornerRadius = UDim.new(0, 6)
        snc.Parent = saveNameBtn
        saveNameBtn.MouseButton1Click:Connect(function()
            local name = inputBox.Text
            if name ~= "" then
                local p = root.Position
                savedPoints[name] = {X = math.floor(p.X * 10) / 10, Y = math.floor(p.Y * 10) / 10, Z = math.floor(p.Z * 10) / 10}
                inputBox.Text = ""
                update()
            end
        end)
        
        y = y + 40
        
        local colors3 = {
            Color3.fromRGB(200, 100, 60),
            Color3.fromRGB(60, 180, 200),
            Color3.fromRGB(200, 60, 100),
            Color3.fromRGB(60, 200, 150),
        }
        
        local i = 0
        for n, d in pairs(savedPoints) do
            i = i + 1
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 40)
            frame.Position = UDim2.new(0, 5, 0, y)
            frame.BackgroundTransparency = 1
            frame.Parent = cont
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.7, -5, 1, 0)
            btn.Position = UDim2.new(0, 0, 0, 0)
            btn.Text = "⭐ " .. n
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundColor3 = colors3[(i-1) % #colors3 + 1]
            btn.BackgroundTransparency = 0.2
            btn.BorderSizePixel = 1
            btn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 13
            btn.Parent = frame
            local btnc = Instance.new("UICorner")
            btnc.CornerRadius = UDim.new(0, 6)
            btnc.Parent = btn
            btn.MouseButton1Click:Connect(function()
                tpSaved(n)
            end)
            
            local bindBtn = Instance.new("TextButton")
            bindBtn.Size = UDim2.new(0.25, -5, 1, 0)
            bindBtn.Position = UDim2.new(0.73, 0, 0, 0)
            local currentKey = binds["saved_" .. n]
            bindBtn.Text = currentKey and keyNames[currentKey] or "🔑"
            bindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            bindBtn.BackgroundColor3 = currentKey and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(40, 40, 60)
            bindBtn.BorderSizePixel = 1
            bindBtn.BorderColor3 = Color3.fromRGB(60, 60, 80)
            bindBtn.Font = Enum.Font.GothamBold
            bindBtn.TextSize = 13
            bindBtn.Parent = frame
            local bindc = Instance.new("UICorner")
            bindc.CornerRadius = UDim.new(0, 6)
            bindc.Parent = bindBtn
            
            bindBtn.MouseButton1Click:Connect(function()
                bindBtn.Text = "..."
                bindBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 60)
                local conn
                conn = game:GetService("UserInputService").InputBegan:Connect(function(i, g)
                    if g then return end
                    local k = i.KeyCode
                    if k and k ~= Enum.KeyCode.Unknown then
                        for n2, k2 in pairs(binds) do
                            if k2 == k then binds[n2] = nil end
                        end
                        binds["saved_" .. n] = k
                        conn:Disconnect()
                        update()
                    end
                end)
                task.delay(5, function()
                    if conn then
                        conn:Disconnect()
                        update()
                    end
                end)
            end)
            
            local delBtn = Instance.new("TextButton")
            delBtn.Size = UDim2.new(0.15, -5, 0, 40)
            delBtn.Position = UDim2.new(0.85, 0, 0, 0)
            delBtn.Text = "✕"
            delBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
            delBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
            delBtn.BorderSizePixel = 1
            delBtn.BorderColor3 = Color3.fromRGB(60, 30, 30)
            delBtn.Font = Enum.Font.GothamBold
            delBtn.TextSize = 15
            delBtn.Parent = frame
            local delc = Instance.new("UICorner")
            delc.CornerRadius = UDim.new(0, 6)
            delc.Parent = delBtn
            delBtn.MouseButton1Click:Connect(function()
                savedPoints[n] = nil
                binds["saved_" .. n] = nil
                update()
            end)
            
            y = y + 45
        end
    end
    
    cont.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

p1.MouseButton1Click:Connect(function()
    page = 1
    p1.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    p1.TextColor3 = Color3.fromRGB(255, 255, 255)
    p2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p2.TextColor3 = Color3.fromRGB(200, 200, 200)
    p3.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p3.TextColor3 = Color3.fromRGB(200, 200, 200)
    update()
end)

p2.MouseButton1Click:Connect(function()
    page = 2
    p2.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    p2.TextColor3 = Color3.fromRGB(255, 255, 255)
    p1.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p1.TextColor3 = Color3.fromRGB(200, 200, 200)
    p3.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p3.TextColor3 = Color3.fromRGB(200, 200, 200)
    update()
end)

p3.MouseButton1Click:Connect(function()
    page = 3
    p3.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    p3.TextColor3 = Color3.fromRGB(255, 255, 255)
    p1.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p1.TextColor3 = Color3.fromRGB(200, 200, 200)
    p2.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    p2.TextColor3 = Color3.fromRGB(200, 200, 200)
    update()
end)

local open = Instance.new("ImageButton")
open.Size = UDim2.new(0, 45, 0, 45)
open.Position = UDim2.new(0, 10, 0, 100)
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
ic.Text = "📍"
ic.TextColor3 = Color3.fromRGB(255, 255, 255)
ic.BackgroundTransparency = 1
ic.Font = Enum.Font.GothamBold
ic.TextSize = 22
ic.Parent = open

local phone = Instance.new("ImageButton")
phone.Size = UDim2.new(0, 55, 0, 55)
phone.Position = UDim2.new(0.5, -27.5, 1, -70)
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
phi.TextSize = 28
phi.Parent = phone

phone.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    main.Visible = isOpen
    if isOpen then update() end
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
    if isOpen then update() end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.P then
        isOpen = not isOpen
        main.Visible = isOpen
        if isOpen then update() end
    end
end)

update()

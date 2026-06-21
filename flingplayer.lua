local P = game:GetService("Players")
local RS = game:GetService("RunService")
local Debris = game:GetService("Debris")
local LP = P.LocalPlayer

-- Создание GUI
local g = Instance.new("ScreenGui")
g.Name = "FlingGui"
g.ResetOnSpawn = false
pcall(function() g.Parent = game:GetService("CoreGui") end)
if not g.Parent then g.Parent = LP:WaitForChild("PlayerGui", 5) end

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 180, 0, 90)
f.Position = UDim2.new(0, 20, 0.5, -45)
f.BackgroundColor3 = Color3.new(0, 0, 0)
f.BackgroundTransparency = 0.3
f.Active = true
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.BackgroundTransparency = 1
t.Text = "💥 FLING GUI"
t.TextColor3 = Color3.new(1, 1, 1)
t.TextSize = 16
t.Font = Enum.Font.GothamBold

local btn = Instance.new("TextButton", f)
btn.Size = UDim2.new(1, -20, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 40)
btn.BackgroundColor3 = Color3.new(0.7, 0, 0)
btn.Text = "FLING ALL"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 14
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

local fling = false

btn.MouseButton1Down:Connect(function()
    fling = not fling
    btn.Text = fling and "STOP" or "FLING ALL"
    btn.BackgroundColor3 = fling and Color3.new(0, 0.6, 0) or Color3.new(0.7, 0, 0)
end)

-- Логика Флинга
RS.Heartbeat:Connect(function()
    if not fling then return end
    
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    for _, plr in ipairs(P:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = plr.Character.HumanoidRootPart
            
            -- Применяем физический импульс
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            -- Случайная сильная скорость, чтобы вызвать "разнос" физики
            bv.Velocity = Vector3.new(math.random(-500, 500), 500, math.random(-500, 500))
            bv.Parent = targetHrp
            
            Debris:AddItem(bv, 0.1)
        end
    end
end)

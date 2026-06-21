local P=game:GetService("Players")
local RS=game:GetService("RunService")
local LP=P.LocalPlayer
local cam=workspace.CurrentCamera

local function add(plr)
  if plr==LP then return end
  plr.CharacterAdded:Connect(function(c)
    task.wait(1)
    local hrp=c:WaitForChild("HumanoidRootPart",5)
    if not hrp then return end
    if hrp:FindFirstChild("ESP") then hrp.ESP:Destroy() end

    local box=Instance.new("BoxHandleAdornment")
    box.Name="ESP"
    box.Adornee=hrp
    box.Size=Vector3.new(4,6,2)
    box.Color3=Color3.new(1,0,0)
    box.Transparency=0.4
    box.AlwaysOnTop=true
    box.ZIndex=10
    box.Parent=hrp

    local bb=Instance.new("BillboardGui")
    bb.Name="ESP"
    bb.Adornee=hrp
    bb.Size=Vector2.new(200,50)
    bb.StudsOffset=Vector3.new(0,3,0)
    bb.AlwaysOnTop=true
    bb.Parent=hrp

    local txt=Instance.new("TextLabel")
    txt.Size=UDim2.new(1,0,1,0)
    txt.BackgroundTransparency=1
    txt.TextColor3=Color3.new(1,0,0)
    txt.TextStrokeTransparency=0
    txt.Font=Enum.Font.GothamBold
    txt.TextScaled=true
    txt.Parent=bb

    RS.RenderStepped:Connect(function()
      if hrp.Parent and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local d=(LP.Character.HumanoidRootPart.Position-hrp.Position).Magnitude
        txt.Text=plr.Name.." ["..math.floor(d).."m]"
      end
    end)
  end)
end

for _,plr in ipairs(P:GetPlayers()) do add(plr) end
P.PlayerAdded:Connect(add)
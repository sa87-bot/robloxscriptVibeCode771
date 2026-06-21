<pre><code>local P=game:GetService("Players")
local RS=game:GetService("RunService")
local LP=P.LocalPlayer
local char=char; local hum=hum; local hrp=hrp
local function bind(c)
  char=c; hum=c:WaitForChild("Humanoid",5); hrp=c:WaitForChild("HumanoidRootPart",5)
end
bind(LP.Character or LP.CharacterAdded:Wait())
LP.CharacterAdded:Connect(bind)

-- ANTICHEAT BYPASS
local mt=getrawmetatable and getrawmetatable() or __metatable
if mt and setreadonly then pcall(setreadonly,mt,false) end
local oldnc=mt.__namecall
mt.__namecall=newcclosure(function(self,...)
  local m=getnamecallmethod()
  if m=="Kick" or m:lower():find("kick") then return nil end
  if m=="FireServer" then
    local args={...}
    for i,v in ipairs(args) do
      if typeof(v)=="string" and v:lower():find("anticheat") then args[i]=nil end
    end
    return oldnc(self,table.unpack(args))
  end
  return oldnc(self,...)
end)

-- GUI
local g=Instance.new("ScreenGui",game:GetService("CoreGui"))
g.ResetOnSpawn=false
local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,220,0,180); f.Position=UDim2.new(0,20,0,100)
f.BackgroundColor3=Color3.fromRGB(25,25,25); f.BorderSizePixel=0; f.Active=true; f.Draggable=true
local title=Instance.new("TextLabel",f)
title.Size=UDim2.new(1,0,0,30); title.BackgroundColor3=Color3.fromRGB(40,40,40)
title.Text="  Tower of Hell"; title.TextColor3=Color3.new(1,1,1); title.TextXAlignment=Enum.TextXAlignment.Left

local toggles={noclip=false,speed=false}
local function btn(text,y,cb)
  local b=Instance.new("TextButton",f)
  b.Size=UDim2.new(1,-20,0,30); b.Position=UDim2.new(0,10,0,y)
  b.BackgroundColor3=Color3.fromRGB(50,50,50); b.TextColor3=Color3.new(1,1,1)
  b.Text=text; b.Font=Enum.Font.GothamBold; b.TextSize=14; b.BorderSizePixel=0
  b.MouseButton1Click:Connect(function() cb() b.Text=text.." "..(toggles[text] and "ON" or "OFF") end)
end

-- TELEPORT TOP
local function top()
  local best,hy=nil,-math.huge
  for _,v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and v.Size.Y<10 and v.Position.Y>hy and not v:IsDescendantOf(char) then
      hy=v.Position.Y; best=v
    end
  end
  if best and hrp then hrp.CFrame=best.CFrame+Vector3.new(0,5,0) end
end

btn("Noclip",40,function() toggles.noclip=not toggles.noclip end)
btn("Speed",75,function()
  toggles.speed=not toggles.speed
  if hum then hum.WalkSpeed=toggles.speed and 120 or 16 end
end)

local tp=Instance.new("TextButton",f)
tp.Size=UDim2.new(1,-20,0,30); tp.Position=UDim2.new(0,10,0,110)
tp.BackgroundColor3=Color3.fromRGB(70,30,30); tp.TextColor3=Color3.new(1,1,1

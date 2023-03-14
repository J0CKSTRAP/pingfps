-- Gui to Lua
-- Version: 3.2

-- Instances:

local FPS_PING = Instance.new("ScreenGui")
local Holder = Instance.new("Frame")
local FPSsign = Instance.new("TextLabel")
local FPS = Instance.new("TextLabel")
local Ping = Instance.new("TextLabel")
local Pingsign = Instance.new("TextLabel")

--Properties:

FPS_PING.Name = "FPS_PING"
FPS_PING.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
FPS_PING.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Holder.Name = "Holder"
Holder.Parent = FPS_PING
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0.715866208, 0, 0.00987654366, 0)
Holder.Size = UDim2.new(0, 301, 0, 28)

FPSsign.Name = "FPSsign"
FPSsign.Parent = Holder
FPSsign.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FPSsign.BackgroundTransparency = 1.000
FPSsign.Size = UDim2.new(0, 79, 0, 28)
FPSsign.Font = Enum.Font.Arial
FPSsign.Text = "FPS:"
FPSsign.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSsign.TextSize = 23.000
FPSsign.TextStrokeTransparency = 0.000
FPSsign.TextWrapped = true

FPS.Name = "FPS"
FPS.Parent = Holder
FPS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FPS.BackgroundTransparency = 1.000
FPS.Position = UDim2.new(0.262458473, 0, 0, 0)
FPS.Size = UDim2.new(0, 79, 0, 28)
FPS.Font = Enum.Font.Arial
FPS.Text = "-N/A-"
FPS.TextColor3 = Color3.fromRGB(255, 255, 255)
FPS.TextSize = 23.000
FPS.TextStrokeTransparency = 0.000
FPS.TextWrapped = true

Ping.Name = "Ping"
Ping.Parent = Holder
Ping.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ping.BackgroundTransparency = 1.000
Ping.Position = UDim2.new(0.787375391, 0, 0, 0)
Ping.Size = UDim2.new(0, 79, 0, 28)
Ping.Font = Enum.Font.Arial
Ping.Text = "-N/A-"
Ping.TextColor3 = Color3.fromRGB(255, 255, 255)
Ping.TextSize = 23.000
Ping.TextStrokeTransparency = 0.000
Ping.TextWrapped = true

Pingsign.Name = "Pingsign"
Pingsign.Parent = Holder
Pingsign.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pingsign.BackgroundTransparency = 1.000
Pingsign.Position = UDim2.new(0.524916947, 0, 0, 0)
Pingsign.Size = UDim2.new(0, 79, 0, 28)
Pingsign.Font = Enum.Font.Arial
Pingsign.Text = "Ping:"
Pingsign.TextColor3 = Color3.fromRGB(255, 255, 255)
Pingsign.TextSize = 23.000
Pingsign.TextStrokeTransparency = 0.000
Pingsign.TextWrapped = true

-- Scripts:

local function JHRFA_fake_script() -- FPS_PING.PingHandler 
	local script = Instance.new('Script', FPS_PING)

	local PingRemote = script.Parent.Handler.GetPing
	
	PingRemote.OnServerEvent:Connect(function(Player)
		PingRemote:FireClient(Player)
	end)
	
	
	
end
coroutine.wrap(JHRFA_fake_script)()
local function DRDPMNH_fake_script() -- FPS_PING.Handler 
	local script = Instance.new('LocalScript', FPS_PING)

	local RunService = game:GetService("RunService")
	local PingRemote = script.GetPing
	
	local FPSCounter = script.Parent.Holder.FPS
	local PingCounter = script.Parent.Holder.Ping
	
	local Colors = {
		Good = Color3.fromRGB(255, 255, 255),
		Normal = Color3.fromRGB(255, 255, 255),
		Bad = Color3.fromRGB(255, 0, 0)
	}
	
	function GetPing()
		local Send = tick()
		local Ping = nil
	
		PingRemote:FireServer()
	
		local Receive; Receive = PingRemote.OnClientEvent:Connect(function()
			Ping = tick() - Send 
		end)
	
		wait(1)
	
		Receive:Disconnect()
	
		return Ping or 999
	end
	
	RunService.RenderStepped:Connect(function(TimeBetween)
		local FPS = math.floor(1 / TimeBetween)
	
		FPSCounter.Text = tostring(FPS)
	
		if FPS >= 50 then
			FPSCounter.TextColor3 = Colors.Good
	
		elseif FPS >= 30 then
			FPSCounter.TextColor3 = Colors.Normal
	
		elseif FPS >= 0 then
			FPSCounter.TextColor3 = Colors.Bad
	
		end
	end)
	
	local PingThread = coroutine.wrap(function()
		while wait() do
			local Ping = tonumber(string.format("%.3f", GetPing() * 1000))
			PingCounter.Text = (math.floor(Ping)).." ms"
	
			if Ping <= 100 then
				PingCounter.TextColor3 = Colors.Good
	
			elseif Ping > 199  then
				PingCounter.TextColor3 = Colors.Normal
	
			elseif Ping > 900 then
				PingCounter.TextColor3 = Colors.Normal
	
			end
		end
	end)
	
	PingThread()
	
	
end
coroutine.wrap(DRDPMNH_fake_script)()

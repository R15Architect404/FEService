--FEService, such hax ik, by me @Whygithubb

local Services = (function() return setmetatable({}, {
    __index = function(self, key)
        s = rawget(self, key)
        if s then
            return s
        end
        s = game:GetService(key)
        rawset(self, key, s)
        return s
    end
}); end)();

local Create = function(Instance, Parent)
    T = type(Instance)
    if T == 'string' then
        Instance = Instance.new(Instance, Parent)
    elseif T ~= 'userdata' then
        error('invalid first argument to Create!')
    end

    return function(Props)
        for k, v in next, Props do
            Instance[k] = v
            -- TODO: signal support
        end
        return Instance
    end
end

local FE = {}
local LocalPlayer = Services.Players.LocalPlayer
local H = Instance.new("Humanoid")
local CState = H.ChangeState

function getChar(p)
   return p and p.Character or LocalPlayer.Character 
end
function getHum(p)
    return p and p.Character or LocalPlayer.Character 
 end


function FE:FullNetwork() --Immediately makes player have full physics capability
    local plr = LocalPlayer
    setscriptable(plr, "SimulationRadius", true)
	setscriptable(plr, "MaximumSimulationRadius", true)
	setscriptable(plr, "MaxSimulationRadius", true)
    local physicSettings = settings().Physics
    physicSettings.AllowSleep = false
	physicSettings.PhysicsEnvironmentalThrottle = Enum['EnviromentalPhysicsThrottle'].Disabled
    plr.MaximumSimulationRadius = 1000
    plr.ReplicationFocus = workspace or Services.Workspace
	  -- no point in looping
	plr.SimulationRadius = 1000
end

function FE:Chat(Msg)
    local Msg = tostring(Msg)
    if not Msg then return end
    Services.Players:Chat(Msg) --such fe hax
end

function FE:GrabTools(num) -- Optional grab limit
    local num = tonumber(num)
    local st = 0
    for i,v in next, Services.Workspace:GetChildren() do
        if v:IsA("BackpackItem") then
            v:EquipTool()
            if num then
                st = st + 1
                if st >= num then break end 
            end
        end
    end
end

local claimedPart = {}
function FE:ClaimPart(Part)
    local x = Instance.new("BindableEvent")
	for _, v in pairs({Services.RunService.RenderStepped, Services.RunService.Heartbeat, Services.RunService.Stepped}) do
		v.Connect(v, function()
			return x.Fire(x, tick())
		end)
	end

    table.insert(claimedPart, x.Event:Connect(function()
        if Part and isnetworkowner and isnetworkowner(Part) then
            Part.Velocity = Vector3.new(14.465,14.465,14.465)
        elseif Part then
            Part.Velocity = Vector3.new(14.465,14.465,14.465)
        end
    end))
end

function FE:UnclaimPart(Part)
    
end

local functionWorker = {}
function FE:SetHumanoidAnimationSpeed(Speed)
    if Speed == false then -- FE:SetHumanoidAnimationSpeed(false) to turn off
        for i,v in next, functionWorker do
            v:Disconnect()
        end
        return
    else
        for i,v in next, functionWorker do
            v:Disconnect()
        end
    end
    assert(tonumber(Speed), "Pass me a number")
    local Speed = tonumber(Speed)
    table.insert(functionWorker, Services.RunService.Stepped:Connect(function()
        for i,v in next, LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks() do
            v:AdjustSpeed(Speed)
        end
    end))
end

function FE:ReplicateJump(Hum) 
    if not Hum or not Hum:IsA("Humanoid") then return end
    sethiddenproperty(Hum,"JumpReplicate",true)
    sethiddenproperty(Hum,"Jump",true)
end

function FE:ReleaseCharacter(num) 
    assert(tonumber(num), "Pass me a number")
    local num = tonumber(num)
    local oldh = workspace.FallenPartsDestroyHeight
    setsimulationradius(0,0)
    sethiddenproperty(LocalPlayer, "SimulationRadius", 0)
	sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 0)
	sethiddenproperty(LocalPlayer, "MaxSimulationRadius", 0)
    workspace.FallenPartsDestroyHeight = 9e8
    task.delay(num, function() 
        setsimulationradius(1000,1000)
        sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 1000)
	    sethiddenproperty(LocalPlayer, "MaxSimulationRadius", 1000)
        sethiddenproperty(LocalPlayer, "SimulationRadius", 1000)
        workspace.FallenPartsDestroyHeight = oldh
    end)
end

local yes = {}
local AllowCState = true
function FE:ChangeState(State)
    local a,b = pcall(CState, H, State)
    if not a then return error("Pass me a valid state") end -- No I wont let you pass this function an invalid state >:(
    table.insert(yes, Services.Stepped:Connect(function()
        if AllowCState and getHum() then
            CState(getHum(), State)
        end
    end))
end

function FE:UnChangeState(num)
    local num = tonumber(num)
    if not num then
        for i,v in next, yes do
            v:Disconnect()
        end
    else
        AllowCState = false
        task.delay(num, function() 
            AllowCState = true
        end)
    end
end

return FE

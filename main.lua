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

function FE:FullNetwork() --Immediately makes player have full physics capability
    local plr = Services.Players.LocalPlayer
    setscriptable(plr, "SimulationRadius", true)
	setscriptable(plr, "MaximumSimulationRadius", true)
	setscriptable(plr, "MaxSimulationRadius", true)
    local physicSettings = settings().Physics
    physicSettings.AllowSleep = false
	physicSettings.PhysicsEnvironmentalThrottle = Enum['EnviromentalPhysicsThrottle'].Disabled
    plr.MaximumSimulationRadius = 1000
    plr.ReplicationFocus = workspace or Services.Workspace
	plr.MaxSimulationRadius = 1000  -- no point in looping
	plr.SimulationRadius = 1000
end

function FE:Chat(Msg)
    local Msg = tostring(Msg)
    if not Msg then return end
    Services.Players:Chat(Msg) --such fe hax
end

function FE:GrabTools()
    for i,v in next, Services.Workspace:GetChildren() do
        if v:IsA("BackpackItem") then
            v:EquipTool()
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

function FE:SetHumanoidAnimationSpeed(Speed)

end

return FE

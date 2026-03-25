-- Blox Fruit Auto Script

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

-- Functions
local function getClosestEnemy()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs")
    if not enemies then return end

    local closestEnemy, shortestDistance = nil, math.huge
    for _, enemy in ipairs(enemies:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            local distance = (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                closestEnemy, shortestDistance = enemy, distance
            end
        end
    end
    return closestEnemy
end

local function useSkill(skillName)
    local skill = player.Backpack:FindFirstChild(skillName) or character:FindFirstChild(skillName)
    if skill then
        skill:Activate()
    end
end

local function teleportTo(position)
    character.HumanoidRootPart.CFrame = CFrame.new(position)
end

local function autoFarm()
    while true do
        local enemy = getClosestEnemy()
        if enemy then
            teleportTo(enemy.HumanoidRootPart.Position)
            useSkill("Sword") -- Replace with your primary skill
            wait(1) -- Adjust delay as needed
        else
            wait(0.5) -- Adjust delay as needed
        end
    end
end

local function autoQuest()
    -- Implement quest logic here
    -- This is a placeholder for quest completion logic
    print("Auto Questing is enabled.")
    wait(5) -- Adjust delay as needed
end

local function autoTeleport()
    -- Implement teleport logic here
    -- This is a placeholder for teleport logic
    print("Auto Teleport is enabled.")
    wait(5) -- Adjust delay as needed
end

local function autoSkillUse()
    while true do
        local enemy = getClosestEnemy()
        if enemy then
            useSkill("Sword") -- Replace with your primary skill
            wait(1) -- Adjust delay as needed
        else
            wait(0.5) -- Adjust delay as needed
        end
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
        autoFarm()
    elseif UserInputService:IsKeyDown(Enum.KeyCode.Q) then
        autoQuest()
    elseif UserInputService:IsKeyCodeDown(Enum.KeyCode.T) then
        autoTeleport()
    elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
        autoSkillUse()
    end
end)

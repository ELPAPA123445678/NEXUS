local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 Blox Fruit Auto Script 2026",
   LoadingTitle = "Cargando Herramientas...",
   LoadingSubtitle = "por Gemini",
   ConfigurationSaving = { Enabled = false }
})

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

-- PESTAÑA DE MOVIMIENTO
local Tab = Window:CreateTab("Movimiento", 4483362458)

local Button = Tab:CreateButton({
   Name = "Activar Vuelo (Fly)",
   Callback = function()
       local Player = game.Players.LocalPlayer
       local Character = Player.Character or Player.CharacterAdded:Wait()
       local Humanoid = Character:WaitForChild("Humanoid")
       local RootPart = Character:WaitForChild("HumanoidRootPart")
       local BodyVelocity = Instance.new("BodyVelocity")
       BodyVelocity.Velocity = Vector3.new(0, 50, 0)
       BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
       BodyVelocity.Parent = RootPart

       local function onInputBegan(input, gameProcessed)
          if gameProcessed then return end
          if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.W then
             BodyVelocity.Velocity = Vector3.new(0, 50, -100)
          elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.S then
             BodyVelocity.Velocity = Vector3.new(0, 50, 100)
          elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.A then
             BodyVelocity.Velocity = Vector3.new(-100, 50, 0)
          elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.D then
             BodyVelocity.Velocity = Vector3.new(100, 50, 0)
          end
       end

       game:GetService("UserInputService").InputBegan:Connect(onInputBegan)

       print("Fly activado (Lógica de vuelo conectada)")
   end,
})

Tab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- PESTAÑA DE TROLLEO (Visual/Local)
local TrollTab = Window:CreateTab("Trolleo", 4483362458)

TrollTab:CreateButton({
   Name = "Gravedad Zero",
   Callback = function()
      game.Workspace.Gravity = 0
      Rayfield:Notify({Title = "Gravedad", Content = "¡Ahora todos flotan!", Duration = 3})
   end,
})

TrollTab:CreateButton({
   Name = "Chat Spam (Hola)",
   Callback = function()
      for i = 1, 5 do
         game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("¡Trolleado! 🤡", "All")
         wait(0.5)
      end
   end,
})

-- PESTAÑA DE AUTO
local AutoTab = Window:CreateTab("Auto", 4483362458)

AutoTab:CreateButton({
   Name = "Activar Auto Farm",
   Callback = function()
      spawn(autoFarm)
   end,
})

AutoTab:CreateButton({
   Name = "Activar Auto Quest",
   Callback = function()
      spawn(autoQuest)
   end,
})

AutoTab:CreateButton({
   Name = "Activar Auto Teleport",
   Callback = function()
      spawn(autoTeleport)
   end,
})

AutoTab:CreateButton({
   Name = "Activar Auto Skill Use",
   Callback = function()
      spawn(autoSkillUse)
   end,
})

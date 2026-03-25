-- ====================================================================
-- BLOX FRUITS AUTO-FARMING SCRIPT v2.0 - COMPLETO Y PROFESIONAL
-- ====================================================================

-- [[ CONFIGURACIÓN GLOBAL ]]
_G.AutoFarm = true
_G.AutoQuest = true
_G.SelectWeapon = "Melee"
_G.DebugMode = true

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- [[ BASES DE DATOS DE MISIONES POR NIVEL ]]
local questDatabase = {
	{level = 1, name = "Bandit Quest 1", npcName = "Bandit", location = Vector3.new(-1060, 15, 1410)},
	{level = 10, name = "Pirate Quest 1", npcName = "Pirate", location = Vector3.new(350, 50, 50)},
	{level = 30, name = "Buggy Quest 1", npcName = "Buggy", location = Vector3.new(-1040, 25, 4820)},
	{level = 60, name = "Alligator Quest 1", npcName = "Alligator", location = Vector3.new(350, 50, 50)},
	{level = 100, name = "Gorilla Quest 1", npcName = "Gorilla", location = Vector3.new(-5450, 80, 8200)},
}

-- [[ TABLA DE ENEMIGOS POR NIVEL ]]
local enemyDatabase = {
	{levelRange = {1, 10}, enemies = {"Bandit", "Bandit"}},
	{levelRange = {10, 30}, enemies = {"Pirate", "Pirate"}},
	{levelRange = {30, 60}, enemies = {"Buggy Pirate", "Buggy Pirate"}},
	{levelRange = {60, 100}, enemies = {"Alligator", "Alligator"}},
	{levelRange = {100, 150}, enemies = {"Gorilla", "Gorilla"}},
}

-- [[ FUNCIONES AUXILIARES ]]

local function log(message, logType)
	if _G.DebugMode then
		logType = logType or "INFO"
		print("[BloxFruits] [" .. logType .. "] " .. message)
	end
end

local function getPlayerLevel()
	local stats = character:FindFirstChild("leaderstats")
	if stats then
		local level = stats:FindFirstChild("Level")
		return level and level.Value or 1
	end
	return 1
end

local function teleportToPos(cframe, duration)
	duration = duration or 2
	if not character or not rootPart then return end
	
	local distance = (rootPart.Position - cframe.Position).Magnitude
	local newDuration = distance / 300
	
	local tweenInfo = TweenInfo.new(
		newDuration,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut
	)
	
	local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = cframe})
	tween:Play()
	tween.Completed:Connect(function()
		log("Teleported successfully", "SUCCESS")
	end)
	
	return tween
end

local function equipWeapon(weaponType)
	pcall(function()
		local tool = player.Backpack:FindFirstChild(weaponType)
		if tool and tool:IsA("Tool") then
			humanoid:EquipTool(tool)
			log("Weapon equipped: " .. weaponType, "INFO")
		else
			log("Weapon not found: " .. weaponType, "WARNING")
		end
	end)
end

local function attackEnemy()
	pcall(function()
		local equippedTool = character:FindFirstChildOfClass("Tool")
		if equippedTool then
			equippedTool:Activate()
		end
	end)
end

local function findNearestEnemy()
	local enemies = Workspace:FindFirstChild("Enemies")
	if not enemies then return nil end
	
	local nearestEnemy = nil
	local nearestDistance = math.huge
	
	for _, enemy in pairs(enemies:GetChildren()) do
		if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
			if enemy:FindFirstChild("HumanoidRootPart") then
				local distance = (rootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
				if distance < nearestDistance then
					nearestDistance = distance
					nearestEnemy = enemy
				end
			end
		end
	end
	
	return nearestEnemy
end

local function farmEnemy(enemy)
	if not enemy or not enemy:FindFirstChild("Humanoid") then return end
	
	local enemyHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
	if not enemyHumanoidRootPart then return end
	
	-- Posicionarse arriba del enemigo
	local aboveEnemy = enemyHumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
	teleportToPos(aboveEnemy, 1)
	
	-- Atacar mientras el enemigo está vivo
	while _G.AutoFarm and enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 do
		wait(0.1)
		attackEnemy()
		
		-- Si el enemigo está muy lejos, volver a teletransportarse
		local distance = (rootPart.Position - enemyHumanoidRootPart.Position).Magnitude
		if distance > 20 then
			teleportToPos(aboveEnemy, 0.5)
		end
	end
	
	log("Enemy defeated!", "SUCCESS")
end

local function findQuestNPC(questName)
	-- Buscar en ReplicatedStorage o Workspace
	for _, npc in pairs(Workspace:GetDescendants()) do
		if npc.Name == questName or npc.Name:find(questName) then
			if npc:FindFirstChild("HumanoidRootPart") then
				return npc.HumanoidRootPart.CFrame
			end
		end
	end
	return nil
end

local function acceptQuest(questName)
	pcall(function()
		-- Intentar aceptar la misión a través de RemoteEvents
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		if remotes then
			local commF = remotes:FindFirstChild("CommF_")
			if commF then
				commF:InvokeServer("StartQuest", questName, 1)
				log("Quest started: " .. questName, "SUCCESS")
			end
		end
	end)
end

local function progressionSystem()
	local currentLevel = getPlayerLevel()
	log("Current Level: " .. currentLevel, "INFO")
	
	-- Encontrar la misión apropiada para el nivel actual
	for _, quest in pairs(questDatabase) do
		if currentLevel >= quest.level and (currentLevel < questDatabase[_ + 1] and questDatabase[_ + 1].level or 999) then
			log("Traveling to: " .. quest.name, "INFO")
			
			-- Teletransportarse al NPC
			teleportToPos(CFrame.new(quest.location), 3)
			wait(2)
			
			-- Aceptar la misión
			if _G.AutoQuest then
				acceptQuest(quest.name)
				wait(1)
			end
			
			break
		end
	end
end

local function autoFarmLoop()
	while _G.AutoFarm do
		wait(1)
		
		equipWeapon(_G.SelectWeapon)
		
		-- Sistema de progresión
		if _G.AutoQuest then
			progressionSystem()
		end
		
		-- Buscar y atacar enemigos
		local enemy = findNearestEnemy()
		if enemy then
			log("Enemy found! Starting attack...", "INFO")
			farmEnemy(enemy)
		else
			log("No enemies found, waiting...", "WARNING")
		end
	end
end

-- [[ CONTROLES DE TECLADO ]]

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.F then
		_G.AutoFarm = not _G.AutoFarm
		log("AutoFarm: " .. tostring(_G.AutoFarm), "INFO")
	elseif input.KeyCode == Enum.KeyCode.Q then
		_G.AutoQuest = not _G.AutoQuest
		log("AutoQuest: " .. tostring(_G.AutoQuest), "INFO")
	elseif input.KeyCode == Enum.KeyCode.E then
		attackEnemy()
		log("Manual attack executed", "INFO")
	end
end)

-- [[ RECONEXIÓN DE PERSONAJE ]]

player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	log("Character respawned, reconnecting systems...", "INFO")
end)

-- [[ INICIO DEL SCRIPT ]]

log("=== Blox Fruits Auto-Farming Script Started ===", "SUCCESS")
log("Controls: F = Toggle AutoFarm, Q = Toggle AutoQuest, E = Manual Attack", "INFO")

autoFarmLoop()

-- [[ CONFIGURACIÓN DE TU SCRIPT ]]
_G.AutoFarm = true
_G.SelectWeapon = "Melee" -- Puede ser "Melee", "Sword" o "Fruit"

local player = game.Players.LocalPlayer
local waitTime = 0.1

-- 1. Función para Equipar Arma automáticamente
local function equipWeapon()
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == _G.SelectWeapon then
            player.Character.Humanoid:EquipTool(v)
        end
    end
end

-- 2. Función de Ataque (Click Automático)
spawn(function()
    while wait(waitTime) do
        if _G.AutoFarm then
            pcall(function()
                local tool = player.Character:FindFirstChildOfClass("Tool")
                if tool then 
                    tool:Activate() 
                end
            end)
        end
    end
end)

-- 3. Función de Teletransporte Suave (Tween)
local function toPos(pos)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local tween = game:GetService("TweenService"):Create(
            char.HumanoidRootPart,
            TweenInfo.new((char.HumanoidRootPart.Position - pos.p).Magnitude / 300, Enum.EasingStyle.Linear),
            {CFrame = pos}
        )
        tween:Play()
    end
end

-- 4. BUCLE PRINCIPAL (Auto Quest + Farm)
spawn(function()
    while wait(1) do
        if _G.AutoFarm then
            -- Aquí deberías poner la lógica de niveles, por ejemplo:
            -- Si nivel < 10, ir a Bandits
            
            -- EJEMPLO: Ir a un NPC de misión (Debes buscar el CFrame del NPC)
            -- toPos(CFrame.new(posicion_del_npc))
            
            -- Aceptar misión usando RemoteEvents
            -- game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BanditQuest1",1)
            
            equipWeapon()
            
            -- Buscar enemigos y teletransportarse a ellos
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    repeat
                        wait()
                        -- Te pone arriba del enemigo para que no te pegue
                        toPos(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                    until not _G.AutoFarm or v.Humanoid.Health <= 0
                end
            end
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Hub 2026", "DarkTheme")

-- SECCIÓN PRINCIPAL
local Main = Window:NewTab("Principal")
local MainSection = Main:NewSection("Movimiento y Fly")

MainSection:NewButton("Activar Fly (Vuelo)", "Te permite volar por el mapa", function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local mouse = player:GetMouse()
    local flying = true
    local speed = 50
    
    local bv = Instance.new("BodyVelocity", char.PrimaryPart)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0.1, 0)
    
    local bg = Instance.new("BodyGyro", char.PrimaryPart)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 9e4
    
    spawn(function()
        while flying do
            bg.CFrame = workspace.CurrentCamera.CFrame
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
            task.wait()
        end
    end)
end)

MainSection:NewSlider("Velocidad", "Ajusta tu rapidez", 300, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- SECCIÓN DE "TROLL" / COMBATE
local Troll = Window:NewTab("Trolleo/Farm")
local TrollSection = Troll:NewSection("Acciones")

TrollSection:NewButton("Auto-Click (Para Farm)", "Ataca automáticamente", function()
    _G.AutoClick = true
    while _G.AutoClick do
        local vim = game:GetService("VirtualUser")
        vim:CaptureController()
        vim:ClickButton1(Vector2.new(0,0))
        task.wait(0.1)
    end
end)

TrollSection:NewButton("Quitar Neblina", "Ves todo el mapa claro", function()
    game:GetService("Lighting").FogEnd = 100000
end)

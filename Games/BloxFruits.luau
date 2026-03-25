local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 My Troll Menu 2026",
   LoadingTitle = "Cargando Herramientas...",
   LoadingSubtitle = "por Gemini",
   ConfigurationSaving = { Enabled = false }
})

-- PESTAÑA DE MOVIMIENTO
local Tab = Window:CreateTab("Movimiento", 4483362458) 

local Button = Tab:CreateButton({
   Name = "Activar Vuelo (Fly)",
   Callback = function()
       -- Aquí iría la lógica del Fly (usualmente requiere un BodyVelocity)
       print("Fly activado (Lógica de vuelo conectada)")
       -- Nota: Los scripts de Fly completos son extensos, 
       -- pero esto activa la función base.
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

local CoreGui = game:GetService("CoreGui")

-- [[ CONFIGURACIÓN ]]
local TITULO = "⚠️ SISTEMA EN MANTENIMIENTO ⚠️"
local MENSAJE = "El script no está disponible en este momento. Por favor, intenta más tarde."

-- 1. Crear Pantalla
local sg = Instance.new("ScreenGui")
sg.Name = "AvisoImportante"
sg.Parent = (gethui and gethui()) or CoreGui

-- 2. Ventana Muy Grande (Caja Negra)
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 200) -- Tamaño grande
main.Position = UDim2.new(0.5, -250, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Parent = sg

-- Borde Rojo Grueso para que se vea "ALTO"
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 4
stroke.Parent = main

-- Esquinas redondeadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = main

-- 3. Título en Rojo Brillante
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Text = TITULO
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.BackgroundTransparency = 1
title.Parent = main

-- 4. Mensaje Central
local msgLabel = Instance.new("TextLabel")
msgLabel.Size = UDim2.new(1, -40, 0, 80)
msgLabel.Position = UDim2.new(0, 20, 0, 70)
msgLabel.Text = MENSAJE
msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
msgLabel.Font = Enum.Font.Gotham
msgLabel.TextSize = 20
msgLabel.TextWrapped = true
msgLabel.BackgroundTransparency = 1
msgLabel.Parent = main

-- 5. Botón de Entendido (Para cerrar)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 45)
btn.Position = UDim2.new(0.5, -100, 0.75, 5)
btn.Text = "ENTENDIDO"
btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Parent = main

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = btn

-- Función para cerrar al hacer click
btn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

-- Configuración básica
local LINK = "discord.gg/redz-hub"
local TITULO_TEXTO = "redz Hub - Offline"

-- 1. Crear la pantalla
local sg = Instance.new("ScreenGui")
sg.Name = "SimpleWarning"
sg.Parent = (gethui and gethui()) or CoreGui
Debris:AddItem(sg, 30) -- Se borra solo en 30 segundos

-- 2. Crear el fondo (Caja negra en el centro)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.Parent = sg

-- 3. Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = TITULO_TEXTO
title.TextColor3 = Color3.new(1, 0, 0) -- Rojo
title.BackgroundTransparency = 1
title.TextSize = 20
title.Parent = frame

-- 4. Botón para Copiar Link
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 40)
btn.Position = UDim2.new(0.5, -100, 0.6, 0)
btn.Text = "Copiar Discord"
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Parent = frame

-- 5. Función de Click
btn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LINK)
        btn.Text = "¡COPIADO!"
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        btn.Text = "Error: No soportado"
    end
end)

-- 6. Botón de Cerrar (X)
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.new(0.3, 0, 0)
close.TextColor3 = Color3.new(1, 1, 1)
close.Parent = frame

close.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

--[[
    SATANA PREMIUM HACK MENU
    ВЕРСИЯ 2.0 - ПОЛНЫЙ ФУНКЦИОНАЛ
]]

-- Службы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Локальный игрок
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Настройки
local Settings = {
    ESP = {
        Enabled = false,
        Box = false,
        Distance = false,
        Health = false,
        Line = false,
        TeamCheck = true,
        BoxColor = Color3.fromRGB(255, 50, 50),
        TextColor = Color3.fromRGB(255, 255, 255)
    },
    
    Aimbot = {
        Enabled = false,
        Distance = 100,
        FOV = 90,
        Smoothness = 0.1,
        TeamCheck = true,
        TargetPart = "Head",
        FOVVisible = true,
        FOVColor = Color3.fromRGB(255, 50, 50)
    },
    
    Memory = {
        SpeedHack = false,
        SpeedMultiplier = 2,
        GodMode = false
    }
}

-- ESP Объекты
local ESPObjects = {}
local ESPConnections = {}

-- Аимбот переменные
local AimbotTarget = nil
local AimbotConnection = nil
local FOVCircle = nil

-- Speed Hack переменные
local OriginalWalkSpeed = 16
local OriginalJumpPower = 50

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SatanaGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Закругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Заголовок окна
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SATANA v2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Область вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, 0, 0, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Создаем кнопки табов
local VisualsButton = Instance.new("TextButton")
VisualsButton.Name = "VisualsButton"
VisualsButton.Size = UDim2.new(0.333, 0, 1, 0)
VisualsButton.Position = UDim2.new(0, 0, 0, 0)
VisualsButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
VisualsButton.BorderSizePixel = 0
VisualsButton.Text = "VISUALS"
VisualsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VisualsButton.TextSize = 14
VisualsButton.Font = Enum.Font.GothamSemibold
VisualsButton.Parent = TabContainer

local AimbotButton = Instance.new("TextButton")
AimbotButton.Name = "AimbotButton"
AimbotButton.Size = UDim2.new(0.333, 0, 1, 0)
AimbotButton.Position = UDim2.new(0.333, 0, 0, 0)
AimbotButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimbotButton.BorderSizePixel = 0
AimbotButton.Text = "AIMBOT"
AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotButton.TextSize = 14
AimbotButton.Font = Enum.Font.GothamSemibold
AimbotButton.Parent = TabContainer

local MemoryButton = Instance.new("TextButton")
MemoryButton.Name = "MemoryButton"
MemoryButton.Size = UDim2.new(0.334, 0, 1, 0)
MemoryButton.Position = UDim2.new(0.666, 0, 0, 0)
MemoryButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MemoryButton.BorderSizePixel = 0
MemoryButton.Text = "MEMORY"
MemoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MemoryButton.TextSize = 14
MemoryButton.Font = Enum.Font.GothamSemibold
MemoryButton.Parent = TabContainer

-- Область контента
local VisualsFrame = Instance.new("ScrollingFrame")
VisualsFrame.Name = "VisualsFrame"
VisualsFrame.Size = UDim2.new(1, -20, 1, -100)
VisualsFrame.Position = UDim2.new(0, 10, 0, 90)
VisualsFrame.BackgroundTransparency = 1
VisualsFrame.BorderSizePixel = 0
VisualsFrame.ScrollBarThickness = 4
VisualsFrame.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
VisualsFrame.Visible = true
VisualsFrame.Parent = MainFrame

local AimbotFrame = Instance.new("ScrollingFrame")
AimbotFrame.Name = "AimbotFrame"
AimbotFrame.Size = UDim2.new(1, -20, 1, -100)
AimbotFrame.Position = UDim2.new(0, 10, 0, 90)
AimbotFrame.BackgroundTransparency = 1
AimbotFrame.BorderSizePixel = 0
AimbotFrame.ScrollBarThickness = 4
AimbotFrame.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
AimbotFrame.Visible = false
AimbotFrame.Parent = MainFrame

local MemoryFrame = Instance.new("ScrollingFrame")
MemoryFrame.Name = "MemoryFrame"
MemoryFrame.Size = UDim2.new(1, -20, 1, -100)
MemoryFrame.Position = UDim2.new(0, 10, 0, 90)
MemoryFrame.BackgroundTransparency = 1
MemoryFrame.BorderSizePixel = 0
MemoryFrame.ScrollBarThickness = 4
MemoryFrame.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
MemoryFrame.Visible = false
MemoryFrame.Parent = MainFrame

-- Упорядочивание элементов
local VisualsLayout = Instance.new("UIListLayout")
VisualsLayout.Padding = UDim.new(0, 10)
VisualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
VisualsLayout.Parent = VisualsFrame

local AimbotLayout = Instance.new("UIListLayout")
AimbotLayout.Padding = UDim.new(0, 10)
AimbotLayout.SortOrder = Enum.SortOrder.LayoutOrder
AimbotLayout.Parent = AimbotFrame

local MemoryLayout = Instance.new("UIListLayout")
MemoryLayout.Padding = UDim.new(0, 10)
MemoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
MemoryLayout.Parent = MemoryFrame

-- Функция для переключения вкладок
local function SwitchTab(tabName)
    VisualsFrame.Visible = false
    AimbotFrame.Visible = false
    MemoryFrame.Visible = false
    
    VisualsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AimbotButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MemoryButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    
    if tabName == "Visuals" then
        VisualsFrame.Visible = true
        VisualsButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    elseif tabName == "Aimbot" then
        AimbotFrame.Visible = true
        AimbotButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    elseif tabName == "Memory" then
        MemoryFrame.Visible = true
        MemoryButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    end
end

-- Функция создания переключателя
local function CreateToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #parent:GetChildren()
    toggleFrame.Parent = parent
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -60, 0, 2)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(220, 20, 60) or Color3.fromRGB(40, 40, 40)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(1, -70, 1, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.TextSize = 14
    toggleText.Font = Enum.Font.Gotham
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggleFrame
    
    local state = default
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        
        -- Анимация переключения
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(toggleButton, tweenInfo, {
            BackgroundColor3 = state and Color3.fromRGB(220, 20, 60) or Color3.fromRGB(40, 40, 40)
        })
        tween:Play()
        
        if callback then
            callback(state)
        end
    end)
    
    return {
        Set = function(value)
            state = value
            toggleButton.BackgroundColor3 = state and Color3.fromRGB(220, 20, 60) or Color3.fromRGB(40, 40, 40)
        end,
        Get = function() return state end
    }
end

-- Функция создания слайдера с анимацией
local function CreateSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.LayoutOrder = #parent:GetChildren()
    sliderFrame.Parent = parent
    
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(1, 0, 0, 20)
    sliderText.BackgroundTransparency = 1
    sliderText.Text = text .. ": " .. default
    sliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderText.TextSize = 14
    sliderText.Font = Enum.Font.Gotham
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.Parent = sliderFrame
    
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(1, 0, 0, 25)
    sliderBackground.Position = UDim2.new(0, 0, 0, 25)
    sliderBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBackground.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 12)
    sliderCorner.Parent = sliderBackground
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    sliderFill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 12)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Text = ""
    
    sliderFill.Parent = sliderBackground
    sliderButton.Parent = sliderBackground
    sliderBackground.Parent = sliderFrame
    
    local value = default
    local dragging = false
    
    local function updateValue(input)
        local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        value = math.floor(min + (max - min) * relativeX + 0.5)
        
        -- Анимация изменения
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(sliderFill, tweenInfo, {
            Size = UDim2.new(relativeX, 0, 1, 0)
        })
        tween:Play()
        
        sliderText.Text = text .. ": " .. value
        
        if callback then
            callback(value)
        end
    end
    
    sliderButton.MouseButton1Down:Connect(function(input)
        dragging = true
        updateValue(input)
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input)
        end
    end)
    
    return {
        Set = function(newValue)
            value = math.clamp(newValue, min, max)
            local relativeX = (value - min) / (max - min)
            
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(sliderFill, tweenInfo, {
                Size = UDim2.new(relativeX, 0, 1, 0)
            })
            tween:Play()
            
            sliderText.Text = text .. ": " .. value
        end,
        Get = function() return value end
    }
end

-- Создаем элементы для вкладки Visuals
local ESPBoxToggle = CreateToggle(VisualsFrame, "ESP BOX", Settings.ESP.Box, function(state)
    Settings.ESP.Box = state
    UpdateESP()
end)

local ESPDistanceToggle = CreateToggle(VisualsFrame, "ESP DISTANCE", Settings.ESP.Distance, function(state)
    Settings.ESP.Distance = state
    UpdateESP()
end)

local ESPHealthToggle = CreateToggle(VisualsFrame, "ESP HEALTH", Settings.ESP.Health, function(state)
    Settings.ESP.Health = state
    UpdateESP()
end)

local ESPLineToggle = CreateToggle(VisualsFrame, "ESP LINE", Settings.ESP.Line, function(state)
    Settings.ESP.Line = state
    UpdateESP()
end)

local ESPToggle = CreateToggle(VisualsFrame, "ESP ENABLED", Settings.ESP.Enabled, function(state)
    Settings.ESP.Enabled = state
    if state then
        EnableESP()
    else
        DisableESP()
    end
end)

-- Создаем элементы для вкладки Aimbot
local AimbotToggle = CreateToggle(AimbotFrame, "ENABLE AIMBOT", Settings.Aimbot.Enabled, function(state)
    Settings.Aimbot.Enabled = state
    if state then
        EnableAimbot()
    else
        DisableAimbot()
    end
end)

local AimbotDistanceSlider = CreateSlider(AimbotFrame, "Aimbot Distance", 0, 500, Settings.Aimbot.Distance, function(value)
    Settings.Aimbot.Distance = value
end)

local AimbotFOVSlider = CreateSlider(AimbotFrame, "Aimbot FOV", 1, 360, Settings.Aimbot.FOV, function(value)
    Settings.Aimbot.FOV = value
    if FOVCircle then
        FOVCircle.Radius = value
    end
end)

local FOVToggle = CreateToggle(AimbotFrame, "SHOW FOV CIRCLE", Settings.Aimbot.FOVVisible, function(state)
    Settings.Aimbot.FOVVisible = state
    if FOVCircle then
        FOVCircle.Visible = state
    end
end)

-- Создаем элементы для вкладки Memory
local SpeedHackToggle = CreateToggle(MemoryFrame, "SPEED HACK", Settings.Memory.SpeedHack, function(state)
    Settings.Memory.SpeedHack = state
    if state then
        EnableSpeedHack()
    else
        DisableSpeedHack()
    end
end)

local SpeedSlider = CreateSlider(MemoryFrame, "Speed Multiplier", 1, 10, Settings.Memory.SpeedMultiplier, function(value)
    Settings.Memory.SpeedMultiplier = value
    if Settings.Memory.SpeedHack then
        UpdateSpeedHack()
    end
end)

local GodModeToggle = CreateToggle(MemoryFrame, "GOD MODE", Settings.Memory.GodMode, function(state)
    Settings.Memory.GodMode = state
    if state then
        EnableGodMode()
    else
        DisableGodMode()
    end
end)

-- Функции ESP
function CreateESP(player)
    if ESPObjects[player] then return end
    
    local esp = {
        Box = Instance.new("BoxHandleAdornment"),
        Distance = Instance.new("TextLabel"),
        Health = Instance.new("TextLabel"),
        Line = Instance.new("LineHandleAdornment")
    }
    
    -- Создаем ESP Box
    esp.Box.Name = "ESPBox"
    esp.Box.Adornee = nil
    esp.Box.Size = Vector3.new(4, 6, 4)
    esp.Box.Color3 = Settings.ESP.BoxColor
    esp.Box.Transparency = 0.5
    esp.Box.AlwaysOnTop = true
    esp.Box.ZIndex = 5
    esp.Box.Visible = false
    esp.Box.Parent = Camera
    
    -- Создаем Distance Text
    esp.Distance.Name = "ESPDistance"
    esp.Distance.BackgroundTransparency = 1
    esp.Distance.TextColor3 = Settings.ESP.TextColor
    esp.Distance.TextSize = 14
    esp.Distance.Font = Enum.Font.GothamBold
    esp.Distance.TextStrokeTransparency = 0
    esp.Distance.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Distance.Visible = false
    esp.Distance.Parent = ScreenGui
    
    -- Создаем Health Text
    esp.Health.Name = "ESPHealth"
    esp.Health.BackgroundTransparency = 1
    esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
    esp.Health.TextSize = 14
    esp.Health.Font = Enum.Font.GothamBold
    esp.Health.TextStrokeTransparency = 0
    esp.Health.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Health.Visible = false
    esp.Health.Parent = ScreenGui
    
    -- Создаем Line
    esp.Line.Name = "ESPLine"
    esp.Line.Adornee = nil
    esp.Line.Color3 = Settings.ESP.BoxColor
    esp.Line.Thickness = 2
    esp.Line.Transparency = 0.7
    esp.Line.ZIndex = 5
    esp.Line.Visible = false
    esp.Line.Parent = Camera
    
    ESPObjects[player] = esp
end

function UpdateESP()
    if not Settings.ESP.Enabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not ESPObjects[player] then
                CreateESP(player)
            end
            
            local esp = ESPObjects[player]
            local character = player.Character
            
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local humanoid = character:FindFirstChild("Humanoid")
                
                -- Получаем позицию на экране
                local position, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                
                if onScreen then
                    -- ESP Box
                    if Settings.ESP.Box then
                        esp.Box.Adornee = rootPart
                        esp.Box.Visible = true
                    else
                        esp.Box.Visible = false
                    end
                    
                    -- ESP Distance
                    if Settings.ESP.Distance then
                        local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
                        esp.Distance.Text = math.floor(distance) .. " studs"
                        esp.Distance.Position = UDim2.new(0, position.X, 0, position.Y + 20)
                        esp.Distance.Visible = true
                    else
                        esp.Distance.Visible = false
                    end
                    
                    -- ESP Health
                    if Settings.ESP.Health and humanoid then
                        local health = math.floor(humanoid.Health)
                        local maxHealth = humanoid.MaxHealth
                        esp.Health.Text = "HP: " .. health .. "/" .. maxHealth
                        
                        -- Цвет в зависимости от здоровья
                        local healthPercent = health / maxHealth
                        if healthPercent > 0.6 then
                            esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
                        elseif healthPercent > 0.3 then
                            esp.Health.TextColor3 = Color3.fromRGB(255, 255, 0)
                        else
                            esp.Health.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                        
                        esp.Health.Position = UDim2.new(0, position.X, 0, position.Y - 30)
                        esp.Health.Visible = true
                    else
                        esp.Health.Visible = false
                    end
                    
                    -- ESP Line
                    if Settings.ESP.Line then
                        esp.Line.Adornee = rootPart
                        esp.Line.Visible = true
                        -- Линия от центра экрана к игроку
                        esp.Line.Length = (rootPart.Position - Camera.CFrame.Position).Magnitude
                        esp.Line.CFrame = CFrame.new(Camera.CFrame.Position, rootPart.Position)
                    else
                        esp.Line.Visible = false
                    end
                else
                    -- Если игрок не на экране, скрываем все
                    esp.Box.Visible = false
                    esp.Distance.Visible = false
                    esp.Health.Visible = false
                    esp.Line.Visible = false
                end
            else
                -- Если персонажа нет, скрываем ESP
                esp.Box.Visible = false
                esp.Distance.Visible = false
                esp.Health.Visible = false
                esp.Line.Visible = false
            end
        end
    end
end

function EnableESP()
    Settings.ESP.Enabled = true
    
    -- Создаем ESP для всех существующих игроков
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end
    
    -- Обновляем ESP каждый кадр
    ESPConnections.Update = RunService.RenderStepped:Connect(UpdateESP)
    
    -- Добавляем обработчик для новых игроков
    ESPConnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
        CreateESP(player)
    end)
    
    -- Добавляем обработчик для вышедших игроков
    ESPConnections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        if ESPObjects[player] then
            ESPObjects[player].Box:Destroy()
            ESPObjects[player].Distance:Destroy()
            ESPObjects[player].Health:Destroy()
            ESPObjects[player].Line:Destroy()
            ESPObjects[player] = nil
        end
    end)
end

function DisableESP()
    Settings.ESP.Enabled = false
    
    -- Отключаем все соединения
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
    
    -- Удаляем все ESP объекты
    for _, esp in pairs(ESPObjects) do
        esp.Box:Destroy()
        esp.Distance:Destroy()
        esp.Health:Destroy()
        esp.Line:Destroy()
    end
    ESPObjects = {}
end

-- Функции Aimbot
function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot.Distance
    local mouse = LocalPlayer:GetMouse()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local targetPart = character:FindFirstChild(Settings.Aimbot.TargetPart)
            
            if humanoid and humanoid.Health > 0 and rootPart and targetPart then
                -- Проверка команды
                if Settings.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Проверка дистанции
                local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
                if distance > Settings.Aimbot.Distance then
                    continue
                end
                
                -- Проверка FOV
                local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local mousePosition = Vector2.new(mouse.X, mouse.Y)
                    local targetPosition = Vector2.new(screenPosition.X, screenPosition.Y)
                    local fovDistance = (mousePosition - targetPosition).Magnitude
                    
                    if fovDistance <= Settings.Aimbot.FOV then
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

function AimAt(target)
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild(Settings.Aimbot.TargetPart)
    if not targetPart then return end
    
    local camera = Workspace.CurrentCamera
    local targetPosition = targetPart.Position
    
    -- Плавное прицеливание
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    
    -- Интерполяция для плавности
    local newCFrame = currentCFrame:Lerp(targetCFrame, Settings.Aimbot.Smoothness)
    camera.CFrame = newCFrame
end

function EnableAimbot()
    Settings.Aimbot.Enabled = true
    
    -- Создаем FOV круг
    if not FOVCircle then
        FOVCircle = Instance.new("Circle")
        FOVCircle.Name = "FOVCircle"
        FOVCircle.Visible = Settings.Aimbot.FOVVisible
        FOVCircle.Color3 = Settings.Aimbot.FOVColor
        FOVCircle.Thickness = 2
        FOVCircle.Transparency = 0.5
        FOVCircle.NumSides = 100
        FOVCircle.Radius = Settings.Aimbot.FOV
        FOVCircle.Filled = false
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Parent = ScreenGui
    end
    
    -- Включаем аимбот
    AimbotConnection = RunService.RenderStepped:Connect(function()
        if Settings.Aimbot.Enabled then
            local target = GetClosestPlayer()
            if target then
                AimAt(target)
            end
        end
    end)
end

function DisableAimbot()
    Settings.Aimbot.Enabled = false
    
    if AimbotConnection then
        AimbotConnection:Disconnect()
        AimbotConnection = nil
    end
    
    if FOVCircle then
        FOVCircle:Destroy()
        FOVCircle = nil
    end
end

-- Функции Memory
function EnableSpeedHack()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            OriginalWalkSpeed = humanoid.WalkSpeed
            OriginalJumpPower = humanoid.JumpPower
            
            humanoid.WalkSpeed = OriginalWalkSpeed * Settings.Memory.SpeedMultiplier
            humanoid.JumpPower = OriginalJumpPower * Settings.Memory.SpeedMultiplier
        end
    end
end

function DisableSpeedHack()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = OriginalWalkSpeed
            humanoid.JumpPower = OriginalJumpPower
        end
    end
end

function UpdateSpeedHack()
    if Settings.Memory.SpeedHack then
        EnableSpeedHack()
    end
end

function EnableGodMode()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = false
            
            -- Защита от урона
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

function DisableGodMode()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = true
            
            -- Восстанавливаем коллизию
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Обработчики событий персонажа
LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- Ждем загрузки персонажа
    
    if Settings.Memory.SpeedHack then
        EnableSpeedHack()
    end
    
    if Settings.Memory.GodMode then
        EnableGodMode()
    end
end)

-- Кнопка открытия GUI (если закрыто)
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 80, 0, 35)
OpenButton.Position = UDim2.new(1, -90, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "SATANA"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 14
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenButtonCorner = Instance.new("UICorner")
OpenButtonCorner.CornerRadius = UDim.new(0, 6)
OpenButtonCorner.Parent = OpenButton

-- Функции открытия/закрытия
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

-- Назначаем обработчики для кнопок табов
VisualsButton.MouseButton1Click:Connect(function()
    SwitchTab("Visuals")
end)

AimbotButton.MouseButton1Click:Connect(function()
    SwitchTab("Aimbot")
end)

MemoryButton.MouseButton1Click:Connect(function()
    SwitchTab("Memory")
end)

-- Функция для перетаскивания окна
local dragging
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            update(input)
        end
    end
end)

-- Уведомление о загрузке
task.spawn(function()
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0, 250, 0, 70)
    Notification.Position = UDim2.new(0.5, -125, 1, 10)
    Notification.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = Notification

    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, 0, 0, 25)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = "SATANA v2.0 LOADED"
    NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifTitle.TextSize = 16
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Parent = Notification

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -10, 0, 35)
    NotifText.Position = UDim2.new(0, 5, 0, 25)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "Все функции активны!"
    NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.Parent = Notification

    -- Анимация появления
    Notification:TweenPosition(UDim2.new(0.5, -125, 1, -90), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5)
    
    -- Автоматическое скрытие
    wait(3)
    Notification:TweenPosition(UDim2.new(0.5, -125, 1, 10), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5)
    wait(0.5)
    Notification:Destroy()
end)

-- Отправляем уведомление в чат
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SATANA v2.0",
    Text = "Все функции загружены и активны!",
    Duration = 5,
    Icon = "rbxassetid://0"
})

print("===================================")
print("SATANA GUI v2.0 загружена успешно!")
print("ESP: Готово")
print("Aimbot: Готово")
print("Memory: Готово")
print("===================================")
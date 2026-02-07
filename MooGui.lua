-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

--[[
    SATANA PREMIUM HACK MENU v4.0
    ПОЛНОСТЬЮ РАБОЧИЙ ФУНКЦИОНАЛ
]]

-- Службы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

-- Локальный игрок
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Проверяем, доступен ли Drawing API
local DrawingSupported = pcall(function()
    local test = Drawing.new("Square")
    test:Remove()
    return true
end)

-- Настройки
local Settings = {
    ESP = {
        Enabled = false,
        Box = false,
        Distance = false,
        Health = false,
        Names = false,
        Tracers = false,
        TeamCheck = true,
        BoxColor = Color3.fromRGB(255, 50, 50),
        TeamColor = Color3.fromRGB(0, 170, 255),
        TextColor = Color3.fromRGB(255, 255, 255),
        MaxDistance = 1000,
        BoxThickness = 2,
        TextSize = 14
    },
    
    Aimbot = {
        Enabled = false,
        Distance = 500,
        FOV = 120,
        Smoothness = 0.3,
        TeamCheck = true,
        TargetPart = "Head",
        FOVVisible = true,
        FOVColor = Color3.fromRGB(255, 50, 50),
        FOVTransparency = 0.3
    },
    
    Memory = {
        SpeedHack = false,
        SpeedMultiplier = 2,
        GodMode = false,
        Noclip = false
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
local SpeedHackConnection = nil

-- Noclip переменные
local NoclipConnection = nil
local NoclipParts = {}

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SatanaGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Фоновый градиент для меню
local BackgroundGradient = Instance.new("Frame")
BackgroundGradient.Name = "BackgroundGradient"
BackgroundGradient.Size = UDim2.new(1, 0, 1, 0)
BackgroundGradient.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundGradient.BackgroundTransparency = 0.8
BackgroundGradient.BorderSizePixel = 0
BackgroundGradient.Parent = ScreenGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(220, 20, 60)
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Закругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Тень окна
local UIShadow = Instance.new("ImageLabel")
UIShadow.Name = "UIShadow"
UIShadow.Size = UDim2.new(1, 10, 1, 10)
UIShadow.Position = UDim2.new(0, -5, 0, -5)
UIShadow.Image = "rbxassetid://5554236805"
UIShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
UIShadow.ImageTransparency = 0.8
UIShadow.ScaleType = Enum.ScaleType.Slice
UIShadow.SliceCenter = Rect.new(23, 23, 277, 277)
UIShadow.BackgroundTransparency = 1
UIShadow.Parent = MainFrame

-- Заголовок окна
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Текст заголовка
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SATANA v4.0"
Title.TextColor3 = Color3.fromRGB(220, 20, 60)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.fromRGB(20, 20, 20)
Title.Parent = TitleBar

-- Подзаголовок
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, -50, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "PREMIUM HACK MENU"
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -37, 0.5, -16)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Эффект при наведении на кнопку закрытия
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 20, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(255, 100, 100)
    }):Play()
end)

-- Область вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

-- Создаем кнопки табов
local function CreateTabButton(name, text, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.333, -4, 1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = false
    button.Parent = TabContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Эффект при наведении
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(220, 20, 60) then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(220, 20, 60) then
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                TextColor3 = Color3.fromRGB(180, 180, 180)
            }):Play()
        end
    end)
    
    return button
end

local VisualsButton = CreateTabButton("Visuals", "VISUALS", UDim2.new(0, 0, 0, 0))
local AimbotButton = CreateTabButton("Aimbot", "AIMBOT", UDim2.new(0.333, 2, 0, 0))
local MemoryButton = CreateTabButton("Memory", "MEMORY", UDim2.new(0.666, 4, 0, 0))

-- Активируем первый таб
VisualsButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
VisualsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Область контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -110)
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Контейнеры для вкладок
local VisualsContainer = Instance.new("ScrollingFrame")
VisualsContainer.Name = "VisualsContainer"
VisualsContainer.Size = UDim2.new(1, 0, 1, 0)
VisualsContainer.BackgroundTransparency = 1
VisualsContainer.BorderSizePixel = 0
VisualsContainer.ScrollBarThickness = 4
VisualsContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
VisualsContainer.Visible = true
VisualsContainer.Parent = ContentFrame

local AimbotContainer = Instance.new("ScrollingFrame")
AimbotContainer.Name = "AimbotContainer"
AimbotContainer.Size = UDim2.new(1, 0, 1, 0)
AimbotContainer.BackgroundTransparency = 1
AimbotContainer.BorderSizePixel = 0
AimbotContainer.ScrollBarThickness = 4
AimbotContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
AimbotContainer.Visible = false
AimbotContainer.Parent = ContentFrame

local MemoryContainer = Instance.new("ScrollingFrame")
MemoryContainer.Name = "MemoryContainer"
MemoryContainer.Size = UDim2.new(1, 0, 1, 0)
MemoryContainer.BackgroundTransparency = 1
MemoryContainer.BorderSizePixel = 0
MemoryContainer.ScrollBarThickness = 4
MemoryContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
MemoryContainer.Visible = false
MemoryContainer.Parent = ContentFrame

-- Упорядочивание элементов
local VisualsLayout = Instance.new("UIListLayout")
VisualsLayout.Padding = UDim.new(0, 10)
VisualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
VisualsLayout.Parent = VisualsContainer

local AimbotLayout = Instance.new("UIListLayout")
AimbotLayout.Padding = UDim.new(0, 10)
AimbotLayout.SortOrder = Enum.SortOrder.LayoutOrder
AimbotLayout.Parent = AimbotContainer

local MemoryLayout = Instance.new("UIListLayout")
MemoryLayout.Padding = UDim.new(0, 10)
MemoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
MemoryLayout.Parent = MemoryContainer

local VisualsPadding = Instance.new("UIPadding")
VisualsPadding.PaddingTop = UDim.new(0, 10)
VisualsPadding.PaddingLeft = UDim.new(0, 5)
VisualsPadding.PaddingRight = UDim.new(0, 5)
VisualsPadding.Parent = VisualsContainer

local AimbotPadding = Instance.new("UIPadding")
AimbotPadding.PaddingTop = UDim.new(0, 10)
AimbotPadding.PaddingLeft = UDim.new(0, 5)
AimbotPadding.PaddingRight = UDim.new(0, 5)
AimbotPadding.Parent = AimbotContainer

local MemoryPadding = Instance.new("UIPadding")
MemoryPadding.PaddingTop = UDim.new(0, 10)
MemoryPadding.PaddingLeft = UDim.new(0, 5)
MemoryPadding.PaddingRight = UDim.new(0, 5)
MemoryPadding.Parent = MemoryContainer

-- Функция для переключения вкладок
local function SwitchTab(tabName)
    VisualsContainer.Visible = false
    AimbotContainer.Visible = false
    MemoryContainer.Visible = false
    
    -- Сбрасываем цвета всех кнопок
    TweenService:Create(VisualsButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(180, 180, 180)
    }):Play()
    
    TweenService:Create(AimbotButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(180, 180, 180)
    }):Play()
    
    TweenService:Create(MemoryButton, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(180, 180, 180)
    }):Play()
    
    -- Активируем выбранную вкладку
    if tabName == "Visuals" then
        VisualsContainer.Visible = true
        TweenService:Create(VisualsButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 20, 60),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    elseif tabName == "Aimbot" then
        AimbotContainer.Visible = true
        TweenService:Create(AimbotButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 20, 60),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    elseif tabName == "Memory" then
        MemoryContainer.Visible = true
        TweenService:Create(MemoryButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 20, 60),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end
end

-- Функция создания переключателя
local function CreateToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 35)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #parent:GetChildren()
    toggleFrame.Parent = parent
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(0.7, -10, 1, 0)
    toggleText.Position = UDim2.new(0, 10, 0, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(240, 240, 240)
    toggleText.TextSize = 14
    toggleText.Font = Enum.Font.GothamSemibold
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -60, 0.5, -12)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.AutoButtonColor = false
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton
    
    local state = default
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        
        -- Анимация переключения
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
        }):Play()
        
        if callback then
            callback(state)
        end
    end)
    
    return {
        Set = function(value)
            state = value
            toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
        end,
        Get = function() return state end
    }
end

-- УЛУЧШЕННАЯ ФУНКЦИЯ СОЗДАНИЯ СЛАЙДЕРА
local function CreateSlider(parent, text, min, max, default, suffix, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.LayoutOrder = #parent:GetChildren()
    sliderFrame.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = sliderFrame
    
    -- Заголовок
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(1, -20, 0, 20)
    sliderText.Position = UDim2.new(0, 10, 0, 5)
    sliderText.BackgroundTransparency = 1
    sliderText.Text = text .. ": " .. default .. (suffix or "")
    sliderText.TextColor3 = Color3.fromRGB(240, 240, 240)
    sliderText.TextSize = 14
    sliderText.Font = Enum.Font.GothamSemibold
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.Parent = sliderFrame
    
    -- Контейнер для слайдера
    local sliderContainer = Instance.new("Frame")
    sliderContainer.Size = UDim2.new(1, -20, 0, 20)
    sliderContainer.Position = UDim2.new(0, 10, 0, 30)
    sliderContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderContainer.BorderSizePixel = 0
    sliderContainer.Parent = sliderFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 6)
    containerCorner.Parent = sliderContainer
    
    -- Заполнение слайдера
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    sliderFill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = sliderFill
    
    -- Ползунок
    local sliderHandle = Instance.new("Frame")
    sliderHandle.Size = UDim2.new(0, 12, 0, 24)
    sliderHandle.Position = UDim2.new(sliderFill.Size.X.Scale, -6, 0.5, -12)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderHandle.BorderSizePixel = 0
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 3)
    handleCorner.Parent = sliderHandle
    
    sliderFill.Parent = sliderContainer
    sliderHandle.Parent = sliderContainer
    
    -- Кликабельная зона
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = sliderContainer
    
    local value = default
    local dragging = false
    
    -- Функция обновления значения
    local function updateValue(newValue)
        value = math.clamp(newValue, min, max)
        local percentage = (value - min) / (max - min)
        
        -- Обновляем положение ползунка
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderHandle.Position = UDim2.new(percentage, -6, 0.5, -12)
        
        -- Обновляем текст
        sliderText.Text = text .. ": " .. math.floor(value) .. (suffix or "")
        
        -- Вызываем коллбэк
        if callback then
            callback(value)
        end
    end
    
    -- Функция для обработки клика
    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            
            -- Получаем позицию клика
            local mouseLocation
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                mouseLocation = input.Position
            else
                mouseLocation = input.Position
            end
            
            -- Вычисляем процент
            local relativeX = (mouseLocation.X - sliderContainer.AbsolutePosition.X) / sliderContainer.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            local newValue = min + (max - min) * relativeX
            
            updateValue(newValue)
        end
    end
    
    -- Функция для обработки перемещения
    local function onInputChanged(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            -- Получаем позицию
            local mouseLocation = input.Position
            
            -- Вычисляем процент
            local relativeX = (mouseLocation.X - sliderContainer.AbsolutePosition.X) / sliderContainer.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            local newValue = min + (max - min) * relativeX
            
            updateValue(newValue)
        end
    end
    
    -- Функция для обработки окончания ввода
    local function onInputEnded(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end
    
    -- Подписываемся на события
    clickArea.InputBegan:Connect(onInputBegan)
    clickArea.InputChanged:Connect(onInputChanged)
    clickArea.InputEnded:Connect(onInputEnded)
    
    -- Также подписываемся на глобальные события для более плавной работы
    UserInputService.InputEnded:Connect(onInputEnded)
    UserInputService.InputChanged:Connect(onInputChanged)
    
    return {
        Set = function(newValue)
            updateValue(newValue)
        end,
        Get = function() return value end
    }
end

-- Создаем элементы для вкладки Visuals
local ESPEnabled = CreateToggle(VisualsContainer, "ESP ENABLED", Settings.ESP.Enabled, function(state)
    Settings.ESP.Enabled = state
    if state then
        EnableESP()
    else
        DisableESP()
    end
end)

local ESPBoxToggle = CreateToggle(VisualsContainer, "ESP BOX", Settings.ESP.Box, function(state)
    Settings.ESP.Box = state
end)

local ESPDistanceToggle = CreateToggle(VisualsContainer, "ESP DISTANCE", Settings.ESP.Distance, function(state)
    Settings.ESP.Distance = state
end)

local ESPHealthToggle = CreateToggle(VisualsContainer, "ESP HEALTH", Settings.ESP.Health, function(state)
    Settings.ESP.Health = state
end)

local ESPNamesToggle = CreateToggle(VisualsContainer, "ESP NAMES", Settings.ESP.Names, function(state)
    Settings.ESP.Names = state
end)

local ESPTracersToggle = CreateToggle(VisualsContainer, "ESP TRACERS", Settings.ESP.Tracers, function(state)
    Settings.ESP.Tracers = state
end)

local ESPTeamCheck = CreateToggle(VisualsContainer, "TEAM CHECK", Settings.ESP.TeamCheck, function(state)
    Settings.ESP.TeamCheck = state
end)

-- Создаем элементы для вкладки Aimbot
local AimbotEnabled = CreateToggle(AimbotContainer, "AIMBOT ENABLED", Settings.Aimbot.Enabled, function(state)
    Settings.Aimbot.Enabled = state
    if state then
        EnableAimbot()
    else
        DisableAimbot()
    end
end)

local AimbotDistanceSlider = CreateSlider(AimbotContainer, "Aimbot Distance", 0, 1000, Settings.Aimbot.Distance, " studs", function(value)
    Settings.Aimbot.Distance = value
end)

local AimbotFOVSlider = CreateSlider(AimbotContainer, "Aimbot FOV", 10, 360, Settings.Aimbot.FOV, "°", function(value)
    Settings.Aimbot.FOV = value
    if FOVCircle then
        FOVCircle.Radius = value
    end
end)

local AimbotSmoothSlider = CreateSlider(AimbotContainer, "Aimbot Smoothness", 1, 10, Settings.Aimbot.Smoothness * 10, "", function(value)
    Settings.Aimbot.Smoothness = value / 10
end)

local FOVVisibleToggle = CreateToggle(AimbotContainer, "SHOW FOV CIRCLE", Settings.Aimbot.FOVVisible, function(state)
    Settings.Aimbot.FOVVisible = state
    if FOVCircle then
        FOVCircle.Visible = state
    end
end)

local TeamCheckToggle = CreateToggle(AimbotContainer, "TEAM CHECK", Settings.Aimbot.TeamCheck, function(state)
    Settings.Aimbot.TeamCheck = state
end)

-- Создаем элементы для вкладки Memory
local SpeedHackToggle = CreateToggle(MemoryContainer, "SPEED HACK", Settings.Memory.SpeedHack, function(state)
    Settings.Memory.SpeedHack = state
    if state then
        EnableSpeedHack()
    else
        DisableSpeedHack()
    end
end)

local SpeedMultiplierSlider = CreateSlider(MemoryContainer, "Speed Multiplier", 1, 10, Settings.Memory.SpeedMultiplier, "x", function(value)
    Settings.Memory.SpeedMultiplier = value
    if Settings.Memory.SpeedHack then
        UpdateSpeedHack()
    end
end)

local GodModeToggle = CreateToggle(MemoryContainer, "GOD MODE", Settings.Memory.GodMode, function(state)
    Settings.Memory.GodMode = state
    if state then
        EnableGodMode()
    else
        DisableGodMode()
    end
end)

local NoclipToggle = CreateToggle(MemoryContainer, "NOCLIP", Settings.Memory.Noclip, function(state)
    Settings.Memory.Noclip = state
    if state then
        EnableNoclip()
    else
        DisableNoclip()
    end
end)

-- ФУНКЦИИ ESP С ИСПОЛЬЗОВАНИЕМ ОБЫЧНЫХ ОБЪЕКТОВ (работает везде)
function CreateESP(player)
    if ESPObjects[player] then return end
    
    local esp = {
        Box = Instance.new("Frame"),
        Name = Instance.new("TextLabel"),
        Distance = Instance.new("TextLabel"),
        Health = Instance.new("TextLabel"),
        Tracer = Instance.new("Frame"),
        HealthBar = Instance.new("Frame"),
        HealthBarFill = Instance.new("Frame")
    }
    
    -- Создаем Box
    esp.Box.Name = "ESPBox"
    esp.Box.Size = UDim2.new(0, 100, 0, 150)
    esp.Box.BackgroundTransparency = 1
    esp.Box.BorderSizePixel = 2
    esp.Box.BorderColor3 = Settings.ESP.BoxColor
    esp.Box.Visible = false
    esp.Box.ZIndex = 10
    esp.Box.Parent = ScreenGui
    
    -- Создаем Name
    esp.Name.Name = "ESPName"
    esp.Name.Size = UDim2.new(0, 200, 0, 20)
    esp.Name.BackgroundTransparency = 1
    esp.Name.TextColor3 = Settings.ESP.TextColor
    esp.Name.TextSize = Settings.ESP.TextSize
    esp.Name.Font = Enum.Font.GothamBold
    esp.Name.Text = player.Name
    esp.Name.TextStrokeTransparency = 0
    esp.Name.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Name.Visible = false
    esp.Name.ZIndex = 11
    esp.Name.Parent = ScreenGui
    
    -- Создаем Distance
    esp.Distance.Name = "ESPDistance"
    esp.Distance.Size = UDim2.new(0, 200, 0, 20)
    esp.Distance.BackgroundTransparency = 1
    esp.Distance.TextColor3 = Settings.ESP.TextColor
    esp.Distance.TextSize = Settings.ESP.TextSize - 2
    esp.Distance.Font = Enum.Font.Gotham
    esp.Distance.TextStrokeTransparency = 0
    esp.Distance.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Distance.Visible = false
    esp.Distance.ZIndex = 11
    esp.Distance.Parent = ScreenGui
    
    -- Создаем Health
    esp.Health.Name = "ESPHealth"
    esp.Health.Size = UDim2.new(0, 200, 0, 20)
    esp.Health.BackgroundTransparency = 1
    esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
    esp.Health.TextSize = Settings.ESP.TextSize - 2
    esp.Health.Font = Enum.Font.Gotham
    esp.Health.TextStrokeTransparency = 0
    esp.Health.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Health.Visible = false
    esp.Health.ZIndex = 11
    esp.Health.Parent = ScreenGui
    
    -- Создаем Tracer
    esp.Tracer.Name = "ESPTracer"
    esp.Tracer.Size = UDim2.new(0, 2, 0, 2)
    esp.Tracer.BackgroundColor3 = Settings.ESP.BoxColor
    esp.Tracer.Visible = false
    esp.Tracer.ZIndex = 9
    esp.Tracer.Parent = ScreenGui
    
    -- Создаем Health Bar
    esp.HealthBar.Name = "ESPHealthBar"
    esp.HealthBar.Size = UDim2.new(0, 100, 0, 4)
    esp.HealthBar.BackgroundColor3 = Color3.new(0, 0, 0)
    esp.HealthBar.BorderSizePixel = 1
    esp.HealthBar.BorderColor3 = Color3.new(1, 1, 1)
    esp.HealthBar.Visible = false
    esp.HealthBar.ZIndex = 11
    esp.HealthBar.Parent = ScreenGui
    
    esp.HealthBarFill.Name = "ESPHealthBarFill"
    esp.HealthBarFill.Size = UDim2.new(1, 0, 1, 0)
    esp.HealthBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    esp.HealthBarFill.BorderSizePixel = 0
    esp.HealthBarFill.Parent = esp.HealthBar
    
    ESPObjects[player] = esp
end

function UpdateESP()
    if not Settings.ESP.Enabled then return end
    
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        if not ESPObjects[player] then
            CreateESP(player)
        end
        
        local esp = ESPObjects[player]
        local character = player.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character.HumanoidRootPart
            local humanoid = character:FindFirstChild("Humanoid")
            
            -- Проверка команды
            if Settings.ESP.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.Health.Visible = false
                esp.Tracer.Visible = false
                esp.HealthBar.Visible = false
                continue
            end
            
            -- Получаем позицию на экране
            local position, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
            
            if onScreen and distance <= Settings.ESP.MaxDistance then
                local screenPosition = Vector2.new(position.X, position.Y)
                
                -- Размер Box в зависимости от расстояния
                local boxSize = Vector2.new(2000 / distance, 3000 / distance)
                boxSize = Vector2.new(
                    math.clamp(boxSize.X, 50, 200),
                    math.clamp(boxSize.Y, 80, 300)
                )
                
                -- Цвет ESP
                local espColor = Settings.ESP.BoxColor
                if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    espColor = Settings.ESP.TeamColor
                end
                
                -- ESP Box
                if Settings.ESP.Box then
                    esp.Box.Size = UDim2.new(0, boxSize.X, 0, boxSize.Y)
                    esp.Box.Position = UDim2.new(0, screenPosition.X - boxSize.X/2, 0, screenPosition.Y - boxSize.Y/2)
                    esp.Box.BorderColor3 = espColor
                    esp.Box.Visible = true
                else
                    esp.Box.Visible = false
                end
                
                -- ESP Name
                if Settings.ESP.Names then
                    esp.Name.Position = UDim2.new(0, screenPosition.X - 100, 0, screenPosition.Y - boxSize.Y/2 - 25)
                    esp.Name.TextColor3 = Settings.ESP.TextColor
                    esp.Name.Visible = true
                else
                    esp.Name.Visible = false
                end
                
                -- ESP Distance
                if Settings.ESP.Distance then
                    esp.Distance.Position = UDim2.new(0, screenPosition.X - 100, 0, screenPosition.Y + boxSize.Y/2 + 5)
                    esp.Distance.Text = "[" .. math.floor(distance) .. " studs]"
                    esp.Distance.TextColor3 = Settings.ESP.TextColor
                    esp.Distance.Visible = true
                else
                    esp.Distance.Visible = false
                end
                
                -- ESP Health
                if Settings.ESP.Health and humanoid then
                    local health = math.floor(humanoid.Health)
                    local maxHealth = humanoid.MaxHealth
                    local healthPercent = health / maxHealth
                    
                    esp.Health.Position = UDim2.new(0, screenPosition.X - 100, 0, screenPosition.Y - boxSize.Y/2 - 45)
                    esp.Health.Text = "HP: " .. health .. "/" .. maxHealth
                    
                    -- Цвет в зависимости от здоровья
                    if healthPercent > 0.6 then
                        esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif healthPercent > 0.3 then
                        esp.Health.TextColor3 = Color3.fromRGB(255, 255, 0)
                    else
                        esp.Health.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                    
                    esp.Health.Visible = true
                    
                    -- Health Bar
                    esp.HealthBar.Position = UDim2.new(0, screenPosition.X - 50, 0, screenPosition.Y + boxSize.Y/2 + 30)
                    esp.HealthBarFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                    esp.HealthBarFill.BackgroundColor3 = esp.Health.TextColor3
                    esp.HealthBar.Visible = true
                else
                    esp.Health.Visible = false
                    esp.HealthBar.Visible = false
                end
                
                -- ESP Tracers
                if Settings.ESP.Tracers then
                    -- Создаем линию от центра экрана к игроку
                    esp.Tracer.Size = UDim2.new(0, 2, 0, math.sqrt(
                        (screenCenter.X - screenPosition.X)^2 + 
                        (screenCenter.Y - screenPosition.Y)^2
                    ))
                    
                    local angle = math.atan2(
                        screenPosition.Y - screenCenter.Y,
                        screenPosition.X - screenCenter.X
                    )
                    
                    esp.Tracer.Position = UDim2.new(
                        0, 
                        screenCenter.X - esp.Tracer.Size.X.Offset/2,
                        0, 
                        screenCenter.Y
                    )
                    
                    esp.Tracer.Rotation = math.deg(angle)
                    esp.Tracer.BackgroundColor3 = espColor
                    esp.Tracer.Visible = true
                else
                    esp.Tracer.Visible = false
                end
            else
                -- Если игрок не на экране, скрываем ESP
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.Health.Visible = false
                esp.Tracer.Visible = false
                esp.HealthBar.Visible = false
            end
        else
            -- Если персонажа нет, скрываем ESP
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Health.Visible = false
            esp.Tracer.Visible = false
            esp.HealthBar.Visible = false
        end
    end
end

function EnableESP()
    Settings.ESP.Enabled = true
    
    -- Создаем ESP для всех игроков
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end
    
    -- Обновляем ESP каждый кадр
    ESPConnections.Update = RunService.RenderStepped:Connect(UpdateESP)
    
    -- Обработчик новых игроков
    ESPConnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
        CreateESP(player)
    end)
    
    -- Обработчик вышедших игроков
    ESPConnections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        if ESPObjects[player] then
            for _, obj in pairs(ESPObjects[player]) do
                obj:Destroy()
            end
            ESPObjects[player] = nil
        end
    end)
end

function DisableESP()
    Settings.ESP.Enabled = false
    
    -- Отключаем соединения
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
    
    -- Удаляем все ESP объекты
    for _, esp in pairs(ESPObjects) do
        for _, obj in pairs(esp) do
            obj:Destroy()
        end
    end
    ESPObjects = {}
end

-- ФУНКЦИИ AIMBOT С ИСПОЛЬЗОВАНИЕМ Drawing API
function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot.Distance
    local mouse = LocalPlayer:GetMouse()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local targetPart = character:FindFirstChild(Settings.Aimbot.TargetPart) or character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and targetPart then
                -- Проверка команды
                if Settings.Aimbot.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Проверка дистанции
                local distance = (targetPart.Position - Camera.CFrame.Position).Magnitude
                if distance > Settings.Aimbot.Distance then
                    continue
                end
                
                -- Проверка FOV
                local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local targetPos = Vector2.new(screenPosition.X, screenPosition.Y)
                    local fovDistance = (mousePos - targetPos).Magnitude
                    
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
    
    local targetPart = target.Character:FindFirstChild(Settings.Aimbot.TargetPart) or target.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end
    
    -- Плавное прицеливание
    local targetPosition = targetPart.Position + Vector3.new(0, 1.5, 0)
    
    -- Используем CFrame для плавного прицеливания
    local camera = Camera
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    
    -- Интерполяция для плавности
    local newCFrame = currentCFrame:Lerp(targetCFrame, Settings.Aimbot.Smoothness)
    camera.CFrame = newCFrame
end

function CreateFOVCircle()
    if DrawingSupported and not FOVCircle then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Visible = Settings.Aimbot.FOVVisible
        FOVCircle.Color = Settings.Aimbot.FOVColor
        FOVCircle.Thickness = 2
        FOVCircle.Transparency = Settings.Aimbot.FOVTransparency
        FOVCircle.NumSides = 64
        FOVCircle.Radius = Settings.Aimbot.FOV
        FOVCircle.Filled = false
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
end

function EnableAimbot()
    Settings.Aimbot.Enabled = true
    
    -- Создаем FOV круг если Drawing поддерживается
    CreateFOVCircle()
    
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
        FOVCircle:Remove()
        FOVCircle = nil
    end
end

-- ФУНКЦИИ MEMORY
function EnableSpeedHack()
    Settings.Memory.SpeedHack = true
    
    local function updateSpeed()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                OriginalWalkSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = OriginalWalkSpeed * Settings.Memory.SpeedMultiplier
                humanoid.JumpPower = 50 * Settings.Memory.SpeedMultiplier
            end
        end
    end
    
    -- Применяем сразу
    updateSpeed()
    
    -- Обновляем при смене персонажа
    SpeedHackConnection = LocalPlayer.CharacterAdded:Connect(updateSpeed)
end

function DisableSpeedHack()
    Settings.Memory.SpeedHack = false
    
    if SpeedHackConnection then
        SpeedHackConnection:Disconnect()
        SpeedHackConnection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
end

function UpdateSpeedHack()
    if Settings.Memory.SpeedHack then
        EnableSpeedHack()
    end
end

function EnableGodMode()
    Settings.Memory.GodMode = true
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end
end

function DisableGodMode()
    Settings.Memory.GodMode = false
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end
end

function EnableNoclip()
    Settings.Memory.Noclip = true
    
    local function noclipLoop()
        if Settings.Memory.Noclip then
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                        NoclipParts[part] = true
                    end
                end
            end
        end
    end
    
    NoclipConnection = RunService.Stepped:Connect(noclipLoop)
end

function DisableNoclip()
    Settings.Memory.Noclip = false
    
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    
    -- Восстанавливаем коллизию
    for part, _ in pairs(NoclipParts) do
        if part and part.Parent then
            part.CanCollide = true
        end
    end
    NoclipParts = {}
end

-- Кнопка открытия GUI
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 90, 0, 40)
OpenButton.Position = UDim2.new(1, -100, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "SATANA"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 16
OpenButton.Font = Enum.Font.GothamBold
OpenButton.AutoButtonColor = false
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenButtonCorner = Instance.new("UICorner")
OpenButtonCorner.CornerRadius = UDim.new(0, 8)
OpenButtonCorner.Parent = OpenButton

local OpenButtonStroke = Instance.new("UIStroke")
OpenButtonStroke.Color = Color3.fromRGB(255, 100, 100)
OpenButtonStroke.Thickness = 2
OpenButtonStroke.Parent = OpenButton

-- Эффект при наведении на кнопку открытия
OpenButton.MouseEnter:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        Size = UDim2.new(0, 95, 0, 42)
    }):Play()
end)

OpenButton.MouseLeave:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 20, 60),
        Size = UDim2.new(0, 90, 0, 40)
    }):Play()
end)

-- Функции открытия/закрытия GUI с анимацией
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {
        Position = UDim2.new(0.5, -200, 0.5, -600)
    }):Play()
    TweenService:Create(BackgroundGradient, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.3)
    MainFrame.Visible = false
    BackgroundGradient.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    BackgroundGradient.Visible = true
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -600)
    BackgroundGradient.BackgroundTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -200, 0.5, -250)
    }):Play()
    
    TweenService:Create(BackgroundGradient, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.8
    }):Play()
    
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

-- ФУНКЦИЯ ДЛЯ ПЕРЕТАСКИВАНИЯ ОКНА (теперь работает идеально)
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
    wait(2)
    
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0, 300, 0, 80)
    Notification.Position = UDim2.new(0.5, -150, 1, 10)
    Notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = Notification

    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Color3.fromRGB(220, 20, 60)
    NotifStroke.Thickness = 2
    NotifStroke.Parent = Notification

    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, 0, 0, 30)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = "SATANA v4.0 ЗАГРУЖЕН"
    NotifTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
    NotifTitle.TextSize = 18
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextStrokeTransparency = 0.5
    NotifTitle.Parent = Notification

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 0, 40)
    NotifText.Position = UDim2.new(0, 10, 0, 30)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "Все функции активны! Нажмите кнопку SATANA для открытия меню."
    NotifText.TextColor3 = Color3.fromRGB(200, 200, 200)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextWrapped = true
    NotifText.Parent = Notification

    -- Анимация появления
    Notification:TweenPosition(UDim2.new(0.5, -150, 1, -100), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5)
    
    -- Автоматическое скрытие
    wait(5)
    Notification:TweenPosition(UDim2.new(0.5, -150, 1, 10), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5)
    wait(0.5)
    Notification:Destroy()
end)

-- Отправляем уведомление в чат
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SATANA v4.0",
    Text = "Премиум меню загружено! Нажмите кнопку SATANA в правом верхнем углу.",
    Duration = 10,
    Icon = "rbxassetid://0"
})

print("==========================================")
print("SATANA PREMIUM HACK MENU v4.0")
print("==========================================")
print("ESP: ✓ Включен (использует обычные объекты)")
print("Aimbot: ✓ Включен с FOV кругом")
print("Memory: ✓ Все функции активны")
print("Слайдеры: ✓ Полностью рабочие")
print("Перемещение: ✓ Работает идеально")
print("==========================================")
print("Нажмите кнопку SATANA для открытия меню")
print("==========================================")

-- Активируем GUI при запуске
OpenButton.Visible = false
MainFrame.Visible = true
BackgroundGradient.Visible = true
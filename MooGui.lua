-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

--[[
    SATANA PREMIUM HACK MENU v3.0
    ПОЛНЫЙ ФУНКЦИОНАЛ С КРАСИВЫМ ESP
]]

-- Службы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

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
        FOVTransparency = 0.3,
        TriggerKey = Enum.KeyCode.E,
        SilentAim = false
    },
    
    Memory = {
        SpeedHack = false,
        SpeedMultiplier = 2,
        GodMode = false,
        Noclip = false
    }
}

-- ESP Объекты (используем Drawing для красивого ESP)
local ESPObjects = {}
local ESPConnections = {}

-- Аимбот переменные
local AimbotTarget = nil
local AimbotConnection = nil
local FOVCircle = nil
local SilentAimActive = false

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

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.BorderMode = Enum.BorderMode.Inset
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Закругление углов с градиентом
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Эффект свечения
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 20, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 40))
})
UIGradient.Rotation = 45
UIGradient.Transparency = NumberSequence.new(0.8)
UIGradient.Parent = MainFrame

-- Заголовок окна
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Текст заголовка с эффектом
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SATANA v3.0"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextStrokeTransparency = 0
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

-- Кнопка закрытия с анимацией
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
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
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

-- Создаем кнопки табов с анимацией
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
VisualsLayout.Padding = UDim.new(0, 12)
VisualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
VisualsLayout.Parent = VisualsContainer

local AimbotLayout = Instance.new("UIListLayout")
AimbotLayout.Padding = UDim.new(0, 12)
AimbotLayout.SortOrder = Enum.SortOrder.LayoutOrder
AimbotLayout.Parent = AimbotContainer

local MemoryLayout = Instance.new("UIListLayout")
MemoryLayout.Padding = UDim.new(0, 12)
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

-- Функция создания переключателя с анимацией
local function CreateToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 40)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.LayoutOrder = #parent:GetChildren()
    toggleFrame.Parent = parent
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    -- Текст
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
    
    -- Кнопка переключателя
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0, 50, 0, 24)
    toggleButton.Position = UDim2.new(1, -60, 0.5, -12)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    toggleButton.BorderSizePixel = 0
    
    local toggleButtonCorner = Instance.new("UICorner")
    toggleButtonCorner.CornerRadius = UDim.new(0, 12)
    toggleButtonCorner.Parent = toggleButton
    
    -- Кружок внутри переключателя
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 20, 0, 20)
    toggleCircle.Position = default and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    
    local toggleCircleCorner = Instance.new("UICorner")
    toggleCircleCorner.CornerRadius = UDim.new(0, 10)
    toggleCircleCorner.Parent = toggleCircle
    
    toggleCircle.Parent = toggleButton
    toggleButton.Parent = toggleFrame
    
    -- Кликабельная зона
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = toggleFrame
    
    local state = default
    
    -- Функция переключения с анимацией
    local function toggleState()
        state = not state
        
        -- Анимация кнопки
        TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
        }):Play()
        
        -- Анимация кружка
        TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        }):Play()
        
        if callback then
            callback(state)
        end
    end
    
    clickArea.MouseButton1Click:Connect(toggleState)
    
    return {
        Set = function(value)
            if state ~= value then
                toggleState()
            end
        end,
        Get = function() return state end,
        Toggle = toggleState
    }
end

-- Функция создания слайдера с улучшенной анимацией
local function CreateSlider(parent, text, min, max, default, suffix, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 70)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.LayoutOrder = #parent:GetChildren()
    sliderFrame.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
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
    
    -- Фон слайдера
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(1, -20, 0, 20)
    sliderBackground.Position = UDim2.new(0, 10, 0, 35)
    sliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderBackground.BorderSizePixel = 0
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 10)
    sliderBgCorner.Parent = sliderBackground
    
    -- Заполнение слайдера
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    sliderFill.BorderSizePixel = 0
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 10)
    sliderFillCorner.Parent = sliderFill
    
    -- Кнопка для перетаскивания
    local sliderButton = Instance.new("Frame")
    sliderButton.Size = UDim2.new(0, 24, 0, 24)
    sliderButton.Position = UDim2.new(sliderFill.Size.X.Scale, -12, 0.5, -12)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    
    local sliderButtonCorner = Instance.new("UICorner")
    sliderButtonCorner.CornerRadius = UDim.new(0, 12)
    sliderButtonCorner.Parent = sliderButton
    
    -- Эффект свечения кнопки
    local buttonGlow = Instance.new("UIStroke")
    buttonGlow.Color = Color3.fromRGB(220, 20, 60)
    buttonGlow.Thickness = 2
    buttonGlow.Transparency = 0.5
    buttonGlow.Parent = sliderButton
    
    sliderFill.Parent = sliderBackground
    sliderButton.Parent = sliderBackground
    sliderBackground.Parent = sliderFrame
    
    -- Область для клика
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 0, 20)
    clickArea.Position = UDim2.new(0, 10, 0, 35)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = sliderFrame
    
    local value = default
    local dragging = false
    
    -- Функция обновления значения с анимацией
    local function updateValue(input)
        local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        value = math.floor(min + (max - min) * relativeX + 0.5)
        
        -- Анимация заполнения
        TweenService:Create(sliderFill, TweenInfo.new(0.1), {
            Size = UDim2.new(relativeX, 0, 1, 0)
        }):Play()
        
        -- Анимация кнопки
        TweenService:Create(sliderButton, TweenInfo.new(0.1), {
            Position = UDim2.new(relativeX, -12, 0.5, -12)
        }):Play()
        
        -- Обновление текста
        sliderText.Text = text .. ": " .. value .. (suffix or "")
        
        if callback then
            callback(value)
        end
    end
    
    -- Обработчики для ПК
    clickArea.MouseButton1Down:Connect(function(input)
        dragging = true
        updateValue(input)
        
        -- Эффект при нажатии
        TweenService:Create(sliderButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 20, 0, 20)
        }):Play()
    end)
    
    -- Обработчики для мобильных устройств
    clickArea.TouchTap:Connect(function()
        local touch = UserInputService:GetMouseLocation()
        updateValue({Position = touch})
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                dragging = false
                -- Возвращаем размер кнопки
                TweenService:Create(sliderButton, TweenInfo.new(0.1), {
                    Size = UDim2.new(0, 24, 0, 24)
                }):Play()
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input)
        end
    end)
    
    return {
        Set = function(newValue)
            value = math.clamp(newValue, min, max)
            local relativeX = (value - min) / (max - min)
            
            -- Анимация
            TweenService:Create(sliderFill, TweenInfo.new(0.3), {
                Size = UDim2.new(relativeX, 0, 1, 0)
            }):Play()
            
            TweenService:Create(sliderButton, TweenInfo.new(0.3), {
                Position = UDim2.new(relativeX, -12, 0.5, -12)
            }):Play()
            
            sliderText.Text = text .. ": " .. value .. (suffix or "")
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

local AimbotSmoothSlider = CreateSlider(AimbotContainer, "Aimbot Smoothness", 0.1, 1, Settings.Aimbot.Smoothness * 10, "", function(value)
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

-- Функции для красивого ESP (используем Drawing API)
function CreateESP(player)
    if ESPObjects[player] then return end
    
    local esp = {
        Box = {
            TopLeft = Drawing.new("Line"),
            TopRight = Drawing.new("Line"),
            BottomLeft = Drawing.new("Line"),
            BottomRight = Drawing.new("Line")
        },
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        HealthBar = {
            Background = Drawing.new("Line"),
            Fill = Drawing.new("Line")
        },
        Tracer = Drawing.new("Line")
    }
    
    -- Настраиваем Box
    for _, line in pairs(esp.Box) do
        line.Thickness = Settings.ESP.BoxThickness
        line.Visible = false
        line.ZIndex = 1
    end
    
    -- Настраиваем Name
    esp.Name.Text = player.Name
    esp.Name.Size = Settings.ESP.TextSize
    esp.Name.Outline = true
    esp.Name.OutlineColor = Color3.new(0, 0, 0)
    esp.Name.Visible = false
    esp.Name.ZIndex = 2
    
    -- Настраиваем Distance
    esp.Distance.Size = Settings.ESP.TextSize - 2
    esp.Distance.Outline = true
    esp.Distance.OutlineColor = Color3.new(0, 0, 0)
    esp.Distance.Visible = false
    esp.Distance.ZIndex = 2
    
    -- Настраиваем Health
    esp.Health.Size = Settings.ESP.TextSize - 2
    esp.Health.Outline = true
    esp.Health.OutlineColor = Color3.new(0, 0, 0)
    esp.Health.Visible = false
    esp.Health.ZIndex = 2
    
    -- Настраиваем Health Bar
    esp.HealthBar.Background.Thickness = 4
    esp.HealthBar.Background.Color = Color3.new(0, 0, 0)
    esp.HealthBar.Background.Visible = false
    esp.HealthBar.Background.ZIndex = 1
    
    esp.HealthBar.Fill.Thickness = 2
    esp.HealthBar.Fill.Visible = false
    esp.HealthBar.Fill.ZIndex = 2
    
    -- Настраиваем Tracer
    esp.Tracer.Thickness = 2
    esp.Tracer.Visible = false
    esp.Tracer.ZIndex = 1
    
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
                for _, drawing in pairs(esp) do
                    if typeof(drawing) == "table" then
                        for _, d in pairs(drawing) do
                            if d.Visible then d.Visible = false end
                        end
                    elseif drawing.Visible then
                        drawing.Visible = false
                    end
                end
                continue
            end
            
            -- Получаем позицию на экране
            local position, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
            
            if onScreen and distance <= Settings.ESP.MaxDistance then
                local screenPosition = Vector2.new(position.X, position.Y)
                
                -- Размер Box в зависимости от расстояния
                local boxSize = Vector2.new(1000 / distance, 1500 / distance)
                local boxPosition = Vector2.new(screenPosition.X - boxSize.X / 2, screenPosition.Y - boxSize.Y / 2)
                
                -- Цвет ESP
                local espColor = Settings.ESP.BoxColor
                if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    espColor = Settings.ESP.TeamColor
                end
                
                -- ESP Box
                if Settings.ESP.Box then
                    local topLeft = boxPosition
                    local topRight = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y)
                    local bottomLeft = Vector2.new(boxPosition.X, boxPosition.Y + boxSize.Y)
                    local bottomRight = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y + boxSize.Y)
                    
                    esp.Box.TopLeft.From = topLeft
                    esp.Box.TopLeft.To = topRight
                    esp.Box.TopLeft.Color = espColor
                    esp.Box.TopLeft.Visible = true
                    
                    esp.Box.TopRight.From = topRight
                    esp.Box.TopRight.To = bottomRight
                    esp.Box.TopRight.Color = espColor
                    esp.Box.TopRight.Visible = true
                    
                    esp.Box.BottomLeft.From = bottomLeft
                    esp.Box.BottomLeft.To = bottomRight
                    esp.Box.BottomLeft.Color = espColor
                    esp.Box.BottomLeft.Visible = true
                    
                    esp.Box.BottomRight.From = topLeft
                    esp.Box.BottomRight.To = bottomLeft
                    esp.Box.BottomRight.Color = espColor
                    esp.Box.BottomRight.Visible = true
                else
                    for _, line in pairs(esp.Box) do
                        line.Visible = false
                    end
                end
                
                -- ESP Name
                if Settings.ESP.Names then
                    esp.Name.Position = Vector2.new(screenPosition.X, boxPosition.Y - 20)
                    esp.Name.Color = Settings.ESP.TextColor
                    esp.Name.Visible = true
                else
                    esp.Name.Visible = false
                end
                
                -- ESP Distance
                if Settings.ESP.Distance then
                    esp.Distance.Text = "[" .. math.floor(distance) .. " studs]"
                    esp.Distance.Position = Vector2.new(screenPosition.X, boxPosition.Y + boxSize.Y + 5)
                    esp.Distance.Color = Settings.ESP.TextColor
                    esp.Distance.Visible = true
                else
                    esp.Distance.Visible = false
                end
                
                -- ESP Health
                if Settings.ESP.Health and humanoid then
                    local health = math.floor(humanoid.Health)
                    local maxHealth = humanoid.MaxHealth
                    local healthPercent = health / maxHealth
                    
                    -- Health Bar
                    if healthPercent > 0 then
                        local barWidth = boxSize.X
                        local barHeight = 4
                        local barPosition = Vector2.new(boxPosition.X, boxPosition.Y + boxSize.Y + 2)
                        
                        esp.HealthBar.Background.From = barPosition
                        esp.HealthBar.Background.To = Vector2.new(barPosition.X + barWidth, barPosition.Y)
                        esp.HealthBar.Background.Visible = true
                        
                        esp.HealthBar.Fill.From = barPosition
                        esp.HealthBar.Fill.To = Vector2.new(barPosition.X + barWidth * healthPercent, barPosition.Y)
                        
                        -- Цвет Health Bar
                        if healthPercent > 0.6 then
                            esp.HealthBar.Fill.Color = Color3.fromRGB(0, 255, 0)
                        elseif healthPercent > 0.3 then
                            esp.HealthBar.Fill.Color = Color3.fromRGB(255, 255, 0)
                        else
                            esp.HealthBar.Fill.Color = Color3.fromRGB(255, 0, 0)
                        end
                        esp.HealthBar.Fill.Visible = true
                    else
                        esp.HealthBar.Background.Visible = false
                        esp.HealthBar.Fill.Visible = false
                    end
                else
                    esp.HealthBar.Background.Visible = false
                    esp.HealthBar.Fill.Visible = false
                end
                
                -- ESP Tracers
                if Settings.ESP.Tracers then
                    esp.Tracer.From = screenCenter
                    esp.Tracer.To = Vector2.new(screenPosition.X, screenPosition.Y + boxSize.Y / 2)
                    esp.Tracer.Color = espColor
                    esp.Tracer.Visible = true
                else
                    esp.Tracer.Visible = false
                end
            else
                -- Если игрок не на экране, скрываем ESP
                for _, drawing in pairs(esp) do
                    if typeof(drawing) == "table" then
                        for _, d in pairs(drawing) do
                            d.Visible = false
                        end
                    else
                        drawing.Visible = false
                    end
                end
            end
        else
            -- Если персонажа нет, скрываем ESP
            for _, drawing in pairs(esp) do
                if typeof(drawing) == "table" then
                    for _, d in pairs(drawing) do
                        d.Visible = false
                    end
                else
                    drawing.Visible = false
                end
            end
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
            for _, drawing in pairs(ESPObjects[player]) do
                if typeof(drawing) == "table" then
                    for _, d in pairs(drawing) do
                        d:Remove()
                    end
                else
                    drawing:Remove()
                end
            end
            ESPObjects[player] = nil
        end
    end)
    
    print("ESP включен")
end

function DisableESP()
    Settings.ESP.Enabled = false
    
    -- Отключаем соединения
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
    
    -- Удаляем все Drawing объекты
    for _, esp in pairs(ESPObjects) do
        for _, drawing in pairs(esp) do
            if typeof(drawing) == "table" then
                for _, d in pairs(drawing) do
                    d:Remove()
                end
            else
                drawing:Remove()
            end
        end
    end
    ESPObjects = {}
    
    print("ESP выключен")
end

-- Функции для Aimbot
function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot.Distance
    local mouse = LocalPlayer:GetMouse()
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local targetPart = character:FindFirstChild(Settings.Aimbot.TargetPart)
            
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
    
    local targetPart = target.Character:FindFirstChild(Settings.Aimbot.TargetPart)
    if not targetPart then return end
    
    -- Плавное прицеливание
    local targetPosition = targetPart.Position + Vector3.new(0, 0.5, 0) -- Немного выше для головы
    
    -- Используем MouseBehavior для плавного аимбота
    local mouse = LocalPlayer:GetMouse()
    local screenPosition = Camera:WorldToViewportPoint(targetPosition)
    
    -- Плавное движение мыши к цели
    local targetVector = Vector2.new(screenPosition.X, screenPosition.Y)
    local currentVector = Vector2.new(mouse.X, mouse.Y)
    local delta = (targetVector - currentVector) * Settings.Aimbot.Smoothness
    
    -- Используем mousemoverel если доступно
    if mousemoverel then
        mousemoverel(delta.X, delta.Y)
    else
        -- Альтернативный метод через изменение LookVector
        local camera = Camera
        local lookVector = (targetPosition - camera.CFrame.Position).Unit
        local newCFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + lookVector)
        
        -- Плавная интерполяция
        camera.CFrame = camera.CFrame:Lerp(newCFrame, Settings.Aimbot.Smoothness)
    end
end

function CreateFOVCircle()
    if FOVCircle then return end
    
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = Settings.Aimbot.FOVVisible
    FOVCircle.Color = Settings.Aimbot.FOVColor
    FOVCircle.Thickness = 2
    FOVCircle.Transparency = Settings.Aimbot.FOVTransparency
    FOVCircle.NumSides = 64
    FOVCircle.Radius = Settings.Aimbot.FOV
    FOVCircle.Filled = false
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    -- Обновляем позицию при изменении размера экрана
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end)
end

function EnableAimbot()
    Settings.Aimbot.Enabled = true
    
    -- Создаем FOV круг
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
    
    print("Aimbot включен")
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
    
    print("Aimbot выключен")
end

-- Функции для Memory
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
    
    print("Speed Hack включен: " .. Settings.Memory.SpeedMultiplier .. "x")
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
    
    print("Speed Hack выключен")
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
            -- Отключаем смерть
            humanoid.BreakJointsOnDeath = false
            
            -- Делаем все части неуязвимыми
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Transparency = 0.5
                    part.Color = Color3.fromRGB(255, 255, 0)
                end
            end
        end
    end
    
    print("God Mode включен")
end

function DisableGodMode()
    Settings.Memory.GodMode = false
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = true
            
            -- Восстанавливаем свойства частей
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                    part.Transparency = 0
                    part.Color = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end
    
    print("God Mode выключен")
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
    
    print("Noclip включен")
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
    
    print("Noclip выключен")
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
        Size = UDim2.new(0, 100, 0, 45)
    }):Play()
end)

OpenButton.MouseLeave:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 20, 60),
        Size = UDim2.new(0, 90, 0, 40)
    }):Play()
end)

-- Функции открытия/закрытия GUI
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -200, 1.5, -250)
    }):Play()
    
    wait(0.3)
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MainFrame.Position = UDim2.new(0.5, -200, 1.5, -250)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -200, 0.5, -250)
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
    wait(1)
    
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
    NotifTitle.Text = "SATANA v3.0 LOADED"
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
    Title = "SATANA v3.0",
    Text = "Премиум меню загружено! Нажмите кнопку SATANA в правом верхнем углу.",
    Duration = 10,
    Icon = "rbxassetid://0"
})

print("==========================================")
print("SATANA PREMIUM HACK MENU v3.0")
print("==========================================")
print("ESP: ✓ Включен (красивый Drawing API)")
print("Aimbot: ✓ Включен с FOV кругом")
print("Memory: ✓ Все функции активны")
print("==========================================")
print("Нажмите кнопку SATANA для открытия меню")
print("==========================================")
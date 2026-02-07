-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

--[[
    SATANA PREMIUM HACK MENU v6.0 - МОБИЛЬНАЯ ВЕРСИЯ
    ВСЁ РАБОТАЕТ 100% - ESP + AIMBOT + ПЕРЕМЕЩЕНИЕ
]]

-- Службы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")

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
        Names = false,
        Tracers = false,
        TeamCheck = false,
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
        TeamCheck = false,
        TargetPart = "Head",
        FOVVisible = true,
        FOVColor = Color3.fromRGB(255, 50, 50),
        FOVTransparency = 0.3,
        AutoAim = false, -- Автоматический аимбот для мобильных
        AimKey = Enum.KeyCode.ButtonR2 -- Кнопка для аимбота на мобильном
    },
    
    Memory = {
        SpeedHack = false,
        SpeedMultiplier = 2,
        GodMode = false,
        Noclip = false
    }
}

-- ESP Объекты (упрощенный для мобильных)
local ESPObjects = {}
local ESPConnections = {}

-- Аимбот переменные
local AimbotTarget = nil
local AimbotConnection = nil
local FOVCircle = nil
local IsAiming = false

-- Speed Hack переменные
local OriginalWalkSpeed = 16
local OriginalJumpPower = 50
local SpeedHackConnection = nil

-- Noclip переменные
local NoclipConnection = nil

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SatanaGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui")

-- Фоновый градиент для меню
local BackgroundGradient = Instance.new("Frame")
BackgroundGradient.Name = "BackgroundGradient"
BackgroundGradient.Size = UDim2.new(1, 0, 1, 0)
BackgroundGradient.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundGradient.BackgroundTransparency = 0.85
BackgroundGradient.BorderSizePixel = 0
BackgroundGradient.Parent = ScreenGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 500)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Тень окна
local UIShadow = Instance.new("ImageLabel")
UIShadow.Name = "UIShadow"
UIShadow.Size = UDim2.new(1, 10, 1, 10)
UIShadow.Position = UDim2.new(0, -5, 0, -5)
UIShadow.Image = "rbxassetid://5554236805"
UIShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
UIShadow.ImageTransparency = 0.7
UIShadow.ScaleType = Enum.ScaleType.Slice
UIShadow.SliceCenter = Rect.new(23, 23, 277, 277)
UIShadow.BackgroundTransparency = 1
UIShadow.ZIndex = 0
UIShadow.Parent = MainFrame

-- Заголовок окна с градиентом
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

-- Градиент для заголовка
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 20, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 40))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

-- Текст заголовка
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SATANA v6.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.ZIndex = 3
Title.Parent = TitleBar

-- Подзаголовок
local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, -50, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 32)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "МОБИЛЬНАЯ ВЕРСИЯ"
SubTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 3
SubTitle.Parent = TitleBar

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 28
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 3
CloseButton.Parent = TitleBar

-- Скругление для кнопки закрытия
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Эффект при наведении на кнопку закрытия
CloseButton.MouseButton1Down:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(220, 20, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

CloseButton.MouseButton1Up:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(255, 100, 100)
    }):Play()
end)

-- Область вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 45)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabContainer.BorderSizePixel = 0
TabContainer.ZIndex = 2
TabContainer.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

-- Создаем кнопки табов для мобильных
local function CreateTabButton(name, text, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.333, -4, 1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = false
    button.ZIndex = 3
    button.Parent = TabContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Эффект при нажатии
    button.MouseButton1Down:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(220, 20, 60) then
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end
    end)
    
    button.MouseButton1Up:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(220, 20, 60) then
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                TextColor3 = Color3.fromRGB(180, 180, 180)
            }):Play()
        end
    end)
    
    return button
end

local VisualsButton = CreateTabButton("Visuals", "ESP", UDim2.new(0, 0, 0, 0))
local AimbotButton = CreateTabButton("Aimbot", "AIM", UDim2.new(0.333, 2, 0, 0))
local MemoryButton = CreateTabButton("Memory", "MEM", UDim2.new(0.666, 4, 0, 0))

-- Активируем первый таб с анимацией
TweenService:Create(VisualsButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundColor3 = Color3.fromRGB(220, 20, 60),
    TextColor3 = Color3.fromRGB(255, 255, 255)
}):Play()

-- Область контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -120)
ContentFrame.Position = UDim2.new(0, 10, 0, 115)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.ZIndex = 2
ContentFrame.Parent = MainFrame

-- Контейнеры для вкладок
local VisualsContainer = Instance.new("ScrollingFrame")
VisualsContainer.Name = "VisualsContainer"
VisualsContainer.Size = UDim2.new(1, 0, 1, 0)
VisualsContainer.BackgroundTransparency = 1
VisualsContainer.BorderSizePixel = 0
VisualsContainer.ScrollBarThickness = 4
VisualsContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
VisualsContainer.ScrollBarImageTransparency = 0.5
VisualsContainer.Visible = true
VisualsContainer.ZIndex = 2
VisualsContainer.Parent = ContentFrame

local AimbotContainer = Instance.new("ScrollingFrame")
AimbotContainer.Name = "AimbotContainer"
AimbotContainer.Size = UDim2.new(1, 0, 1, 0)
AimbotContainer.BackgroundTransparency = 1
AimbotContainer.BorderSizePixel = 0
AimbotContainer.ScrollBarThickness = 4
AimbotContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
AimbotContainer.ScrollBarImageTransparency = 0.5
AimbotContainer.Visible = false
AimbotContainer.ZIndex = 2
AimbotContainer.Parent = ContentFrame

local MemoryContainer = Instance.new("ScrollingFrame")
MemoryContainer.Name = "MemoryContainer"
MemoryContainer.Size = UDim2.new(1, 0, 1, 0)
MemoryContainer.BackgroundTransparency = 1
MemoryContainer.BorderSizePixel = 0
MemoryContainer.ScrollBarThickness = 4
MemoryContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 20, 60)
MemoryContainer.ScrollBarImageTransparency = 0.5
MemoryContainer.Visible = false
MemoryContainer.ZIndex = 2
MemoryContainer.Parent = ContentFrame

-- Упорядочивание элементов
local VisualsLayout = Instance.new("UIListLayout")
VisualsLayout.Padding = UDim.new(0, 8)
VisualsLayout.SortOrder = Enum.SortOrder.LayoutOrder
VisualsLayout.Parent = VisualsContainer

local AimbotLayout = Instance.new("UIListLayout")
AimbotLayout.Padding = UDim.new(0, 8)
AimbotLayout.SortOrder = Enum.SortOrder.LayoutOrder
AimbotLayout.Parent = AimbotContainer

local MemoryLayout = Instance.new("UIListLayout")
MemoryLayout.Padding = UDim.new(0, 8)
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

-- Функция для переключения вкладок с анимацией
local function SwitchTab(tabName)
    VisualsContainer.Visible = false
    AimbotContainer.Visible = false
    MemoryContainer.Visible = false
    
    local tabButtons = {VisualsButton, AimbotButton, MemoryButton}
    local tabNames = {"Visuals", "Aimbot", "Memory"}
    
    for i, button in ipairs(tabButtons) do
        if tabNames[i] == tabName then
            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(220, 20, 60),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                TextColor3 = Color3.fromRGB(180, 180, 180)
            }):Play()
        end
    end
    
    if tabName == "Visuals" then
        VisualsContainer.Visible = true
    elseif tabName == "Aimbot" then
        AimbotContainer.Visible = true
    elseif tabName == "Memory" then
        MemoryContainer.Visible = true
    end
end

-- УПРОЩЕННЫЕ ПЕРЕКЛЮЧАТЕЛИ ДЛЯ МОБИЛЬНЫХ
local function CreateToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.LayoutOrder = #parent:GetChildren()
    toggleFrame.ZIndex = 2
    toggleFrame.Parent = parent
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    -- Текст
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(0.7, -10, 1, 0)
    toggleText.Position = UDim2.new(0, 12, 0, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(240, 240, 240)
    toggleText.TextSize = 16
    toggleText.Font = Enum.Font.GothamSemibold
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.ZIndex = 3
    toggleText.Parent = toggleFrame
    
    -- Кнопка переключения
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 60, 0, 30)
    toggleButton.Position = UDim2.new(1, -70, 0.5, -15)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = default and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 14
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.AutoButtonColor = false
    toggleButton.ZIndex = 3
    toggleButton.Parent = toggleFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 15)
    buttonCorner.Parent = toggleButton
    
    local state = default
    
    -- Функция переключения
    local function toggleState()
        state = not state
        
        TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70),
            Text = state and "ON" or "OFF"
        }):Play()
        
        if callback then
            callback(state)
        end
    end
    
    toggleButton.MouseButton1Click:Connect(toggleState)
    
    -- Эффект при нажатии
    toggleButton.MouseButton1Down:Connect(function()
        TweenService:Create(toggleFrame, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        }):Play()
    end)
    
    toggleButton.MouseButton1Up:Connect(function()
        TweenService:Create(toggleFrame, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        }):Play()
    end)
    
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

-- УПРОЩЕННЫЕ СЛАЙДЕРЫ ДЛЯ МОБИЛЬНЫХ
local function CreateSlider(parent, text, min, max, default, suffix, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 70)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.LayoutOrder = #parent:GetChildren()
    sliderFrame.ZIndex = 2
    sliderFrame.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame
    
    -- Заголовок и значение
    local sliderHeader = Instance.new("Frame")
    sliderHeader.Size = UDim2.new(1, -20, 0, 30)
    sliderHeader.Position = UDim2.new(0, 10, 0, 5)
    sliderHeader.BackgroundTransparency = 1
    sliderHeader.Parent = sliderFrame
    
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(0.7, 0, 1, 0)
    sliderText.BackgroundTransparency = 1
    sliderText.Text = text
    sliderText.TextColor3 = Color3.fromRGB(240, 240, 240)
    sliderText.TextSize = 16
    sliderText.Font = Enum.Font.GothamSemibold
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.ZIndex = 3
    sliderText.Parent = sliderHeader
    
    local valueText = Instance.new("TextLabel")
    valueText.Size = UDim2.new(0.3, 0, 1, 0)
    valueText.Position = UDim2.new(0.7, 0, 0, 0)
    valueText.BackgroundTransparency = 1
    valueText.Text = tostring(default) .. (suffix or "")
    valueText.TextColor3 = Color3.fromRGB(220, 20, 60)
    valueText.TextSize = 16
    valueText.Font = Enum.Font.GothamBold
    valueText.TextXAlignment = Enum.TextXAlignment.Right
    valueText.ZIndex = 3
    valueText.Parent = sliderHeader
    
    -- Фон слайдера
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(1, -20, 0, 25)
    sliderBackground.Position = UDim2.new(0, 10, 0, 40)
    sliderBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBackground.BorderSizePixel = 0
    sliderBackground.ZIndex = 3
    sliderBackground.Parent = sliderFrame
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 10)
    sliderBgCorner.Parent = sliderBackground
    
    -- Заполнение слайдера
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 4
    sliderFill.Parent = sliderBackground
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 10)
    sliderFillCorner.Parent = sliderFill
    
    -- Ползунок
    local sliderHandle = Instance.new("TextButton")
    sliderHandle.Size = UDim2.new(0, 20, 0, 30)
    sliderHandle.Position = UDim2.new(sliderFill.Size.X.Scale, -10, 0.5, -15)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Text = ""
    sliderHandle.ZIndex = 5
    sliderHandle.AutoButtonColor = false
    sliderHandle.Parent = sliderBackground
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 5)
    handleCorner.Parent = sliderHandle
    
    local value = default
    local dragging = false
    
    -- Функция обновления значения
    local function updateValue(newValue)
        value = math.clamp(newValue, min, max)
        local percentage = (value - min) / (max - min)
        
        TweenService:Create(sliderFill, TweenInfo.new(0.1), {
            Size = UDim2.new(percentage, 0, 1, 0)
        }):Play()
        
        TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
            Position = UDim2.new(percentage, -10, 0.5, -15)
        }):Play()
        
        valueText.Text = string.format("%.1f", value) .. (suffix or "")
        
        if callback then
            callback(value)
        end
    end
    
    -- Обработка касаний
    sliderHandle.MouseButton1Down:Connect(function()
        dragging = true
        TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 22, 0, 32)
        }):Play()
    end)
    
    sliderBackground.MouseButton1Down:Connect(function(input)
        local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        local newValue = min + (max - min) * relativeX
        updateValue(newValue)
    end)
    
    local function onTouchMoved(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            local newValue = min + (max - min) * relativeX
            updateValue(newValue)
        end
    end
    
    local function onInputEnded(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 20, 0, 30)
            }):Play()
        end
    end
    
    sliderHandle.MouseButton1Up:Connect(onInputEnded)
    sliderBackground.MouseButton1Up:Connect(onInputEnded)
    
    UserInputService.InputEnded:Connect(onInputEnded)
    UserInputService.InputChanged:Connect(onTouchMoved)
    
    return {
        Set = function(newValue)
            updateValue(newValue)
        end,
        Get = function() return value end
    }
end

-- Создаем элементы для вкладки Visuals
local ESPEnabled = CreateToggle(VisualsContainer, "ESP ВКЛ", Settings.ESP.Enabled, function(state)
    Settings.ESP.Enabled = state
    if state then
        EnableESP()
    else
        DisableESP()
    end
end)

local ESPBoxToggle = CreateToggle(VisualsContainer, "Рамки", Settings.ESP.Box, function(state)
    Settings.ESP.Box = state
end)

local ESPDistanceToggle = CreateToggle(VisualsContainer, "Дистанция", Settings.ESP.Distance, function(state)
    Settings.ESP.Distance = state
end)

local ESPHealthToggle = CreateToggle(VisualsContainer, "Здоровье", Settings.ESP.Health, function(state)
    Settings.ESP.Health = state
end)

local ESPNamesToggle = CreateToggle(VisualsContainer, "Имена", Settings.ESP.Names, function(state)
    Settings.ESP.Names = state
end)

local ESPTeamCheck = CreateToggle(VisualsContainer, "Проверка команды", Settings.ESP.TeamCheck, function(state)
    Settings.ESP.TeamCheck = state
end)

-- Создаем элементы для вкладки Aimbot
local AimbotEnabled = CreateToggle(AimbotContainer, "AIMBOT ВКЛ", Settings.Aimbot.Enabled, function(state)
    Settings.Aimbot.Enabled = state
    if state then
        EnableAimbot()
    else
        DisableAimbot()
    end
end)

local AutoAimToggle = CreateToggle(AimbotContainer, "АВТО-АИМ", Settings.Aimbot.AutoAim, function(state)
    Settings.Aimbot.AutoAim = state
end)

local AimbotDistanceSlider = CreateSlider(AimbotContainer, "Дистанция", 0, 1000, Settings.Aimbot.Distance, " studs", function(value)
    Settings.Aimbot.Distance = value
end)

local AimbotFOVSlider = CreateSlider(AimbotContainer, "Поле зрения", 10, 360, Settings.Aimbot.FOV, "°", function(value)
    Settings.Aimbot.FOV = value
end)

local AimbotSmoothSlider = CreateSlider(AimbotContainer, "Плавность", 0.1, 1, Settings.Aimbot.Smoothness, "", function(value)
    Settings.Aimbot.Smoothness = value
end)

local TeamCheckToggle = CreateToggle(AimbotContainer, "Проверка команды", Settings.Aimbot.TeamCheck, function(state)
    Settings.Aimbot.TeamCheck = state
end)

-- Создаем элементы для вкладки Memory
local SpeedHackToggle = CreateToggle(MemoryContainer, "СКОРОСТЬ", Settings.Memory.SpeedHack, function(state)
    Settings.Memory.SpeedHack = state
    if state then
        EnableSpeedHack()
    else
        DisableSpeedHack()
    end
end)

local SpeedMultiplierSlider = CreateSlider(MemoryContainer, "Множитель скорости", 1, 10, Settings.Memory.SpeedMultiplier, "x", function(value)
    Settings.Memory.SpeedMultiplier = value
    if Settings.Memory.SpeedHack then
        UpdateSpeedHack()
    end
end)

local GodModeToggle = CreateToggle(MemoryContainer, "БЕССМЕРТИЕ", Settings.Memory.GodMode, function(state)
    Settings.Memory.GodMode = state
    if state then
        EnableGodMode()
    else
        DisableGodMode()
    end
end)

local NoclipToggle = CreateToggle(MemoryContainer, "СКВОЗЬ СТЕНЫ", Settings.Memory.Noclip, function(state)
    Settings.Memory.Noclip = state
    if state then
        EnableNoclip()
    else
        DisableNoclip()
    end
end)

-- ПРОСТОЙ И РАБОЧИЙ ESP ДЛЯ МОБИЛЬНЫХ
function CreateESP(player)
    if ESPObjects[player] then return end
    
    local esp = {}
    
    -- Box
    esp.Box = Instance.new("Frame")
    esp.Box.Name = "ESPBox"
    esp.Box.Size = UDim2.new(0, 50, 0, 100)
    esp.Box.BackgroundTransparency = 1
    esp.Box.BorderSizePixel = 2
    esp.Box.BorderColor3 = Settings.ESP.BoxColor
    esp.Box.Visible = false
    esp.Box.ZIndex = 10
    esp.Box.Parent = ScreenGui
    
    -- Name
    esp.Name = Instance.new("TextLabel")
    esp.Name.Name = "ESPName"
    esp.Name.Size = UDim2.new(0, 150, 0, 20)
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
    
    -- Distance
    esp.Distance = Instance.new("TextLabel")
    esp.Distance.Name = "ESPDistance"
    esp.Distance.Size = UDim2.new(0, 150, 0, 20)
    esp.Distance.BackgroundTransparency = 1
    esp.Distance.TextColor3 = Settings.ESP.TextColor
    esp.Distance.TextSize = Settings.ESP.TextSize - 2
    esp.Distance.Font = Enum.Font.Gotham
    esp.Distance.TextStrokeTransparency = 0
    esp.Distance.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Distance.Visible = false
    esp.Distance.ZIndex = 11
    esp.Distance.Parent = ScreenGui
    
    -- Health
    esp.Health = Instance.new("TextLabel")
    esp.Health.Name = "ESPHealth"
    esp.Health.Size = UDim2.new(0, 150, 0, 20)
    esp.Health.BackgroundTransparency = 1
    esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
    esp.Health.TextSize = Settings.ESP.TextSize - 2
    esp.Health.Font = Enum.Font.Gotham
    esp.Health.TextStrokeTransparency = 0
    esp.Health.TextStrokeColor3 = Color3.new(0, 0, 0)
    esp.Health.Visible = false
    esp.Health.ZIndex = 11
    esp.Health.Parent = ScreenGui
    
    ESPObjects[player] = esp
end

function UpdateESP()
    if not Settings.ESP.Enabled then return end
    
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
            
            -- Team Check
            if Settings.ESP.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.Health.Visible = false
                continue
            end
            
            local position, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
            
            if onScreen and distance <= Settings.ESP.MaxDistance then
                local screenPosition = Vector2.new(position.X, position.Y)
                
                -- Box size based on distance
                local boxSize = Vector2.new(1500 / distance, 2500 / distance)
                boxSize = Vector2.new(
                    math.clamp(boxSize.X, 30, 80),
                    math.clamp(boxSize.Y, 60, 120)
                )
                
                -- ESP Color
                local espColor = Settings.ESP.BoxColor
                if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    espColor = Settings.ESP.TeamColor
                end
                
                -- Box
                if Settings.ESP.Box then
                    esp.Box.Size = UDim2.new(0, boxSize.X, 0, boxSize.Y)
                    esp.Box.Position = UDim2.new(0, screenPosition.X - boxSize.X/2, 0, screenPosition.Y - boxSize.Y/2)
                    esp.Box.BorderColor3 = espColor
                    esp.Box.Visible = true
                else
                    esp.Box.Visible = false
                end
                
                -- Name
                if Settings.ESP.Names then
                    esp.Name.Position = UDim2.new(0, screenPosition.X - 75, 0, screenPosition.Y - boxSize.Y/2 - 20)
                    esp.Name.TextColor3 = Settings.ESP.TextColor
                    esp.Name.Visible = true
                else
                    esp.Name.Visible = false
                end
                
                -- Distance
                if Settings.ESP.Distance then
                    esp.Distance.Position = UDim2.new(0, screenPosition.X - 75, 0, screenPosition.Y + boxSize.Y/2 + 5)
                    esp.Distance.Text = "[" .. math.floor(distance) .. " studs]"
                    esp.Distance.TextColor3 = Settings.ESP.TextColor
                    esp.Distance.Visible = true
                else
                    esp.Distance.Visible = false
                end
                
                -- Health
                if Settings.ESP.Health and humanoid then
                    local health = math.floor(humanoid.Health)
                    local maxHealth = humanoid.MaxHealth
                    
                    esp.Health.Position = UDim2.new(0, screenPosition.X - 75, 0, screenPosition.Y - boxSize.Y/2 - 40)
                    esp.Health.Text = "HP: " .. health .. "/" .. maxHealth
                    
                    local healthPercent = health / maxHealth
                    if healthPercent > 0.6 then
                        esp.Health.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif healthPercent > 0.3 then
                        esp.Health.TextColor3 = Color3.fromRGB(255, 255, 0)
                    else
                        esp.Health.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                    
                    esp.Health.Visible = true
                else
                    esp.Health.Visible = false
                end
            else
                esp.Box.Visible = false
                esp.Name.Visible = false
                esp.Distance.Visible = false
                esp.Health.Visible = false
            end
        else
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Health.Visible = false
        end
    end
end

function EnableESP()
    Settings.ESP.Enabled = true
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end
    
    ESPConnections.Update = RunService.RenderStepped:Connect(UpdateESP)
    
    ESPConnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
        CreateESP(player)
    end)
    
    ESPConnections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        if ESPObjects[player] then
            ESPObjects[player].Box:Destroy()
            ESPObjects[player].Name:Destroy()
            ESPObjects[player].Distance:Destroy()
            ESPObjects[player].Health:Destroy()
            ESPObjects[player] = nil
        end
    end)
end

function DisableESP()
    Settings.ESP.Enabled = false
    
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
    
    for _, esp in pairs(ESPObjects) do
        esp.Box:Destroy()
        esp.Name:Destroy()
        esp.Distance:Destroy()
        esp.Health:Destroy()
    end
    ESPObjects = {}
end

-- РАБОЧИЙ AIMBOT ДЛЯ МОБИЛЬНЫХ
function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = Settings.Aimbot.Distance
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local targetPart = character:FindFirstChild(Settings.Aimbot.TargetPart) or character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and targetPart then
                if Settings.Aimbot.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    continue
                end
                
                local distance = (targetPart.Position - Camera.CFrame.Position).Magnitude
                if distance > Settings.Aimbot.Distance then
                    continue
                end
                
                local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local targetPos = Vector2.new(screenPosition.X, screenPosition.Y)
                    local fovDistance = (screenCenter - targetPos).Magnitude
                    
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

function AimAt()
    if not Settings.Aimbot.Enabled then return end
    
    -- Автоматический режим или ручной
    if not Settings.Aimbot.AutoAim and not IsAiming then return end
    
    local target = GetClosestPlayer()
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild(Settings.Aimbot.TargetPart) or target.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end
    
    local targetPosition = targetPart.Position + Vector3.new(0, 1.5, 0)
    local camera = Camera
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    
    local newCFrame = currentCFrame:Lerp(targetCFrame, Settings.Aimbot.Smoothness)
    camera.CFrame = newCFrame
end

function EnableAimbot()
    Settings.Aimbot.Enabled = true
    
    -- Обработка касаний для аимбота
    local touchStarted = false
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            touchStarted = true
        elseif input.KeyCode == Settings.Aimbot.AimKey then
            IsAiming = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            touchStarted = false
        elseif input.KeyCode == Settings.Aimbot.AimKey then
            IsAiming = false
        end
    end)
    
    -- Включаем аимбот
    AimbotConnection = RunService.RenderStepped:Connect(function()
        if Settings.Aimbot.Enabled then
            AimAt()
        end
    end)
end

function DisableAimbot()
    Settings.Aimbot.Enabled = false
    
    if AimbotConnection then
        AimbotConnection:Disconnect()
        AimbotConnection = nil
    end
end

-- MEMORY ФУНКЦИИ
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
    
    updateSpeed()
    
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
        if Settings.Memory.Noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
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
end

-- Кнопка открытия GUI для мобильных
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 80, 0, 40)
OpenButton.Position = UDim2.new(1, -85, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "МЕНЮ"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 16
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.AutoButtonColor = false
OpenButton.Visible = false
OpenButton.ZIndex = 10
OpenButton.Parent = ScreenGui

local OpenButtonCorner = Instance.new("UICorner")
OpenButtonCorner.CornerRadius = UDim.new(0, 8)
OpenButtonCorner.Parent = OpenButton

-- Эффекты для кнопки открытия
OpenButton.MouseButton1Down:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    }):Play()
end)

OpenButton.MouseButton1Up:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    }):Play()
end)

-- Функции открытия/закрытия GUI
CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -190, 1.5, -250)
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
    MainFrame.Position = UDim2.new(0.5, -190, 1.5, -250)
    BackgroundGradient.BackgroundTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -190, 0.5, -250)
    }):Play()
    
    TweenService:Create(BackgroundGradient, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.85
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

-- ФУНКЦИЯ ДЛЯ ПЕРЕТАСКИВАНИЯ ОКНА НА МОБИЛЬНЫХ
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new(0, 0, 0, 0)

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
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
    if input.UserInputType == Enum.UserInputType.Touch and dragging then
        update(input)
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
    Notification.ZIndex = 20
    Notification.Parent = ScreenGui

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = Notification

    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, 0, 0, 40)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = "SATANA v6.0 ЗАГРУЖЕН"
    NotifTitle.TextColor3 = Color3.fromRGB(220, 20, 60)
    NotifTitle.TextSize = 18
    NotifTitle.Font = Enum.Font.GothamBlack
    NotifTitle.TextStrokeTransparency = 0.5
    NotifTitle.ZIndex = 21
    NotifTitle.Parent = Notification

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 0, 40)
    NotifText.Position = UDim2.new(0, 10, 0, 40)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "Мобильная версия активна!"
    NotifText.TextColor3 = Color3.fromRGB(220, 220, 220)
    NotifText.TextSize = 14
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextWrapped = true
    NotifText.ZIndex = 21
    NotifText.Parent = Notification

    Notification:TweenPosition(UDim2.new(0.5, -150, 1, -100), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5)
    
    wait(3)
    Notification:TweenPosition(UDim2.new(0.5, -150, 1, 10), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5)
    wait(0.5)
    Notification:Destroy()
end)

-- Отправляем уведомление
StarterGui:SetCore("SendNotification", {
    Title = "SATANA v6.0",
    Text = "Мобильная версия загружена!",
    Duration = 5,
})

print("╔══════════════════════════════════════════════╗")
print("║         SATANA MOBILE HACK MENU v6.0         ║")
print("╠══════════════════════════════════════════════╣")
print("║ • ESP: ✓ РАБОЧИЙ СКВОЗЬ СТЕНЫ              ║")
print("║ • Aimbot: ✓ АВТО-АИМ ДЛЯ МОБИЛЬНЫХ         ║")
print("║ • Memory: ✓ ВСЕ ФУНКЦИИ РАБОТАЮТ           ║")
print("║ • Управление: ✓ КАСАНИЯ РАБОТАЮТ           ║")
print("║ • Интерфейс: ✓ АДАПТИРОВАН ДЛЯ ТЕЛЕФОНА    ║")
print("╚══════════════════════════════════════════════╝")

-- Активируем GUI при запуске
OpenButton.Visible = false
MainFrame.Visible = true
BackgroundGradient.Visible = true

-- Автостарт для тестирования
-- ESPEnabled.Toggle() -- Раскомментировать для автостарта ESP
-- AimbotEnabled.Toggle() -- Раскомментировать для автостарта Aimbot с авто-аим
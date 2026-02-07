-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
--                Premium Roblox Hack Menu

-- Конфигурация цветов
local Config = {
    MainColor = Color3.fromRGB(220, 20, 60),     -- Красный Satana
    SecondaryColor = Color3.fromRGB(40, 40, 40),  -- Темно-серый
    BackgroundColor = Color3.fromRGB(25, 25, 25), -- Фон
    TextColor = Color3.fromRGB(255, 255, 255),    -- Белый текст
    AccentColor = Color3.fromRGB(255, 50, 50),    -- Акцентный красный
    BorderColor = Color3.fromRGB(60, 60, 60),     -- Цвет рамок
    TabActiveColor = Color3.fromRGB(180, 0, 0),   -- Активный таб
    SliderColor = Color3.fromRGB(200, 30, 30)     -- Цвет слайдеров
}

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SatanaGUI"
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game.CoreGui

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
MainFrame.BackgroundColor3 = Config.BackgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Тень окна
local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.8
Shadow.BorderSizePixel = 0
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Закругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Заголовок окна
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Config.MainColor
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
Title.Text = "SATANA"
Title.TextColor3 = Config.TextColor
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
CloseButton.TextColor3 = Config.TextColor
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
TabContainer.BackgroundColor3 = Config.SecondaryColor
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Область контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -100)
ContentFrame.Position = UDim2.new(0, 10, 0, 90)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Создаем табы
local Tabs = {}
local TabButtons = {}

local function CreateTab(name, displayName)
    local tab = Instance.new("ScrollingFrame")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.BorderSizePixel = 0
    tab.ScrollBarThickness = 4
    tab.ScrollBarImageColor3 = Config.MainColor
    tab.Visible = false
    tab.Parent = ContentFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = tab
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 10)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = tab
    
    -- Кнопка таба
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Button"
    tabButton.Size = UDim2.new(0.33, 0, 1, 0)
    tabButton.BackgroundColor3 = Config.SecondaryColor
    tabButton.BorderSizePixel = 0
    tabButton.Text = displayName
    tabButton.TextColor3 = Config.TextColor
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.Parent = TabContainer
    
    local tabButtonCorner = Instance.new("UICorner")
    tabButtonCorner.CornerRadius = UDim.new(0, 6)
    tabButtonCorner.Parent = tabButton
    
    Tabs[name] = tab
    TabButtons[name] = tabButton
    
    return tab
end

-- Создаем основные вкладки
CreateTab("Visuals", "VISUALS")
CreateTab("Aimbot", "AIMBOT")
CreateTab("Memory", "MEMORY")

-- Функция переключения табов
local function SwitchTab(tabName)
    for name, tab in pairs(Tabs) do
        tab.Visible = (name == tabName)
        TabButtons[name].BackgroundColor3 = (name == tabName) and Config.TabActiveColor or Config.SecondaryColor
    end
end

-- Активируем первый таб
SwitchTab("Visuals")

-- Создаем элементы управления
local Controls = {}

-- Функция создания переключателя
function Controls:CreateToggle(name, defaultValue, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #self:GetChildren() + 1
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -55, 0, 2)
    toggleButton.BackgroundColor3 = defaultValue and Config.MainColor or Config.SecondaryColor
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(1, -60, 1, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = name
    toggleText.TextColor3 = Config.TextColor
    toggleText.TextSize = 14
    toggleText.Font = Enum.Font.Gotham
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    
    toggleText.Parent = toggleFrame
    toggleButton.Parent = toggleFrame
    toggleFrame.Parent = self
    
    local state = defaultValue
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.BackgroundColor3 = state and Config.MainColor or Config.SecondaryColor
        if callback then
            callback(state)
        end
    end)
    
    return {
        Set = function(value)
            state = value
            toggleButton.BackgroundColor3 = state and Config.MainColor or Config.SecondaryColor
        end,
        Get = function() return state end
    }
end

-- Функция создания слайдера
function Controls:CreateSlider(name, min, max, defaultValue, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -10, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.LayoutOrder = #self:GetChildren() + 1
    
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(1, 0, 0, 20)
    sliderText.BackgroundTransparency = 1
    sliderText.Text = name .. ": " .. defaultValue
    sliderText.TextColor3 = Config.TextColor
    sliderText.TextSize = 14
    sliderText.Font = Enum.Font.Gotham
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.Parent = sliderFrame
    
    local sliderBackground = Instance.new("Frame")
    sliderBackground.Size = UDim2.new(1, 0, 0, 25)
    sliderBackground.Position = UDim2.new(0, 0, 0, 25)
    sliderBackground.BackgroundColor3 = Config.SecondaryColor
    sliderBackground.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 12)
    sliderCorner.Parent = sliderBackground
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Config.SliderColor
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
    sliderFrame.Parent = self
    
    local dragging = false
    local value = defaultValue
    
    local function updateValue(input)
        local relativeX = (input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        value = math.floor(min + (max - min) * relativeX + 0.5)
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        sliderText.Text = name .. ": " .. value
        if callback then
            callback(value)
        end
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
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
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            sliderText.Text = name .. ": " .. value
        end,
        Get = function() return value end
    }
end

-- Функция создания кнопки
function Controls:CreateButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.BackgroundColor3 = Config.MainColor
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Config.TextColor
    button.TextSize = 16
    button.Font = Enum.Font.GothamSemibold
    button.LayoutOrder = #self:GetChildren() + 1
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    button.Parent = self
    
    return button
end

-- Создаем элементы для вкладки Visuals
local visuals = {
    Controls:CreateToggle("ESP BOX", false, function(state)
        print("ESP BOX:", state)
    end),
    
    Controls:CreateToggle("ESP DISTANCE", false, function(state)
        print("ESP DISTANCE:", state)
    end),
    
    Controls:CreateToggle("ESP HEALTH", false, function(state)
        print("ESP HEALTH:", state)
    end),
    
    Controls:CreateToggle("ESP LINE", false, function(state)
        print("ESP LINE:", state)
    end)
}

-- Создаем элементы для вкладки Aimbot
local aimbot = {
    Controls:CreateToggle("Enable Aimbot", false, function(state)
        print("Aimbot Enabled:", state)
    end),
    
    Controls:CreateSlider("Aimbot Distance", 0, 500, 100, function(value)
        print("Aimbot Distance:", value)
    end),
    
    Controls:CreateSlider("Aimbot FOV", 1, 360, 90, function(value)
        print("Aimbot FOV:", value)
    end)
}

-- Создаем элементы для вкладки Memory
local memory = {
    Controls:CreateToggle("Speed Hack", false, function(state)
        print("Speed Hack:", state)
    end),
    
    Controls:CreateSlider("Speed Multiplier", 1, 10, 2, function(value)
        print("Speed Multiplier:", value)
    end),
    
    Controls:CreateToggle("God Mode", false, function(state)
        print("God Mode:", state)
    end)
}

-- Добавляем элементы в соответствующие табы
for _, control in pairs(visuals) do
    control:GetParent().Parent = Tabs.Visuals
end

for _, control in pairs(aimbot) do
    control:GetParent().Parent = Tabs.Aimbot
end

for _, control in pairs(memory) do
    control:GetParent().Parent = Tabs.Memory
end

-- Создаем кнопку открытия GUI (если закрыто)
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 100, 0, 40)
OpenButton.Position = UDim2.new(1, -110, 0, 10)
OpenButton.BackgroundColor3 = Config.MainColor
OpenButton.BorderSizePixel = 0
OpenButton.Text = "SATANA"
OpenButton.TextColor3 = Config.TextColor
OpenButton.TextSize = 16
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenButtonCorner = Instance.new("UICorner")
OpenButtonCorner.CornerRadius = UDim.new(0, 8)
OpenButtonCorner.Parent = OpenButton

-- Функции открытия/закрытия
local function CloseGUI()
    MainFrame.Visible = false
    OpenButton.Visible = true
end

local function OpenGUI()
    MainFrame.Visible = true
    OpenButton.Visible = false
end

-- Назначаем обработчики
CloseButton.MouseButton1Click:Connect(CloseGUI)
OpenButton.MouseButton1Click:Connect(OpenGUI)

-- Назначаем обработчики для кнопок табов
TabButtons.Visuals.MouseButton1Click:Connect(function()
    SwitchTab("Visuals")
end)

TabButtons.Aimbot.MouseButton1Click:Connect(function()
    SwitchTab("Aimbot")
end)

TabButtons.Memory.MouseButton1Click:Connect(function()
    SwitchTab("Memory")
end)

-- Добавляем возможность перетаскивания окна
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Автоматически открываем GUI при запуске
OpenGUI()

-- Уведомление о загрузке
local Notification = Instance.new("Frame")
Notification.Size = UDim2.new(0, 300, 0, 80)
Notification.Position = UDim2.new(0.5, -150, 1, 10)
Notification.BackgroundColor3 = Config.MainColor
Notification.BorderSizePixel = 0
Notification.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = Notification

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Size = UDim2.new(1, 0, 0, 30)
NotifTitle.BackgroundTransparency = 1
NotifTitle.Text = "SATANA LOADED"
NotifTitle.TextColor3 = Config.TextColor
NotifTitle.TextSize = 18
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Parent = Notification

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -20, 0, 40)
NotifText.Position = UDim2.new(0, 10, 0, 30)
NotifText.BackgroundTransparency = 1
NotifText.Text = "GUI успешно загружена!"
NotifText.TextColor3 = Config.TextColor
NotifText.TextSize = 14
NotifText.Font = Enum.Font.Gotham
NotifText.Parent = Notification

-- Анимация появления уведомления
Notification:TweenPosition(UDim2.new(0.5, -150, 1, -100), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5)

-- Автоматическое скрытие уведомления
game:GetService("Debris"):AddItem(Notification, 5)

print("===================================")
print("SATANA GUI успешно загружена!")
print("===================================")
-- ███████╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
-- ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
-- ███████╗███████║   ██║   ███████║██╔██╗ ██║███████║
-- ╚════██║██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
-- ███████║██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
-- ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SatanaGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 450) -- Уменьшил для телефона
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
Title.Text = "SATANA"
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

-- Область контента (используем Frame вместо ScrollingFrame для простоты)
local VisualsFrame = Instance.new("Frame")
VisualsFrame.Name = "VisualsFrame"
VisualsFrame.Size = UDim2.new(1, -20, 1, -100)
VisualsFrame.Position = UDim2.new(0, 10, 0, 90)
VisualsFrame.BackgroundTransparency = 1
VisualsFrame.Visible = true
VisualsFrame.Parent = MainFrame

local AimbotFrame = Instance.new("Frame")
AimbotFrame.Name = "AimbotFrame"
AimbotFrame.Size = UDim2.new(1, -20, 1, -100)
AimbotFrame.Position = UDim2.new(0, 10, 0, 90)
AimbotFrame.BackgroundTransparency = 1
AimbotFrame.Visible = false
AimbotFrame.Parent = MainFrame

local MemoryFrame = Instance.new("Frame")
MemoryFrame.Name = "MemoryFrame"
MemoryFrame.Size = UDim2.new(1, -20, 1, -100)
MemoryFrame.Position = UDim2.new(0, 10, 0, 90)
MemoryFrame.BackgroundTransparency = 1
MemoryFrame.Visible = false
MemoryFrame.Parent = MainFrame

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

-- Создаем элементы для вкладки Visuals
local function CreateToggle(parent, text, yPosition)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.Position = UDim2.new(0, 0, 0, yPosition)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -60, 0, 2)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
    
    local state = false
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        print(text .. ":", state)
    end)
    
    return toggleButton
end

-- Создаем элементы Visuals
CreateToggle(VisualsFrame, "ESP BOX", 10)
CreateToggle(VisualsFrame, "ESP DISTANCE", 50)
CreateToggle(VisualsFrame, "ESP HEALTH", 90)
CreateToggle(VisualsFrame, "ESP LINE", 130)

-- Создаем элементы для вкладки Aimbot
local aimbotToggle = CreateToggle(AimbotFrame, "Enable Aimbot", 10)

-- Слайдер для расстояния аимбота
local distanceFrame = Instance.new("Frame")
distanceFrame.Size = UDim2.new(1, 0, 0, 60)
distanceFrame.Position = UDim2.new(0, 0, 0, 50)
distanceFrame.BackgroundTransparency = 1
distanceFrame.Parent = AimbotFrame

local distanceText = Instance.new("TextLabel")
distanceText.Size = UDim2.new(1, 0, 0, 20)
distanceText.BackgroundTransparency = 1
distanceText.Text = "Aimbot Distance: 100"
distanceText.TextColor3 = Color3.fromRGB(255, 255, 255)
distanceText.TextSize = 14
distanceText.Font = Enum.Font.Gotham
distanceText.TextXAlignment = Enum.TextXAlignment.Left
distanceText.Parent = distanceFrame

local distanceSlider = Instance.new("Frame")
distanceSlider.Size = UDim2.new(1, 0, 0, 25)
distanceSlider.Position = UDim2.new(0, 0, 0, 25)
distanceSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
distanceSlider.BorderSizePixel = 0
distanceSlider.Parent = distanceFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 12)
sliderCorner.Parent = distanceSlider

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = distanceSlider

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 12)
fillCorner.Parent = sliderFill

-- Слайдер для FOV
local fovFrame = Instance.new("Frame")
fovFrame.Size = UDim2.new(1, 0, 0, 60)
fovFrame.Position = UDim2.new(0, 0, 0, 120)
fovFrame.BackgroundTransparency = 1
fovFrame.Parent = AimbotFrame

local fovText = Instance.new("TextLabel")
fovText.Size = UDim2.new(1, 0, 0, 20)
fovText.BackgroundTransparency = 1
fovText.Text = "Aimbot FOV: 90"
fovText.TextColor3 = Color3.fromRGB(255, 255, 255)
fovText.TextSize = 14
fovText.Font = Enum.Font.Gotham
fovText.TextXAlignment = Enum.TextXAlignment.Left
fovText.Parent = fovFrame

local fovSlider = Instance.new("Frame")
fovSlider.Size = UDim2.new(1, 0, 0, 25)
fovSlider.Position = UDim2.new(0, 0, 0, 25)
fovSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
fovSlider.BorderSizePixel = 0
fovSlider.Parent = fovFrame

local fovSliderCorner = Instance.new("UICorner")
fovSliderCorner.CornerRadius = UDim.new(0, 12)
fovSliderCorner.Parent = fovSlider

local fovFill = Instance.new("Frame")
fovFill.Size = UDim2.new(0.25, 0, 1, 0)
fovFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
fovFill.BorderSizePixel = 0
fovFill.Parent = fovSlider

local fovFillCorner = Instance.new("UICorner")
fovFillCorner.CornerRadius = UDim.new(0, 12)
fovFillCorner.Parent = fovFill

-- Создаем элементы для вкладки Memory
local speedToggle = CreateToggle(MemoryFrame, "Speed Hack", 10)

-- Слайдер для множителя скорости
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, 0, 0, 60)
speedFrame.Position = UDim2.new(0, 0, 0, 50)
speedFrame.BackgroundTransparency = 1
speedFrame.Parent = MemoryFrame

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(1, 0, 0, 20)
speedText.BackgroundTransparency = 1
speedText.Text = "Speed Multiplier: 2x"
speedText.TextColor3 = Color3.fromRGB(255, 255, 255)
speedText.TextSize = 14
speedText.Font = Enum.Font.Gotham
speedText.TextXAlignment = Enum.TextXAlignment.Left
speedText.Parent = speedFrame

local speedSlider = Instance.new("Frame")
speedSlider.Size = UDim2.new(1, 0, 0, 25)
speedSlider.Position = UDim2.new(0, 0, 0, 25)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = speedFrame

local speedSliderCorner = Instance.new("UICorner")
speedSliderCorner.CornerRadius = UDim.new(0, 12)
speedSliderCorner.Parent = speedSlider

local speedFill = Instance.new("Frame")
speedFill.Size = UDim2.new(0.2, 0, 1, 0)
speedFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
speedFill.BorderSizePixel = 0
speedFill.Parent = speedSlider

local speedFillCorner = Instance.new("UICorner")
speedFillCorner.CornerRadius = UDim.new(0, 12)
speedFillCorner.Parent = speedFill

local godToggle = CreateToggle(MemoryFrame, "God Mode", 130)

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
    NotifTitle.Text = "SATANA LOADED"
    NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifTitle.TextSize = 16
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Parent = Notification

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -10, 0, 35)
    NotifText.Position = UDim2.new(0, 5, 0, 25)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "GUI успешно загружена!"
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

print("===================================")
print("SATANA GUI загружена успешно!")
print("Адаптирована для мобильных устройств")
print("===================================")

-- Отправляем уведомление в чат
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SATANA",
    Text = "GUI успешно загружена!",
    Duration = 3,
    Icon = "rbxassetid://0"
})
-- Universal Game Enhancer - No Tracers + New Pink Stick + Aim Assist + Silent Aim + Spin + Fullbright + Autoclicker + Big Boobs
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- ШУТКА ПРИ ЗАПУСКЕ
print("===========================================")
print("🚨 ВЫ ВЗЛОМАНЫ KAZAH 🚨")
print("💀 ВАШ КОМПЬЮТЕР БУДЕТ УНИЧТОЖЕН ЧЕРЕЗ 5 СЕКУНД")
print("😂 ШУТКА! ПРИЯТНОЙ ИГРЫ С ENHANCER!")
print("===========================================")

-- Настройки
local settings = {
    fly = false,
    noclip = false,
    esp = false,
    speed = false,
    jump = false,
    xray = false,
    infJump = false,
    antiAfk = false,
    guiVisible = false,
    flySpeed = 50,
    walkSpeed = 50,
    jumpPower = 100,
    espSkeleton = true,
    espNames = true,
    espTracers = false,
    espBoxes = true,
    espTeamColor = true,
    aimAssist = false,
    aimThroughWalls = false,
    aimKey = Enum.KeyCode.Q,
    aimFov = 50,
    aimSmoothness = 10,
    aimIgnoreTeam = true,
    mobileAimEnabled = false,
    mobileAutoAim = false,
    guiScale = 1,
    silentAim = false,
    silentAimFov = 30,
    silentAimHitbox = "Head",
    spin = false,
    spinSpeed = 10,
    fullbright = false,
    autoclicker = false,
    autoclickerSpeed = 10,
    bigBoobs = false,
    bigBoobsSize = 5
}

-- Переменные
local flyConnection, noclipConnection, espConnection, antiAfkConnection, infJumpConnection, aimConnection, mobileAimConnection, silentAimConnection
local spinConnection, fullbrightConnection, autoclickerConnection, bigBoobsConnection
local bodyGyro, bodyVelocity
local pinkStick = nil
local gui = nil
local mobileIcon = nil
local mainFrame = nil
local mobileAimButton = nil
local mobileAutoAimButton = nil
local isAiming = false
local isAutoAiming = false
local skibidiToilet = nil
local originalLightingSettings = {}
local breastParts = {}

-- ESP Variables
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP"
espFolder.Parent = workspace

-- Переменные для хранения соединений перетаскивания
local aimButtonDragConnections = {}
local autoAimButtonDragConnections = {}

-- ФУНКЦИЯ BIG BOOBS (БОЛЬШАЯ ГРУДЬ) - ОБНОВЛЕННАЯ С ВЫДВИНУТОЙ ВПЕРЕД ГРУДЬЮ
local function toggleBigBoobs(enabled)
    settings.bigBoobs = enabled
    
    if enabled then
        print("Big Boobs: ENABLED - Size " .. settings.bigBoobsSize)
        
        local function setupBreasts()
            if not player.Character then return end
            
            -- Очищаем старые части
            for _, part in pairs(breastParts) do
                if part then
                    part:Destroy()
                end
            end
            breastParts = {}
            
            local character = player.Character
            local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
            if not torso then return end
            
            -- Создаем левую грудь (ВЫДВИНУТА ВПЕРЕД И БЛИЖЕ К ЦЕНТРУ)
            local leftBreast = Instance.new("Part")
            leftBreast.Name = "LeftBreast"
            leftBreast.Size = Vector3.new(settings.bigBoobsSize, settings.bigBoobsSize, settings.bigBoobsSize)
            leftBreast.Shape = Enum.PartType.Ball
            leftBreast.Material = Enum.Material.Neon
            leftBreast.BrickColor = BrickColor.new("Bright orange")
            leftBreast.Anchored = false
            leftBreast.CanCollide = false
            leftBreast.Parent = character
            
            local leftWeld = Instance.new("Weld")
            leftWeld.Part0 = torso
            leftWeld.Part1 = leftBreast
            -- ВЫДВИНУТА ВПЕРЕД: добавлен Z = 0.5, ближе к центру: X = -1.2
            leftWeld.C0 = CFrame.new(-1.2, 0.5, 0.5) * CFrame.Angles(0, 0, math.rad(-8))
            leftWeld.Parent = leftBreast
            
            -- Создаем правую грудь (ВЫДВИНУТА ВПЕРЕД И БЛИЖЕ К ЦЕНТРУ)
            local rightBreast = Instance.new("Part")
            rightBreast.Name = "RightBreast"
            rightBreast.Size = Vector3.new(settings.bigBoobsSize, settings.bigBoobsSize, settings.bigBoobsSize)
            rightBreast.Shape = Enum.PartType.Ball
            rightBreast.Material = Enum.Material.Neon
            rightBreast.BrickColor = BrickColor.new("Bright orange")
            rightBreast.Anchored = false
            rightBreast.CanCollide = false
            rightBreast.Parent = character
            
            local rightWeld = Instance.new("Weld")
            rightWeld.Part0 = torso
            rightWeld.Part1 = rightBreast
            -- ВЫДВИНУТА ВПЕРЕД: добавлен Z = 0.5, ближе к центру: X = 1.2
            rightWeld.C0 = CFrame.new(1.2, 0.5, 0.5) * CFrame.Angles(0, 0, math.rad(8))
            rightWeld.Parent = rightBreast
            
            -- Сохраняем ссылки
            breastParts = {leftBreast, rightBreast}
            
            print("Big Boobs: Created orange breasts with size " .. settings.bigBoobsSize .. " (closer together and forward)")
        end
        
        -- Настраиваем грудь при появлении персонажа
        setupBreasts()
        
        -- Следим за изменением размера груди
        bigBoobsConnection = RunService.Heartbeat:Connect(function()
            if not settings.bigBoobs or not player.Character then return end
            
            -- Обновляем размер если изменился
            for _, breast in pairs(breastParts) do
                if breast and breast.Parent then
                    if breast.Size ~= Vector3.new(settings.bigBoobsSize, settings.bigBoobsSize, settings.bigBoobsSize) then
                        breast.Size = Vector3.new(settings.bigBoobsSize, settings.bigBoobsSize, settings.bigBoobsSize)
                    end
                else
                    -- Если грудь пропала, создаем заново
                    setupBreasts()
                    break
                end
            end
            
            -- Добавляем небольшую анимацию "покачивания"
            if player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MoveDirection.Magnitude > 0 then
                for i, breast in pairs(breastParts) do
                    if breast and breast:FindFirstChildOfClass("Weld") then
                        local weld = breast:FindFirstChildOfClass("Weld")
                        local time = tick()
                        local bounce = math.sin(time * 8) * 0.1
                        if i == 1 then -- левая
                            weld.C0 = CFrame.new(-1.2, 0.5 + bounce, 0.5) * CFrame.Angles(0, 0, math.rad(-8))
                        else -- правая
                            weld.C0 = CFrame.new(1.2, 0.5 + bounce, 0.5) * CFrame.Angles(0, 0, math.rad(8))
                        end
                    end
                end
            end
        end)
        
    else
        if bigBoobsConnection then
            bigBoobsConnection:Disconnect()
            bigBoobsConnection = nil
        end
        
        -- Удаляем грудь
        for _, breast in pairs(breastParts) do
            if breast then
                breast:Destroy()
            end
        end
        breastParts = {}
        
        print("Big Boobs: DISABLED")
    end
end

-- Вспомогательная функция для получения корневой части персонажа
local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

-- Глобальные функции для перетаскивания
local function setupDragging(frame)
    local dragging = false
    local dragStart, startPos
    
    local function updatePosition(input)
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            if frame:IsA("ImageButton") or frame:IsA("TextButton") then
                frame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            end
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if frame:IsA("ImageButton") then
                frame.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            elseif frame:IsA("TextButton") and frame.Name == "MobileAimButton" then
                frame.BackgroundColor3 = settings.mobileAimEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            elseif frame:IsA("TextButton") and frame.Name == "MobileAutoAimButton" then
                frame.BackgroundColor3 = settings.mobileAutoAim and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(100, 100, 255)
            end
        end
    end)
    
    local inputChangedConnection = UIS.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updatePosition(input)
        end
    end)
    
    -- Сохраняем соединения для возможности отключения
    if frame.Name == "MobileAimButton" then
        aimButtonDragConnections.inputChanged = inputChangedConnection
    elseif frame.Name == "MobileAutoAimButton" then
        autoAimButtonDragConnections.inputChanged = inputChangedConnection
    end
end

-- ФУНКЦИЯ SPIN (КРУТИЛКА КАК В INFINITE YIELD) - ИГРОК КРУТИТСЯ С ПОМОЩЬЮ BodyAngularVelocity
local function toggleSpin(enabled)
    settings.spin = enabled
    
    if enabled then
        print("Spin: ENABLED - Player spinning at speed " .. settings.spinSpeed)
        
        -- Удаляем старый спин если есть
        if player.Character then
            local rootPart = getRoot(player.Character)
            if rootPart then
                for i, v in pairs(rootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
            end
        end
        
        -- Создаем BodyAngularVelocity для вращения
        local function setupSpin()
            if not player.Character then return end
            
            local rootPart = getRoot(player.Character)
            if not rootPart then return end
            
            -- Удаляем старый спин если есть
            for i, v in pairs(rootPart:GetChildren()) do
                if v.Name == "Spinning" then
                    v:Destroy()
                end
            end
            
            -- Создаем новый BodyAngularVelocity
            local spin = Instance.new("BodyAngularVelocity")
            spin.Name = "Spinning"
            spin.Parent = rootPart
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.AngularVelocity = Vector3.new(0, settings.spinSpeed, 0)
            spin.P = math.huge
            
            print("Spin: BodyAngularVelocity created with speed " .. settings.spinSpeed)
        end
        
        -- Настраиваем спин при появлении персонажа
        setupSpin()
        
        -- Следим за изменением скорости спина
        spinConnection = RunService.Heartbeat:Connect(function()
            if not settings.spin or not player.Character then return end
            
            local rootPart = getRoot(player.Character)
            if rootPart then
                local spin = rootPart:FindFirstChild("Spinning")
                if spin then
                    -- Обновляем скорость вращения
                    spin.AngularVelocity = Vector3.new(0, settings.spinSpeed, 0)
                else
                    -- Если спин пропал, создаем заново
                    setupSpin()
                end
            end
        end)
        
    else
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
        
        -- Удаляем BodyAngularVelocity
        if player.Character then
            local rootPart = getRoot(player.Character)
            if rootPart then
                for i, v in pairs(rootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
            end
        end
        
        print("Spin: DISABLED - BodyAngularVelocity destroyed")
    end
end

-- ФУНКЦИЯ FULLBRIGHT
local function toggleFullbright(enabled)
    settings.fullbright = enabled
    
    if enabled then
        print("Fullbright: ENABLED - Maximum brightness")
        
        -- Сохраняем оригинальные настройки освещения
        originalLightingSettings.Ambient = originalLightingSettings.Ambient or Lighting.Ambient
        originalLightingSettings.OutdoorAmbient = originalLightingSettings.OutdoorAmbient or Lighting.OutdoorAmbient
        originalLightingSettings.ClockTime = originalLightingSettings.ClockTime or Lighting.ClockTime
        
        -- Устанавливаем максимальную яркость
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.GeographicLatitude = 0
        Lighting.ExposureCompensation = 1
        
        fullbrightConnection = RunService.Heartbeat:Connect(function()
            if not settings.fullbright then return end
            
            -- Поддерживаем яркость
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        end)
        
    else
        if fullbrightConnection then
            fullbrightConnection:Disconnect()
            fullbrightConnection = nil
        end
        
        -- Восстанавливаем оригинальные настройки
        if originalLightingSettings.Ambient then
            Lighting.Ambient = originalLightingSettings.Ambient
        end
        if originalLightingSettings.OutdoorAmbient then
            Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient
        end
        if originalLightingSettings.ClockTime then
            Lighting.ClockTime = originalLightingSettings.ClockTime
        end
        
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
        
        print("Fullbright: DISABLED")
    end
end

-- ИСПРАВЛЕННАЯ ФУНКЦИЯ AUTOCLICKER
local function toggleAutoclicker(enabled)
    settings.autoclicker = enabled
    
    if enabled then
        print("Autoclicker: ENABLED - " .. settings.autoclickerSpeed .. " clicks per second")
        
        local lastClickTime = 0
        
        autoclickerConnection = RunService.Heartbeat:Connect(function()
            if not settings.autoclicker then return end
            
            -- Автоматический клик с заданной скоростью
            local delay = 1 / settings.autoclickerSpeed
            local currentTime = tick()
            
            if currentTime - lastClickTime >= delay then
                lastClickTime = currentTime
                
                -- Имитируем клик мыши
                if player.Character then
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        pcall(function()
                            -- Активируем инструмент
                            tool:Activate()
                            
                            -- Для разных типов оружия
                            local remoteEvents = {}
                            for _, remote in pairs(tool:GetDescendants()) do
                                if remote:IsA("RemoteEvent") then
                                    table.insert(remoteEvents, remote)
                                end
                            end
                            
                            -- Отправляем события стрельбы
                            for _, remote in pairs(remoteEvents) do
                                pcall(function()
                                    if remote.Name == "Fire" or remote.Name == "Shoot" or remote.Name == "Attack" then
                                        remote:FireServer()
                                    else
                                        remote:FireServer("Fire", tool.Handle.Position)
                                    end
                                end)
                            end
                        end)
                    else
                        -- Если нет инструмента, имитируем обычный клик
                        pcall(function()
                            local mouse = player:GetMouse()
                            if mouse then
                                local target = mouse.Target
                                if target then
                                    -- Кликаем по объекту
                                    fireclickdetector(target:FindFirstChildOfClass("ClickDetector"))
                                end
                            end
                        end)
                    end
                end
            end
        end)
        
    else
        if autoclickerConnection then
            autoclickerConnection:Disconnect()
            autoclickerConnection = nil
        end
        print("Autoclicker: DISABLED")
    end
end

-- Функция для превращения в скибиди туалет
local function toggleSkibidiToilet()
    if skibidiToilet then
        -- Удаляем скибиди туалет
        skibidiToilet:Destroy()
        skibidiToilet = nil
        print("Skibidi Toilet: OFF")
    else
        -- Создаем скибиди туалет
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        skibidiToilet = Instance.new("Folder")
        skibidiToilet.Name = "SkibidiToilet"
        skibidiToilet.Parent = workspace
        
        -- Создаем туалет (основная часть)
        local toilet = Instance.new("Part")
        toilet.Name = "Toilet"
        toilet.Size = Vector3.new(4, 5, 4)
        toilet.Material = Enum.Material.Plastic
        toilet.BrickColor = BrickColor.new("Bright blue")
        toilet.Anchored = false
        toilet.CanCollide = false
        toilet.Parent = skibidiToilet
        
        local toiletWeld = Instance.new("Weld")
        toiletWeld.Part0 = humanoidRootPart
        toiletWeld.Part1 = toilet
        toiletWeld.C0 = CFrame.new(0, -2, 0)
        toiletWeld.Parent = toilet
        
        -- Крышка туалета
        local toiletLid = Instance.new("Part")
        toiletLid.Name = "ToiletLid"
        toiletLid.Size = Vector3.new(4.2, 0.5, 4.2)
        toiletLid.Material = Enum.Material.Plastic
        toiletLid.BrickColor = BrickColor.new("Bright blue")
        toiletLid.Anchored = false
        toiletLid.CanCollide = false
        toiletLid.Parent = skibidiToilet
        
        local lidWeld = Instance.new("Weld")
        lidWeld.Part0 = toilet
        lidWeld.Part1 = toiletLid
        lidWeld.C0 = CFrame.new(0, 2.5, 0)
        lidWeld.Parent = toiletLid
        
        -- Голова скибиди (выскакивающая из туалета)
        local skibidiHead = Instance.new("Part")
        skibidiHead.Name = "SkibidiHead"
        skibidiHead.Size = Vector3.new(2, 2, 2)
        skibidiHead.Shape = Enum.PartType.Ball
        skibidiHead.Material = Enum.Material.Neon
        skibidiHead.BrickColor = BrickColor.new("Bright yellow")
        skibidiHead.Anchored = false
        skibidiHead.CanCollide = false
        skibidiHead.Parent = skibidiToilet
        
        local headWeld = Instance.new("Weld")
        headWeld.Part0 = toilet
        headWeld.Part1 = skibidiHead
        headWeld.C0 = CFrame.new(0, 3, 0)
        headWeld.Parent = skibidiHead
        
        -- Глаза
        local leftEye = Instance.new("Part")
        leftEye.Name = "LeftEye"
        leftEye.Size = Vector3.new(0.4, 0.4, 0.4)
        leftEye.Shape = Enum.PartType.Ball
        leftEye.Material = Enum.Material.Neon
        leftEye.BrickColor = BrickColor.new("Really red")
        leftEye.Anchored = false
        leftEye.CanCollide = false
        leftEye.Parent = skibidiToilet
        
        local leftEyeWeld = Instance.new("Weld")
        leftEyeWeld.Part0 = skibidiHead
        leftEyeWeld.Part1 = leftEye
        leftEyeWeld.C0 = CFrame.new(-0.5, 0.3, 0.8)
        leftEyeWeld.Parent = leftEye
        
        local rightEye = Instance.new("Part")
        rightEye.Name = "RightEye"
        rightEye.Size = Vector3.new(0.4, 0.4, 0.4)
        rightEye.Shape = Enum.PartType.Ball
        rightEye.Material = Enum.Material.Neon
        rightEye.BrickColor = BrickColor.new("Really red")
        rightEye.Anchored = false
        rightEye.CanCollide = false
        rightEye.Parent = skibidiToilet
        
        local rightEyeWeld = Instance.new("Weld")
        rightEyeWeld.Part0 = skibidiHead
        rightEyeWeld.Part1 = rightEye
        rightEyeWeld.C0 = CFrame.new(0.5, 0.3, 0.8)
        rightEyeWeld.Parent = rightEye
        
        -- Рот
        local mouth = Instance.new("Part")
        mouth.Name = "Mouth"
        mouth.Size = Vector3.new(1, 0.3, 0.3)
        mouth.Material = Enum.Material.Neon
        mouth.BrickColor = BrickColor.new("Really red")
        mouth.Anchored = false
        mouth.CanCollide = false
        mouth.Parent = skibidiToilet
        
        local mouthWeld = Instance.new("Weld")
        mouthWeld.Part0 = skibidiHead
        mouthWeld.Part1 = mouth
        mouthWeld.C0 = CFrame.new(0, -0.3, 0.8)
        mouthWeld.Parent = mouth
        
        -- Анимация выскакивания головы
        local headConnection
        headConnection = RunService.Heartbeat:Connect(function()
            if not skibidiToilet or not character:FindFirstChild("HumanoidRootPart") then
                if headConnection then
                    headConnection:Disconnect()
                end
                return
            end
            
            -- Плавное движение головы вверх-вниз
            local time = tick()
            local bounce = math.sin(time * 3) * 0.5
            headWeld.C0 = CFrame.new(0, 3 + bounce, 0)
            
            -- Моргание глаз
            if math.sin(time * 5) > 0.8 then
                leftEye.Transparency = 0
                rightEye.Transparency = 0
            else
                leftEye.Transparency = 0
                rightEye.Transparency = 0
            end
        end)
        
        print("Skibidi Toilet: ON - DOOM DOOM DOOM YES YES YES")
    end
end

-- Функция для получения ближайшей цели для Silent Aim
local function getClosestTarget()
    local character = player.Character
    if not character then return nil end
    
    local camera = workspace.CurrentCamera
    local bestTarget = nil
    local closestDistance = settings.silentAimFov
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local targetCharacter = otherPlayer.Character
            local targetPart = targetCharacter:FindFirstChild(settings.silentAimHitbox)
            local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
            
            -- Проверяем, является ли игрок союзником
            local isTeammate = false
            if settings.aimIgnoreTeam and otherPlayer.Team and player.Team then
                isTeammate = (otherPlayer.Team == player.Team)
            end
            
            if targetPart and targetHumanoid and targetHumanoid.Health > 0 and not isTeammate then
                -- Проверяем видимость цели
                local isVisible = true
                if not settings.aimThroughWalls then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    raycastParams.FilterDescendantsInstances = {character, targetCharacter}
                    local raycastResult = workspace:Raycast(
                        camera.CFrame.Position,
                        (targetPart.Position - camera.CFrame.Position).Unit * 1000,
                        raycastParams
                    )
                    
                    if raycastResult and raycastResult.Instance and not raycastResult.Instance:IsDescendantOf(targetCharacter) then
                        isVisible = false
                    end
                end
                
                if isVisible then
                    -- Вычисляем позицию цели на экране
                    local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen then
                        -- Вычисляем расстояние от центра экрана до цели
                        local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                        local targetPoint = Vector2.new(screenPoint.X, screenPoint.Y)
                        local distance = (center - targetPoint).Magnitude
                        
                        -- Если цель ближе к центру, чем предыдущая лучшая цель
                        if distance < closestDistance then
                            closestDistance = distance
                            bestTarget = targetPart
                        end
                    end
                end
            end
        end
    end
    
    return bestTarget
end

-- SILENT AIM SYSTEM
local function toggleSilentAim(enabled)
    settings.silentAim = enabled
    
    if enabled then
        print("Silent Aim: ENABLED - Auto-targeting closest enemy")
        
        -- Подключаем Silent Aim
        silentAimConnection = RunService.Heartbeat:Connect(function()
            if not settings.silentAim then return end
            
            local target = getClosestTarget()
            if target then
                -- Автоматически наводимся на цель
                local camera = workspace.CurrentCamera
                local currentCFrame = camera.CFrame
                local targetPosition = target.Position
                
                -- Вычисляем направление к цели
                local direction = (targetPosition - currentCFrame.Position).Unit
                
                -- Плавное наведение
                local smoothness = math.max(1, settings.aimSmoothness)
                local newLookVector = currentCFrame.LookVector:Lerp(direction, 1 / smoothness)
                
                -- Создаем новый CFrame
                camera.CFrame = CFrame.lookAt(currentCFrame.Position, currentCFrame.Position + newLookVector)
                
                -- Авто-стрельба при активном Silent Aim
                autoShoot()
            end
        end)
        
    else
        if silentAimConnection then
            silentAimConnection:Disconnect()
            silentAimConnection = nil
        end
        print("Silent Aim: DISABLED")
    end
end

-- ESP SYSTEM (БЕЗ ТРАЙСЕРОВ)
local function createSkeletonESP(character, color)
    local espGroup = Instance.new("Folder")
    espGroup.Name = "ESP_" .. character.Name
    espGroup.Parent = espFolder
    
    -- Names
    if settings.espNames then
        local head = character:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NameTag"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = head
            billboard.Parent = espGroup
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Text = character.Name
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = color
            nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 14
            nameLabel.Parent = billboard
        end
    end
    
    -- Skeleton
    if settings.espSkeleton then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Skeleton"
        highlight.Adornee = character
        highlight.FillColor = color
        highlight.FillTransparency = 0.8
        highlight.OutlineColor = color
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = espGroup
    end
    
    -- Boxes
    if settings.espBoxes then
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        if rootPart then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "Box"
            box.Adornee = rootPart
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = Vector3.new(4, 6, 2)
            box.Transparency = 0.7
            box.Color3 = color
            box.Parent = espGroup
        end
    end
    
    return espGroup
end

local function toggleESP(enabled)
    settings.esp = enabled
    
    if enabled then
        espFolder:ClearAllChildren()
        
        espConnection = RunService.Heartbeat:Connect(function()
            if not settings.esp then return end
            
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local character = otherPlayer.Character
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    
                    if humanoid and humanoid.Health > 0 then
                        local espName = "ESP_" .. character.Name
                        
                        if not espFolder:FindFirstChild(espName) then
                            local color = Color3.fromRGB(255, 50, 50)
                            
                            if settings.espTeamColor and otherPlayer.Team then
                                if otherPlayer.Team == player.Team then
                                    color = Color3.fromRGB(50, 255, 50)
                                else
                                    color = Color3.fromRGB(255, 50, 50)
                                end
                            end
                            
                            createSkeletonESP(character, color)
                        end
                    else
                        local oldESP = espFolder:FindFirstChild("ESP_" .. character.Name)
                        if oldESP then
                            oldESP:Destroy()
                        end
                    end
                end
            end
        end)
        
    else
        if espConnection then 
            espConnection:Disconnect() 
        end
        espFolder:ClearAllChildren()
    end
end

-- FLY SYSTEM
local function toggleFly(enabled)
    settings.fly = enabled
    
    if enabled then
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 1000
        bodyGyro.D = 50
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = humanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not settings.fly or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local camera = workspace.CurrentCamera
            local newVelocity = Vector3.new(0, 0, 0)
            
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                newVelocity = newVelocity + camera.CFrame.LookVector * settings.flySpeed
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                newVelocity = newVelocity - camera.CFrame.LookVector * settings.flySpeed
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                newVelocity = newVelocity - camera.CFrame.RightVector * settings.flySpeed
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                newVelocity = newVelocity + camera.CFrame.RightVector * settings.flySpeed
            end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                newVelocity = newVelocity + Vector3.new(0, settings.flySpeed, 0)
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                newVelocity = newVelocity - Vector3.new(0, settings.flySpeed, 0)
            end
            
            bodyVelocity.Velocity = newVelocity
            bodyGyro.CFrame = camera.CFrame
        end)
        
    else
        if flyConnection then 
            flyConnection:Disconnect() 
        end
        if bodyGyro then 
            bodyGyro:Destroy() 
        end
        if bodyVelocity then 
            bodyVelocity:Destroy() 
        end
    end
end

-- SPEED BOOST
local function toggleSpeed(enabled)
    settings.speed = enabled
    
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        if enabled then
            character.Humanoid.WalkSpeed = settings.walkSpeed
        else
            character.Humanoid.WalkSpeed = 16
        end
    end
end

-- HIGH JUMP
local function toggleJump(enabled)
    settings.jump = enabled
    
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        if enabled then
            character.Humanoid.JumpPower = settings.jumpPower
        else
            character.Humanoid.JumpPower = 50
        end
    end
end

-- INFINITE JUMP
local function toggleInfJump(enabled)
    settings.infJump = enabled
    
    if enabled then
        infJumpConnection = UIS.JumpRequest:Connect(function()
            if settings.infJump and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if infJumpConnection then
            infJumpConnection:Disconnect()
        end
    end
end

-- ANTI AFK
local function toggleAntiAfk(enabled)
    settings.antiAfk = enabled
    
    if enabled then
        antiAfkConnection = RunService.Heartbeat:Connect(function()
            if settings.antiAfk then
                local virtualUser = game:GetService("VirtualUser")
                virtualUser:CaptureController()
                virtualUser:ClickButton2(Vector2.new())
            end
        end)
    else
        if antiAfkConnection then 
            antiAfkConnection:Disconnect() 
        end
    end
end

-- X-RAY VISION
local function toggleXray(enabled)
    settings.xray = enabled
    
    if enabled then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent ~= workspace.CurrentCamera then
                part.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

-- NOCLIP SYSTEM
local function toggleNoclip(enabled)
    settings.noclip = enabled
    
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character and settings.noclip then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then 
            noclipConnection:Disconnect() 
        end
    end
end

-- ФУНКЦИЯ ДЛЯ РОЗОВОЙ ПАЛКИ С КРУЖКАМИ ПО БОКАМ
local function togglePinkStick()
    if pinkStick then
        pinkStick:Destroy()
        pinkStick = nil
    else
        local stickGroup = Instance.new("Folder")
        stickGroup.Name = "PinkStickGroup"
        stickGroup.Parent = workspace
        
        local stick = Instance.new("Part")
        stick.Name = "PinkStick"
        stick.Size = Vector3.new(1, 20, 1)
        stick.Material = Enum.Material.Neon
        stick.BrickColor = BrickColor.new("Hot pink")
        stick.Anchored = true
        stick.CanCollide = false
        stick.Parent = stickGroup
        
        local ball1 = Instance.new("Part")
        ball1.Name = "PinkBall1"
        ball1.Size = Vector3.new(3, 3, 3)
        ball1.Shape = Enum.PartType.Ball
        ball1.Material = Enum.Material.Neon
        ball1.BrickColor = BrickColor.new("Hot pink")
        ball1.Anchored = true
        ball1.CanCollide = false
        ball1.Parent = stickGroup
        
        local ball2 = Instance.new("Part")
        ball2.Name = "PinkBall2"
        ball2.Size = Vector3.new(3, 3, 3)
        ball2.Shape = Enum.PartType.Ball
        ball2.Material = Enum.Material.Neon
        ball2.BrickColor = BrickColor.new("Hot pink")
        ball2.Anchored = true
        ball2.CanCollide = false
        ball2.Parent = stickGroup
        
        local ball3 = Instance.new("Part")
        ball3.Name = "PinkBall3"
        ball3.Size = Vector3.new(3, 3, 3)
        ball3.Shape = Enum.PartType.Ball
        ball3.Material = Enum.Material.Neon
        ball3.BrickColor = BrickColor.new("Hot pink")
        ball3.Anchored = true
        ball3.CanCollide = false
        ball3.Parent = stickGroup
        
        pinkStick = stickGroup
        
        local stickConnection
        stickConnection = RunService.Heartbeat:Connect(function()
            if not pinkStick or not player.Character then
                if stickConnection then
                    stickConnection:Disconnect()
                end
                return
            end
            
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local camera = workspace.CurrentCamera
                local offset = camera.CFrame.LookVector * 6
                local stickPos = humanoidRootPart.Position + offset + Vector3.new(0, 10, 0)
                
                stick.Position = stickPos
                stick.CFrame = CFrame.new(stickPos) * CFrame.Angles(0, 0, 0)
                
                local stickBottom = stickPos + Vector3.new(0, -10, 0)
                ball1.Position = stickBottom + Vector3.new(-2, 0, 0)
                ball2.Position = stickBottom + Vector3.new(2, 0, 0)
                
                local stickTop = stickPos + Vector3.new(0, 10, 0)
                ball3.Position = stickTop
            end
        end)
    end
end

-- Функция для автоматической стрельбы
local function autoShoot()
    if not player.Character then return end
    
    -- Ищем оружие в руках
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if tool then
        -- Пытаемся активировать оружие
        pcall(function()
            -- Для разных типов оружия
            tool:Activate()
            
            -- Если есть RemoteEvent для стрельбы
            for _, remote in pairs(tool:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    pcall(function()
                        remote:FireServer("Fire", tool.Handle.Position)
                    end)
                end
            end
        end)
    end
end

-- AIM ASSIST SYSTEM
local function toggleAimAssist(enabled)
    settings.aimAssist = enabled
    
    if enabled then
        aimConnection = RunService.Heartbeat:Connect(function()
            if not settings.aimAssist then return end
            
            -- Проверяем, активен ли какой-либо режим прицеливания
            local shouldAim = UIS:IsKeyDown(settings.aimKey) or 
                            (settings.mobileAimEnabled and mobileAimActive) or
                            (settings.mobileAutoAim and mobileAutoAimActive)
            
            if shouldAim then
                local character = player.Character
                if not character then return end
                
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then return end
                
                local camera = workspace.CurrentCamera
                local bestTarget = nil
                local closestDistance = settings.aimFov
                
                -- Ищем ближайшую цель в поле зрения
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        local targetCharacter = otherPlayer.Character
                        local targetHead = targetCharacter:FindFirstChild("Head")
                        local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
                        
                        -- Проверяем, является ли игрок союзником
                        local isTeammate = false
                        if settings.aimIgnoreTeam and otherPlayer.Team and player.Team then
                            isTeammate = (otherPlayer.Team == player.Team)
                        end
                        
                        if targetHead and targetHumanoid and targetHumanoid.Health > 0 and not isTeammate then
                            -- Проверяем видимость цели
                            local isVisible = true
                            if not settings.aimThroughWalls then
                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                                raycastParams.FilterDescendantsInstances = {character, targetCharacter}
                                local raycastResult = workspace:Raycast(
                                    camera.CFrame.Position,
                                    (targetHead.Position - camera.CFrame.Position).Unit * 1000,
                                    raycastParams
                                )
                                
                                if raycastResult and raycastResult.Instance and not raycastResult.Instance:IsDescendantOf(targetCharacter) then
                                    isVisible = false
                                end
                            end
                            
                            if isVisible then
                                -- Вычисляем позицию цели на экране
                                local screenPoint, onScreen = camera:WorldToViewportPoint(targetHead.Position)
                                
                                if onScreen then
                                    -- Вычисляем расстояние от центра экрана до цели
                                    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                                    local targetPoint = Vector2.new(screenPoint.X, screenPoint.Y)
                                    local distance = (center - targetPoint).Magnitude
                                    
                                    -- Если цель ближе к центру, чем предыдущая лучшая цель
                                    if distance < closestDistance then
                                        closestDistance = distance
                                        bestTarget = targetHead
                                    end
                                end
                            end
                        end
                    end
                end
                
                -- Если нашли цель
                if bestTarget then
                    local camera = workspace.CurrentCamera
                    local currentCFrame = camera.CFrame
                    local targetPosition = bestTarget.Position
                    
                    -- Вычисляем направление к цели
                    local direction = (targetPosition - currentCFrame.Position).Unit
                    
                    -- Плавное наведение с учетом smoothness
                    local smoothness = math.max(1, settings.aimSmoothness)
                    local newLookVector = currentCFrame.LookVector:Lerp(direction, 1 / smoothness)
                    
                    -- Создаем новый CFrame
                    camera.CFrame = CFrame.lookAt(currentCFrame.Position, currentCFrame.Position + newLookVector)
                    
                    -- Если активен авто-аим, стреляем автоматически
                    if settings.mobileAutoAim and mobileAutoAimActive then
                        autoShoot()
                    end
                end
            end
        end)
    else
        if aimConnection then
            aimConnection:Disconnect()
        end
    end
end

-- Теперь создаем GUI с ВСЕМИ настройками
local function createGUI()
    -- Проверяем, не существует ли уже GUI
    local playerGui = player:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("UniversalEnhancer") then
        gui = playerGui:FindFirstChild("UniversalEnhancer")
        -- Находим элементы и обновляем ссылки
        mobileIcon = gui:FindFirstChild("MobileIcon")
        mainFrame = gui:FindFirstChild("MainFrame")
        mobileAimButton = gui:FindFirstChild("MobileAimButton")
        mobileAutoAimButton = gui:FindFirstChild("MobileAutoAimButton")
        return gui
    end

    -- Создание GUI
    gui = Instance.new("ScreenGui")
    gui.Name = "UniversalEnhancer"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    -- Иконка для мобильных устройств
    mobileIcon = Instance.new("ImageButton")
    mobileIcon.Name = "MobileIcon"
    mobileIcon.Size = UDim2.new(0, 60, 0, 60)
    mobileIcon.Position = UDim2.new(0, 20, 0, 20)
    mobileIcon.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    mobileIcon.Image = "rbxassetid://3926305904"
    mobileIcon.ImageRectOffset = Vector2.new(964, 324)
    mobileIcon.ImageRectSize = Vector2.new(36, 36)
    mobileIcon.Visible = true
    mobileIcon.Active = true
    mobileIcon.Selectable = true
    mobileIcon.Parent = gui

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 15)
    iconCorner.Parent = mobileIcon

    -- Кнопка Aim для телефона (ручной режим)
    mobileAimButton = Instance.new("TextButton")
    mobileAimButton.Name = "MobileAimButton"
    mobileAimButton.Size = UDim2.new(0, 70, 0, 70)
    mobileAimButton.Position = UDim2.new(1, -80, 1, -160)
    mobileAimButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    mobileAimButton.BackgroundTransparency = 0.3
    mobileAimButton.Text = "🎯\nHOLD"
    mobileAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mobileAimButton.Font = Enum.Font.GothamBold
    mobileAimButton.TextSize = 12
    mobileAimButton.Visible = false
    mobileAimButton.Active = true
    mobileAimButton.Parent = gui

    local aimCorner = Instance.new("UICorner")
    aimCorner.CornerRadius = UDim.new(1, 0)
    aimCorner.Parent = mobileAimButton

    -- Кнопка Auto Aim для телефона (автоматический режим)
    mobileAutoAimButton = Instance.new("TextButton")
    mobileAutoAimButton.Name = "MobileAutoAimButton"
    mobileAutoAimButton.Size = UDim2.new(0, 70, 0, 70)
    mobileAutoAimButton.Position = UDim2.new(1, -80, 1, -80)
    mobileAutoAimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    mobileAutoAimButton.BackgroundTransparency = 0.3
    mobileAutoAimButton.Text = "🤖\nAUTO"
    mobileAutoAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mobileAutoAimButton.Font = Enum.Font.GothamBold
    mobileAutoAimButton.TextSize = 12
    mobileAutoAimButton.Visible = false
    mobileAutoAimButton.Active = true
    mobileAutoAimButton.Parent = gui

    local autoAimCorner = Instance.new("UICorner")
    autoAimCorner.CornerRadius = UDim.new(1, 0)
    autoAimCorner.Parent = mobileAutoAimButton

    -- Основное окно (УВЕЛИЧЕНО ВЫСОТА)
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 600) -- Увеличена высота с 500 до 600
    mainFrame.Position = UDim2.new(0, 50, 0, 100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = false
    mainFrame.Active = true
    mainFrame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Text = "🎮 UNIVERSAL ENHANCER"
    title.Size = UDim2.new(0.6, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = titleBar

    -- Кнопка закрыть
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "×"
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(0.85, 0, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.Active = true
    closeBtn.Parent = titleBar

    -- Кнопка уменьшения размера
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Text = "−"
    minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    minimizeBtn.Position = UDim2.new(0.75, 0, 0, 0)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 18
    minimizeBtn.Active = true
    minimizeBtn.Parent = titleBar

    -- Контент (УВЕЛИЧЕНА ВЫСОТА)
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -35)
    contentFrame.Position = UDim2.new(0, 0, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 6
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 1500) -- Увеличена высота контента
    contentFrame.Parent = mainFrame

    -- Расширенные настройки Fly - УМЕНЬШЕННЫЙ РАЗМЕР
    local flySettingsFrame = Instance.new("Frame")
    flySettingsFrame.Name = "FlySettingsFrame"
    flySettingsFrame.Size = UDim2.new(0, 300, 0, 120)
    flySettingsFrame.Position = UDim2.new(0, 360, 0, 40)
    flySettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    flySettingsFrame.BorderSizePixel = 0
    flySettingsFrame.Visible = false
    flySettingsFrame.Parent = mainFrame

    local flySettingsCorner = Instance.new("UICorner")
    flySettingsCorner.CornerRadius = UDim.new(0, 8)
    flySettingsCorner.Parent = flySettingsFrame

    local flySettingsTitle = Instance.new("TextLabel")
    flySettingsTitle.Text = "⚙ FLY SETTINGS"
    flySettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    flySettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    flySettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    flySettingsTitle.Font = Enum.Font.GothamBold
    flySettingsTitle.TextSize = 12
    flySettingsTitle.Parent = flySettingsFrame

    -- Расширенные настройки Speed - УМЕНЬШЕННЫЙ РАЗМЕР
    local speedSettingsFrame = Instance.new("Frame")
    speedSettingsFrame.Name = "SpeedSettingsFrame"
    speedSettingsFrame.Size = UDim2.new(0, 300, 0, 150)
    speedSettingsFrame.Position = UDim2.new(0, 360, 0, 170)
    speedSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    speedSettingsFrame.BorderSizePixel = 0
    speedSettingsFrame.Visible = false
    speedSettingsFrame.Parent = mainFrame

    local speedSettingsCorner = Instance.new("UICorner")
    speedSettingsCorner.CornerRadius = UDim.new(0, 8)
    speedSettingsCorner.Parent = speedSettingsFrame

    local speedSettingsTitle = Instance.new("TextLabel")
    speedSettingsTitle.Text = "⚙ SPEED SETTINGS"
    speedSettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    speedSettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    speedSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedSettingsTitle.Font = Enum.Font.GothamBold
    speedSettingsTitle.TextSize = 12
    speedSettingsTitle.Parent = speedSettingsFrame

    -- Расширенные настройки ESP - УМЕНЬШЕННЫЙ РАЗМЕР
    local espSettingsFrame = Instance.new("Frame")
    espSettingsFrame.Name = "ESPSettingsFrame"
    espSettingsFrame.Size = UDim2.new(0, 300, 0, 160)
    espSettingsFrame.Position = UDim2.new(0, 360, 0, 330)
    espSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    espSettingsFrame.BorderSizePixel = 0
    espSettingsFrame.Visible = false
    espSettingsFrame.Parent = mainFrame

    local espSettingsCorner = Instance.new("UICorner")
    espSettingsCorner.CornerRadius = UDim.new(0, 8)
    espSettingsCorner.Parent = espSettingsFrame

    local espSettingsTitle = Instance.new("TextLabel")
    espSettingsTitle.Text = "⚙ ESP SETTINGS"
    espSettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    espSettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    espSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    espSettingsTitle.Font = Enum.Font.GothamBold
    espSettingsTitle.TextSize = 12
    espSettingsTitle.Parent = espSettingsFrame

    -- Расширенные настройки Aim Assist - УВЕЛИЧЕН РАЗМЕР ДЛЯ ПОЛЗУНКОВ
    local aimSettingsFrame = Instance.new("Frame")
    aimSettingsFrame.Name = "AimSettingsFrame"
    aimSettingsFrame.Size = UDim2.new(0, 300, 0, 350) -- Увеличена высота с 280 до 350
    aimSettingsFrame.Position = UDim2.new(0, 360, 0, 40)
    aimSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    aimSettingsFrame.BorderSizePixel = 0
    aimSettingsFrame.Visible = false
    aimSettingsFrame.Parent = mainFrame

    local aimSettingsCorner = Instance.new("UICorner")
    aimSettingsCorner.CornerRadius = UDim.new(0, 8)
    aimSettingsCorner.Parent = aimSettingsFrame

    local aimSettingsTitle = Instance.new("TextLabel")
    aimSettingsTitle.Text = "⚙ AIM ASSIST SETTINGS"
    aimSettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    aimSettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    aimSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimSettingsTitle.Font = Enum.Font.GothamBold
    aimSettingsTitle.TextSize = 12
    aimSettingsTitle.Parent = aimSettingsFrame

    -- Расширенные настройки Graphics - УВЕЛИЧЕН РАЗМЕР
    local graphicsSettingsFrame = Instance.new("Frame")
    graphicsSettingsFrame.Name = "GraphicsSettingsFrame"
    graphicsSettingsFrame.Size = UDim2.new(0, 300, 0, 240) -- Увеличена высота с 200 до 240
    graphicsSettingsFrame.Position = UDim2.new(0, 360, 0, 40)
    graphicsSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    graphicsSettingsFrame.BorderSizePixel = 0
    graphicsSettingsFrame.Visible = false
    graphicsSettingsFrame.Parent = mainFrame

    local graphicsSettingsCorner = Instance.new("UICorner")
    graphicsSettingsCorner.CornerRadius = UDim.new(0, 8)
    graphicsSettingsCorner.Parent = graphicsSettingsFrame

    local graphicsSettingsTitle = Instance.new("TextLabel")
    graphicsSettingsTitle.Text = "⚙ GRAPHICS SETTINGS"
    graphicsSettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    graphicsSettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    graphicsSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    graphicsSettingsTitle.Font = Enum.Font.GothamBold
    graphicsSettingsTitle.TextSize = 12
    graphicsSettingsTitle.Parent = graphicsSettingsFrame

    -- РАСШИРЕННЫЕ НАСТРОЙКИ BIG BOOBS
    local bigBoobsSettingsFrame = Instance.new("Frame")
    bigBoobsSettingsFrame.Name = "BigBoobsSettingsFrame"
    bigBoobsSettingsFrame.Size = UDim2.new(0, 300, 0, 120)
    bigBoobsSettingsFrame.Position = UDim2.new(0, 360, 0, 40)
    bigBoobsSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    bigBoobsSettingsFrame.BorderSizePixel = 0
    bigBoobsSettingsFrame.Visible = false
    bigBoobsSettingsFrame.Parent = mainFrame

    local bigBoobsSettingsCorner = Instance.new("UICorner")
    bigBoobsSettingsCorner.CornerRadius = UDim.new(0, 8)
    bigBoobsSettingsCorner.Parent = bigBoobsSettingsFrame

    local bigBoobsSettingsTitle = Instance.new("TextLabel")
    bigBoobsSettingsTitle.Text = "⚙ BIG BOOBS SETTINGS"
    bigBoobsSettingsTitle.Size = UDim2.new(1, 0, 0, 25)
    bigBoobsSettingsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bigBoobsSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    bigBoobsSettingsTitle.Font = Enum.Font.GothamBold
    bigBoobsSettingsTitle.TextSize = 12
    bigBoobsSettingsTitle.Parent = bigBoobsSettingsFrame

    -- Ссылки на кнопки для обновления
    local buttonReferences = {}

    -- Функция обновления кнопок
    local function updateButton(settingName, enabled)
        if buttonReferences[settingName] then
            local button = buttonReferences[settingName]
            if enabled then
                button.Text = "✅ " .. string.sub(button.Text, 5)
                if settingName == "bigBoobs" then
                    button.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Оранжевый когда включено
                else
                    button.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                end
            else
                button.Text = "❌ " .. string.sub(button.Text, 5)
                if settingName == "bigBoobs" then
                    button.BackgroundColor3 = Color3.fromRGB(80, 40, 0) -- Темно-оранжевый когда выключено
                else
                    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end
            end
        end
    end

    -- Функция создания кнопок
    local function createToggleButton(text, yPosition, toggleFunction, settingName)
        local button = Instance.new("TextButton")
        button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
        button.Size = UDim2.new(0.9, 0, 0, 40)
        button.Position = UDim2.new(0.05, 0, 0, yPosition)
        
        -- Особый цвет для кнопки Big Boobs
        if settingName == "bigBoobs" then
            button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(80, 40, 0)
        else
            button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(45, 45, 45)
        end
        
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 12
        button.Active = true
        button.Parent = contentFrame
        
        buttonReferences[settingName] = button
        
        button.MouseButton1Click:Connect(function()
            local newState = not settings[settingName]
            settings[settingName] = newState
            updateButton(settingName, newState)
            toggleFunction(newState)
        end)
        
        return button
    end

    -- Функция создания ESP настройки
    local function createESPSetting(text, yPosition, settingName)
        local button = Instance.new("TextButton")
        button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
        button.Size = UDim2.new(0.9, 0, 0, 30)
        button.Position = UDim2.new(0.05, 0, 0, yPosition)
        button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 11
        button.Active = true
        button.Parent = espSettingsFrame
        
        button.MouseButton1Click:Connect(function()
            settings[settingName] = not settings[settingName]
            button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
            button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
            if settings.esp then
                toggleESP(true)
            end
        end)
    end

    -- Функция создания Aim Assist настройки
    local function createAimSetting(text, yPosition, settingName)
        local button = Instance.new("TextButton")
        button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
        button.Size = UDim2.new(0.9, 0, 0, 30)
        button.Position = UDim2.new(0.05, 0, 0, yPosition)
        button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 11
        button.Active = true
        button.Parent = aimSettingsFrame
        
        button.MouseButton1Click:Connect(function()
            settings[settingName] = not settings[settingName]
            button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
            button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
        end)
    end

    -- Функция создания Graphics настройки
    local function createGraphicsSetting(text, yPosition, toggleFunction, settingName)
        local button = Instance.new("TextButton")
        button.Text = settings[settingName] and "✅ " .. text or "❌ " .. text
        button.Size = UDim2.new(0.9, 0, 0, 30)
        button.Position = UDim2.new(0.05, 0, 0, yPosition)
        button.BackgroundColor3 = settings[settingName] and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 11
        button.Active = true
        button.Parent = graphicsSettingsFrame
        
        button.MouseButton1Click:Connect(function()
            local newState = not settings[settingName]
            settings[settingName] = newState
            button.Text = newState and "✅ " .. text or "❌ " .. text
            button.BackgroundColor3 = newState and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
            toggleFunction(newState)
        end)
    end

    -- Функция создания выпадающего списка
    local function createDropdown(parentFrame, text, yPosition, options, defaultValue, settingName, callback)
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(0.9, 0, 0, 50)
        dropdownFrame.Position = UDim2.new(0.05, 0, 0, yPosition)
        dropdownFrame.BackgroundTransparency = 1
        dropdownFrame.Parent = parentFrame
        
        local label = Instance.new("TextLabel")
        label.Text = text .. ": " .. settings[settingName]
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.Parent = dropdownFrame
        
        local dropdown = Instance.new("TextButton")
        dropdown.Size = UDim2.new(1, 0, 0, 25)
        dropdown.Position = UDim2.new(0, 0, 0, 25)
        dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        dropdown.Text = settings[settingName]
        dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdown.Font = Enum.Font.Gotham
        dropdown.TextSize = 11
        dropdown.Active = true
        dropdown.Parent = dropdownFrame
        
        local dropdownCorner = Instance.new("UICorner")
        dropdownCorner.CornerRadius = UDim.new(0, 5)
        dropdownCorner.Parent = dropdown
        
        dropdown.MouseButton1Click:Connect(function()
            for i, option in pairs(options) do
                if option == settings[settingName] then
                    local nextOption = options[(i % #options) + 1]
                    settings[settingName] = nextOption
                    dropdown.Text = nextOption
                    label.Text = text .. ": " .. nextOption
                    if callback then
                        callback(nextOption)
                    end
                    break
                end
            end
        end)
    end

    -- Функция создания ползунка
    local function createSlider(parentFrame, text, yPosition, minValue, maxValue, defaultValue, settingName, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(0.9, 0, 0, 50)
        sliderFrame.Position = UDim2.new(0.05, 0, 0, yPosition)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = parentFrame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Text = text .. ": " .. settings[settingName]
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.Parent = sliderFrame
        
        local slider = Instance.new("TextButton")
        slider.Name = "Slider"
        slider.Size = UDim2.new(1, 0, 0, 20)
        slider.Position = UDim2.new(0, 0, 0, 25)
        slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        slider.Text = ""
        slider.Active = true
        slider.Parent = sliderFrame
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 5)
        sliderCorner.Parent = slider
        
        local fill = Instance.new("Frame")
        fill.Name = "Fill"
        fill.Size = UDim2.new((settings[settingName] - minValue) / (maxValue - minValue), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        fill.BorderSizePixel = 0
        fill.Parent = slider
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 5)
        fillCorner.Parent = fill
        
        local connection = nil
        
        slider.MouseButton1Down:Connect(function()
            if connection then
                connection:Disconnect()
            end
            
            connection = RunService.Heartbeat:Connect(function()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                local x = math.clamp(mouse.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
                local percent = x / slider.AbsoluteSize.X
                local value = math.floor(minValue + (maxValue - minValue) * percent)
                
                fill.Size = UDim2.new(percent, 0, 1, 0)
                label.Text = text .. ": " .. value
                settings[settingName] = value
                
                if callback then
                    callback(value)
                end
            end)
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and connection then
                connection:Disconnect()
                connection = nil
            end
        end)
    end

    -- МОБИЛЬНЫЙ AIM SYSTEM
    local mobileAimActive = false
    local mobileAimTouch = nil
    local mobileAutoAimActive = false
    local mobileAutoAimTouch = nil

    local function toggleMobileAim(enabled)
        settings.mobileAimEnabled = enabled
        updateButton("mobileAimEnabled", enabled)
        if mobileAimButton then
            mobileAimButton.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            mobileAimButton.Visible = enabled and UIS.TouchEnabled
        end
    end

    local function toggleMobileAutoAim(enabled)
        settings.mobileAutoAim = enabled
        updateButton("mobileAutoAim", enabled)
        if mobileAutoAimButton then
            mobileAutoAimButton.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(100, 100, 255)
            mobileAutoAimButton.Visible = enabled and UIS.TouchEnabled
        end
    end

    -- Обработчики для мобильного аима (ручной режим)
    mobileAimButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and settings.mobileAimEnabled then
            mobileAimActive = true
            mobileAimTouch = input
            mobileAimButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            print("Mobile Aim: ACTIVATED")
        end
    end)

    mobileAimButton.InputEnded:Connect(function(input)
        if input == mobileAimTouch then
            mobileAimActive = false
            mobileAimTouch = nil
            mobileAimButton.BackgroundColor3 = settings.mobileAimEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            print("Mobile Aim: DEACTIVATED")
        end
    end)

    -- Обработчики для авто-аима
    mobileAutoAimButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and settings.mobileAutoAim then
            mobileAutoAimActive = true
            mobileAutoAimTouch = input
            mobileAutoAimButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
            print("Mobile Auto Aim: ACTIVATED")
        end
    end)

    mobileAutoAimButton.InputEnded:Connect(function(input)
        if input == mobileAutoAimTouch then
            mobileAutoAimActive = false
            mobileAutoAimTouch = nil
            mobileAutoAimButton.BackgroundColor3 = settings.mobileAutoAim and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(100, 100, 255)
            print("Mobile Auto Aim: DEACTIVATED")
        end
    end

    -- Функции управления GUI - ИСПРАВЛЕННЫЕ
    local function toggleGUI()
        settings.guiVisible = not settings.guiVisible
        mainFrame.Visible = settings.guiVisible
        print("GUI toggled: " .. tostring(settings.guiVisible))
    end

    local function closeGUI()
        mainFrame.Visible = false
        settings.guiVisible = false
        flySettingsFrame.Visible = false
        speedSettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
        print("GUI closed")
    end

    local function minimizeGUI()
        if settings.guiScale == 1 then
            settings.guiScale = 0.7
            mainFrame.Size = UDim2.new(0, 350 * 0.7, 0, 600 * 0.7)
            minimizeBtn.Text = "+"
        else
            settings.guiScale = 1
            mainFrame.Size = UDim2.new(0, 350, 0, 600)
            minimizeBtn.Text = "−"
        end
    end

    local function toggleFlySettings()
        flySettingsFrame.Visible = not flySettingsFrame.Visible
        speedSettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
    end

    local function toggleSpeedSettings()
        speedSettingsFrame.Visible = not speedSettingsFrame.Visible
        flySettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
    end

    local function toggleESPSettings()
        espSettingsFrame.Visible = not espSettingsFrame.Visible
        flySettingsFrame.Visible = false
        speedSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
    end

    local function toggleAimSettings()
        aimSettingsFrame.Visible = not aimSettingsFrame.Visible
        flySettingsFrame.Visible = false
        speedSettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
    end

    local function toggleGraphicsSettings()
        graphicsSettingsFrame.Visible = not graphicsSettingsFrame.Visible
        flySettingsFrame.Visible = false
        speedSettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        bigBoobsSettingsFrame.Visible = false
    end

    -- Функция для переключения настроек Big Boobs
    local function toggleBigBoobsSettings()
        bigBoobsSettingsFrame.Visible = not bigBoobsSettingsFrame.Visible
        flySettingsFrame.Visible = false
        speedSettingsFrame.Visible = false
        espSettingsFrame.Visible = false
        aimSettingsFrame.Visible = false
        graphicsSettingsFrame.Visible = false
    end

    -- Обработчики кнопок GUI
    local function handleIconClick()
        print("Mobile icon clicked - toggling GUI")
        toggleGUI()
    end

    -- Надежные обработчики для иконки
    mobileIcon.MouseButton1Click:Connect(handleIconClick)
    mobileIcon.TouchTap:Connect(handleIconClick)
    mobileIcon.Activated:Connect(handleIconClick)

    closeBtn.MouseButton1Click:Connect(closeGUI)
    minimizeBtn.MouseButton1Click:Connect(minimizeGUI)

    -- Создание кнопок
    createToggleButton("FLY", 30, toggleFly, "fly")
    createToggleButton("NOCLIP", 80, toggleNoclip, "noclip")
    createToggleButton("ESP PLAYERS", 130, toggleESP, "esp")
    createToggleButton("SPEED BOOST", 180, toggleSpeed, "speed")
    createToggleButton("HIGH JUMP", 230, toggleJump, "jump")
    createToggleButton("INFINITE JUMP", 280, toggleInfJump, "infJump")
    createToggleButton("ANTI AFK", 330, toggleAntiAfk, "antiAfk")
    createToggleButton("X-RAY VISION", 380, toggleXray, "xray")
    createToggleButton("AIM ASSIST", 430, toggleAimAssist, "aimAssist")
    createToggleButton("SILENT AIM", 480, toggleSilentAim, "silentAim")
    createToggleButton("MOBILE AIM", 530, toggleMobileAim, "mobileAimEnabled")
    createToggleButton("MOBILE AUTO AIM", 580, toggleMobileAutoAim, "mobileAutoAim")
    
    -- НОВЫЕ КНОПКИ
    createToggleButton("SPIN", 630, toggleSpin, "spin")
    createToggleButton("FULLBRIGHT", 680, toggleFullbright, "fullbright")
    createToggleButton("AUTOCLICKER", 730, toggleAutoclicker, "autoclicker")
    createToggleButton("BIG BOOBS", 780, toggleBigBoobs, "bigBoobs")

    -- ФАНОВАЯ КНОПКА ДЛЯ РОЗОВОЙ ПАЛКИ
    local pinkStickBtn = Instance.new("TextButton")
    pinkStickBtn.Text = "🎀 Pink Stick"
    pinkStickBtn.Size = UDim2.new(0.9, 0, 0, 40)
    pinkStickBtn.Position = UDim2.new(0.05, 0, 0, 830)
    pinkStickBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    pinkStickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    pinkStickBtn.Font = Enum.Font.Gotham
    pinkStickBtn.TextSize = 12
    pinkStickBtn.Active = true
    pinkStickBtn.Parent = contentFrame
    pinkStickBtn.MouseButton1Click:Connect(togglePinkStick)

    -- КНОПКА ДЛЯ СКИБИДИ ТУАЛЕТА (БЕЛЫЙ ЦВЕТ)
    local skibidiBtn = Instance.new("TextButton")
    skibidiBtn.Text = "🚽 Skibidi Toilet"
    skibidiBtn.Size = UDim2.new(0.9, 0, 0, 40)
    skibidiBtn.Position = UDim2.new(0.05, 0, 0, 880)
    skibidiBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    skibidiBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    skibidiBtn.Font = Enum.Font.GothamBold
    skibidiBtn.TextSize = 12
    skibidiBtn.Active = true
    skibidiBtn.Parent = contentFrame
    skibidiBtn.MouseButton1Click:Connect(toggleSkibidiToilet)

    -- Кнопки расширенных настроек
    local flySettingsBtn = Instance.new("TextButton")
    flySettingsBtn.Text = "⚙ Fly Settings"
    flySettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    flySettingsBtn.Position = UDim2.new(0.05, 0, 0, 930)
    flySettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
    flySettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flySettingsBtn.Font = Enum.Font.Gotham
    flySettingsBtn.TextSize = 12
    flySettingsBtn.Active = true
    flySettingsBtn.Parent = contentFrame
    flySettingsBtn.MouseButton1Click:Connect(toggleFlySettings)

    local speedSettingsBtn = Instance.new("TextButton")
    speedSettingsBtn.Text = "⚙ Speed Settings"
    speedSettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    speedSettingsBtn.Position = UDim2.new(0.05, 0, 0, 970)
    speedSettingsBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 60)
    speedSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedSettingsBtn.Font = Enum.Font.Gotham
    speedSettingsBtn.TextSize = 12
    speedSettingsBtn.Active = true
    speedSettingsBtn.Parent = contentFrame
    speedSettingsBtn.MouseButton1Click:Connect(toggleSpeedSettings)

    local espSettingsBtn = Instance.new("TextButton")
    espSettingsBtn.Text = "⚙ ESP Settings"
    espSettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    espSettingsBtn.Position = UDim2.new(0.05, 0, 0, 1010)
    espSettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
    espSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    espSettingsBtn.Font = Enum.Font.Gotham
    espSettingsBtn.TextSize = 12
    espSettingsBtn.Active = true
    espSettingsBtn.Parent = contentFrame
    espSettingsBtn.MouseButton1Click:Connect(toggleESPSettings)

    local aimSettingsBtn = Instance.new("TextButton")
    aimSettingsBtn.Text = "⚙ Aim Settings"
    aimSettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    aimSettingsBtn.Position = UDim2.new(0.05, 0, 0, 1050)
    aimSettingsBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 120)
    aimSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimSettingsBtn.Font = Enum.Font.Gotham
    aimSettingsBtn.TextSize = 12
    aimSettingsBtn.Active = true
    aimSettingsBtn.Parent = contentFrame
    aimSettingsBtn.MouseButton1Click:Connect(toggleAimSettings)

    local graphicsSettingsBtn = Instance.new("TextButton")
    graphicsSettingsBtn.Text = "⚙ Graphics Settings"
    graphicsSettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    graphicsSettingsBtn.Position = UDim2.new(0.05, 0, 0, 1090)
    graphicsSettingsBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 120)
    graphicsSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    graphicsSettingsBtn.Font = Enum.Font.Gotham
    graphicsSettingsBtn.TextSize = 12
    graphicsSettingsBtn.Active = true
    graphicsSettingsBtn.Parent = contentFrame
    graphicsSettingsBtn.MouseButton1Click:Connect(toggleGraphicsSettings)

    -- КНОПКА ДЛЯ РАСШИРЕННЫХ НАСТРОЕК BIG BOOBS (ОРАНЖЕВАЯ)
    local bigBoobsSettingsBtn = Instance.new("TextButton")
    bigBoobsSettingsBtn.Text = "⚙ Big Boobs Settings"
    bigBoobsSettingsBtn.Size = UDim2.new(0.9, 0, 0, 35)
    bigBoobsSettingsBtn.Position = UDim2.new(0.05, 0, 0, 1130)
    bigBoobsSettingsBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    bigBoobsSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    bigBoobsSettingsBtn.Font = Enum.Font.GothamBold
    bigBoobsSettingsBtn.TextSize = 12
    bigBoobsSettingsBtn.Active = true
    bigBoobsSettingsBtn.Parent = contentFrame
    bigBoobsSettingsBtn.MouseButton1Click:Connect(toggleBigBoobsSettings)

    -- Создание ESP настроек
    createESPSetting("Skeleton", 30, "espSkeleton")
    createESPSetting("Player Names", 65, "espNames")
    createESPSetting("Boxes", 100, "espBoxes")
    createESPSetting("Team Colors", 135, "espTeamColor")

    -- Создание Fly настроек с ползунками
    createSlider(flySettingsFrame, "Fly Speed", 30, 10, 200, 50, "flySpeed", function(value)
        settings.flySpeed = value
    end)

    -- Создание Speed настроек с ползунками
    createSlider(speedSettingsFrame, "Walk Speed", 30, 16, 200, 50, "walkSpeed", function(value)
        settings.walkSpeed = value
        if settings.speed and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end)

    createSlider(speedSettingsFrame, "Jump Power", 100, 50, 500, 100, "jumpPower", function(value)
        settings.jumpPower = value
        if settings.jump and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end)

    -- Создание Aim Assist настроек
    createAimSetting("Aim Through Walls", 30, "aimThroughWalls")
    createAimSetting("Ignore Teammates", 65, "aimIgnoreTeam")
    createAimSetting("Mobile Auto Aim", 100, "mobileAutoAim")
    createAimSetting("Silent Aim", 135, "silentAim")

    -- Создание выпадающего списка для хитбокса
    createDropdown(aimSettingsFrame, "Silent Aim Hitbox", 170, {"Head", "HumanoidRootPart", "Torso"}, "Head", "silentAimHitbox", function(value)
        settings.silentAimHitbox = value
    end)

    -- Создание ползунков Aim Assist (С ПРАВИЛЬНЫМИ ПОЗИЦИЯМИ)
    createSlider(aimSettingsFrame, "Aim FOV", 210, 10, 200, 50, "aimFov", function(value)
        settings.aimFov = value
    end)

    createSlider(aimSettingsFrame, "Silent Aim FOV", 260, 5, 100, 30, "silentAimFov", function(value)
        settings.silentAimFov = value
    end)

    createSlider(aimSettingsFrame, "Aim Smoothness", 310, 1, 20, 10, "aimSmoothness", function(value)
        settings.aimSmoothness = value
    end)

    -- Создание Graphics настроек
    createGraphicsSetting("Spin", 30, toggleSpin, "spin")
    createGraphicsSetting("Fullbright", 65, toggleFullbright, "fullbright")
    createGraphicsSetting("Autoclicker", 100, toggleAutoclicker, "autoclicker")

    -- Создание ползунка для скорости спина (С ЛИМИТОМ 1000)
    createSlider(graphicsSettingsFrame, "Spin Speed", 135, 1, 1000, 10, "spinSpeed", function(value)
        settings.spinSpeed = value
        -- Обновляем спин если он активен
        if settings.spin then
            toggleSpin(true)
        end
    end)

    -- Создание ползунка для скорости автокликера
    createSlider(graphicsSettingsFrame, "Autoclicker Speed", 170, 1, 20, 10, "autoclickerSpeed", function(value)
        settings.autoclickerSpeed = value
        if settings.autoclicker then
            toggleAutoclicker(true) -- Перезапускаем автокликер с новой скоростью
        end
    end)

    -- СОЗДАНИЕ НАСТРОЕК BIG BOOBS
    createSlider(bigBoobsSettingsFrame, "Boobs Size", 30, 1, 10, 5, "bigBoobsSize", function(value)
        settings.bigBoobsSize = value
        -- Обновляем грудь если она активна
        if settings.bigBoobs then
            toggleBigBoobs(true)
        end
    end)

    -- Настройка перетаскивания для всех элементов
    setupDragging(mainFrame)
    setupDragging(mobileIcon)
    setupDragging(mobileAimButton)
    setupDragging(mobileAutoAimButton)
    setupDragging(flySettingsFrame)
    setupDragging(speedSettingsFrame)
    setupDragging(espSettingsFrame)
    setupDragging(aimSettingsFrame)
    setupDragging(graphicsSettingsFrame)
    setupDragging(bigBoobsSettingsFrame)

    -- Hotkey: Right Shift для GUI
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            toggleGUI()
        end
    end)

    print("GUI created successfully!")
    return gui
end

-- Создаем GUI при запуске
createGUI()

-- Авто-восстановление настроек при респавне
player.CharacterAdded:Connect(function(character)
    wait(1)
    
    if settings.speed and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = settings.walkSpeed
    end
    if settings.jump and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = settings.jumpPower
    end
    
    if settings.fly then
        toggleFly(true)
    end
    if settings.esp then
        toggleESP(true)
    end
    if settings.aimAssist then
        toggleAimAssist(true)
    end
    if settings.silentAim then
        toggleSilentAim(true)
    end
    if settings.spin then
        toggleSpin(true)
    end
    if settings.fullbright then
        toggleFullbright(true)
    end
    if settings.autoclicker then
        toggleAutoclicker(true)
    end
    if settings.bigBoobs then
        toggleBigBoobs(true)
    end
end)

print("🎮 Universal Enhancer Loaded!")
print("📱 Click the blue icon to open GUI")
print("🖥️ Right Shift to toggle GUI")
print("📱 Mobile Aim buttons appear only when enabled in GUI")
print("⚙ Use gear buttons for advanced settings")
print("🎀 New Pink Stick with side balls!")
print("🎯 AIM ASSIST: Press Q or use mobile buttons to aim")
print("🤖 AUTO AIM: Mobile button for auto-aim and auto-shoot")
print("🔫 SILENT AIM: Auto-targeting closest enemy")
print("✅ IGNORE TEAMMATES: Aim assist won't target allies")
print("✅ TRACERS REMOVED: Clean ESP without tracers")
print("🛡️ GUI PROTECTED: Will not disappear after death")
print("📐 GUI SCALING: Use - button to resize GUI")
print("👆 DRAGGABLE: All UI elements can be moved")
print("🎯 AIM SETTINGS: Now properly working with all options!")
print("⚡ FLY/SPEED SETTINGS: Added sliders for better control!")
print("🎯 AIM SETTINGS WINDOW: Now positioned closer to main GUI!")
print("🚽 SKIBIDI TOILET: New fun feature added!")
print("🌀 SPIN: Player spinning with BodyAngularVelocity like in Infinite Yield!")
print("💡 FULLBRIGHT: Maximum brightness enabled!")
print("🖱️ AUTOCLICKER: Fixed automatic clicking with adjustable speed!")
print("🍊 BIG BOOBS: New orange breast feature with adjustable size and bounce animation!")
print("⚙ BIG BOOBS SETTINGS: Added dedicated settings window with size slider!")
print("🔧 BIG BOOBS UPDATED: Breasts are now closer together and moved forward for more natural look!")

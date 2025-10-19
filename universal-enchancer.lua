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

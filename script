local function createPlayerESP(player)
    local Players = game:GetService('Players')
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild('Head')

    local Billboard = Instance.new('BillboardGui')
    Billboard.Size = UDim2.new(0, 100, 0, 40)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Name = 'ESP'

    local NameLabel = Instance.new('TextLabel')
    NameLabel.Text = player.Name -- or 'Testing'
    NameLabel.Size = UDim2.new(1, 0, 1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextColor3 = Color3.new(1, 0, 0)
    NameLabel.Parent = Billboard

    Billboard.Parent = head
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        player.CharacterAdded:Connect(function()
            createPlayerESP(player)
        end)

        -- If character already exists
        if player.Character then
            createPlayerESP(player)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then
        player.CharacterAdded:Connect(function()
            createPlayerESP(player)
        end)
    end
end)

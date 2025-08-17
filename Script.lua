local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local camera = workspace.CurrentCamera

local espSquares = {} -- Store ESP squares for each player

-- Function to create ESP for one player
local function createPlayerESP(player)
    local function setupESP()
        local character = player.Character
        if not character then
            return
        end

        local humanoidRootPart = character:WaitForChild('HumanoidRootPart', 5)
        if not humanoidRootPart then
            return
        end

        -- Create the drawing square
        local square = Drawing.new('Square')
        square.Filled = false
        square.Color = Color3.fromRGB(255, 0, 0)
        square.Thickness = 2
        square.Transparency = 1
        square.Visible = false

        espSquares[player] = square

        -- Update the square every frame
        RunService.RenderStepped:Connect(function()
            if character and humanoidRootPart and humanoidRootPart.Parent then
                local position, onScreen =
                    camera:WorldToViewportPoint(humanoidRootPart.Position)

                if onScreen then
                    -- Optional: size based on distance
                    local size = math.clamp(50 / (position.Z / 10), 5, 100)

                    square.Position = Vector2.new(
                        position.X - size / 2,
                        position.Y - size / 2
                    )
                    square.Size = Vector2.new(size, size)
                    square.Visible = true
                else
                    square.Visible = false
                end
            else
                square.Visible = false
            end
        end)
    end

    -- Setup now or when character respawns
    if player.Character then
        setupESP()
    end

    player.CharacterAdded:Connect(setupESP)

end

-- Remove ESP for a player
local function removePlayerESP(player)
    local square = espSquares[player]
    if square then
        square:Remove()
        espSquares[player] = nil
    end
end

createPlayerESP()

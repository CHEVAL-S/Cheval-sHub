local _0x1 = game:GetService("Players")
local _0x2 = game:GetService("CoreGui")
local _0x3 = game:GetService("TweenService")
local _0x4 = game:GetService("UserInputService")
local _0x5 = game:GetService("RunService")
local _0x6 = game:GetService("Workspace")
local _0x7 = _0x1.LocalPlayer
local _0x8 = _0x6.CurrentCamera
local _0x9 = _0x7:GetMouse()
local _0xA = nil
pcall(function() _0xA = _0x2 end)
if not _0xA then _0xA = _0x7:WaitForChild("PlayerGui") end
if _0xA:FindFirstChild("ChevalsHub") then _0xA.ChevalsHub:Destroy() end
local _0xB = Instance.new("ScreenGui")
_0xB.Name = "ChevalsHub"; _0xB.Parent = _0xA
local _0xC, _0xD, _0xE, _0xF, _0x10 = false, false, false, false, false
local _0x11, _0x12, _0x13, _0x14 = 20, 300, 50, false
local _0x15 = {InfJump = Enum.KeyCode.J, NoClip = Enum.KeyCode.N, Fly = Enum.KeyCode.F}
local _0x16, _0x17 = nil, nil
local _0x18 = Instance.new("Frame", _0xB)
_0x18.Size = UDim2.new(0, 290, 0, 320); _0x18.Position = UDim2.new(0.8, 0, 1.5, 0); _0x18.BackgroundColor3 = Color3.fromRGB(15, 15, 15); _0x18.BorderSizePixel = 0
local _0x19 = Instance.new("UICorner", _0x18); _0x19.CornerRadius = UDim.new(0, 10)
local _0x1A = Instance.new("UIStroke", _0x18); _0x1A.Color = Color3.fromRGB(0, 255, 127); _0x1A.Thickness = 2
local _0x1B = Instance.new("TextLabel", _0x18)
_0x1B.Size = UDim2.new(1, 0, 0, 40); _0x1B.BackgroundTransparency = 1; _0x1B.Text = "CHEVAL'S HUB (in dev)"; _0x1B.TextColor3 = Color3.fromRGB(0, 255, 127); _0x1B.TextSize = 16; _0x1B.Font = Enum.Font.GothamBold
local _0x1C = Instance.new("Frame", _0x18)
_0x1C.Size = UDim2.new(1, -20, 0, 30); _0x1C.Position = UDim2.new(0, 10, 0, 40); _0x1C.BackgroundTransparency = 1
local _0x1D = Instance.new("Frame", _0x18)
_0x1D.Size = UDim2.new(1, 0, 0, 230); _0x1D.Position = UDim2.new(0, 0, 0, 80); _0x1D.BackgroundTransparency = 1
local _0x1E = Instance.new("Frame", _0x18)
_0x1E.Size = UDim2.new(1, 0, 0, 230); _0x1E.Position = UDim2.new(0, 0, 0, 80); _0x1E.BackgroundTransparency = 1; _0x1E.Visible = false
local _0x1F = Instance.new("UIListLayout", _0x1E)
_0x1F.SortOrder = Enum.SortOrder.LayoutOrder; _0x1F.Padding = UDim.new(0, 10); _0x1F.HorizontalAlignment = Enum.HorizontalAlignment.Center
local _0x20 = Instance.new("TextButton", _0x1C)
_0x20.Size = UDim2.new(0.5, -5, 1, 0); _0x20.BackgroundColor3 = Color3.fromRGB(0, 255, 127); _0x20.Text = "Mouvements"; _0x20.TextColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", _0x20).CornerRadius = UDim.new(0, 6)
local _0x21 = Instance.new("TextButton", _0x1C)
_0x21.Size = UDim2.new(0.5, -5, 1, 0); _0x21.Position = UDim2.new(0.5, 5, 0, 0); _0x21.BackgroundColor3 = Color3.fromRGB(30, 30, 30); _0x21.Text = "Visuels / Aim"; _0x21.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", _0x21).CornerRadius = UDim.new(0, 6)
_0x20.MouseButton1Click:Connect(function() _0x1D.Visible = true; _0x1E.Visible = false; _0x20.BackgroundColor3 = Color3.fromRGB(0, 255, 127); _0x20.TextColor3 = Color3.fromRGB(0, 0, 0); _0x21.BackgroundColor3 = Color3.fromRGB(30, 30, 30); _0x21.TextColor3 = Color3.fromRGB(255, 255, 255) end)
_0x21.MouseButton1Click:Connect(function() _0x1D.Visible = false; _0x1E.Visible = true; _0x21.BackgroundColor3 = Color3.fromRGB(0, 255, 127); _0x21.TextColor3 = Color3.fromRGB(0, 0, 0); _0x20.BackgroundColor3 = Color3.fromRGB(30, 30, 30); _0x20.TextColor3 = Color3.fromRGB(255, 255, 255) end)
_0x4.JumpRequest:Connect(function() if _0xC then local _0x22 = _0x7.Character and _0x7.Character:FindFirstChildOfClass("Humanoid"); if _0x22 then _0x22:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
_0x5.Stepped:Connect(function() local _0x23 = _0x7.Character; if not _0x23 then return end; local _0x24 = _0x23:FindFirstChild("HumanoidRootPart"); local _0x25 = _0x23:FindFirstChildOfClass("Humanoid"); if not _0x24 or not _0x25 then return end; if _0xD and not _0xE then for _, _0x26 in pairs(_0x23:GetChildren()) do if _0x26:IsA("BasePart") then _0x26.CanCollide = false end end end; if _0xE then _0x25.PlatformStand = true; if not _0x17 or _0x17.Parent ~= _0x24 then _0x17 = Instance.new("BodyVelocity", _0x24); _0x17.MaxForce = Vector3.new(100000, 100000, 100000) end; local _0x27 = Vector3.new(0, 0, 0); if _0x4:IsKeyDown(Enum.KeyCode.W) or _0x4:IsKeyDown(Enum.KeyCode.Z) then _0x27 += _0x8.CFrame.LookVector end; if _0x4:IsKeyDown(Enum.KeyCode.S) then _0x27 -= _0x8.CFrame.LookVector end; if _0x4:IsKeyDown(Enum.KeyCode.A) or _0x4:IsKeyDown(Enum.KeyCode.Q) then _0x27 -= _0x8.CFrame.RightVector end; if _0x4:IsKeyDown(Enum.KeyCode.D) then _0x27 += _0x8.CFrame.RightVector end; if _0x4:IsKeyDown(Enum.KeyCode.Space) then _0x27 += Vector3.new(0, 1, 0) end; if _0x4:IsKeyDown(Enum.KeyCode.LeftShift) then _0x27 -= Vector3.new(0, 1, 0) end; _0x17.Velocity = _0x27.Unit * _0x13 else if _0x17 then _0x17:Destroy(); _0x17 = nil end; _0x25.PlatformStand = false end end)
local _0x28 = {}
local function _0x29(_0x2A, _0x2B, _0x2C, _0x2D, _0x2E) local _0x2F = Instance.new("Frame", _0x2D); _0x2F.Size = UDim2.new(1, -20, 0, 35); _0x2F.BackgroundTransparency = 1; local _0x30 = Instance.new("TextButton", _0x2F); _0x30.Size = UDim2.new(0.7, -5, 1, 0); _0x30.BackgroundColor3 = Color3.fromRGB(30, 30, 30); _0x30.Text = _0x2A .. " : OFF"; _0x30.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", _0x30).CornerRadius = UDim.new(0, 6); local _0x31 = Instance.new("TextButton", _0x2F); _0x31.Size = UDim2.new(0.3, 0, 1, 0); _0x31.Position = UDim2.new(0.7, 5, 0, 0); _0x31.BackgroundColor3 = Color3.fromRGB(40, 40, 40); _0x31.Text = "[" .. _0x15[_0x2B].Name .. "]"; _0x31.TextColor3 = Color3.fromRGB(0, 255, 127); Instance.new("UICorner", _0x31).CornerRadius = UDim.new(0, 6); _0x30.MouseButton1Click:Connect(function() _0x2E(_0x30) end); _0x31.MouseButton1Click:Connect(function() _0x16 = _0x2B; _0x31.Text = "[...]" end); _0x28[_0x2B] = {Main = _0x30, Bind = _0x31, Action = _0x2E} end
_0x4.InputBegan:Connect(function(_0x32, _0x33) if _0x33 then return end; if _0x16 then _0x15[_0x16] = _0x32.KeyCode; _0x28[_0x16].Bind.Text = "[" .. _0x32.KeyCode.Name .. "]"; _0x16 = nil; return end; if _0x32.KeyCode == Enum.KeyCode.RightControl then local _0x34 = _0x18.Position.Y.Scale > 1 and UDim2.new(0.8, 0, 0.35, 0) or UDim2.new(0.8, 0, 1.5, 0); _0x3:Create(_0x18, TweenInfo.new(0.4), {Position = _0x34}):Play() end end)
_0x29("Infinite Jump", "InfJump", 5, _0x1D, function(b) _0xC = not _0xC; b.Text = "Infinite Jump : " .. (_0xC and "ON" or "OFF") end)
_0x29("NoClip", "NoClip", 45, _0x1D, function(b) _0xD = not _0xD; b.Text = "NoClip : " .. (_0xD and "ON" or "OFF") end)
_0x29("Fly Mode", "Fly", 85, _0x1D, function(b) _0xE = not _0xE; b.Text = "Fly Mode : " .. (_0xE and "ON" or "OFF") end)
local function _0x35(_0x2A, _0x2E) local _0x36 = Instance.new("TextButton", _0x1E); _0x36.Size = UDim2.new(1, -20, 0, 38); _0x36.BackgroundColor3 = Color3.fromRGB(30, 30, 30); _0x36.Text = _0x2A .. " : OFF"; _0x36.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", _0x36).CornerRadius = UDim.new(0, 6); _0x36.MouseButton1Click:Connect(function() _0x2E(_0x36) end) end
local function _0x37(_0x38) local _0x39 = _0x8.CFrame.Position; local _0x3A = (_0x38.Position - _0x39).Unit * (_0x38.Position - _0x39).Magnitude; local _0x3B = RaycastParams.new(); _0x3B.FilterDescendantsInstances = {_0x7.Character}; _0x3B.FilterType = Enum.RaycastFilterType.Exclude; local _0x3C = _0x6:Raycast(_0x39, _0x3A, _0x3B); return _0x3C and (_0x3C.Instance:IsDescendantOf(_0x38.Parent) or _0x3C.Instance == _0x38) end
_0x5.RenderStepped:Connect(function() for _, _0x3D in pairs(_0x1:GetPlayers()) do if _0x3D ~= _0x7 and _0x3D.Character then local _0x3E = _0x3D.Character:FindFirstChild("ESPHighlight"); if _0xF then if not _0x3E then _0x3E = Instance.new("Highlight", _0x3D.Character); _0x3E.Name = "ESPHighlight"; _0x3E.FillColor = Color3.fromRGB(255, 0, 100); _0x3E.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end elseif _0x3E then _0x3E:Destroy() end end end; if _0x10 and _0x4:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then local _0x3F = nil; local _0x40 = math.huge; local _0x41 = Vector2.new(_0x8.ViewportSize.X / 2, _0x8.ViewportSize.Y / 2); for _, _0x3D in pairs(_0x1:GetPlayers()) do if _0x3D ~= _0x7 and _0x3D.Character and _0x3D.Character:FindFirstChild("Head") and _0x3D.Character:FindFirstChildOfClass("Humanoid") and _0x3D.Character.Humanoid.Health > 0 then local _0x42, _0x43 = _0x8:WorldToViewportPoint(_0x3D.Character.Head.Position); if _0x43 and _0x37(_0x3D.Character.Head) then local _0x44 = (Vector2.new(_0x42.X, _0x42.Y) - _0x41).Magnitude; if _0x44 < _0x40 then _0x40 = _0x44; _0x3F = _0x3D.Character.Head end end end end; if _0x3F then _0x8.CFrame = CFrame.new(_0x8.CFrame.Position, _0x3F.Position) end end end)
_0x35("Activer Wallhack ESP", function(b) _0xF = not _0xF; b.Text = "Activer Wallhack ESP : " .. (_0xF and "ON" or "OFF") end)
_0x35("Activer Hard Lock Aimbot", function(b) _0x10 = not _0x10; b.Text = "Activer Hard Lock Aimbot : " .. (_0x10 and "ON" or "OFF") end)
_0x3:Create(_0x18, TweenInfo.new(0.4), {Position = UDim2.new(0.8, 0, 0.35, 0)}):Play()

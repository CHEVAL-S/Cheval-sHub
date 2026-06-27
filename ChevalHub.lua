local Directory = "https://raw.githubusercontent.com/TON_PSEUDO/ChevalHub/main/Games"
local Api = "https://api.luarmor.net/files/v4/loaders"
local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
    },
    Premium = {
        [994732206] = Api .. "/0ae9fe4cf963e3a13d25eed0e2ce5940.lua",
        [10004244222] = Api .. "/63980a492928552d074ceee243a918d6.lua",
        [9792947201] = Api .. "/50e8e00251d97215e14313c0bb012058.lua",
        [10200395747] = Api .. "/65265b2869c03f57430ee45357d8c3f9.lua"
    }
}
local SCRIPT_ID = "0ae9fe4cf963e3a13d25eed0e2ce5940"
local FOLDER = "Cheval Hub"
local KEY_FILE = FOLDER .. "/Key.json"
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local gameId = game.GameId

local function Tween(obj, props, t, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(t, style, dir), props):Play()
end

local function Protect(gui)
    local env = (getgenv and getgenv()) or _G
    if env.HIDEUI then
        gui.Parent = env.HIDEUI
    elseif gethui then
        gui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = game:GetService("CoreGui")
    else
        gui.Parent = game:GetService("CoreGui")
    end
end

local function New(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Children" and k ~= "Parent" then
            pcall(function() inst[k] = v end)
        end
    end
    if props.Children then
        for _, c in ipairs(props.Children) do
            pcall(function() c.Parent = inst end)
        end
    end
    inst.Parent = props.Parent or parent
    return inst
end

local function CircleRipple(btn, mx, my)
    task.spawn(function()
        btn.ClipsDescendants = true
        local nx = mx - btn.AbsolutePosition.X
        local ny = my - btn.AbsolutePosition.Y
        local sz = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.6
        local c = New("ImageLabel", {
            Name = "Ripple",
            Image = "rbxassetid://266543268",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 0.82,
            BackgroundTransparency = 1,
            ZIndex = btn.ZIndex + 5,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, nx, 0, ny),
        }, btn)
        Tween(c, { Size = UDim2.new(0, sz, 0, sz), Position = UDim2.new(0.5, -sz/2, 0.5, -sz/2) }, 0.45, Enum.EasingStyle.Quad)
        Tween(c, { ImageTransparency = 1 }, 0.45, Enum.EasingStyle.Linear)
        task.wait(0.46)
        c:Destroy()
    end)
end

local function SaveKey(key)
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({ key = key }))
end

local function LoadSavedKey()
    if isfolder(FOLDER) and isfile(KEY_FILE) then
        local ok, v = pcall(function()
            return HttpService:JSONDecode(readfile(KEY_FILE))
        end)
        if ok and type(v) == "table" and v.key then return v.key end
    end
    return ""
end

local function ClearKey()
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({}))
end

local function LoadScript(tier, key)
    local tbl = Scripts[tier]
    if not tbl then return end
    local url = tbl[gameId]
    if not url then
        warn("[Cheval Hub] No " .. tier .. " script for GameId: " .. tostring(gameId))
        return
    end
    if tier == "Premium" and key then
        getgenv().script_key = key
    end
    local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
    if not ok then warn("[Cheval Hub] Error: " .. tostring(err)) end
end

local function ShowKeyUI()
    local done = false
    local isPremium = false
    local resultKey = ""
    local submitting = false
    local supportInfo = {
        { label = "Discord", value = "discord.gg/chevalhub" },
        { label = "Game", value = (pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end) and game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name) or "Unknown" },
        { label = "Version", value = "v1.0" },
    }
    local UpdateLog = {
        { version = "v1.0", date = "2026", notes = "Sortie officielle de ChevalHub !" },
    }
    local SG = Instance.new("ScreenGui")
    SG.Name = "CH_" .. tostring(math.random(1e6))
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Global
    SG.ResetOnSpawn = false
    SG.IgnoreGuiInset = true
    Protect(SG)
    
    local Backdrop = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 200,
        Parent = SG,
    })
    
    local W, H = 450, 310
    local Card = New("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, W * 0.5, 0, H * 0.5),
        BackgroundColor3 = Color3.fromRGB(5, 5, 8),
        BackgroundTransparency = 0.80,
        BorderSizePixel = 0,
        ZIndex = 201,
        ClipsDescendants = true,
        Parent = SG,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 14) }),
            New("UIStroke", {
                Color = Color3.fromRGB(0, 140, 255), -- Contour Bleu Électrique
                Transparency = 0.38,
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
        }
    })
    
    -- Effets de lumière de fond bleus
    New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 70, 180),
        BackgroundTransparency = 0.88,
        BorderSizePixel = 0,
        Position = UDim2.new(0, -60, 0, -60),
        Size = UDim2.new(0, 220, 0, 220),
        ZIndex = 201,
        Parent = Card,
        Children = { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }
    })
    New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 40, 120),
        BackgroundTransparency = 0.90,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -100, 1, -100),
        Size = UDim2.new(0, 180, 0, 180),
        ZIndex = 201,
        Parent = Card,
        Children = { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }
    })
    
    local Header = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(8, 8, 12),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 44),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 14) }),
            New("Frame", {
                BackgroundColor3 = Color3.fromRGB(8, 8, 12),
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(1, 0, 0.5, 0),
                ZIndex = 202
            }),
        }
    })
    
    New("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 13, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Image = "rbxassetid://7733992528",
        ImageColor3 = Color3.fromRGB(0, 160, 255),
        ZIndex = 203,
        Parent = Header
    })
    
    New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(1, -130, 1, 0),
        Font = Enum.Font.FredokaOne,
        Text = "Cheval Hub — Key System",
        TextColor3 = Color3.fromRGB(200, 230, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 203,
        Parent = Header
    })
    
    New("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(20, 50, 30),
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -40, 0.5, 0),
        Size = UDim2.new(0, 72, 0, 20),
        ZIndex = 203,
        Parent = Header,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 5) }),
            New("UIStroke", { Color = Color3.fromRGB(80, 200, 110), Transparency = 0.45, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
            New("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = "Freemium",
                TextColor3 = Color3.fromRGB(130, 235, 160),
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 204
            }),
        }
    })
    
    local CloseBtn = New("ImageButton", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        Image = "rbxassetid://79324227570635",
        ImageColor3 = Color3.fromRGB(200, 80, 80),
        ZIndex = 203,
        Parent = Header
    })
    
    New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 140, 255),
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 44),
        Size = UDim2.new(1, 0, 0, 1),
        ZIndex = 202,
        Parent = Card,
        Children = { New("UIGradient", {
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.1, 0),
                NumberSequenceKeypoint.new(0.9, 0),
                NumberSequenceKeypoint.new(1, 1)
            })
        }) }
    })
    
    local LW = 180
    local RX = LW + 18
    local RW = W - RX - 10
    
    New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 120, 255),
        BackgroundTransparency = 0.65,
        BorderSizePixel = 0,
        Position = UDim2.new(0, LW + 8, 0, 52),
        Size = UDim2.new(0, 1, 0, H - 60),
        ZIndex = 202,
        Parent = Card,
        Children = { New("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.08, 0),
                NumberSequenceKeypoint.new(0.92, 0),
                NumberSequenceKeypoint.new(1, 1)
            })
        }) }
    })
    
    local InfoBox = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(6, 6, 10),
        BackgroundTransparency = 0.20,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 8, 0, 52),
        Size = UDim2.new(0, LW, 0, 112),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 8) }),
            New("UIStroke", { Color = Color3.fromRGB(0, 120, 255), Transparency = 0.58, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
        }
    })
    
    New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 9, 0, 5),
        Size = UDim2.new(1, -14, 0, 13),
        Font = Enum.Font.GothamBold,
        Text = "Information",
        TextColor3 = Color3.fromRGB(50, 160, 255),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 203,
        Parent = InfoBox
    })
    
    local rowY = 26
    for _, info in ipairs(supportInfo) do
        New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 9, 0, rowY),
            Size = UDim2.new(0, 55, 0, 12),
            Font = Enum.Font.GothamBold,
            Text = (info.label or "") .. ":",
            TextColor3 = Color3.fromRGB(100, 140, 180),
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 203,
            Parent = InfoBox
        })
        New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 64, 0, rowY),
            Size = UDim2.new(1, -70, 0, 12),
            Font = Enum.Font.Gotham,
            Text = tostring(info.value or ""),
            TextColor3 = Color3.fromRGB(180, 210, 245),
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 203,
            Parent = InfoBox
        })
        rowY = rowY + 16
        if rowY > 96 then break end
    end
    
    local LogBox = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(6, 6, 10),
        BackgroundTransparency = 0.20,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 8, 0, 170),
        Size = UDim2.new(0, LW, 0, 128),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 8) }),
            New("UIStroke", { Color = Color3.fromRGB(0, 120, 255), Transparency = 0.58, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
        }
    })
    
    New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 9, 0, 5),
        Size = UDim2.new(1, -14, 0, 13),
        Font = Enum.Font.GothamBold,
        Text = "Update Log",
        TextColor3 = Color3.fromRGB(50, 160, 255),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 203,
        Parent = LogBox
    })
    
    local logY = 26
    for _, entry in ipairs(UpdateLog) do
        New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 9, 0, logY),
            Size = UDim2.new(1, -14, 0, 12),
            Font = Enum.Font.GothamBold,
            RichText = true,
            Text = string.format('<font color="#00a0ff">%s</font>  <font color="#446688">%s</font>', entry.version or "", entry.date or ""),
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 203,
            Parent = LogBox
        })
        logY = logY + 13
        New("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 13, 0, logY),
            Size = UDim2.new(1, -18, 0, 11),
            Font = Enum.Font.Gotham,
            Text = "• " .. (entry.notes or ""),
            TextColor3 = Color3.fromRGB(140, 170, 200),
            TextSize = 8,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 203,
            Parent = LogBox
        })
        logY = logY + 14
        if logY > 110 then break end
    end
    
    local NoticeBg = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(6, 6, 10),
        BackgroundTransparency = 0.22,
        BorderSizePixel = 0,
        Position = UDim2.new(0, RX, 0, 52),
        Size = UDim2.new(0, RW, 0, 50),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 7) }),
            New("UIStroke", { Color = Color3.fromRGB(80, 200, 110), Transparency = 0.52, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
            New("Frame", {
                BackgroundColor3 = Color3.fromRGB(80, 200, 110),
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0.5, -10),
                Size = UDim2.new(0, 3, 0, 20),
                ZIndex = 203,
                Children = { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }
            })
        }
    })
    
    New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -16, 1, 0),
        Font = Enum.Font.Gotham,
        TextColor3 = Color3.fromRGB(140, 230, 170),
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 203,
        Text = "ChevalHub — key is optional.\nEnter a key to unlock premium features.",
        Parent = NoticeBg
    })
    
    local LRMBar = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(6, 6, 10),
        BackgroundTransparency = 0.22,
        BorderSizePixel = 0,
        Position = UDim2.new(0, RX, 0, 110),
        Size = UDim2.new(0, RW, 0, 28),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 6) }),
            New("UIStroke", { Color = Color3.fromRGB(0, 120, 255), Transparency = 0.60, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
        }
    })
    
    New("ImageLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0.5, -6),
        Size = UDim2.new(0, 12, 0, 12),
        Image = "rbxassetid://7733992528",
        ImageColor3 = Color3.fromRGB(0, 140, 255),
        ZIndex = 203,
        Parent = LRMBar
    })
    
    local LRMStatusLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 25, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "Checking Luarmor...",
        TextColor3 = Color3.fromRGB(140, 180, 220),
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 203,
        Parent = LRMBar
    })
    
    local InputBg = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(2, 2, 5),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = UDim2.new(0, RX, 0, 146),
        Size = UDim2.new(0, RW, 0, 34),
        ZIndex = 202,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 7) }),
            New("UIStroke", { Color = Color3.fromRGB(0, 120, 255), Transparency = 0.48, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
        }
    })
    
    local KeyInput = New("TextBox", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(1, -39, 1, 0),
        Font = Enum.Font.GothamBold,
        PlaceholderText = "Enter premium key...",
        PlaceholderColor3 = Color3.fromRGB(60, 90, 130),
        Text = "",
        TextColor3 = Color3.fromRGB(180, 220, 255),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ZIndex = 203,
        Parent = InputBg
    })
    
    local StatusLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, RX, 0, 185),
        Size = UDim2.new(0, RW, 0, 13),
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = Color3.fromRGB(140, 170, 200),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 202,
        Parent = Card
    })
    
    local function SetStatus(msg, col)
        StatusLabel.Text = msg
        StatusLabel.TextColor3 = col or Color3.fromRGB(140, 170, 200)
    end
    
    local function AnimateClose()
        Tween(Card, { Size = UDim2.new(0, W * 0.65, 0, H * 0.65), BackgroundTransparency = 0.75 }, 0.20, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(Backdrop, { BackgroundTransparency = 1 }, 0.20, Enum.EasingStyle.Quint)
        task.delay(0.22, function()
            SG:Destroy()
            done = true
        end)
    end
    
    local function SubmitKey(keyStr)
        if submitting then return end
        if not keyStr or keyStr == "" then
            SetStatus("Please enter a key first.", Color3.fromRGB(255, 175, 80))
            return
        end
        submitting = true
        SetStatus("Submitting key...", Color3.fromRGB(150, 200, 255))
        task.spawn(function()
            local sdk, LuarmorAPI = pcall(function()
                return loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
            end)
            if not sdk or type(LuarmorAPI) ~= "table" then
                submitting = false
                SetStatus("Failed to reach Luarmor SDK.", Color3.fromRGB(255, 90, 110))
                return
            end
            LuarmorAPI.script_id = SCRIPT_ID
            local check, status = pcall(function()
                return LuarmorAPI.check_key(keyStr)
            end)
            submitting = false
            if not check or type(status) ~= "table" then
                SetStatus("Verification error — try again.", Color3.fromRGB(255, 90, 110))
                return
            end
            local code = status.code or ""
            if code == "KEY_VALID" then
                isPremium = true
                resultKey = keyStr
                SaveKey(keyStr)
                getgenv().script_key = keyStr
                LRMStatusLabel.Text = "Premium Active"
                LRMStatusLabel.TextColor3 = Color3.fromRGB(80, 230, 130)
                SetStatus("Key verified", Color3.fromRGB(80, 230, 130))
                task.wait(0.5)
                AnimateClose()
            else
                ClearKey()
                SetStatus(tostring(status.message or ("Error: " .. code)), Color3.fromRGB(255, 90, 110))
            end
        end)
    end
    
    local BtnY = 202
    local BtnH = 30
    local BtnGap = 6
    local BtnW = math.floor((RW - BtnGap * 2) / 3)
    
    local function MakeBtn(label, px, w, bg, tc, cb)
        local btn = New("TextButton", {
            BackgroundColor3 = bg,
            BackgroundTransparency = 0.28,
            BorderSizePixel = 0,
            Position = UDim2.new(0, px, 0, BtnY),
            Size = UDim2.new(0, w, 0, BtnH),
            AutoButtonColor = false,
            Text = "",
            ClipsDescendants = true,
            ZIndex = 202,
            Parent = Card,
            Children = {
                New("UICorner", { CornerRadius = UDim.new(0, 7) }),
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = Enum.Font.FredokaOne,
                    Text = label,
                    TextColor3 = tc,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 203
                })
            }
        })
        btn.MouseEnter:Connect(function() Tween(btn, { BackgroundTransparency = 0.08 }, 0.12) end)
        btn.MouseLeave:Connect(function() Tween(btn, { BackgroundTransparency = 0.28 }, 0.16) end)
        btn.MouseButton1Click:Connect(function()
            CircleRipple(btn, Mouse.X, Mouse.Y)
            cb()
        end)
        return btn
    end
    
    MakeBtn("Version Libre", RX, BtnW, Color3.fromRGB(15, 35, 60), Color3.fromRGB(130, 190, 255), function()
        if not Scripts.Free[gameId] then
            SetStatus("Pas de version libre pour ce jeu.", Color3.fromRGB(255, 150, 80))
        else
            isPremium = false
            AnimateClose()
        end
    end)
    
    local panelOpen = false
    local OptionPanel = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(4, 4, 8),
        BorderSizePixel = 0,
        Position = UDim2.new(0, RX + BtnW + BtnGap, 0, BtnY - 78),
        Size = UDim2.new(0, BtnW, 0, 72),
        ZIndex = 215,
        Visible = false,
        Parent = Card,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 7) }),
            New("UIStroke", { Color = Color3.fromRGB(0, 120, 255), Transparency = 0.48, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
        }
    })
    
    local function MakeOptionBtn(label, yPos, link, statusMsg)
        local btn = New("TextButton", {
            BackgroundColor3 = Color3.fromRGB(10, 30, 60),
            BackgroundTransparency = 0.30,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 4, 0, yPos),
            Size = UDim2.new(1, -8, 0, 30),
            Text = label,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(160, 210, 255),
            TextSize = 11,
            ZIndex = 216,
            Parent = OptionPanel,
            Children = { New("UICorner", { CornerRadius = UDim.new(0, 5) }) }
        })
        btn.MouseButton1Click:Connect(function()
            pcall(function() (setclipboard or toclipboard)(link) end)
            SetStatus(statusMsg, Color3.fromRGB(105, 195, 255))
            panelOpen = false
            OptionPanel.Visible = false
        end)
    end
    
    MakeOptionBtn("Lootlabs", 4, "https://ads.luarmor.net/get_key?for=Quantum_Onyx_Key_Sytem-FpNBDhxVzYzS", "Lien Lootlabs Copié")
    MakeOptionBtn("Linkvertise", 38, "https://ads.luarmor.net/get_key?for=Quantum_Onyx_Key_Sytem-TcgtEiNunUTO", "Lien Linkvertise Copié")
    
    local getKeyBtn = MakeBtn("Clé", RX + BtnW + BtnGap, BtnW, Color3.fromRGB(10, 40, 70), Color3.fromRGB(120, 200, 255), function()
        panelOpen = not panelOpen
        OptionPanel.Visible = panelOpen
    end)
    
    MakeBtn("Valider", RX + (BtnW + BtnGap) * 2, BtnW, Color3.fromRGB(0, 60, 120), Color3.fromRGB(200, 235, 255), function()
        SubmitKey(KeyInput.Text)
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        isPremium = false
        AnimateClose()
    end)
    
    Tween(Backdrop, { BackgroundTransparency = 0.50 }, 0.28, Enum.EasingStyle.Quint)
    Tween(Card, { Size = UDim2.new(0, W, 0, H), BackgroundTransparency = 0 }, 0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local SavedKey = LoadSavedKey()
    if SavedKey ~= "" then
        KeyInput.Text = SavedKey
        task.delay(1.0, function() if not done then SubmitKey(SavedKey) end end)
    end
    
    repeat task.wait(0.08) until done
    return isPremium, resultKey
end

local function AuthenticateAndLoad()
    local SavedKey = LoadSavedKey()
    if SavedKey and SavedKey ~= "" then
        local sdk, LuarmorAPI = pcall(function()
            return loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
        end)
        if sdk and type(LuarmorAPI) == "table" then
            LuarmorAPI.script_id = SCRIPT_ID
            local check, status = pcall(function() return LuarmorAPI.check_key(SavedKey) end)
            if check and type(status) == "table" and status.code == "KEY_VALID" then
                getgenv().script_key = SavedKey
                LoadScript("Premium", SavedKey)
                return
            else
                ClearKey()
            end
        end
    end
    task.spawn(function()
        local premium, key = ShowKeyUI()
        if premium then LoadScript("Premium", key) else LoadScript("Free", nil) end
    end)
end

AuthenticateAndLoad()

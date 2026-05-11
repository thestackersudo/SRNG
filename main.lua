-- https://discord.gg/hJCn7UnkVZ

repeat task.wait() until game:IsLoaded()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local localPlayer = players.LocalPlayer
local client = workspace:FindFirstChild(localPlayer.Name)
local clientHRP = client.HumanoidRootPart

localPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local Window = Fluent:CreateWindow({
    Title = "Plink Slime RNG v1.0.3",
    SubTitle = "by who?",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
	Upgrades = Window:AddTab({ Title = "Upgrades", Icon = "" }),
	Webhooks = Window:AddTab({ Title = "Webhooks", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

function SendDiscordWebhook(url, data)
	local createdBody = CreateDiscordEmbeds(data)
	return Post(url, createdBody)
end

function Post(url,body)
	if url then
		request({
		Url = url,
		Method = "POST",
		Headers = {
		["Content-Type"] = "application/json"
		},
		Body = body
	})
	else
		Notify("Failed to send Webhook.")
	end
	
end

function CreateDiscordEmbeds(data)
	local body = {
		content = data.content,
		embeds = {
			{
				title = data.title,
				description = data.description,
				color = 5814783,
				footer = {
					text = "Plink Utils"
				},
				timestamp = DateTime.now():ToIsoDate(),
			}
		},
		attachments = {}
	}
	return HttpService:JSONEncode(body)
end

function Notify(title, content)
	Fluent:Notify({
        Title = title,
        Content = content,
        Duration = 5
    })
end

function TP(x,y,z)
	clientHRP.CFrame = CFrame.new(x,y,z)
end

function PrintTable(table)
	for i,v in pairs(table) do
		print(i,v)
	end
end

local function getUpgradeTiles()
	local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
	if not playerGui then return nil end

	local root = playerGui:FindFirstChild("Root")
	if not root then return nil end

	local upgradeScreen = root:FindFirstChild("UpgradeScreen")
	if not upgradeScreen then return nil end

	local upgradeContent = upgradeScreen:FindFirstChild("UpgradeContent")
	if not upgradeContent then return nil end

	local frame = upgradeContent:FindFirstChild("Frame")
	if not frame then return nil end

	return frame:GetChildren()
end

function Upgrade()
	local upgradeTiles = getUpgradeTiles()

if upgradeTiles then
	for _,tile in pairs(upgradeTiles) do
		if tile.Name == "UIAspectRatioConstraint" or tile.Name == "UpgradeHoverInfo" then continue end
			local imageChildren = tile.ImageLabel:GetChildren()
			local upgradeBackground = tile.ImageLabel.Image
				for _,label in pairs(imageChildren) do
					
					if label.Name == "TextLabelFrame" then
						local prefix = label:FindFirstChild("Prefix")
						if prefix then
							if label.TextLabel.TextColor3:ToHex() ~= "ff2d49" and upgradeBackground == "rbxassetid://127271823919078" then
								local upgrade = tile.Name:match("^(%S+)Tile")
								local args = {
								"requestUnlock",
								upgrade
								}
								game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("UpgradeService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
							end	
						end
					end
				end		
			end
		end
end

function Roll()
	local args = {
	"requestRoll"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("RollService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end

function ConsumePotions()
	local args = {
	"requestUseBoost",
	"luck"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("BoostService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	local args = {
	"requestUseBoost",
	"ultraLuck"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("BoostService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	local args = {
	"requestUseBoost",
	"currency"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("BoostService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	local args = {
	"requestUseBoost",
	"rollSpeed"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("BoostService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

end

local function getTeleportZones()
	local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
	if not playerGui then return nil end

	local root = playerGui:FindFirstChild("Root")
	if not root then return nil end

	local teleporter = root:FindFirstChild("Teleporter")
	if not teleporter then return nil end

	local content = teleporter:FindFirstChild("Content")
	if not content then return nil end

	local frame = content:FindFirstChild("Frame")
	if not frame then return nil end

	local scrollingFrame = frame:FindFirstChild("ScrollingFrame")
	if not scrollingFrame then return nil end

	return scrollingFrame:GetChildren()
end

function TeleportBestZone()
local zones = workspace.Zones:GetChildren()
local returnZones = {}
local unlockedZones = {}

for _,zone in pairs(zones) do
	local blockerName = "ClientGateBlocker_" .. zone.Name
	
	local gate = zone.Gate:FindFirstChild(blockerName)

	if gate then
		table.insert(returnZones, gate)
	end
end

local counter = 0
for _,gateBlocker in pairs(returnZones) do
	if gateBlocker.CanCollide ~= true then
		if tonumber(gateBlocker.Parent.Parent.Name) > counter then
			counter = tonumber(gateBlocker.Parent.Parent.Name)
		end
	end
end
counter = counter + 1

	Teleport(counter)
end

function ClaimIndex()
	local args = {
	"requestClaimReward",
	"basic"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("IndexService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	task.wait(0.1)
	local args = {
	"requestClaimReward",
	"big"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("IndexService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	task.wait(0.1)
	local args = {
	"requestClaimReward",
	"huge"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("IndexService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	task.wait(0.1)
	local args = {
	"requestClaimReward",
	"shiny"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("IndexService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
	task.wait(0.1)
	local args = {
	"requestClaimReward",
	"inverted"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("IndexService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end

function Teleport(worldNum)
	local args = {
	"requestTeleportZone",
	worldNum
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("ZonesService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

end

do
	Tabs.Main:AddButton({
        Title = "Discord",
        Description = "Join the discord for updates <3 - ",
        Callback = function()
		Notify("Discord link copied to clipboard.")
			setclipboard("https://discord.gg/hJCn7UnkVZ")
        end
    })

	Tabs.Main:AddButton({
        Title = "Debug Button",
        Description = "Prolly Does Nothing",
        Callback = function()
        end
    })
	
	-- local Keybind = Tabs.Main:AddKeybind("Keybind", {
    --     Title = "Debug Keybind",
    --     Mode = "Toggle", -- Always, Toggle, Hold
    --     Default = "K",

    --     Callback = function(Value)
    --         print(UserInputService:GetMouseLocation())
    --     end,

    --     -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    --     ChangedCallback = function(New)
    --         print("Keybind changed!", New)
    --     end
    -- })

    local AutoRoll = Tabs.Main:AddToggle("AutoRoll", {Title = "Auto Roll", Default = false })

    AutoRoll:OnChanged(function()
		Notify("Auto Roll Toggled", tostring(Options.AutoRoll.Value))
        task.spawn(function() 
			while Options.AutoRoll.Value == true do
				task.wait(tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui.Root.BottomBarStats.StatsList.RollSpeedStat.Content.Value.TextLabel.Text, "[%d%.]+")))
				Roll()
			end
		end)
    end)

	local AutoIndex = Tabs.Main:AddToggle("AutoIndex", {Title = "Auto Index", Default = false })

    AutoIndex:OnChanged(function()
		Notify("Auto Index Toggled", tostring(Options.AutoIndex.Value))
        task.spawn(function() 
			while Options.AutoIndex.Value == true do
				task.wait(30)
				ClaimIndex()
			end
		end)
    end)

	local AutoFarm = Tabs.Main:AddToggle("AutoFarm", {Title = "Auto Farm", Default = false })

    AutoFarm:OnChanged(function()
		Notify("Auto Farm Toggled", tostring(Options.AutoFarm.Value))
        task.spawn(function() 
			while Options.AutoFarm.Value == true do
				task.wait()
				local drops = workspace.Loot:GetChildren()
				
				for _,drop in pairs(drops) do
					if drop then
						for _,dropChild in pairs(drop:GetChildren()) do
							if dropChild.Name ~= "LootHighlight" then
								dropChild.CFrame = CFrame.new(clientHRP.CFrame.X,clientHRP.CFrame.Y,clientHRP.CFrame.Z)
								-- dropChild.CFrame.X, dropChild.CFrame.Y, dropChild.CFrame.Z
								task.wait(0.3)
							end
						end
					end
				end
			
			end
		end)
    end)

	 Tabs.Upgrades:AddParagraph({
        Title = "Auto Upgrade works on a interval.",
        Content = "You have to open the upgrade menu sometimes for this to function correctly, \nwhen the game doesnt detect the menu is active the remote doesnt fire."
    })
	
	local AutoUpgrade = Tabs.Upgrades:AddToggle("AutoUpgrade", {Title = "Auto Upgrade", Default = false })

    AutoUpgrade:OnChanged(function()
		Notify("Auto Upgrade Toggled", tostring(Options.AutoUpgrade.Value))
        task.spawn(function() 
			while Options.AutoUpgrade.Value == true do
				Upgrade()
				task.wait(Options.AutoUpgradeInterval.Value)
			end
		end)
    end)
	
	local AutoUpgradeInterval = Tabs.Upgrades:AddInput("AutoUpgradeInterval", {
        Title = "Auto Upgrade Interval",
        Default = "30",
        Placeholder = "10",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
        end
    })


	local AutoTeleportBestZone = Tabs.Main:AddToggle("AutoTeleportBestZone", {Title = "Auto Best Zone", Default = false })

    AutoTeleportBestZone:OnChanged(function()
		Notify("Auto Best Zone Toggled", tostring(Options.AutoTeleportBestZone.Value))
        task.spawn(function() 
			while Options.AutoTeleportBestZone.Value == true do
				TeleportBestZone()
				task.wait(Options.AutoBestZoneInterval.Value)
			end
		end)
    end)

	local AutoBestZoneInterval = Tabs.Main:AddInput("AutoBestZoneInterval", {
        Title = "Auto Best Zone Interval",
        Default = "30",
        Placeholder = "10",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
        end
    })


	local AutoBuyZone = Tabs.Upgrades:AddToggle("AutoBuyZone", {Title = "Auto Buy Zone", Default = false })

    AutoBuyZone:OnChanged(function()
		Notify("Auto Buy Zone Toggled", tostring(Options.AutoBuyZone.Value))
        task.spawn(function() 
			while Options.AutoBuyZone.Value == true do
				local args = {
				"requestPurchaseZone"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("ZonesService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
				task.wait(5)
			end
		end)
    end)

	


	local AutoRebirth = Tabs.Upgrades:AddToggle("AutoRebirth", {Title = "Auto Rebirth", Default = false })

    AutoRebirth:OnChanged(function()
		Notify("Auto Rebirth Toggled", tostring(Options.AutoRebirth.Value))
        task.spawn(function() 
			while Options.AutoRebirth.Value == true do
				Notify("Rebirth", "Rebirthing...")
				local args = {
					"requestRebirth"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("RebirthService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
				task.wait(5)
			end
		end)
    end)

	local AutoPotions = Tabs.Main:AddToggle("AutoPotions", {Title = "Auto Potions", Default = false })

    AutoPotions:OnChanged(function()
		Notify("Auto Potions Toggled", tostring(Options.AutoPotions.Value))
        task.spawn(function() 
			while Options.AutoPotions.Value == true do
				ConsumePotions()
				task.wait(3)
			end
		end)
    end)

	local AutoEquipBest = Tabs.Upgrades:AddToggle("AutoEquipBest", {Title = "Auto Equip Best", Default = false })

    AutoEquipBest:OnChanged(function()
		Notify("Auto Equip Best Toggle", tostring(Options.AutoEquipBest.Value))
        task.spawn(function() 
			while Options.AutoEquipBest.Value == true do
				local args = {
				"requestEquipBest"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("InventoryService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
				task.wait(10)
				Notify("Equipped Best", "Equipped best pets.")
			end
		end)
    end)


	--Webhooks
	local WebhookUrl = Tabs.Webhooks:AddInput("WebhookUrl", {
        Title = "Webhook URL",
        Default = "",
        Placeholder = "WEBHOOK URL",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
        end
    })

	local Webhook = Tabs.Webhooks:AddToggle("Webhook", {Title = "Webhook", Default = false })

    Webhook:OnChanged(function()
		Notify("Webhook Toggled", tostring(Options.Webhook.Value))
        task.spawn(function() 
			while Options.Webhook.Value == true do
				task.wait()
				SendDiscordWebhook(Options.WebhookUrl.Value, {
					title = localPlayer.Name,
					description = workspace:FindFirstChild(localPlayer.Name).HumanoidRootPart.TitleGui.NumRolls.Text
				})
				task.wait(tonumber(Options.WebhookInterval.Value))
			end
		end)
    end)
	

	local WebhookInterval = Tabs.Webhooks:AddInput("WebhookInterval", {
        Title = "Webhook Interval",
        Default = "30",
        Placeholder = "10",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
        end
    })
end


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Plink")
SaveManager:SetFolder("Plink/SRNG")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
SaveManager:LoadAutoloadConfig()


-- local metaTable = {
-- 	__tostring = function(table) 
-- 		for i,v in pairs(table) do
-- 			print(i,v)
-- 		end
-- 	end,
-- }

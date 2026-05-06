_G.autoUpgrade = false

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local client = workspace:FindFirstChild(localPlayer.Name)
local clientHRP = client.HumanoidRootPart


local Window = Fluent:CreateWindow({
    Title = "Plink Slime RNG v1.0.0",
    SubTitle = "by who?",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

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

function Upgrade()
	task.wait()
	local upgradeTiles = game:GetService("Players").LocalPlayer.PlayerGui.Root.UpgradeScreen.UpgradeContent.Frame:GetChildren()

	if upgradeTiles then
		for _,tile in pairs(upgradeTiles) do
				if tile.Name ~= "UIAspectRatioConstraint" or tile.Name ~= "UpgradeHoverInfo" then
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

do
	Tabs.Main:AddButton({
        Title = "Discord",
        Description = "Join the discord for updates <3 - ",
        Callback = function()
		Notify("Discord link copied to clipboard.")
			setclipboard("https://discord.gg/hJCn7UnkVZ")
        end
    })
	
    local AutoRoll = Tabs.Main:AddToggle("AutoRoll", {Title = "Auto Roll", Default = false })

    AutoRoll:OnChanged(function()
		Notify("Auto Roll Toggled", tostring(Options.AutoRoll.Value))
        task.spawn(function() 
			while Options.AutoRoll.Value == true do
				task.wait()
				local args = {
				"requestRoll"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("RollService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))

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
								TP(dropChild.CFrame.X, dropChild.CFrame.Y, dropChild.CFrame.Z)
							end
						end
					end
				end
			
			end
		end)
    end)


	local AutoUpgrade = Tabs.Main:AddToggle("AutoUpgrade", {Title = "Auto Upgrade", Default = false })

    AutoUpgrade:OnChanged(function()
		Notify("Auto Upgrade Toggled", tostring(Options.AutoUpgrade.Value))
        task.spawn(function() 
			while Options.AutoUpgrade.Value == true do
				Upgrade()
			end
		end)
    end)


	local AutoZone = Tabs.Main:AddToggle("AutoZone", {Title = "Auto Zone", Default = false })

    AutoZone:OnChanged(function()
		Notify("Auto Upgrade Toggled", tostring(Options.AutoZone.Value))
        task.spawn(function() 
			while Options.AutoZone.Value == true do
				local args = {
				"requestPurchaseZone"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("leifstout_networker@0.3.1"):WaitForChild("networker"):WaitForChild("_remotes"):WaitForChild("ZonesService"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
				task.wait(5)
			end
		end)
    end)


	local AutoRebirth = Tabs.Main:AddToggle("AutoRebirth", {Title = "Auto Rebirth", Default = false })

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

	local PlayerInput = Tabs.Main:AddInput("PlayerInput", {
        Title = "Player Input",
        Default = "Blackwind101",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
        end
    })
	
	local AutoTPToPlayer = Tabs.Main:AddToggle("AutoTPToPlayer", {Title = "Auto TP To Player", Default = false })

    AutoTPToPlayer:OnChanged(function()
		Notify("Auto TP To Player Toggled", tostring(Options.AutoTPToPlayer.Value))
        task.spawn(function() 
			while Options.AutoTPToPlayer.Value == true do
				task.wait(1)
				local player = workspace[PlayerInput.Value]
				if player then
					clientHRP.CFrame = player.HumanoidRootPart.CFrame
				else
					Notify("Player not Found.", "Enter a valid player name in the box below.")
				end
			end
		end)
    end)

	

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

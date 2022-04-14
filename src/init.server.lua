local RunService = game:GetService("RunService")
if RunService:IsRunMode() then
	return
end

local root = script

local libs = root.libs
local Fusion = require(libs.fusion)

local Children = Fusion.Children

local components = root.components
local Plugin = require(components.plugin)

local assetManager = require(root.asset_manager)

Plugin({
	Name = "Mitten Tools",
	plugin = plugin,
	[Children] = {
		assetManager = assetManager,
	},
})

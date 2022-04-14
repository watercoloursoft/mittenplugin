local root = script.Parent

local libs = root.libs
local Fusion = require(libs.fusion)

local New = Fusion.New
local Children = Fusion.Children

local components = script.Parent.components
local Button = require(components.button)
local Widget = require(components.widget)

local useTheme = require(components.studio_theme)
local FileTree = require(components.file_tree)

local TOPBAR_SIZE_PX = 30
local BOTTOMBAR_SIZE_PX = 30

local assetManagerWidget = New("Frame")({
	Name = "Background",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.MainBackground),
	[Children] = {
		Topbar = New("Frame")({
			Name = "Topbar",
			BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Titlebar),
			BorderColor3 = useTheme(Enum.StudioStyleGuideColor.Border),
			BorderMode = Enum.BorderMode.Middle,
			BorderSizePixel = 1,

			Size = UDim2.new(1, 0, 0, TOPBAR_SIZE_PX),
			ZIndex = 2,
		}),
		Content = New("Frame")({
			Name = "Content",
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, -TOPBAR_SIZE_PX),
			Position = UDim2.new(0, 0, 1, -1),
			[Children] = {
				Sidebar = New("Frame")({
					Name = "Sidebar",
					BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.HeaderSection),
					BorderColor3 = useTheme(Enum.StudioStyleGuideColor.Border),
					BorderMode = Enum.BorderMode.Middle,
					BorderSizePixel = 1,
					Size = UDim2.new(0, 130, 1, 0),
					[Children] = FileTree({
						fileTree = {
							Children = {
								Egg = { Children = { MMM = { Children = {} }, mittenplugin = { Children = {} } } },
							},
						},
					}),
				}),
				BottomBar = New("Frame")({
					Name = "BottomBar",

					AnchorPoint = Vector2.new(0, 1),

					BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Titlebar),
					BorderColor3 = useTheme(Enum.StudioStyleGuideColor.Border),
					BorderMode = Enum.BorderMode.Middle,
					BorderSizePixel = 1,

					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, BOTTOMBAR_SIZE_PX),
				}),
			},
		}),
	},
})

return {
	["Asset Manager"] = Button({
		Click = function()
			print(1)
		end,
		iconname = "rbxassetid://226153250",
		text = "Assets",
		tooltip = "Easy to use Asset Manager",
		linkedWidget = "Asset Manager Window",
	}),
	["Asset Manager Window"] = Widget({
		title = "Asset Manager",
		defaultSize = Vector2.new(600, 300),
		minimimumSize = Vector2.new(200, 150),
		initiallyEnabled = true,
		[Children] = assetManagerWidget,
	}),
}

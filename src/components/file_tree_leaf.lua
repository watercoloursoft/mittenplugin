local TextService = game:GetService("TextService")
local root = script.Parent.Parent

local libs = root.libs
local Fusion = require(libs.fusion)

local modules = root.modules
local VirtualFileTree = require(modules.virtual_file_tree)

local useTheme = require(script.Parent.studio_theme)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children
local Ref = Fusion.Ref
local Value = Fusion.Value

local LEAF_TEXT_SIZE = 14
local LEAF_SIZE_PX = 18
local CHECK_SIZE = Vector2.new(math.huge, LEAF_SIZE_PX)

export type FileTreeLeafComponent = {
	Name: string,
	Type: VirtualFileTree.VirtualFileType,

	indentationAmountPx: number,
}
return function(props: FileTreeLeafComponent)
	local spaceNeeded = TextService:GetTextSize(props.Name, LEAF_TEXT_SIZE, Enum.Font.SourceSans, CHECK_SIZE)
	local modifier = Value(Enum.StudioStyleGuideModifier.Default)
	if props.Name == "mittenplugin" then
		modifier:set(Enum.StudioStyleGuideModifier.Selected)
	end
	return New("Frame")({
		BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.TableItem, modifier),
		BackgroundTransparency = if props.Name == "mittenplugin" then 0 else 1,
		Size = UDim2.new(1, 0, 0, LEAF_SIZE_PX),
		[Children] = New("Frame")({
			BackgroundTransparency = 1,
			Size = UDim2.new(0, props.indentationAmountPx + spaceNeeded.X + 1, 1, 0),
			[Children] = {
				New("TextLabel")({
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Text = props.Name,
					TextColor3 = useTheme(Enum.StudioStyleGuideColor.MainText, modifier),
					TextSize = LEAF_TEXT_SIZE,
					Font = Enum.Font.SourceSans,
					TextXAlignment = Enum.TextXAlignment.Left,

					[Children] = New("UIPadding")({
						PaddingLeft = UDim.new(0, props.indentationAmountPx),
						PaddingBottom = UDim.new(0, 2),
						PaddingTop = UDim.new(0, 2),
						PaddingRight = UDim.new(0, 2),
					}),
				}),
			},
		}),
	})
end

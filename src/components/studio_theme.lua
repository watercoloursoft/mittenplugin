local root = script.Parent.Parent

local studio = settings().Studio :: Studio

local libs = root.libs
local Fusion = require(libs.fusion)

local Value = Fusion.Value
local Observer = Fusion.Observer

local function UpdateThemeColor(
	state: Fusion.State<Color3>,
	styleColor: Enum.StudioStyleGuideColor,
	modifier: Fusion.State<Enum.StudioStyleGuideModifier>
)
	state:set(
		studio.Theme:GetColor(styleColor, if modifier then modifier:get() else Enum.StudioStyleGuideModifier.Default)
	)
end

local function useTheme(styleColor: Enum.StudioStyleGuideColor, modifier: Fusion.State<Enum.StudioStyleGuideModifier>?)
	local colorValue = Value()
	UpdateThemeColor(colorValue, styleColor, modifier)
	studio.ThemeChanged:Connect(function()
		UpdateThemeColor(colorValue, styleColor, modifier)
	end)
	if modifier then
		Observer(modifier):onChange(function()
			UpdateThemeColor(colorValue, styleColor, modifier)
		end)
	end
	return colorValue
end

return useTheme

local StudioService = game:GetService("StudioService")

local root = script.Parent.Parent

local libs = root.libs
local Fusion = require(libs.fusion)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children
local Ref = Fusion.Ref

export type NestedChildren = { [string | number]: Instance }

export type PluginWidgetComponentProps = {
	type: "Widget",

	initialDockState: Enum.InitialDockState?,
	initiallyEnabled: boolean?,
	restoreEnabled: boolean?,
	defaultSize: Vector2?,
	minimimumSize: Vector2,

	title: string,
	[typeof(Children)]: NestedChildren,
}
return function(props: PluginWidgetComponentProps)
	return {
		type = "Widget",

		initialDockState = props.initialDockState or Enum.InitialDockState.Float,
		initiallyEnabled = props.initiallyEnabled or false,
		restoreEnabled = props.restoreEnabled or true,
		defaultSize = props.defaultSize or Vector2.new(200, 300),
		minimimumSize = props.minimimumSize or Vector2.new(150, 150),

		title = props.title or "?",
		[Children] = props[Children],
	} :: PluginWidgetComponentProps
end

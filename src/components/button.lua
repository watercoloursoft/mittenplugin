local ClickEvent = "Click"

local defaultIcon = ""

export type PluginButtonComponentProps = {
	type: "Button",

	tooltip: string,
	iconname: string?,
	text: string?,

	Click: (() -> nil)?,
	linkedWidget: string?,
}
return function(props: PluginButtonComponentProps)
	return {
		type = "Button",

		tooltip = props.tooltip or "",
		iconname = props.iconname or defaultIcon,
		text = props.text or "Button",

		[ClickEvent] = props[ClickEvent],
		linkedWidget = props.linkedWidget or "",
	} :: PluginButtonComponentProps
end

local root = script.Parent.Parent

local libs = root.libs
local Fusion = require(libs.fusion)

local button = require(script.Parent.button)
local widget = require(script.Parent.widget)

local Children = Fusion.Children

export type PluginComponentProps = {
	Name: string,
	plugin: typeof(plugin),
	[typeof(Children)]: { button.PluginButtonComponentProps | widget.PluginWidgetComponentProps },
}
return function(props: PluginComponentProps)
	local plugin = props.plugin
	local toolbar = plugin:CreateToolbar(props.Name)
	local buttons = {} :: { [string]: PluginToolbarButton }
	local widgets = {} :: { [string]: DockWidgetPluginGui }
	-- map with keys being the widget key and values being the button key
	local buttonsDependingOnwidgets = {} :: { [string]: string }

	local function IterateChildren(children: { button.PluginButtonComponentProps | widget.PluginWidgetComponentProps })
		for key, itemProps in pairs(children) do
			if typeof(itemProps) == "table" and not itemProps.type then
				IterateChildren(itemProps)
				return
			end
			if itemProps.type == "Button" then
				local createdButton = toolbar:CreateButton(key, itemProps.tooltip, itemProps.iconname, itemProps.text)
				if itemProps.Click then
					createdButton.Click:Connect(itemProps.Click)
				end
				local widgetName = itemProps.linkedWidget
				if widgetName then
					createdButton.Click:Connect(function()
						local foundWidget = widgets[widgetName]
						if foundWidget then
							foundWidget.Enabled = not foundWidget.Enabled
							createdButton:SetActive(foundWidget.Enabled)
						end
					end)
					buttonsDependingOnwidgets[widgetName] = buttonsDependingOnwidgets[widgetName] or {}
					table.insert(buttonsDependingOnwidgets[widgetName], key)
				end
				buttons[key] = createdButton
			elseif itemProps.type == "Widget" then
				local createdWidget = plugin:CreateDockWidgetPluginGui(
					key,
					DockWidgetPluginGuiInfo.new(
						itemProps.initialDockState,
						itemProps.initiallyEnabled,
						itemProps.restoreEnabled,
						itemProps.defaultSize.X,
						itemProps.defaultSize.Y,
						itemProps.minimimumSize.X,
						itemProps.minimimumSize.Y
					)
				)
				createdWidget.Title = itemProps.title
				createdWidget.Name = props.Name .. " <" .. itemProps.title .. ">"
				createdWidget:BindToClose(function()
					for _, buttonName in pairs(buttonsDependingOnwidgets[key]) do
						local foundButton = buttons[buttonName]
						foundButton:SetActive(false)
					end
					createdWidget.Enabled = false
				end)
				local function IterateUIChildren(children: widget.NestedChildren, name: string?)
					if typeof(children) == "Instance" then
						if name then
							children.Name = name
						end
						children.Parent = createdWidget
					elseif typeof(children) == "table" then
						for childKey, uiObject in pairs(children) do
							IterateUIChildren(uiObject, childKey)
						end
					end
				end
				if itemProps[Children] then
					IterateUIChildren(itemProps[Children])
				end
				widgets[key] = createdWidget
			end
		end
	end
	IterateChildren(props[Children])

	return {}
end

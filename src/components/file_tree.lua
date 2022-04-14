local root = script.Parent.Parent

local libs = root.libs
local Fusion = require(libs.fusion)

local modules = root.modules
local VirtualFileTree = require(modules.virtual_file_tree)

local FileTreeLeaf = require(script.Parent.file_tree_leaf)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children
local Ref = Fusion.Ref

local INDENTATION_PER_LEVEL_PX = 22

export type FileTreeComponent = {
	indentationLevel: number?,
	fileTree: VirtualFileTree.VirtualFile,

	additiveNodes: { [string | number]: Instance }?,
}
local function FileTree(props: FileTreeComponent)
	local indentationLevel = props.indentationLevel or 1
	local nodes = props.additiveNodes or {
		UIListLayout = New("UIListLayout")({
			Padding = UDim.new(0, 0),
		}),
	}

	for childName, file in pairs(props.fileTree.Children) do
		nodes[childName] = FileTreeLeaf({
			Name = childName,
			Type = file.AssetType,
			indentationAmountPx = indentationLevel * INDENTATION_PER_LEVEL_PX,
		})
		FileTree({ fileTree = file, indentationLevel = indentationLevel + 1, additiveNodes = nodes })
	end

	return nodes
end

return FileTree

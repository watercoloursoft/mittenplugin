export type VirtualFileType = "Image" | "Mesh" | "Packages" | "Audio" | "Prefab" | "Folder"

export type VirtualFile = {
	AssetType: VirtualFileType,
	Data: any,

	Parent: VirtualFile?,
	Children: {
		[string]: VirtualFile,
	},
}

local function CreateVirtualFile(fileType: VirtualFileType, data: any)
	return { AssetType = fileType, Data = data, Parent = nil, Children = {} } :: VirtualFile
end

local function SetFileParent(f: VirtualFile, parent: VirtualFile?)
	f.Parent = parent
end

return {
	CreateVirtualFile = CreateVirtualFile,
	SetFileParent = SetFileParent,
}

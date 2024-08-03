local httpService = game:GetService("HttpService")

local SaveManager = {} do
	SaveManager.Folder = "CrazyDay"
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = "Toggle", idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(idx, object)
				return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(idx, object)
				return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.key, data.mode)
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = "Input", idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] and type(data.text) == "string" then
					SaveManager.Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, "no config file is selected"
		end

		local fullPath = self.Folder .. "/" .. name .. ".json"

		local data = {
			objects = {}
		}

		for idx, option in next, SaveManager.Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end

		local success, encoded = pcall(httpService.JSONEncode, httpService, data)
		if not success then
			return false, "failed to encode data"
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, "no config file is selected"
		end
		
		local file = self.Folder .. "/" .. name .. ".json"
		if not isfile(file) then return false, "invalid file" end

		local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
		if not success then return false, "decode error" end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end) -- task.spawn() so the config loading wont get stuck.
			end
		end

		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme", "AcrylicToggle", "TransparentToggle", "MenuKeybind" , "BlackScreenToggle"
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
        self.Options = library.Options
	end

	function SaveManager:BuildConfigSection(tab)
		assert(self.Library, "Must set SaveManager.Library")

		SaveManager:Load("Configuration")
		local section = tab:AddSection("Configuration")
		section:AddToggle("Auto Save", {
			Title = "Auto Save",
			Description = nil,
			Default = true,
			Callback = function(Value)
				SaveManager:Save("Configuration")
			end
		})

		section:AddButton({
            Title = "Reset Configuration",
            Callback = function()
				self.Library.Window:Dialog({
					Title = "Configuration",
					Content = "Are you sure you want to reset the configuration?",
					Buttons = {
						{Title = "Yes", Callback = function()
							for idx, option in next, SaveManager.Options do
								if self.Ignore[idx] then continue end
								if option.Type == "Dropdown" then
									if option.Multi == true then
										option:SetValue({nil})
									else
										option:SetValue(nil)
									end
								elseif option.Type == "Toggle" and not table.find({"Auto Save"}, idx) then
										option:SetValue(false)
								elseif option.Type == "Slider" then
										option:SetValue(0)
								elseif option.Type == "Input" then
										option:SetValue("")
								elseif option.Type == "Keybind" then
										option:SetValue("", option.Mode)
								elseif option.Type == "Colorpicker" then
										option:SetValueRGB(Color3.fromRGB(0, 0, 0))
								end
							end
						end},
						{Title = "No"}
					}
				})
            end
        })

		for idx, val in next, SaveManager.Options do
			if self.Ignore[idx] then continue end
			val:OnChanged(function (Value)
				if SaveManager.Options["Auto Save"].Value then
					SaveManager:Save("Configuration")
				end
			end)
		end
	end

	SaveManager:BuildFolderTree()
end

return SaveManager

local LrTasks = import("LrTasks")
local LrFileUtils = import("LrFileUtils")

local function statusSection( f, _ )
	local Executable = _PLUGIN.path .. "/starnet/starnet++"

	local ExecutableMissing = LrFileUtils.exists(Executable) ~= "file"
	local ExecutablePresenceStatus
	if ExecutableInstalled then
		ExecutableInstalationStatus = LOC("$$$/Starnet/ExecutableMissing=Executable is missing, click button to initialize")
	else 
		ExecutableInstalationStatus = LOC("$$$/Starnet/ExecutableFound=Executable was found")
	end

	return {
		{
			title = LOC("$$$/Starnet/PluginManagerHealth=Plugin health check"),
			f:row {
				spacing = f:control_spacing(),

				f:static_text {
					title = ExecutableInstalationStatus,
					fill_horizontal = 1,
				},

				f:push_button {
					width = 150,
					title = LOC("$$$/Starnet/InitButton=Initialize"),
					enabled = ExecutableMissing,
					action = function()
						LrTasks.startAsyncTask(function()
							local CommandTemplate = "%s/Init.sh > %s/Init.log 2>%s/Init.err"
							LrTasks.execute(CommandTemplate:format(_PLUGIN.path, _PLUGIN.path, _PLUGIN.path))
						end)
					end,
				},
			},
			f:row {
				spacing = f:control_spacing(),

				f:static_text {
					title = LOC("$$$/Starnet/FixExecutableRights=In case of permission denied error, click button to fix executable flags"),
					fill_horizontal = 1,
				},

				f:push_button {
					width = 150,
					title = LOC("$$$/Starnet/FixRights=Fix rights"),
					enabled = true,
					action = function()
						LrTasks.startAsyncTask(function()
							local CommandTemplate = "chmod +x %s/starnet/starnet++ > %s/Rights.log 2>%s/Rights.err"
							LrTasks.execute(CommandTemplate:format(_PLUGIN.path, _PLUGIN.path, _PLUGIN.path))
						end)
					end,
				},
			},
		},

	}
end

return{
	sectionsForBottomOfDialog = statusSection,
}

local PluginInfo = {
    VERSION = { major=0, minor=0, revision=1, },
  
    LrSdkVersion = 9.0,
    LrSdkMinimumVersion = 4.0,
  
    LrToolkitIdentifier = "org.rbaranga.lrplugin.starnet",
    LrPluginName = "Starnet",
    LrPluginInfoUrl = "https://github.com/rbaranga/starnet-lightroom-plugin",

    LrPluginInfoProvider = "InfoProvider.lua",
	
    LrExportServiceProvider = {
        title = "Starnet",
        file = "ServiceProvider.lua",
        builtInPresetsDir = "preset",
    },
}

return PluginInfo
local LrDialogs = import "LrDialogs"
local LrView = import "LrView"
local LrPathUtils = import "LrPathUtils"
local LrFileUtils = import "LrFileUtils"
local LrLogger = import "LrLogger"
local LrTasks = import "LrTasks"
local LrErrors = import "LrErrors"

local Logger = LrLogger( "Starnet" )
Logger:enable( "print" )

local ExportProcessRenderedPhotos = {}

ExportProcessRenderedPhotos.hideSections = {"exportLocation", "fileNaming", "imageSettings", "outputSharpening", "metadata", "watermarking", "video"}
ExportProcessRenderedPhotos.hidePrintResolution = true;
ExportProcessRenderedPhotos.canExportToTemporaryLocation = true
ExportProcessRenderedPhotos.allowFileFormats = {"TIFF", "ORIGINAL"}

function ExportProcessRenderedPhotos.processRenderedPhotos( FunctionContext, ExportContext )
    local Extension = "tif"
	local ProgressScope = ExportContext:configureProgress{
        title = LOC ("$$$/Starnet/Progress/Title=Removing stars..."),
    }

	for i, Rendition in ExportContext:renditions{ stopIfCanceled = true } do
        if ProgressScope:isCanceled() then 
            break 
        end
        local Success, PathOrMessage = Rendition:waitForRender()
        if Success then
			local Photo = Rendition.photo
            
            local PhotoName = Photo:getFormattedMetadata("fileName")
            local PhotoPath = Photo:getRawMetadata("path")
            local TargetName = LrPathUtils.addExtension(LrPathUtils.removeExtension(PhotoName) .. "-Starless", Extension)
            local TargetPath = PhotoPath:gsub(PhotoName, TargetName)
            
            local TempOutFile = LrPathUtils.addExtension(PathOrMessage, "out")
            local TempErrFile = LrPathUtils.addExtension(PathOrMessage, "err") 

            local CommandTemplate = "%s/Starnet.sh %q %q > %q 2>%q"
            local Command = CommandTemplate:format(_PLUGIN.path, PathOrMessage, TargetPath, TempOutFile, TempErrFile)

            local Result = LrTasks.execute(Command);
            if Result ~= 0 then
                local Error = "Failed when trying to execute command: " .. LrFileUtils.readFile(TempErrFile);
                Logger:trace(Error)
                LrErrors.throwUserError("Starnet failed: " .. Error)
            else
                if LrFileUtils.exists( TargetPath ) then
                    local Log = LrFileUtils.readFile(TempOutFile);
                    Logger:trace(Log)

                    local Catalog = Photo.catalog
                    Catalog:withWriteAccessDo("0", function(context)
					    Catalog:addPhoto(TargetPath, Photo, nil)
                    end)
                else
                    LrErrors.throwUserError("Starnet failed: " .. TargetPath .. " not found!")
                end
            end
        else
            LrErrors.throwUserError("Starnet image render error: " .. PathOrMessage)
        end
    end
end

return ExportProcessRenderedPhotos
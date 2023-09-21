Citizen.CreateThread(function()
    Wait(50)
    -- Credit to Dalrae for the solve.
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end

    RequestStreamedTextureDict("circlemap", false)
    if not HasStreamedTextureDictLoaded("circlemap") then
        Wait(150)
    end
    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
    -- -0.0100 = nav symbol and icons left
    -- 0.180 = nav symbol and icons stretched
    -- 0.258 = nav symbol and icons raised up
    SetMinimapComponentPosition("minimap", "L", "B", -0.0070 + minimapOffset, -0.005, 0.165, 0.20777768)

    -- icons within map
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.021 + minimapOffset, 0.02, 0.121, 0.19)

    -- -0.00 = map pulled left
    -- 0.015 = map raised up
    -- 0.252 = map stretched
    -- 0.338 = map shorten
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.008, 0.06, 0.252, 0.338)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(0)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)
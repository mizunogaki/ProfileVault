local PV = ProfileVault

PV.CVarSettings = {}

local categories = {
    graphics = {
        "graphicsQuality",
        "graphicsTextureResolution",
        "graphicsShadowQuality",
        "graphicsEnvironmentDetail",
        "graphicsGroundClutter",
        "graphicsSpellDensity",
        "graphicsViewDistance",
        "graphicsParticleDensity",
        "graphicsDepthEffects",
        "graphicsLightMode",
        "graphicsComputeEffects",
        "graphicsOutlineMode",
        "graphicsPBRLiquidDetail",
        "graphicsLiquidDetail",
        "graphicsProjectedTextures",
        "graphicsBloomUserMult",
        "bloomUserMult",
        "graphicsSSAO",
        "vsync",
        "RenderScale",
        "ffxAntiAliasingMode",
        "textureFilteringMode",
        "farclip",
        "horizonStart",
        "horizonClip",
        "shadowMode",
        "shadowNumCascades",
        "weatherDensity",
        "groundEffectDensity",
        "groundEffectDist",
        "projectedTextures",
        "particleDensity",
        "particleMTDensity",
        "spellClutter",
        "rippleDetail",
        "pbrLiquidDetail",
        "reflectionMode",
        "Gamma",
        "Contrast",
        "maxFPS",
        "maxFPSBk",
        "useMaxFPS",
        "MSAAAlphaTest",
        "LowLatencyMode",
        "ResampleSharpness",
        "ResampleAlwaysSharpen",
        "ResampleQuality",
        "volumeFog",
        "volumeFogLevel",
        "shadowBlendCascades",
        "DepthBasedOpacity",
        "gxMaximize",
        "gxWindow",
        "gxFullscreenResolution",
        "gxWindowedResolution",
    },
    camera = {
        "cameraDistanceMaxZoomFactor",
        "cameraZoomSpeed",
        "cameraSmoothStyle",
        "cameraView",
        "cameraFov",
    },
    interface = {
        "useUiScale",
        "uiScale",
        "UnitNameOwn",
        "UnitNameNPC",
        "UnitNameFriendlyPlayerName",
        "UnitNameEnemyPlayerName",
        "UnitNameNonCombatCreatureName",
        "nameplateShowEnemies",
        "nameplateShowFriendlyPlayers",
        "nameplateShowFriendlyMinions",
        "nameplateShowSelf",
        "autoSelfCast",
        "lootUnderMouse",
        "autoLootDefault",
        "lockActionBars",
        "enableMultiActionBars",
        "statusTextDisplay",
        "combinedBags",
    },
    sound = {
        "Sound_MasterVolume",
        "Sound_MusicVolume",
        "Sound_AmbienceVolume",
        "Sound_SFXVolume",
        "Sound_DialogVolume",
        "Sound_NumChannels",
        "Sound_EnableSoundWhenGameIsInBG",
    },
}

function PV.CVarSettings:GetTracked()
    local all = {}

    for _, category in pairs(categories) do
        for _, cvarName in ipairs(category) do
            all[#all + 1] = cvarName
        end
    end

    return all
end

function PV.CVarSettings:BuildSection()
    local section = {}

    for _, cvarName in ipairs(self:GetTracked()) do
        local ok, value = pcall(GetCVar, cvarName)

        if ok and value ~= nil then
            section[cvarName] = value
        end
    end

    return section
end

function PV.CVarSettings:ApplySection(section)
    if not section then
        return 0
    end

    local applied = 0

    local function apply(name, value)
        if pcall(SetCVar, name, value) then
            applied = applied + 1
        end
    end

    if section.graphicsQuality ~= nil then
        apply("graphicsQuality", section.graphicsQuality)
    end

    for cvarName, value in pairs(section) do
        if cvarName ~= "graphicsQuality" and cvarName:sub(1, 8) == "graphics" then
            apply(cvarName, value)
        end
    end

    for cvarName, value in pairs(section) do
        if cvarName ~= "graphicsQuality" and cvarName:sub(1, 8) ~= "graphics" then
            apply(cvarName, value)
        end
    end

    return applied
end
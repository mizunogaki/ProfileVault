local ADDON_NAME = "ProfileVault"

ProfileVault = ProfileVault or {}
local PV = ProfileVault

function PV:EnsureDB()
    if type(ProfileVaultDB) ~= "table" then
        ProfileVaultDB = {}
    end

    if type(ProfileVaultDB.profiles) ~= "table" then
        ProfileVaultDB.profiles = {}
    end

    if ProfileVaultDB.profiles[1] ~= nil and ProfileVaultDB.order == nil then
        local migrated = {}
        local order = {}

        for index, profile in ipairs(ProfileVaultDB.profiles) do
            local name = "profile" .. index
            migrated[name] = profile
            order[#order + 1] = name
        end

        ProfileVaultDB.profiles = migrated
        ProfileVaultDB.order = order

        if ProfileVaultDB.currentProfile then
            ProfileVaultDB.lastProfile = "profile" .. ProfileVaultDB.currentProfile
        end
        ProfileVaultDB.currentProfile = nil
    end

    if type(ProfileVaultDB.order) ~= "table" then
        ProfileVaultDB.order = {}
    end
end

function PV:GetProfileNames()
    self:EnsureDB()

    local names = {}
    local seen = {}

    for _, name in ipairs(ProfileVaultDB.order) do
        if ProfileVaultDB.profiles[name] and not seen[name] then
            names[#names + 1] = name
            seen[name] = true
        end
    end

    for name in pairs(ProfileVaultDB.profiles) do
        if not seen[name] then
            names[#names + 1] = name
            seen[name] = true
        end
    end

    table.sort(names)
    return names
end

function PV:ProfileExists(name)
    self:EnsureDB()
    return name ~= nil and ProfileVaultDB.profiles[name] ~= nil
end

function PV:GetLastProfileName()
    self:EnsureDB()
    return ProfileVaultDB.lastProfile
end

function PV:BuildProfile()
    return {
        created = date("%Y-%m-%d %H:%M:%S"),
        cvars = self.CVarSettings:BuildSection(),
        keybinds = self.Keybinds:BuildSection(),
    }
end

function PV:ApplyProfileData(profile)
    if not profile then
        return false, 0, 0
    end

    local cvarCount = self.CVarSettings:ApplySection(profile.cvars)
    local bindCount = self.Keybinds:ApplySection(profile.keybinds)

    return true, cvarCount, bindCount
end

function PV:SaveProfile(name)
    if not name or name == "" then
        return false, "empty name"
    end

    self:EnsureDB()

    local isNew = ProfileVaultDB.profiles[name] == nil
    ProfileVaultDB.profiles[name] = self:BuildProfile()
    ProfileVaultDB.lastProfile = name

    if isNew then
        table.insert(ProfileVaultDB.order, name)
    end

    return true
end

function PV:LoadProfile(name)
    if not name or name == "" then
        return false, 0, 0
    end

    self:EnsureDB()

    local profile = ProfileVaultDB.profiles[name]
    if not profile then
        return false, 0, 0
    end

    ProfileVaultDB.lastProfile = name
    return self:ApplyProfileData(profile)
end

function PV:DeleteProfile(name)
    self:EnsureDB()

    if not ProfileVaultDB.profiles[name] then
        return false
    end

    ProfileVaultDB.profiles[name] = nil

    for index, ordered in ipairs(ProfileVaultDB.order) do
        if ordered == name then
            table.remove(ProfileVaultDB.order, index)
            break
        end
    end

    if ProfileVaultDB.lastProfile == name then
        ProfileVaultDB.lastProfile = ProfileVaultDB.order[#ProfileVaultDB.order]
    end

    return true
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(_, event, loadedAddon)
    if event == "ADDON_LOADED" and loadedAddon == ADDON_NAME then
        PV:EnsureDB()
        print("|cff00ff00ProfileVault:|r загружен. Настройки доступны в меню «Модификации», команда /pv.")
    end
end)

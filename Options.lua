local PV = ProfileVault

local ROW_HEIGHT = 24

local panel = CreateFrame("Frame", "ProfileVaultOptionsPanel")
panel.name = "Profile Vault"
panel:EnableKeyboard(false)

local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("Profile Vault")

local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
subtitle:SetText("Сохранение и загрузка профилей графики и клавиш.")

local status = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
status:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -14)
status:SetJustifyH("LEFT")
status:SetText("")

local function SetStatus(text, isError)
    if isError then
        status:SetText("|cffff5555" .. text .. "|r")
    else
        status:SetText("|cff55ff55" .. text .. "|r")
    end
end

local nameLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
nameLabel:SetPoint("TOPLEFT", status, "BOTTOMLEFT", 0, -16)
nameLabel:SetText("Имя профиля:")

local nameBox = CreateFrame("EditBox", "ProfileVaultNameBox", panel, "InputBoxTemplate")
nameBox:SetAutoFocus(false)
nameBox:SetSize(220, 24)
nameBox:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -6)
nameBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
nameBox:SetScript("OnEnterPressed", function(self)
    local name = strtrim(self:GetText() or "")
    if name ~= "" then
        SetStatus("Выбран профиль: " .. name)
    end
    self:ClearFocus()
end)

local saveButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
saveButton:SetSize(120, 24)
saveButton:SetPoint("LEFT", nameBox, "RIGHT", 8, 0)
saveButton:SetText("Сохранить")

local loadButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
loadButton:SetSize(120, 24)
loadButton:SetPoint("TOPLEFT", nameBox, "BOTTOMLEFT", 0, -10)
loadButton:SetText("Загрузить")

local deleteButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
deleteButton:SetSize(120, 24)
deleteButton:SetPoint("LEFT", loadButton, "RIGHT", 8, 0)
deleteButton:SetText("Удалить")

local listLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
listLabel:SetPoint("TOPLEFT", loadButton, "BOTTOMLEFT", 0, -20)
listLabel:SetText("Сохранённые профили:")

local scroll = CreateFrame("ScrollFrame", "ProfileVaultScroll", panel, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", listLabel, "BOTTOMLEFT", 0, -8)
scroll:SetSize(400, 160)

local content = CreateFrame("Frame", nil, scroll)
content:SetSize(380, 1)
scroll:SetScrollChild(content)

local rows = {}

local function RefreshList()
    for _, row in ipairs(rows) do
        row:Hide()
    end

    local names = PV:GetProfileNames()
    local yOffset = 0

    for index, name in ipairs(names) do
        local row = rows[index]
        if not row then
            row = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
            row:SetSize(376, ROW_HEIGHT - 2)
            row:SetScript("OnClick", function(self)
                nameBox:SetText(self.profileName)
                SetStatus("Выбран профиль: " .. self.profileName)
            end)
            rows[index] = row
        end

        row.profileName = name

        local profile = ProfileVaultDB.profiles[name]
        local created = profile and profile.created
        if created and created ~= "" then
            row:SetText(name .. "   (" .. created .. ")")
        else
            row:SetText(name)
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
        row:Show()

        yOffset = yOffset + ROW_HEIGHT
    end

    content:SetSize(380, math.max(yOffset, 1))
end

local function GetNameFromBox()
    return strtrim(nameBox:GetText() or "")
end

saveButton:SetScript("OnClick", function()
    local name = GetNameFromBox()
    if name == "" then
        SetStatus("Укажите имя профиля.", true)
        return
    end

    local ok = PV:SaveProfile(name)
    if ok then
        RefreshList()
        SetStatus(("Профиль \"%s\" сохранён."):format(name))
    else
        SetStatus("Не удалось сохранить профиль.", true)
    end
end)

loadButton:SetScript("OnClick", function()
    local name = GetNameFromBox()
    if name == "" then
        SetStatus("Выберите или введите имя профиля.", true)
        return
    end

    local ok, cvarCount, bindCount = PV:LoadProfile(name)
    if ok then
        SetStatus(("Профиль \"%s\" применён (CVars: %d, бинды: %d). Введите /reload."):format(name, cvarCount or 0, bindCount or 0))
    else
        SetStatus(("Профиль \"%s\" не найден."):format(name), true)
    end
end)

deleteButton:SetScript("OnClick", function()
    local name = GetNameFromBox()
    if name == "" then
        SetStatus("Выберите или введите имя профиля.", true)
        return
    end

    if PV:DeleteProfile(name) then
        RefreshList()
        SetStatus(("Профиль \"%s\" удалён."):format(name))
    else
        SetStatus(("Профиль \"%s\" не найден."):format(name), true)
    end
end)

panel:SetScript("OnShow", function()
    PV:EnsureDB()
    RefreshList()
end)

function PV:OpenOptions()
    if Settings and Settings.OpenToCategory and self.OptionsCategory then
        local ok = pcall(Settings.OpenToCategory, self.OptionsCategory:GetID())
        if ok then
            return
        end
    end

    if InterfaceOptionsFrame_OpenToCategory then
        pcall(InterfaceOptionsFrame_OpenToCategory, panel)
    end
end

local function RegisterPanel()
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local ok, category = pcall(Settings.RegisterCanvasLayoutCategory, panel, "Profile Vault")
        if ok and category then
            category.ID = "ProfileVault"
            pcall(Settings.RegisterAddOnCategory, category)
            PV.OptionsCategory = category
            return
        end
    end

    if InterfaceOptions_AddCategory then
        pcall(InterfaceOptions_AddCategory, panel)
    end
end

RegisterPanel()

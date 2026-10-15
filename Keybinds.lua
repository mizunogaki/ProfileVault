local PV = ProfileVault

PV.Keybinds = {}

function PV.Keybinds:BuildSection()
    local section = {}
    local total = GetNumBindings()

    for index = 1, total do
        local command, category, key1, key2 = GetBinding(index)

        if command and command ~= "" then
            section[command] = {
                key1 = key1,
                key2 = key2,
            }
        end
    end

    return section
end

function PV.Keybinds:ClearAll()
    local keys = {}
    local total = GetNumBindings()

    for index = 1, total do
        local command, category, key1, key2 = GetBinding(index)

        if command and command ~= "" then
            if key1 and key1 ~= "" then
                keys[#keys + 1] = key1
            end
            if key2 and key2 ~= "" then
                keys[#keys + 1] = key2
            end
        end
    end

    for _, key in ipairs(keys) do
        pcall(SetBinding, key, nil)
    end
end

function PV.Keybinds:ApplySection(section)
    if not section or next(section) == nil then
        return 0
    end

    self:ClearAll()

    local applied = 0

    for command, keys in pairs(section) do
        if command and command ~= "" and type(keys) == "table" then
            if keys.key1 and keys.key1 ~= "" then
                if pcall(SetBinding, keys.key1, command) then
                    applied = applied + 1
                end
            end

            if keys.key2 and keys.key2 ~= "" then
                if pcall(SetBinding, keys.key2, command) then
                    applied = applied + 1
                end
            end
        end
    end

    SaveBindings(GetCurrentBindingSet())

    return applied
end

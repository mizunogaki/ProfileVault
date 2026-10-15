SLASH_PROFILEVAULT1 = "/pv"

local function PrintHelp()
    print("|cff00ff00ProfileVault:|r")
    print("/pv save <имя> — сохранить текущие настройки в профиль")
    print("/pv load <имя> — применить профиль")
    print("/pv delete <имя> — удалить профиль")
    print("/pv list — список профилей")
    print("/pv ui — открыть панель настроек в разделе «Модификации»")
end

SlashCmdList["PROFILEVAULT"] = function(msg)
    local PV = ProfileVault
    msg = msg or ""

    local command, arg = msg:match("^%s*(%S*)%s*(.-)%s*$")
    command = (command or ""):lower()

    if command == "save" then
        if arg == "" then
            print("|cffff0000ProfileVault:|r укажите имя: /pv save <имя>")
            return
        end

        local ok, err = PV:SaveProfile(arg)
        if ok then
            print(("|cff00ff00ProfileVault:|r профиль \"%s\" сохранён."):format(arg))
        else
            print("|cffff0000ProfileVault:|r не удалось сохранить: " .. tostring(err))
        end

    elseif command == "load" or command == "restore" then
        local name = arg
        if name == "" then
            name = PV:GetLastProfileName()
        end

        if not name then
            print("|cffff0000ProfileVault:|r нет сохранённых профилей.")
            return
        end

        local ok, cvarCount, bindCount = PV:LoadProfile(name)
        if ok then
            print(("|cff00ff00ProfileVault:|r применён профиль \"%s\" (CVars: %d, бинды: %d).")
                :format(name, cvarCount or 0, bindCount or 0))
            print("Для полного применения графики введите /reload (часть настроек требует перезапуска клиента).")
        else
            print(("|cffff0000ProfileVault:|r профиль \"%s\" не найден."):format(name))
        end

    elseif command == "delete" then
        if arg == "" then
            print("|cffff0000ProfileVault:|r укажите имя: /pv delete <имя>")
            return
        end

        if PV:DeleteProfile(arg) then
            print(("|cff00ff00ProfileVault:|r профиль \"%s\" удалён."):format(arg))
        else
            print(("|cffff0000ProfileVault:|r профиль \"%s\" не найден."):format(arg))
        end

    elseif command == "list" then
        local names = PV:GetProfileNames()
        if #names == 0 then
            print("|cff00ff00ProfileVault:|r сохранённых профилей нет.")
        else
            print("|cff00ff00ProfileVault:|r сохранённые профили:")
            for _, name in ipairs(names) do
                print("  - " .. name)
            end
        end

    elseif command == "ui" or command == "options" then
        if PV.OpenOptions then
            PV:OpenOptions()
        else
            print("|cffff0000ProfileVault:|r панель настроек недоступна.")
        end

    else
        PrintHelp()
    end
end

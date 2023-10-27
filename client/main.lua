local QBCore = exports['qb-core']:GetCoreObject()

local function CopyToClipboard(cid)
    SendNUIMessage({
        string = cid
    })
    QBCore.Functions.Notify('ID copied on the Clipboard', "success")
end

RegisterNetEvent('dc-skills:client:copyToClipboard', function(dataType)
    CopyToClipboard(dataType)
end)

RegisterNetEvent('dc-skills:client:openMenu', function(metadata)
    local opzioni = {}
    pData = QBCore.Functions.GetPlayerData()

    opzioni[#opzioni + 1] = {
        title = 'Citizen ID: ' .. pData.citizenid,
        icon = 'circle-info',
        metadata = {
            {label = 'Click', value = 'Copy ID'}
        },
        onSelect = function()
            CopyToClipboard(pData.citizenid)
        end
    }

    opzioni[#opzioni + 1] = {
        title = 'Skill tree',
        icon = 'arrow-down',
        disabled = true
    }

    for k,v in pairs(metadata) do
        local livello = 0
        local metaExp = v.exp

        if metaExp == nil then metaExp = 0 end

        for i = 1, #Config.Levels do
            if metaExp >= Config.Levels[i] then
                livello = i
            end

            if metaExp >= Config.Levels[#Config.Levels] then
                livello = 'MAX'
            end
        end

        local prox
        if livello == 'MAX' then
            prox = '∞'
        else
            prox = livello + 1
        end

        local remaining = Config.Levels[prox] or '∞'
        local oldrank = Config.Levels[livello] or 0
        local percentage = ((metaExp - oldrank) / (remaining - oldrank)) * 100

        opzioni[#opzioni + 1] = {
            title = v.name,
            description = 'Your level: ' .. livello .. ' [EXP: ' .. metaExp .. '/' .. remaining .. ']',
            icon = v.icon,
            progress = percentage,
            colorScheme = '#38D9A9'
        }
    end

    lib.registerContext({
        id = 'menu_skills',
        title = 'Info ' .. pData.charinfo.firstname .. ' ' .. pData.charinfo.lastname,
        options = opzioni
    })

    lib.showContext('menu_skills')
end)

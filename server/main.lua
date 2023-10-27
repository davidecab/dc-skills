local QBCore = exports['qb-core']:GetCoreObject()

lib.addCommand('info', { help = 'Apri informazioni personaggio', restricted = false }, function(source, args, raw)
    local Player = QBCore.Functions.GetPlayer(source)

    local metadata = {}
    for key, meta in pairs(Config.Metadata) do
        metadata[#metadata+1] = {
            exp = Player.Functions.GetMetaData(meta.skill),
            name = meta.name,
            icon = meta.icon
        }
    end

    TriggerClientEvent('u-skills:client:openMenu', source, metadata)
end)

lib.addCommand('addskill', {
    help = 'Aggiunge exp ad una Skill',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Player server ID',
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Nome della Skill',
        },
        {
            name = 'exp',
            type = 'number',
            help = 'Quantità di exp da aggiungere, lascia in bianco per aggiungere 1',
            optional = true,
        },
    },
}, function(source, args, raw)
    local Target = args.target
    local Player = QBCore.Functions.GetPlayer(Target)
    local doesSkillExists = false

    if not Player then return end

    for k,v in pairs(Config.Metadata) do
        if args.skill == v.skill then
            doesSkillExists = true
            break
        end
    end

    if args.skill then
        if doesSkillExists then
            Player.Functions.SetMetaData(args.skill, (Player.Functions.GetMetaData(args.skill) or 0) + args.exp)
            TriggerClientEvent('QBCore:Notify', source, 'Aggiunti ' .. args.exp .. ' punti exp alla skill "' .. args.skill .. '" per il player con ID:' .. args.target, 'success', 7000)
            TriggerClientEvent('QBCore:Notify', args.target, 'Ricevuti ' .. args.exp .. ' punti exp per la skill "' .. args.skill .. '"', 'success', 7000)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Questa skill non esiste', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Skill non specificata', 'error')
    end
end)

lib.addCommand('setskill', {
    help = 'Imposta exp di una Skill',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Player server ID',
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Nome della Skill',
        },
        {
            name = 'exp',
            type = 'number',
            help = 'Quantità di exp da impostare',
        },
    },
}, function(source, args, raw)
    local Target = args.target
    local Player = QBCore.Functions.GetPlayer(Target)
    local doesSkillExists = false

    if not Player then return TriggerClientEvent('QBCore:Notify', source, 'Player offline', 'error') end

    for k,v in pairs(Config.Metadata) do
        if args.skill == v.skill then
            doesSkillExists = true
            break
        end
    end

    if args.skill then
        if doesSkillExists then
            Player.Functions.SetMetaData(args.skill, args.exp)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Questa skill non esiste', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Skill non specificata', 'error')
    end
end)
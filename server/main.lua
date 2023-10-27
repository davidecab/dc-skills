local QBCore = exports['qb-core']:GetCoreObject()

lib.addCommand('info', { help = 'Open skills info', restricted = false }, function(source, args, raw)
    local Player = QBCore.Functions.GetPlayer(source)

    local metadata = {}
    for key, meta in pairs(Config.Metadata) do
        metadata[#metadata+1] = {
            exp = Player.Functions.GetMetaData(meta.skill),
            name = meta.name,
            icon = meta.icon
        }
    end

    TriggerClientEvent('dc-skills:client:openMenu', source, metadata)
end)

lib.addCommand('addskill', {
    help = 'Adds exp to a Skill',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Player server ID',
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Skill name',
        },
        {
            name = 'exp',
            type = 'number',
            help = 'Amount of exp to add, leave blank to add 1',
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
            TriggerClientEvent('QBCore:Notify', source, 'Added ' .. args.exp .. ' exp points to the skill "' .. args.skill .. '" for the player with ID:' .. args.target, 'success', 7000)
            TriggerClientEvent('QBCore:Notify', args.target, 'Received ' .. args.exp .. ' exp points for the skill "' .. args.skill .. '"', 'success', 7000)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Skill does not exist', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'Skill not specified', 'error')
    end
end)

lib.addCommand('setskill', {
    help = 'Set skill exp points',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Player server ID',
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Skill name',
        },
        {
            name = 'exp',
            type = 'number',
            help = 'Amount of exp to set',
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

RPX = exports['rpx-core']:GetObject()

RegisterServerEvent("rpx-appearance:server:saveSkin", function(skin, clothes)
    local src = source
    local Player = RPX.GetPlayer(src)

    if skin == nil then skin = {} end
    if clothes == nil then clothes = {} end

    Player.SetSkinData(skin)
    Player.SetClothesData(clothes)
end)

RegisterServerEvent("rpx-appearance:server:saveOutfit", function(outfitName, skinData)
    local src = source
    local Player = RPX.GetPlayer(src)
    if skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        MySQL.Async.fetchAll('INSERT INTO outfits (citizenid, outfitname, skin, outfitId) VALUES (@citizenid, @outfitname, @skin, @outfitId)', {
            ['@citizenid'] = Player.citizenid,
            ['@outfitname'] = outfitName,
            ['@skin'] = skinData,
            ['@outfitId'] = outfitId
        })
        local result = MySQL.Sync.fetchAll('SELECT * FROM outfits WHERE citizenid = @citizenid', { ['@citizenid'] = Player.citizenid })
        if result[1] ~= nil then
            TriggerClientEvent('rpx-appearance:client:reloadOutfits', src, result)
        else
            TriggerClientEvent('rpx-appearance:client:reloadOutfits', src, nil)
        end
    end
end)

RegisterServerEvent("rpx-appearance:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = RPX.GetPlayer(src)
    MySQL.Async.fetchAll('DELETE outfits (citizenid, outfitname, skin, outfitId) VALUES (@citizenid, @outfitname, @skin, @outfitId)', {
        ['@citizenid'] = Player.citizenid,
        ['@outfitname'] = outfitName,
        ['@skin'] = skinData,
        ['@outfitId'] = outfitId
    })
    local result = MySQL.Sync.fetchAll('SELECT * FROM outfits WHERE citizenid = @citizenid', { ['@citizenid'] = Player.citizenid })
    if result[1] ~= nil then
        TriggerClientEvent('rpx-appearance:client:reloadOutfits', src, result)
    else
        TriggerClientEvent('rpx-appearance:client:reloadOutfits', src, nil)
    end
end)

RegisterServerEvent("rpx-appearance:server:SavedNewPlayerSkin", function()
    local src = source
    local Player = RPX.GetPlayer(src)
    
    TriggerClientEvent("CLIENT:RPX:PlayerLoaded", src)
    TriggerEvent("SERVER:RPX:PlayerLoaded", src, Player)
end)

exports['rpx-core']:CreateCallback('rpx-appearance:server:getOutfits', function(source, cb)
    local Player = RPX.GetPlayer(source)
    local retVal = {}

    local result = MySQL.Sync.fetchAll('SELECT * FROM outfits WHERE citizenid=@citizenid', {['@citizenid'] = Player.citizenid})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            result[k].skin = json.decode(result[k].skin)
            retVal[k] = v
        end
        cb(retVal)
    end
    cb(retVal)
end)

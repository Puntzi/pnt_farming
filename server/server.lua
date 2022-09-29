
if Config.UseOxInventory then
    local ox_inventory = exports.ox_inventory

    RegisterNetEvent('pnt_farming:giveItem', function(item)
        local xPlayer = ESX.GetPlayerFromId(source)
        if ox_inventory:CanCarryItem(source, item, 1) then
            ox_inventory:AddItem(source, item, 1)
        else
            xPlayer.showNotification(_U('cant_carry'))
        end
    end)

    RegisterNetEvent('pnt_farming:processFruit', function(item)
        local xPlayer = ESX.GetPlayerFromId(source)
        if ox_inventory:CanCarryItem(source, Config.ProcessZone.ItemBox) then 
            ox_inventory:AddItem(source, Config.ProcessZone.ItemBox, 1)
            ox_inventory:RemoveItem(source, item, Config.ProcessZone.Quantity)
        else
            xPlayer.showNotification(_U('cant_carry'))
        end
    end)

    RegisterNetEvent('pnt_farming:sellBox', function(price)
        local xPlayer = ESX.GetPlayerFromId(source)
        ox_inventory:RemoveItem(source, Config.ProcessZone.ItemBox, 1)
        ox_inventory:AddItem(source, 'money', price)
    end)
else
    RegisterNetEvent('pnt_farming:giveItem', function(item)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(item, 1) then 
            xPlayer.addInventoryItem(item, 1)
        else 
            xPlayer.showNotification(_U('cant_carry'))
        end
    end)

    RegisterNetEvent('pnt_farming:processFruit', function(item)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(Config.ProcessZone.ItemBox) then 
            xPlayer.addInventoryItem(item, 1)
            xPlayer.removeInventoryItem(item, Config.ProcessZone.Quantity)
        else
            xPlayer.showNotification(_U('cant_carry'))
        end
    end)

    RegisterNetEvent('pnt_farming:sellBox', function(price)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(Config.ProcessZone.ItemBox, 1)
        xPlayer.addMoney(price)
    end)

    ESX.RegisterServerCallback('pnt_farming:hasItem', function(source, cb, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        if item == Config.ProcessZone.ItemBox then 
            if xPlayer.hasItem(item).count >= 1 then 
                return cb(true)
            else
                return xPlayer.showNotification(_U('any_box_to_sell'))
            end
        end
        for i = 1, #item, 1 do 
            local fruit = xPlayer.hasItem(item[i])
            if fruit.count >= Config.ProcessZone.Quantity then
                cb(fruit.name)
                break
            else
                xPlayer.showNotification(_U('not_enough_fruits', ('%s'):format(Config.ProcessZone.Quantity)))
            end
        end
    end)
end

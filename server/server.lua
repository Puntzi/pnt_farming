local ox_inventory = exports.ox_inventory


RegisterNetEvent('pnt_farming:giveItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(item)
    if ox_inventory:CanCarryItem(source, item, 1) then
        ox_inventory:AddItem(source, item, 1, nil, nil)
    else
        xPlayer.showNotification(_U('cant_carry'))
    end
end)
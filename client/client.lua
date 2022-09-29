CreateThread(function()
    for k,v in pairs(Config.Farms) do 
        for i = 1, #v.Zones, 1 do
            local zones = v.Zones[i] 
            local zonesPoints = lib.points.new(zones, Config.DrawDistance, {farm = k})
            function zonesPoints:nearby()
                DrawMarker(Config.MarkerType, self.coords.x, self.coords.y, self.coords.z - 1, 0.0,0.0,0.0, 0.0,0.0,0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                if self.currentDistance < Config.DistanceToInteract then
                    lib.showTextUI(_U('pickup_fruit', ('%s'):format(k)), {
                        position = "right-center",
                        icon = 'hand',
                        style = {
                            borderRadius = 2,
                            backgroundColor = '#48BB78',
                            color = 'white'
                        }
                    })
                    if IsControlJustPressed(0, 38) then
                        if lib.progressCircle({
                            duration = Config.TimeToRecolect,
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                combat = true,
                                car = true,
                            },
                            anim = {
                                dict = 'amb@prop_human_movie_bulb@idle_a',
                                clip = 'idle_a' 
                            },
                        }) then TriggerServerEvent('pnt_farming:giveItem', v.ItemName) else ESX.ShowNotification(_U('canceled')) end
                    end
                else
                    lib.hideTextUI()
                end
            end
        end

        if v.Blip.active then 
            local blip = AddBlipForCoord(v.Blip.coords)

            SetBlipSprite (blip, v.Blip.sprite)
            SetBlipDisplay(blip, v.Blip.display)
            SetBlipScale  (blip, v.Blip.scale)
            SetBlipColour (blip, v.Blip.color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(_U('map_blip', ('%s'):format(k)))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    local processZone = Config.ProcessZone

    if Config.UseOxInventory then 
        for i = 1, #processZone.Zones, 1 do
            local zones = processZone.Zones[i]
            local zonesPoints = lib.points.new(zones, Config.DrawDistance)
            function zonesPoints:nearby()
                if self.currentDistance < Config.DistanceToInteract then
                    lib.showTextUI(_U('interact_process_fruit'))
                    if IsControlJustPressed(0, 38) then 
                        local fruits = exports.ox_inventory:Search('count', processZone.Items)
                        if fruits then
                            for name, count in pairs(fruits) do
                                if count >= Config.ProcessZone.Quantity then
                                    if lib.progressCircle({
                                        duration = Config.TimeToRecolect,
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            move = true,
                                            combat = true,
                                            car = true,
                                        },
                                        anim = {
                                            dict = 'anim@heists@box_carry@',
                                            clip = 'idle' 
                                        },
                                        prop = {
                                            model = 'hei_prop_heist_box',
                                            bone = 60309,
                                            pos = vec3(0.025, 0.08, 0.255),
                                            rot = vec3(-145.0, 290.0, 0.0) 
                                        },
                                    }) then return TriggerServerEvent('pnt_farming:processFruit', name) else return ESX.ShowNotification(_U('canceled')) end
                                else
                                    ESX.ShowNotification(_U('not_enough_fruits', ('%s'):format(Config.ProcessZone.Quantity)))
                                end
                            end
                        end
                    end
                else
                    lib.hideTextUI()
                end
            end
        end
    else 
        for i = 1, #processZone.Zones, 1 do
            local zones = processZone.Zones[i]
            local zonesPoints = lib.points.new(zones, Config.DrawDistance)
            function zonesPoints:nearby()
                if self.currentDistance < Config.DistanceToInteract then
                    lib.showTextUI(_U('interact_process_fruit'))
                    if IsControlJustPressed(0, 38) then
                        ESX.TriggerServerCallback('pnt_farming:hasItem', function(name)
                            if lib.progressCircle({
                                duration = Config.TimeToRecolect,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    combat = true,
                                    car = true,
                                },
                                anim = {
                                    dict = 'anim@heists@box_carry@',
                                    clip = 'idle' 
                                },
                                prop = {
                                    model = 'hei_prop_heist_box',
                                    bone = 60309,
                                    pos = vec3(0.025, 0.08, 0.255),
                                    rot = vec3(-145.0, 290.0, 0.0) 
                                },
                            }) then return TriggerServerEvent('pnt_farming:processFruit', name) else return ESX.ShowNotification(_U('canceled')) end
                        end, processZone.Items)
                    end
                else
                    lib.hideTextUI()
                end
            end
        end
    end


    if processZone.Blip.active then 
        local blip = AddBlipForCoord(processZone.Blip.coords)

        SetBlipSprite (blip, processZone.Blip.sprite)
        SetBlipDisplay(blip, processZone.Blip.display)
        SetBlipScale  (blip, processZone.Blip.scale)
        SetBlipColour (blip, processZone.Blip.color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(_U('process_zone'))
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    for i = 1, #Config.SellZones.Zones, 1 do 
        local sellZones = Config.SellZones.Zones[i]
        local sellZonesPoints = lib.points.new(sellZones, Config.DrawDistance)

        if Config.UseOxInventory then
            function sellZonesPoints:nearby()
                if self.currentDistance < Config.DistanceToInteract then
                    lib.showTextUI(_U('sell_box'))
                    if IsControlJustPressed(0, 38) then 
                        local box = exports.ox_inventory:Search('count', Config.ProcessZone.ItemBox)
                        if box >= 1 then
                            if lib.progressCircle({
                                duration = Config.TimeToRecolect,
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    combat = true,
                                    car = true,
                                },
                                anim = {
                                    dict = 'anim@heists@box_carry@',
                                    clip = 'idle' 
                                },
                                prop = {
                                    model = 'hei_prop_heist_box',
                                    bone = 60309,
                                    pos = vec3(0.025, 0.08, 0.255),
                                    rot = vec3(-145.0, 290.0, 0.0) 
                                },
                            }) then return TriggerServerEvent('pnt_farming:sellBox', sellZones.sellPrice) else return ESX.ShowNotification(_U('canceled')) end
                        else 
                            ESX.ShowNotification(_U('any_box_to_sell'))
                        end
                    end
                else
                    lib.hideTextUI()
                end
            end
        else
            function sellZonesPoints:nearby()
                if self.currentDistance < Config.DistanceToInteract then
                    lib.showTextUI(_U('sell_box'))
                    if IsControlJustPressed(0, 38) then 
                        ESX.TriggerServerCallback('pnt_farming:hasItem', function(hasBox)
                            if hasBox then
                                if lib.progressCircle({
                                    duration = Config.TimeToRecolect,
                                    position = 'bottom',
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        move = true,
                                        combat = true,
                                        car = true,
                                    },
                                    anim = {
                                        dict = 'anim@heists@box_carry@',
                                        clip = 'idle' 
                                    },
                                    prop = {
                                        model = 'hei_prop_heist_box',
                                        bone = 60309,
                                        pos = vec3(0.025, 0.08, 0.255),
                                        rot = vec3(-145.0, 290.0, 0.0) 
                                    },
                                }) then return TriggerServerEvent('pnt_farming:sellBox', sellZones.sellPrice) else return ESX.ShowNotification(_U('canceled')) end
                            end
                        end, Config.ProcessZone.ItemBox)
                    end
                else
                    lib.hideTextUI()
                end
            end
        end
    end

    if Config.SellZones.Blip.active then 
        for i = 1, #Config.SellZones.Zones, 1 do 
            local sellZones = Config.SellZones.Zones[i]
            local blip = AddBlipForCoord(sellZones.coords)

            SetBlipSprite (blip, Config.SellZones.Blip.sprite)
            SetBlipDisplay(blip, Config.SellZones.Blip.display)
            SetBlipScale  (blip, Config.SellZones.Blip.scale)
            SetBlipColour (blip, Config.SellZones.Blip.color)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(_U('sell_zone'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

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
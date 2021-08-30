ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

------------ Création du Menu / Sous Menu -----------

RMenu.Add('example', 'main', RageUI.CreateMenu("Magasin", "Nos Article(s)"))
RMenu:Get('example', 'main'):SetRectangleBanner(0, 0, 0, 255)
RMenu.Add('example', 'boisson', RageUI.CreateSubMenu(RMenu:Get('example', 'main'), "Boisson", "Menu Boisson"))
RMenu.Add('example', 'nourriture', RageUI.CreateSubMenu(RMenu:Get('example', 'main'), "Nourriture", "Menu Nourriture"))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('example', 'main'), true, true, true, function()

            RageUI.Button("Boisson", "Choisi ta Boisson !", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('example', 'boisson'))

            RageUI.Button("Nourriture", "Choisi ta Nourriture !", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('example', 'nourriture'))
            
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('example', 'boisson'), true, true, true, function()

            RageUI.Button("Eau", "OUfff J'avais tres soifff !", {RightLabel = "~g~2$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('akram:BuyEau')
                end
            end)

            RageUI.Button("Coca-Cola", "Coca bien frais Chakal !", {RightLabel = "~g~2$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('akram:BuyCocal')
                end
            end)


        end, function()
        end)

            RageUI.IsVisible(RMenu:Get('example', 'nourriture'), true, true, true, function()

                RageUI.Button("Pain", "Miam Miam C'est bon !", {RightLabel = "~g~2$"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('akram:BuyPain')
                    end
                end)

                RageUI.Button("Hamburger", "Bonne appétit ! ", {RightLabel = "~g~7$"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('akram:BuyHam')
                    end
                end)

        end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)


    


    ---------------------------------------- Position du Menu --------------------------------------------

    local position = {
        {x = 373.875,   y = 325.896,  z = 103.566},
		{x = 2557.458,  y = 382.282,  z = 108.622},
		{x = -3038.939, y = 585.954,  z = 7.908},
		{x = -3241.927, y = 1001.462, z = 12.830},
		{x = 547.431,   y = 2671.710, z = 42.156},
		{x = 1961.464,  y = 3740.672, z = 32.343},
		{x = 2678.916,  y = 3280.671, z = 55.241},
        {x = 1729.216,  y = 6414.131, z = 35.037},
        {x = 1135.808,  y = -982.281,  z = 46.415},
		{x = -1222.915, y = -906.983,  z = 12.326},
		{x = -1487.553, y = -379.107,  z = 40.163},
		{x = -2968.243, y = 390.910,   z = 15.043},
		{x = 1166.024,  y = 2708.930,  z = 38.157},
        {x = 1392.562,  y = 3604.684,  z = 34.980},
        {x = -48.519,   y = -1757.514, z = 29.421},
		{x = 1163.373,  y = -323.801,  z = 69.205},
		{x = -707.501,  y = -914.260,  z = 19.215},
		{x = -1820.523, y = 792.518,   z = 138.118},
		{x = 1698.388,  y = 4924.404,  z = 42.063},
        {x = 25.82,  y = -1345.22,  z = 29.5},
        {x = -864.2,  y = -2409.29,  z = 14.03},
        {x = 967.74,  y = -1867.96,  z = 31.3}
    }    

Citizen.CreateThread(function()
    for k, v in pairs(position) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 52)
        SetBlipScale (blip, 0.6)
        SetBlipColour(blip, 18)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Supérette')
        EndTextCommandSetBlipName(blip)
    end
end) 
    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
              
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 30.0 then
                    DrawMarker(22, position[k].x,position[k].y,position[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 0, 255, 0, 255, 55555, false, true, 2, false, false, false, false)
                end

                if dist <= 1.0 then

                   RageUI.Text({
                        message = "Appuyez sur [~b~E~w~] pour acceder au ~b~Shop",
                        time_display = 1
                    })
                   -- ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour acceder au ~b~Shop")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('example', 'main'), not RageUI.Visible(RMenu:Get('example', 'main')))
                    end
                end
            end
        end
    end)



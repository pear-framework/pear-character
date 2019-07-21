Pear = nil

Citizen.CreateThread(function()
    while not Pear do
        Citizen.Wait(50)

        Pear = exports["pear-core"]:FetchMain()
    end

    if Pear.User.Loaded then
        FetchCharacters()

        DoScreenFadeIn(1000)

        exports["spawnmanager"]:setAutoSpawn(true)
        exports["spawnmanager"]:spawnPlayer()
    end

    -- if Pear.IsCharacterLoaded() then
    --     -- TODO: add ischaracterloaded function()
    --     print("the character is loaded")
    -- end
end)

RegisterNetEvent("pear-core:userLoaded")
AddEventHandler("pear-core:userLoaded", function(userData)
    FetchCharacters()
end)

RegisterNetEvent("pear-character:characterLoaded")
AddEventHandler("pear-character:characterLoaded", function(characterData)
    Pear.CharacterData = characterData
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)

    while true do
        local sleepThread = 500

        if Pear.CharacterData then
            sleepThread = 5

            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            Pear.Draw3DText(pedCoords, "Name: " .. Pear.CharacterData["firstname"] .. " " .. Pear.CharacterData["lastname"])
            Pear.Draw3DText(pedCoords + vector3(0.0, 0.0, 0.3), "Cash: " .. Pear.CharacterData["cash"])
            Pear.Draw3DText(pedCoords + vector3(0.0, 0.0, 0.6), "Bank: " .. Pear.CharacterData["bank"])
            Pear.Draw3DText(pedCoords + vector3(0.0, 0.0, 0.9), "Job: " .. Pear.CharacterData["job"])
            Pear.Draw3DText(pedCoords + vector3(0.0, 0.0, 1.2), "Dateofbirth: " .. Pear.CharacterData["characterId"])
        end

        Citizen.Wait(sleepThread)
    end
end)

RegisterCommand("v", function(src, args)
    local vehicleModel = args[1] or "adder"

    if type(vehicleModel) == "string" then
        vehicleModel = GetHashKey(vehicleModel)
    end

    while not HasModelLoaded(vehicleModel) do
        RequestModel(vehicleModel)

        Citizen.Wait(5)
    end

    local vehicle = CreateVehicle(vehicleModel, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true)

    NetworkFadeInEntity(vehicle, true)

    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
end)

RegisterCommand("dv", function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

    if DoesEntityExist(vehicle) then
        TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
	
        while IsPedInVehicle(PlayerPedId(), vehicle, true) do
            Citizen.Wait(0)
        end

        Citizen.Wait(500)

        NetworkFadeOutEntity(vehicle, true, true)

        Citizen.Wait(100)

        DeleteVehicle(vehicle)
    end
end)
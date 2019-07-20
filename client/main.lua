Pear = nil

Citizen.CreateThread(function()
    while not Pear do
        Citizen.Wait(100)

        Pear = exports["pear-core"]:FetchMain()
    end

    if Pear.User.Loaded then
        FetchCharacters()
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
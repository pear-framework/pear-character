FetchCharacters = function()
    Pear.Callback("pear-character:fetchCharacters", function(charactersFetched)
        if charactersFetched then
            OpenCharacterSelector(charactersFetched)
        end
    end)
end

OpenCharacterSelector = function(characters)
    Pear.Notify("/choosecharacter ",  "(personnummer)")

    for characterIndex = 1, #characters do
        local character = characters[characterIndex]

        if character then
            Pear.Notify(character["firstname"], " ", character["lastname"], " ", character["characterId"])
        end
    end
end
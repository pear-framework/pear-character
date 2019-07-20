FetchCharacters = function()
    Pear.Callback("pear-character:fetchCharacters", function(charactersFetched)
        if charactersFetched then
            OpenCharacterSelector(charactersFetched)
        end
    end)
end

OpenCharacterSelector = function(characters)
    
end
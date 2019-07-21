LoadCharacter = function(source, characterData)
    CachedCharacters[source] = characterData

    TriggerClientEvent("pear-character:characterLoaded", source, characterData)
end
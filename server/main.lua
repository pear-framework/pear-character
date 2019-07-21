Pear = nil
CachedCharacters = {}

TriggerEvent("pear-core:fetchMain", function(library)
    Pear = library
end)

Pear.CreateCallback("pear-character:fetchCharacters", function(source, callback)
    local user = exports["pear-core"]:FetchUser(source)

    if user then
        local query = [[
            SELECT
                *
            FROM
                users_characters
            WHERE
                steamHex = @hex
        ]]

        MySQL.Async.fetchAll(query, {
            ["@hex"] = user["identifier"]
        }, function(response)
            Pear.Log("Fetched all characters with hex:", user["identifier"], "received characters:", json.encode(response))

            callback(response)
        end)
    end
end)

AddEventHandler("playerDropped", function(src)
    if CachedCharacters[src] then
        CachedCharacters[src] = nil
    end
end)

RegisterCommand("createcharacter", function(source, args)
    local user = exports["pear-core"]:FetchUser(source)

    if user then
        local firstname = args[1]
        local lastname = args[2]
        local dateofbirth = args[3]

        if firstname and #firstname > 0 and lastname and #lastname > 0 and dateofbirth and #dateofbirth > 0 then
            local query = [[
                INSERT
                    INTO
                users_characters
                    (steamHex, characterId, firstname, lastname, dateofbirth, lastdigits)
                VALUES
                    (@hex, @cid, @firstname, @lastname, @dob, @lastdigits)
            ]]

            local generatedLastDigits = math.random(1000, 9999)

            Pear.Log(dateofbirth)

            MySQL.Async.execute(query, {
                ["@hex"] = user["identifier"],
                ["@cid"] = dateofbirth .. "-" .. generatedLastDigits,
                ["@firstname"] = firstname,
                ["@lastname"] = lastname,
                ["@dob"] = dateofbirth,
                ["@lastdigits"] = generatedLastDigits
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    Pear.Log("Created character with cid:", dateofbirth .. "-" .. generatedLastDigits, "on hex:", user["identifier"])

                    Pear.Notify(source, "You created: ", firstname, " ", lastname)
                end
            end)
        else
            Pear.Log("Wrong arguments.")

            Pear.Notify(source, "/createcharacter <firstname> <lastname> <dateofbirth (1993-06-16)>")
        end
    else
        Pear.Log("User with source:", source, "could not get fetched?")
    end
end)

RegisterCommand("choosecharacter", function(source, args)
    local user = exports["pear-core"]:FetchUser(source)

    if user then
        local characterId = args[1]

        if #characterId ~= 15 then
            Pear.Log("Wrong character id format.")
    
            return
        end

        local query = [[
            SELECT
                *
            FROM
                users_characters
            WHERE
                characterId = @cid
        ]]

        MySQL.Async.fetchAll(query, {
            ["@cid"] = characterId
        }, function(response)
            if response and #response > 0 then
                local characterData = response[1]

                if characterData["steamHex"] == user["identifier"] then
                    LoadCharacter(source, characterData)
                else
                    Pear.Log("Trying to load someone elses character?")
                end
            end
        end)
    else
        Pear.Log("User with source:", source, "could not get fetched?")
    end
end)
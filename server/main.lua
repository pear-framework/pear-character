local Pear

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

RegisterCommand("createcharacter", function(source, args)
    Pear.Log("test")

    local user = exports["pear-core"]:FetchUser(source)

    Pear.Log(53539)

    if user then
        Pear.Log(2333)

        local firstname = args[1]
        local lastname = args[2]
        local dateofbirth = args[3]

        Pear.Log(1)

        if #firstname > 0 and #lastname > 0 and #dateofbirth > 0 then
            local query = [[
                INSERT
                    INTO
                users_characters
                    (steamHex, characterId, firstname, lastname, dateofbirth, lastdigits)
                VALUES
                    (@hex, @cid, @firstname, @lastname, @dob, @lastdigits)
            ]]

            local generatedLastDigits = math.random(1000, 9999)

            MySQL.Async.execute(query, {
                ["@hex"] = user["identifier"],
                ["@cid"] = dateofbirth .. "-" .. generatedLastDigits,
                ["@firstname"] = firstname,
                ["@lastname"] = lastname,
                ["@dateofbirth"] = dateofbirth,
                ["@lastdigits"] = generatedLastDigits
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    Pear.Log("Created character with cid:", dateofbirth .. "-" .. generatedLastDigits, "on hex:", user["identifier"])

                    Pear.Notify(source, "Du skapade: ", firstname, " ", lastname)
                end
            end)
        end
    else
        Pear.Log("User with source:", source, "could not get fetched?")
    end
end)
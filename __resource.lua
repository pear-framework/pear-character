--[[
    Pear Character 2019
]]--

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
    "config.lua",

    "client/main.lua",
    "client/functions.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",

    "config.lua",
    "server/functions.lua",
    "server/main.lua"
}
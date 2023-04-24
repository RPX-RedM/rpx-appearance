---
--- RPX Appearance - conversion from QBR-Core by Sinatra#0101
--- The RPX framework and its resources are still under heavy development.
--- Bugs and missing features are expected.
---

do
    Config = require 'shared.config'

    if IsDuplicityVersion() then
        -- Server Modules
        require 'server.main'
    else
        -- Client Modules
        require 'client.main'
        require 'client.skin'
    end
end
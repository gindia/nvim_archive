local options = {
   colors = {
        up_to_date = "#3C4048",  -- color for up to date crate
        outdated = "#d19a66",    -- color for outdated crate
    },
    icons = {
        enable = true,           -- whether to enable icons
        style = {
            up_to_date = "|  ", -- text before up to date version
            outdated = "|  ",   -- text before outdated version
        },
    },
    autostart = true,           -- register plugin for autostart
    unstable = false,            -- show unstable versions
}

require('crates').setup(...)

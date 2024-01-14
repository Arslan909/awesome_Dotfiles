local wibox = require("wibox")
local awful = require("awful")

local power_button = wibox.widget {
    {
        widget = wibox.widget.textbox,
        text = "",
        font = "jetBrains Nerd Font Mono 20",
        align = "center",
        valign = "center",
        forced_width = 40,
        forced_height = 10,
        shape = function(cr, width, height)
            gears.shape.rectangle(cr, width, height)
        end,
        bg = "#ff0000",
        fg = "#ffffff",
    },
    widget = wibox.container.background,
    -- bg = "#ff0000",
    -- fg = "#00008b",
    -- fg = "#ff0000",
    fg = "#ff6961",
    bg = "#00000030",
    -- fg = "#ffffff"
}

power_button:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        -- awful.spawn.with_shell("poweroff")
        awful.spawn.with_shell("/home/arslan/.config/awesome/i3lock")
    end
end)

return power_button


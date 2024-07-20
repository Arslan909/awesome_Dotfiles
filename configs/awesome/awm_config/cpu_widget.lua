local wibox = require("wibox")
local vicious = require("vicious")


local cpu_icon = ""

local icon_font_size = 14

local percentage_font_size = 12


local cpu_widget_container = wibox.widget {
    font = "jetBrains Nerd Font " .. icon_font_size,
    markup = '<span color="#FF5656">' .. cpu_icon .. '</span> 00%',
    widget = wibox.widget.textbox
}

-- Update CPU usage percentage
vicious.register(cpu_widget_container, vicious.widgets.cpu,
    function(widget, args)
        return '<span font_desc="jetBrains Nerd Font' .. icon_font_size .. '">' ..
                   cpu_icon .. '</span> ' ..
               '<span font_desc="' .. percentage_font_size .. '">' ..
                   args[1] .. "%" ..
               '</span>'
    end, 2) -- Update every 2 seconds

    cpu_widget_container = wibox.container.margin(cpu_widget_container, 0, 0, 2, 3)

return cpu_widget_container

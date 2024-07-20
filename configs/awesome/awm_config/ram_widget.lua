local wibox = require("wibox")
local vicious = require("vicious")

-- local ram_icon = ""
local ram_icon = "󰘚"


local icon_font_size = 14

-- Font sizes for the percentage values
local percentage_font_size = 12


local ram_widget_container = wibox.widget {
    font = "jetBrains Nerd Font " .. icon_font_size,
    markup = '<span color="#00FF00">' .. ram_icon .. '</span> 00%', -- Initialize with 00% RAM usage
    widget = wibox.widget.textbox
}

-- Update RAM usage percentage
vicious.register(ram_widget_container, vicious.widgets.mem,
    function(widget, args)
        return '<span font_desc="jetBrains Nerd Font ' .. icon_font_size .. '">' ..
                   ram_icon .. '</span> ' ..
               '<span font_desc="' .. percentage_font_size .. '">' ..
                   args[1] .. "%" ..
               '</span>'
    end, 2) -- Update every 2 seconds

    ram_widget_container = wibox.container.margin(ram_widget_container, 0, 0, 2, 3)

return ram_widget_container

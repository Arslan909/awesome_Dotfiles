local awful = require("awful")
local wibox = require("wibox")

local temperature_widget = wibox.widget {
    widget = wibox.widget.textbox,
}

local function update_widget(widget)
    awful.spawn.easy_async('bash -c "sensors | grep temp3"', function(stdout)
        -- Extract the temperature value from the output
        local temperature = stdout:match("temp3:%s+%+(%d+%.%d+)°C")

        -- Update the widget text with the temperature value
        if temperature then
            widget:set_text(temperature .. "°C")
        else
            widget:set_text("N/A")
        end
    end)
end

-- Update the widget initially
update_widget(temperature_widget)

-- Update the widget every 15 seconds
awful.widget.watch('bash -c "sensors | grep temp3"', 10, function(widget, stdout)
    update_widget(widget)
end)

return temperature_widget


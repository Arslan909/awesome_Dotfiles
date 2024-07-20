local wibox = require("wibox")
local awful = require("awful")

color = '#79819d'

local volume_icon = wibox.widget {
    font = "Font Awesome 5 Free Solid 12",
    markup = "<span color= '#79819d'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
}

local volume_widget = wibox.widget {
    {
        volume_icon,
        widget = wibox.container.background,
        forced_height = 40,
        forced_width = 25,
    },
    {
        id = "label",
        widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.horizontal
}

local function update_volume(widget)
    awful.spawn.easy_async_with_shell("amixer sget Master", function(stdout)
        local volume_level = stdout:match("(%d?%d?%d)%%")
        volume_level = tonumber(string.format("% 3d", volume_level))
        local is_muted = stdout:match("%[(o%D%D?)%]")

        local icon_markup = "<span color='#79819d'></span>"
        if is_muted == "off" then
            icon_markup = "<span color='#79819d'></span>"
        elseif volume_level <= 33 then
            icon_markup = "<span color='#79819d'></span>"
        elseif volume_level <= 66 then
            icon_markup = "<span color='#79819d'></span>"
        end

        volume_icon.markup = icon_markup
        widget.label:set_text(volume_level .. "%")
    end)
end

update_volume(volume_widget)

volume_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 4 then -- scroll up
        awful.spawn("amixer set Master 5%+", false)
        update_volume(volume_widget)
    elseif button == 5 then -- scroll down
        awful.spawn("amixer set Master 5%-", false)
        update_volume(volume_widget)
    elseif button == 1 then -- left click
        awful.spawn("amixer set Master toggle", false)
        update_volume(volume_widget)
    end
end)

awful.widget.watch("amixer sget Master", 1, function(widget, stdout)
    update_volume(widget)
end, volume_widget)

return volume_widget

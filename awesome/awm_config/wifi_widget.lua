local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")

local wifi_icon = "直"
local wifi_icon_off = "󰖪"  -- Use the correct icon for WiFi off state
local icon_font_size = 14
local ssid_font_size = 12

-- Function to create and update the WiFi widget
local function create_wifi_widget()
    local wifi_widget_container = wibox.widget {
        font = "Nerd Font " .. icon_font_size,
        markup = '<span color="#00FFFF">' .. wifi_icon .. '</span> N/A', -- Initialize with N/A for WiFi status
        widget = wibox.widget.textbox
    }

    -- Function to toggle WiFi using nmcli
    local function toggle_wifi()
        awful.spawn.easy_async_with_shell(
            "nmcli radio wifi",
            function(stdout, _, _, _)
                if stdout:match("enabled") then
                    awful.spawn("nmcli radio wifi off")
                else
                    awful.spawn("nmcli radio wifi on")
                end
                vicious.force({wifi_widget_container}) -- Force update the widget to reflect WiFi status change
            end
        )
    end

    -- Update WiFi status (assuming you have a network interface named "wlp2s0")
    vicious.register(wifi_widget_container, vicious.widgets.wifi,
        function(widget, args)
            if args["{ssid}"] then
                return '<span font_desc="Nerd Font ' .. icon_font_size .. '">' ..
                           wifi_icon .. '</span> ' ..
                       '<span font_desc="' .. ssid_font_size .. '">' ..
                           args["{ssid}"] ..
                       '</span>'
            else
                return '<span font_desc="Nerd Font ' .. icon_font_size .. '">' ..
                           wifi_icon_off .. '</span> N/A'
            end
        end, 2, "wlp2s0") -- Update every 5 seconds

    -- Add a mouse keybinding (button 1) to toggle WiFi and update the WiFi widget
    wifi_widget_container:buttons(
        awful.button({}, 1, function()
            toggle_wifi()
        end)
    )

    -- Apply margin to the widget container (optional)
    wifi_widget_container = wibox.container.margin(wifi_widget_container, 0, 0, 0, 3)

    return wifi_widget_container
end

return create_wifi_widget()

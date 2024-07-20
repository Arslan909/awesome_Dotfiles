local wibox = require("wibox")
local gears = require("gears")
color = '#79819d'

local battery_widget = wibox.widget {
    {
        font = "jetBrains Nerd Font 12",
        markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰁹</span></span>",
        widget = wibox.widget.textbox,
    },
    {
        id = "text",
        widget = wibox.widget.textbox,
    },
    {
        id = "charging",
        font = "FontAwesome 10",
        markup = "<span color='#0000ff'><span font='FontAwesome 8'></span></span>",
        widget = wibox.widget.textbox,s,
        visible = false,
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = 5
}

function update_battery(widget)
    local f = io.open("/sys/class/power_supply/BAT0/capacity", "r")
    local battery_percentage = f:read("*n")
    f:close()

    local f = io.open("/sys/class/power_supply/BAT0/status", "r")
    local status = f:read("*line")
    f:close()
    
    if battery_percentage <= 0 then
        widget.children[1].markup = "<span color='#ff6961'><span font='jetBrains Nerd Font 12'>󰂎</span></span>"
    elseif battery_percentage <= 20 then
        widget.children[1].markup = "<span color='#ff6961'><span font='jetBrains Nerd Font 12'>󰁻</span></span>"
    elseif battery_percentage <= 50 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰁾</span></span>"
    elseif battery_percentage < 100 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰂁</span></span>"
    elseif battery_percentage >= 100 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰁹</span></span>"
    end

    widget.text:set_text(battery_percentage.."% ")
    
    if status == "Charging" and battery_percentage <= 0 then
        -- widget.charging.visible = true
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰢟 </span></span>"
    elseif status == "Charging" and battery_percentage <= 20 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰂆 </span></span>"
    elseif status == "Charging" and battery_percentage <= 50 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰂈 </span></span>"
    elseif status == "Charging" and battery_percentage < 100 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰂉 </span></span>"
    elseif status == "Charging" and battery_percentage >= 100 then
        widget.children[1].markup = "<span color='#79819d'><span font='jetBrains Nerd Font 12'>󰂅 </span></span>"
    -- else
    --     widget.charging.visible = false
    end
end

update_battery(battery_widget)

local battery_timer = gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        update_battery(battery_widget)
    end
}

battery_widget:connect_signal("mouse::enter", function()
    update_battery(battery_widget)
end)

return battery_widget


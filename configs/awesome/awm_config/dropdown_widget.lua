-- dropdown_widget.lua

local awful = require("awful")
local wibox = require("wibox")

local dropdown_items = {
    "To-Do List",
    "Item 1",
    "Item 2",
    "Item 3",
    -- Add more items here
}

local to_do_list = {
    "Finish project",
    "Study for the exam",
    "Buy groceries",
}

local function show_dropdown()
    local menu_items = {}
    table.insert(menu_items, { "To-Do List", function() edit_todo_list() end })

    for _, item in ipairs(to_do_list) do
        table.insert(menu_items, item)
    end

    awful.menu({ items = menu_items }):toggle()
end

local dropdown_widget = wibox.widget.textbox("Dropdown")

dropdown_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        show_dropdown()
    end
end)

local function edit_todo_list()
    local todo_list_text = table.concat(to_do_list, "\n")
    awful.spawn.easy_async_with_shell("echo -e \"" .. todo_list_text .. "\" | zenity --text-info --editable", function(stdout)
        to_do_list = {}
        for line in stdout:gmatch("[^\r\n]+") do
            table.insert(to_do_list, line)
        end
    end)
end

return dropdown_widget

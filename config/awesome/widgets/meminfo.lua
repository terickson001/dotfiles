local wibox = require("wibox")
local awful = require("awful")

activeram_widget = wibox.widget.textbox()
activeram_widget:set_align("right")

function update_activeram(widget)
    local active
    for line in io.lines('/proc/meminfo') do
        for key, value in string.gmatch(line, "(%w+):\ +(%d+).+") do
            if key == "Active" then active = tonumber(value) end
        end
    end

    widget:set_markup(string.format("%.2fMB",(active/1024)))
end

update_activeram(activeram_widget)

memtimer = timer({ timeout = 10 })
memtimer:connect_signal("timeout", function () update_activeram(activeram_widget) end)
memtimer:start()

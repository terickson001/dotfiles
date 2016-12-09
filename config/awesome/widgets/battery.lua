local wibox = require("wibox")
local awful = require("awful")

local battery_widget= wibox.widget.textbox()
battery_widget:set_align("right")

-- Full:  |██|
-- Empty: |    |
local phases = {' ', '▏', '▎', '▍', '▌', '▋', '▊', '▉'}
phases[0]=''
local fullChar = "█"
local blockCount = 2
local chunkPercent = 1/blockCount

function update_battery(widget)
    local active
    local info = io.popen("/usr/bin/acpi -i", "r"):read("*l")
    for status, percent in info:gmatch("Battery %d: (%a+), (%d+)%%") do
        if status ~= "Full" then
            time = info:match(".* (%d+:%d+:%d+) ")
        elseif percent=="100" then
            widget:set_markup("  100%|<span color='limegreen'>██</span>|")
            return
        end
        percent = tonumber(percent)/100
        fullBlocks = percent//chunkPercent
        partialBlock=math.ceil(percent % chunkPercent / chunkPercent * 8)

        local color = percent > .60 and "limegreen" or (percent > .30 and "yellow" or "red")
        local battery = ""
        for i=1, fullBlocks do
            battery = battery .. fullChar
        end
        battery = battery .. phases[partialBlock]
        widget:set_markup(string.format("  %3.f%%|<span color='%s'>%s</span>|", percent*100, color, battery))
    end
end

update_battery(battery_widget)

local battery_timer = timer({ timeout = .250 })
battery_timer:connect_signal("timeout", function () update_battery(battery_widget) end)
battery_timer:start()

return battery_widget

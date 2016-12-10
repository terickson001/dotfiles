local wibox = require("wibox")
local awful = require("awful")

local battery_widget= wibox.widget.textbox()
battery_widget:set_align("right")

local hasBattery = io.popen("/usr/bin/acpi -b", "r"):read("*l") ~= nil

-- Full:  |██|
-- Empty: |    |
local phases = {' ', '▏', '▎', '▍', '▌', '▋', '▊', '▉'}
phases[0]=''
local fullChar = "█"
local blockCount = 4
local chunkPercent = 1/blockCount

function update_battery(widget)
    if not hasBattery then return nil end

    local info = io.popen("/usr/bin/acpi -b", "r"):read("*l")
    for status, percent in info:gmatch("Battery %d: (%a+), (%d+)%%") do
        if status ~= "Full" then
            time = info:match(".* (%d+:%d+:%d+) ")
            if status == "Charging" then
                statusIndicator = "<span color='limegreen' font='12'>⬆</span>"
            else
                statusIndicator = "<span color='yellow' font='12'>⬇</span>"
            end
        elseif percent=="100" then
            widget:set_markup("  100%|<span color='limegreen'>██</span>| ")
            return
        end
        percent = tonumber(percent)/100
        fullBlocks = percent//chunkPercent
        emptyBlocks = (1-percent)//chunkPercent
        partialBlock=math.ceil(percent % chunkPercent / chunkPercent * 8)

        local color = percent > .60 and "limegreen" or (percent > .30 and "yellow" or "red")
        local full = ""
        for i=1, fullBlocks do
            full = full .. fullChar
        end
        local part = phases[partialBlock]
        local empty = ""
        for i=1, emptyBlocks do
            empty = empty .. phases[1]
        end
        battery = full .. part .. empty
        widget:set_markup(string.format("<span font='Terminess Powerline'>  %3.f%%|<span color='%s'>%s</span>|%s</span>", percent*100, color, battery, statusIndicator))
    end
end

update_battery(battery_widget)

local battery_timer = timer({ timeout = 5 })
battery_timer:connect_signal("timeout", function () update_battery(battery_widget) end)
battery_timer:start()

return battery_widget

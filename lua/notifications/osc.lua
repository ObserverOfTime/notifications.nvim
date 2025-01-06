---Show notification using OSC 777
---@param title string
---@param body string
local function osc_777(title, body)
    local message = '\x1b]777;notify;%s;%s\x1b\\'
    io.stdout:write(message:format(title, body))
end

---Show notification using OSC 99
---@param title string
---@param body string
---@param critical boolean
local function osc_99(title, body, critical)
    local urgency = critical and 2 or 1
    local message = '\x1b]99;i=1:d=0:u=%d;%s\x1b\\'
    io.stdout:write(message:format(urgency, title))
    message = '\x1b]99;i=1:d=1:p=body:u=%d;%s\x1b\\'
    io.stdout:write(message:format(urgency, body))
end

---Show notification using OSC 9
---@param body string
local function osc_9(_, body)
    local message = '\x1b]9;%s\x1b\\'
    io.stdout:write(message:format(body))
end

local M = {
    ['777'] = osc_777,
    ['99'] = osc_99,
    ['9'] = osc_9,
}

setmetatable(M, {
    __index = function(_, k)
        error(('OSC %s is not supported'):format(k))
    end
})

return M

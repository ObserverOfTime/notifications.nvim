local M = {}

local levels = vim.deepcopy(vim.log.levels)
vim.tbl_add_reverse_lookup(levels)

--- @type fun(msg: string, title: string, icon: string, critical: boolean)
local notify
if jit.os == 'Linux' or jit.os == 'BSD' then
    notify = require 'notifications.glib2'
elseif jit.os == 'Windows' then -- TODO: support Windows
    error('Windows is not currently supported')
elseif jit.os == 'OSX' then -- TODO: support macOS
    error('macOS is not currently supported')
else
    error(('Platform "%s" is not supported'):format(jit.os))
end

--- Log level icons
M.icons = {
    TRACE = '',
    DEBUG = '󰠭',
    INFO  = '',
    WARN  = '',
    ERROR = '',
    OFF   = '',
}

--- @class Options
--- @field icon? string
--- @field title? string
--- @field critical? boolean

--- Show a notification on the desktop
--- @param msg string
--- @param level? integer
--- @param opts? Options
--- @see vim.notify
M.notify = function(msg, level, opts)
    opts = opts or {}
    level = level or levels.OFF
    local critical = opts.critical
    if critical == nil then
        critical = level == levels.WARN or level == levels.ERROR
    end
    local icon = opts.icon or M.icons[levels[level]]
    ---@cast levels string[]
    local title = opts.title or levels[level]
    if title == 'OFF' then title = '' end
    notify(msg, title, icon, critical)
end

return M

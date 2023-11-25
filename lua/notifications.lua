local M = {}

local levels = vim.deepcopy(vim.log.levels)
vim.tbl_add_reverse_lookup(levels)

---@type fun(title: string, body: string, critical: boolean)
local notify
if jit.os == 'Linux' or jit.os == 'BSD' then
    notify = require 'notifications.glib2'
elseif jit.os == 'Windows' then
    notify = require 'notifications.powershell'
elseif jit.os == 'OSX' then
    notify = require 'notifications.applescript'
else
    error(('Platform "%s" is not supported'):format(jit.os))
end

local icons
if jit.os == 'Linux' or jit.os == 'BSD' then
    icons = {
        TRACE = ' ',
        DEBUG = '󰠭 ',
        INFO  = ' ',
        WARN  = ' ',
        ERROR = ' ',
        OFF   = ' ',
    }
else
    icons = {
        TRACE = '🔍 ',
        DEBUG = '🐞 ',
        INFO  = '📣 ',
        WARN  = '⚠️  ',
        ERROR = '🚨 ',
        OFF   = '⛔ ',
    }
end

local hl_groups = {
    TRACE = 'DiagnosticFloatingHint',
    DEBUG = 'DiagnosticFloatingHint',
    INFO = 'DiagnosticFloatingInfo',
    WARN = 'DiagnosticFloatingWarn',
    ERROR = 'DiagnosticFloatingError',
    OFF = 'DiagnosticFloatingOk',
}

---Show a notification on the desktop
---@param msg string
---@param level? integer
---@param opts? notifications.NotifyOpts
---@see vim.notify
M.notify = function(msg, level, opts)
    opts = opts or {}
    level = level or levels.OFF
    local critical = opts.critical
    if critical == nil then
        critical = level == levels.WARN or level == levels.ERROR
    end
    local icon = opts.icon or M._icons[levels[level]]
    ---@cast levels string[]
    local title = opts.title or levels[level]

    table.insert(M._history, {
        date = os.date('%T'),
        title = opts.title or '',
        icon = icon,
        level = levels[level],
        body = msg
    })

    if title == 'OFF' then title = '' end
    notify(icon..title, msg, critical)
end

M.show_history = function()
    local ui = vim.api.nvim_list_uis()[1]
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(bufnr, false, {
        title = ' Notifications ',
        title_pos = 'right',
        relative = 'editor',
        anchor = 'SE',
        border = 'rounded',
        style = 'minimal',
        row = ui.height - 2,
        col = ui.width - 1,
        width = math.floor(ui.width * 0.4),
        height = math.floor(ui.height * 0.6)
    })

    for idx, val in ipairs(M._history) do
        local hl_group = M._hl_groups[val.level]
        vim.api.nvim_buf_set_lines(bufnr, idx - 1, idx - 1, false, {
            ('%s %s%s %s: %s'):format(val.date, val.icon, val.level, val.title, val.body)
        })
        vim.api.nvim_buf_add_highlight(bufnr, M._hl_ns, hl_group, idx - 1, 0, -1)
    end
end

---Setup
---@param opts? notifications.SetupOpts
M.setup = function(opts)
    opts = vim.tbl_deep_extend('keep', opts or {}, {
        override_notify = true,
        hist_command = 'Notifications',
        hl_groups = hl_groups,
        icons = icons,
    })
    vim.validate {
        override_notify = {opts.override_notify, 'b'},
        hist_command = {opts.hist_command, 's'},
        hl_groups = {opts.hl_groups, 't'},
        icons = {opts.icons, 't'}
    }

    ---@type notifications.Notification[]
    M._history = {}
    M._icons = opts.icons
    M._hl_groups = opts.hl_groups
    M._hl_ns = vim.api.nvim_create_namespace('notifications')

    if opts.override_notify then
        vim.notify = M.notify
    end

    if opts.hist_command then
        vim.api.nvim_create_user_command(
            opts.hist_command, M.show_history,
            {desc = 'Show notification history'}
        )
    end
end

return M

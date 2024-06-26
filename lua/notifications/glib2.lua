assert(vim.fn.executable('gdbus') == 1, 'Missing glib2 dependency')

---Show notification using glib2
---@param title string
---@param body string
---@param critical boolean
return function(title, body, critical)
    local urgency = critical and 2 or 1
    vim.system {
        'gdbus', 'call', '--session',
        '--dest=org.freedesktop.Notifications',
        '--object-path=/org/freedesktop/Notifications',
        '--method=org.freedesktop.Notifications.Notify',
        '--', 'Neovim', '0', 'neovim', title, body,
        '[]', ('{%s, %s}'):format(
            ('"urgency": <byte %d>'):format(urgency),
            '"desktop-entry": <string "nvim">'
        ), 'int32 -1'
    }
end

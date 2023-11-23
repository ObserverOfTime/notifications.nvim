assert(vim.fn.executable('gdbus') == 1, 'Missing glib2 dependency')

--- Show notification using `glib2`
--- @param msg string
--- @param title string
--- @param icon string
--- @param critical boolean
return function(msg, title, icon, critical)
    local urgency = critical and 2 or 1
    -- TODO: use vim.system in 0.10
    vim.loop.spawn('gdbus', {
        args = {
            'call', '--session',
            '--dest=org.freedesktop.Notifications',
            '--object-path=/org/freedesktop/Notifications',
            '--method=org.freedesktop.Notifications.Notify',
            '--', 'Neovim', '0', 'neovim',
            ('%s %s'):format(icon, title), msg,
            '[]', ('{%s, %s}'):format(
                ('"urgency": <byte %d>'):format(urgency),
                '"desktop-entry": <string "nvim">'
            ), 'int32 -1'
        }
    })
end

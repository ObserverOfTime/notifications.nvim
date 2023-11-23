assert(
    vim.fn.executable('notify-send') == 1,
    'Please install notify-send (libnotify)'
)

--- Show notification using `libnotify`
--- @param msg string
--- @param title string
--- @param icon string
--- @param critical boolean
return function(msg, title, icon, critical)
    -- TODO: use vim.system in 0.10
    vim.loop.spawn('notify-send', {
        args = {
            '-a', 'Neovim', '-i', 'neovim',
            '-h', 'string:desktop-entry:nvim',
            '-u', critical and 'critical' or 'normal',
            ('%s %s'):format(icon, title), msg
        }
    })
end

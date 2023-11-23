-- FIXME: figure out how to set the Neovim icon
local template = [[display notification %q with title "Neovim" subtitle %q]]

---Show notification using AppleScript
---@param title string
---@param body string
return function(title, body)
    -- TODO: use vim.system in 0.10
    vim.loop.spawn('osascript', {
        args = {
            '-e', template:format(title, body)
        }
    })
end

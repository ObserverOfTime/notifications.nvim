-- FIXME: figure out how to set the Neovim icon
local template = [[display notification %q with title "Neovim" subtitle %q]]

---Show notification using AppleScript
---@param title string
---@param body string
return function(title, body)
    vim.system {
        'osascript', '-e', template:format(title, body)
    }
end

# notifications.nvim

Show notifications on the desktop.

## Platforms

* [x] Linux/BSD (glib2)
* [x] Windows (PowerShell)
* [x] macOS (AppleScript)

## Installation

### lazy.nvim

```lua
{
  'ObserverOfTime/notifications.nvim',
  config = function()
    local notifications = require 'notifications'
    vim.notify = notifications.notify
    --[[ Optionally override the icons:
    notifications.icons = {
      TRACE = ' ', -- '🔍 ',
      DEBUG = '󰠭 ', -- '🐞 ',
      INFO  = ' ', -- '📣 ',
      WARN  = ' ', -- '⚠️  ',
      ERROR = ' ', -- '🚨 ',
      OFF   = ' ', -- '⛔ ',
    } --]]
  end,
}
```

## Usage

```lua
vim.notify('Hello world', vim.log.levels.INFO, {
  icon = '󱇎',
  title = 'Test',
  critical = true
})
```

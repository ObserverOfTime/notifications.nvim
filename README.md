# notifications.nvim

Show notifications on the desktop.

## Platforms

* [x] Linux/BSD (requires `glib2`)
* [x] Windows (PowerShell)
* [ ] macOS _(PR welcome)_

## Installation

### lazy.nvim

```lua
{
  'ObserverOfTime/notifications.nvim',
  config = function()
    local notifications = require 'notifications'
    vim.notify = notifications.notify
    --[[ Default icons (Linux only):
    notifications.icons = {
      TRACE = ' ',
      DEBUG = '󰠭 ',
      INFO  = ' ',
      WARN  = ' ',
      ERROR = ' ',
      OFF   = ' ',
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

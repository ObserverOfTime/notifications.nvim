# notifications.nvim

Show notifications on the desktop.

## Platforms

* [x] Linux/BSD (glib2)
* [x] Windows (PowerShell)
* [x] macOS (AppleScript)

_The plugin also supports OSC 777, OSC 99, and OSC 9._

## Installation

### lazy.nvim

```lua
{
  'ObserverOfTime/notifications.nvim',
  opts = {
    override_notify = true,
    hist_command = 'Notifications',
    -- or set `icons = false` to disable all icons
    icons = {
      TRACE = '', -- '🔍',
      DEBUG = '󰠭', -- '🐞',
      INFO  = '', -- '📣',
      WARN  = '', -- '⚠️ ',
      ERROR = '', -- '🚨',
      OFF   = '', -- '⛔',
    },
    hl_groups = {
      TRACE = 'DiagnosticFloatingHint',
      DEBUG = 'DiagnosticFloatingHint',
      INFO = 'DiagnosticFloatingInfo',
      WARN = 'DiagnosticFloatingWarn',
      ERROR = 'DiagnosticFloatingError',
      OFF = 'DiagnosticFloatingOk',
    }
  },
  -- to use OSC 777/99/9:
  --[[
  config = function(_, opts)
    vim.g.nvimcord_use_osc = '777'
    require('nvimcord').setup(opts)
  end
  --]]
}
```

### pckr.nvim

```lua
{
  'ObserverOfTime/notifications.nvim',
  config = function()
    -- to use OSC 777/99/9:
    -- vim.g.nvimcord_use_osc = '777'
    require('notifications').setup {
      ...
    }
  end
}
```

## Usage

### Send a notification

```lua
vim.notify('Hello world', vim.log.levels.INFO, {
  icon = '󱇎',
  title = 'Test',
  critical = true
})
```

### View the history

```vim
:Notifications
```

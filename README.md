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
  opts = {
      override_notify = true,
      hist_command = 'Notifications',
      icons = {
        TRACE = ' ', -- '🔍 ',
        DEBUG = '󰠭 ', -- '🐞 ',
        INFO  = ' ', -- '📣 ',
        WARN  = ' ', -- '⚠️  ',
        ERROR = ' ', -- '🚨 ',
        OFF   = ' ', -- '⛔ ',
    },
    -- or to disable all icons:
    -- icons = false,
    hl_groups = {
      TRACE = 'DiagnosticFloatingHint',
      DEBUG = 'DiagnosticFloatingHint',
      INFO = 'DiagnosticFloatingInfo',
      WARN = 'DiagnosticFloatingWarn',
      ERROR = 'DiagnosticFloatingError',
      OFF = 'DiagnosticFloatingOk',
    }
  }
}
```

### pckr.nvim

```lua
{
  'ObserverOfTime/notifications.nvim',
  config = function()
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

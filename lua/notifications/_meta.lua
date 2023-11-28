---@meta

---@class notifications.Levels
---@field TRACE string
---@field DEBUG string
---@field INFO  string
---@field WARN  string
---@field ERROR string
---@field OFF   string

---@class notifications.Notification
---@field date string
---@field icon string
---@field level string
---@field title string
---@field body string

---@class notifications.NotifyOpts
---@field icon? string
---@field title? string
---@field critical? boolean

---@class notifications.SetupOpts
---@field override_notify boolean Override `vim.notify`
---@field hist_command string|nil The name of the history command
---@field hl_groups notifications.Levels The log level hl groups
---@field icons notifications.Levels|false The log level icons

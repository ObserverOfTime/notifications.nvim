assert(vim.fn.executable('nvim') == 1, 'nvim must be in the PATH')

local template = [[& {
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null;
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null;

$Path = (Get-Item (Get-Command "nvim").Source).Directory.Parent.FullName;
$Icon = "$Path\share\icons\hicolor\128x128\apps\nvim.png";

$Xml = [Windows.Data.Xml.Dom.XmlDocument]::New();
$Xml.LoadXml(@"
<toast activationType="protocol">
  <visual>
    <binding template="ToastGeneric">
      <text hint-maxLines="1">$([Security.SecurityElement]::Escape(%q))</text>
      <text>$([Security.SecurityElement]::Escape(%q))</text>
      <image src="$Icon" placement="appLogoOverride"/>
    </binding>
  </visual>
</toast>
"@);

$Toast = [Windows.UI.Notifications.ToastNotification]::New($Xml);
$Toast.Priority = %d;
$Toast.Tag = "Neovim";
$Toast.Group = "Neovim";

[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Neovim").Show($Toast);
}]]

---Show notification using PowerShell
---@param _ string
---@param title string
---@param body string
---@param critical boolean
return function(_, title, body, critical)
    local priority = critical and 1 or 0
    -- TODO: use vim.system in 0.10
    vim.loop.spawn('powershell', {
        args = {
            '-NoProfile',
            '-Command',
            -- FIXME: nerdfont icons don't work
            template:format(title, body, priority)
        }
    })
end

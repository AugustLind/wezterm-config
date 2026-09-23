local wezterm = require('wezterm')
local mux = wezterm.mux

local M = {}

M.setup = function()
   wezterm.on('gui-startup', function(cmd)
      local _, _, window = mux.spawn_window(cmd or {})
      window:gui_window():maximize()
   end)

   -- `wezterm connect unix` fires gui-attached instead of gui-startup
   wezterm.on('gui-attached', function(domain)
      local workspace = mux.get_active_workspace()
      for _, window in ipairs(mux.all_windows()) do
         if window:get_workspace() == workspace then
            window:gui_window():maximize()
         end
      end
   end)
end

return M

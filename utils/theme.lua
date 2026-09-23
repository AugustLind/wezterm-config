local wezterm = require('wezterm')

local M = {}

M.state_file = wezterm.config_dir .. '/state/theme'

---Read the persisted theme mode ('dark' | 'light'). Defaults to 'dark'.
---@return 'dark' | 'light'
function M.mode()
   local f = io.open(M.state_file, 'r')
   if not f then
      return 'dark'
   end
   local contents = f:read('*a')
   f:close()
   contents = contents:gsub('%s+', '')
   if contents == 'light' then
      return 'light'
   end
   return 'dark'
end

---@return boolean
function M.is_light()
   return M.mode() == 'light'
end

---Get the colorscheme table for the current mode.
function M.colors()
   if M.is_light() then
      return require('colors.custom_light')
   end
   return require('colors.custom')
end

return M

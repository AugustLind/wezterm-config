local wezterm = require('wezterm')
local platform = require('utils.platform')

-- local font_family = 'Maple Mono NF'
local font_family = 'JetBrainsMono Nerd Font'
-- local font_family = 'CartographCF Nerd Font'

local font_size = platform.is_mac and 12 or 9.75

---@type Config
return {
   font = wezterm.font_with_fallback({
      { family = font_family, weight = 'Medium' },
      'Noto Sans NKo', -- covers U+07FF, which some TUIs emit
   }),
   font_size = font_size,
   -- stray rare codepoints (U+07FF, U+20C1...) kept triggering popups; placeholders are fine
   warn_about_missing_glyphs = false,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}

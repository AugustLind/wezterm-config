-- A slightly altered version of catppuccin latte (light mode counterpart to `custom.lua`)
-- stylua: ignore
local latte = {
   rosewater = '#dc8a78',
   flamingo  = '#dd7878',
   pink      = '#ea76cb',
   mauve     = '#8839ef',
   red       = '#d20f39',
   maroon    = '#e64553',
   peach     = '#fe640b',
   yellow    = '#df8e1d',
   green     = '#40a02b',
   teal      = '#179299',
   sky       = '#04a5e5',
   sapphire  = '#209fb5',
   blue      = '#1e66f5',
   lavender  = '#7287fd',
   text      = '#4c4f69',
   subtext1  = '#5c5f77',
   subtext0  = '#6c6f85',
   overlay2  = '#7c7f93',
   overlay1  = '#8c8fa1',
   overlay0  = '#9ca0b0',
   surface2  = '#acb0be',
   surface1  = '#bcc0cc',
   surface0  = '#ccd0da',
   base      = '#eff1f5',
   mantle    = '#e6e9ef',
   crust     = '#dce0e8',
}

local colorscheme = {
   foreground = latte.text,
   background = latte.base,
   cursor_bg = latte.rosewater,
   cursor_border = latte.rosewater,
   cursor_fg = latte.crust,
   selection_bg = latte.surface2,
   selection_fg = latte.text,
   ansi = {
      latte.subtext1, -- black
      latte.red, -- red
      latte.green, -- green
      latte.yellow, -- yellow
      latte.blue, -- blue
      latte.pink, -- magenta/purple
      latte.teal, -- cyan
      latte.surface2, -- white
   },
   brights = {
      latte.subtext0, -- black
      latte.red, -- red
      latte.green, -- green
      latte.yellow, -- yellow
      latte.blue, -- blue
      latte.pink, -- magenta/purple
      latte.teal, -- cyan
      latte.surface1, -- white
   },
   tab_bar = {
      background = 'rgba(255, 255, 255, 0.4)',
      active_tab = {
         bg_color = latte.surface2,
         fg_color = latte.text,
      },
      inactive_tab = {
         bg_color = latte.surface0,
         fg_color = latte.subtext1,
      },
      inactive_tab_hover = {
         bg_color = latte.surface0,
         fg_color = latte.text,
      },
      new_tab = {
         bg_color = latte.base,
         fg_color = latte.text,
      },
      new_tab_hover = {
         bg_color = latte.mantle,
         fg_color = latte.text,
         italic = true,
      },
   },
   visual_bell = latte.red,
   indexed = {
      [16] = latte.peach,
      [17] = latte.rosewater,
   },
   scrollbar_thumb = latte.surface2,
   split = latte.overlay0,
   compose_cursor = latte.flamingo,
}

return colorscheme

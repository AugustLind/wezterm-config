# August's WezTerm config

Personal, Linux-focused [WezTerm](https://wezfurlong.org/wezterm/) configuration based on
[KevinSilvester/wezterm-config](https://github.com/KevinSilvester/wezterm-config).
The upstream MIT license and copyright are preserved in [LICENSE](LICENSE).

## Current behavior

- OpenGL rendering, 60 fps, a steady cursor, 5,000 lines of scrollback, and a status refresh every five seconds.
- Background images are off at startup; image selection and focus-mode shortcuts remain available.
- Linux uses XWayland (`enable_wayland = false`) and `TITLE|RESIZE` decorations for a native titlebar in the author's GNOME setup.
- Tabs start directly rather than attaching to a background mux server. Automatic persistent sessions were disabled because of observed input latency.
- JetBrainsMono Nerd Font Medium, with Noto Sans NKo as an additional fallback. Missing-glyph warnings are disabled; unsupported characters may still render as placeholders.
- Light and dark themes, with the selected mode stored locally in `state/theme`.

Closing windows does not preserve shells through a background mux server by default.
Pane and tab close shortcuts do not ask for confirmation.

## Installation

Back up an existing `~/.config/wezterm` before cloning into that location.
Once this repository is public, the HTTPS URL works without a GitHub SSH key:

```bash
git clone https://github.com/AugustLind/wezterm-config.git ~/.config/wezterm
bash ~/.config/wezterm/install.sh
```

Install WezTerm and JetBrainsMono Nerd Font separately, or use the helper's
Debian/Ubuntu-style APT installation path:

```bash
bash ~/.config/wezterm/install.sh --all
```

`--all` downloads the Nerd Font and can install WezTerm nightly from the WezTerm
APT repository using `sudo`. It requires tools including `curl`, `gpg`, `tar`,
and Fontconfig. Its version check currently recognizes `wezterm 2026...` builds;
review the script if using another release. It does not install Noto Sans NKo;
install that fallback through your distribution's font packages if needed.

Without `--all`, the helper creates the local state directory and installs a
per-user desktop launcher override when the system desktop file is available.
If invoked from a different checkout location, it links that checkout into
`~/.config/wezterm`, backing up an existing real directory first.
The launcher uses `wezterm start --cwd .`, matching direct startup in the config.
Save work before closing and reopening WezTerm after installation.

This fork is tailored to Linux. Windows and macOS branches remain from upstream
and need customization; the installer is Linux-specific. Use the
[official installation instructions](https://wezfurlong.org/wezterm/installation.html)
for other platforms.

## Customize for your machine

| File | Settings |
|---|---|
| [config/appearance.lua](config/appearance.lua) | Renderer, frame rate, titlebar, Wayland, background, and window appearance |
| [config/fonts.lua](config/fonts.lua) | Font family, fallback, size, and missing-glyph warnings |
| [config/launch.lua](config/launch.lua) | Default shell and launcher entries |
| [config/domains.lua](config/domains.lua) | SSH, WSL, and optional Unix mux domains |
| [config/bindings.lua](config/bindings.lua) | Keyboard and mouse bindings |
| [config/general.lua](config/general.lua) | Scrollback and other general behavior |
| [utils/theme.lua](utils/theme.lua) | Local theme state and palette selection |

Linux defaults to `bash -l`. The macOS shell paths assume Homebrew under
`/opt/homebrew`. Windows entries include upstream example usernames (`kevin`),
WSL distributions, and a Git Bash path; replace those before using them.
The SSH/WSL entries are examples, not credentials for a shared machine.

### Theme

Write `light` or `dark` to the local state file:

```bash
mkdir -p ~/.config/wezterm/state
printf '%s\n' light > ~/.config/wezterm/state/theme
# Use dark instead of light to switch back.
```

The config watches this file for reloads. Dark is the default when no valid mode
is stored. `/state/` is ignored by Git.

### Optional persistent sessions

Direct startup is the default. To opt into a background mux server, enable the
commented `unix_domains` and `default_gui_startup_args` settings in
[config/domains.lua](config/domains.lua), then start with `wezterm connect unix`.
If you also want the desktop launcher to attach, update its per-user `Exec=`
entry to match. `install.sh` restores direct startup when run again.

Mux sessions can keep shells running after a GUI disconnect. Their lifecycle
and input behavior differ from direct startup, so save work before changing modes.

## Useful shortcuts

On Linux/Windows, `SUPER` below means **Alt**, and `SUPER_REV` means **Alt+Ctrl**.
On macOS, they mean **Command** and **Command+Ctrl**. The leader key is
`SUPER_REV+Space`.

| Key | Action |
|---|---|
| `F1` | Copy mode |
| `F2` | Command palette |
| `F3` / `F4` / `F5` | Launcher / tabs / workspaces |
| `F11` / `F12` | Full screen / debug overlay |
| `Ctrl+Shift+c` / `Ctrl+Shift+v` | Copy / paste |
| `SUPER+f` | Search terminal text |
| `SUPER+t` | New tab in the default domain |
| `SUPER_REV+t` | New tab in the current pane's domain |
| `SUPER+[` / `SUPER+]` | Previous / next tab |
| `SUPER_REV+[` / `SUPER_REV+]` | Move tab left / right |
| `SUPER_REV+w` | Close current tab without confirmation |
| `SUPER+n` | New window |
| `SUPER_REV+Enter` | Maximize window |
| `SUPER+Enter` | Toggle pane zoom |
| `SUPER+w` | Close pane without confirmation |
| `SUPER+\` / `SUPER_REV+\` | Split vertically / horizontally |
| `SUPER_REV+h/j/k/l` | Move between panes |
| `SUPER+9` | Toggle tab bar |
| `SUPER+0` / `SUPER_REV+0` | Rename / reset tab title |
| `SUPER+b` | Toggle background focus mode |
| `SUPER+/` | Random background image |
| `SUPER+,` / `SUPER+.` | Previous / next background image |
| `SUPER_REV+/` | Choose background image |
| `LEADER+f` / `LEADER+p` | Font / pane resizing key table |

The full definitions, including resize-table controls, are in
[config/bindings.lua](config/bindings.lua).

## Troubleshooting

- **Titlebar or window behavior:** the config disables native Wayland. Review
  `enable_wayland` and `window_decorations` for your compositor; XWayland must
  be available when running under a Wayland desktop with these defaults.
- **Launcher still attaches to old mux sessions:** rerun the updated installer
  or inspect `~/.local/share/applications/org.wezfurlong.wezterm.desktop`.
  Existing mux shells are not stopped by this configuration change.
- **Input latency:** confirm startup is direct and that an older desktop
  launcher is not still running `wezterm connect unix`.
- **Missing characters:** check the installed fonts and fallback in
  `config/fonts.lua`. Set `warn_about_missing_glyphs = true` while investigating.
- **No background image:** images are disabled at startup. Use focus-mode and
  image-selection shortcuts; the image directory is configured through
  `utils/backdrops.lua` and `wezterm.lua`.
- **Configuration errors:** use `F12` for WezTerm's debug overlay and check
  referenced shell paths and installed fonts.

## Repository notes

[wezterm.lua](wezterm.lua) loads the configuration modules and event handlers.
The `colors/`, `events/`, and `utils/` directories contain palettes, UI behavior,
and helpers. Screenshots under `.github/screenshots/` are inherited upstream
examples and may differ from this fork's defaults.

Machine-local theme state is ignored. Review your own added hostnames, paths,
images, and commit history before publishing a customized fork.

## Credits and license

Based on Kevin Silvester's WezTerm configuration, with personal changes by August.
Distributed under the [MIT license](LICENSE). Upstream references include
[Catppuccin](https://github.com/catppuccin/wezterm) and
[lume](https://github.com/rxi/lume).

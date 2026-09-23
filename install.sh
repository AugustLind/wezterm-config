#!/usr/bin/env bash
# Set up this WezTerm config on a new Linux machine.
#   git clone git@github.com:AugustLind/wezterm-config.git ~/.config/wezterm
#   ~/.config/wezterm/install.sh            # config + launcher only
#   ~/.config/wezterm/install.sh --all      # also install WezTerm nightly + JetBrainsMono Nerd Font
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$CONFIG_DIR" != "$HOME/.config/wezterm" ]]; then
   echo "Linking $CONFIG_DIR -> ~/.config/wezterm"
   if [[ -e "$HOME/.config/wezterm" && ! -L "$HOME/.config/wezterm" ]]; then
      mv "$HOME/.config/wezterm" "$HOME/.config/wezterm.bak.$(date +%s)"
   fi
   mkdir -p "$HOME/.config"
   ln -sfn "$CONFIG_DIR" "$HOME/.config/wezterm"
fi

mkdir -p "$CONFIG_DIR/state"

if [[ "${1:-}" == "--all" ]]; then
   if ! command -v wezterm >/dev/null || ! wezterm --version | grep -q '^wezterm 2026'; then
      echo "== Installing WezTerm nightly (needs sudo) =="
      curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
      echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
         | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
      sudo apt-get update
      sudo apt-get install -y wezterm-nightly
   fi

   if ! fc-list | grep -qi 'JetBrainsMono Nerd'; then
      echo "== Installing JetBrainsMono Nerd Font =="
      tmp="$(mktemp -d)"
      curl -fsSL -o "$tmp/font.tar.xz" \
         https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
      mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
      tar -xf "$tmp/font.tar.xz" -C "$HOME/.local/share/fonts/JetBrainsMono"
      fc-cache -f >/dev/null
      rm -rf "$tmp"
   fi
fi

# Launcher override: open WezTerm attached to the persistent unix-domain mux
desktop=/usr/share/applications/org.wezfurlong.wezterm.desktop
if [[ -f "$desktop" ]]; then
   echo "== Installing launcher override (wezterm connect unix) =="
   mkdir -p "$HOME/.local/share/applications"
   sed 's|^Exec=wezterm start --cwd \.|Exec=wezterm connect unix|' "$desktop" \
      > "$HOME/.local/share/applications/org.wezfurlong.wezterm.desktop"
else
   echo "WezTerm launcher not found; skipping launcher override (install WezTerm first or use --all)."
fi

echo "Done. Close all WezTerm windows (and run 'pkill wezterm-mux') then reopen WezTerm."

<div align="center">

### ~/. my dotfiles ~/. :house:&nbsp;

#### \> Managed with dotbot :robot:&nbsp;

</div>

## Setup

### Requirements

- CachyOS with Niri and Fish already initialized, so that
  `~/.config/niri/config.kdl` and `~/.config/fish/config.fish` exist.
- `git`, `jq`, `niri`, `foot`, `kitty`, `fish`, `starship`, `pfetch`,
  `noctalia-shell`, `noctalia-qs`, `brave-bin`, and `ttf-hack-nerd`.
- Start Noctalia at least once before installing so that it creates
  `~/.config/noctalia/settings.json`.

Run the CachyOS installer:

```bash
bash install.sh
```

The script initializes Dotbot when needed and installs the Niri, Fish, Foot,
Kitty and Starship configuration. It also sets Foot as Noctalia's terminal and
adds it to the launcher without replacing your other pinned apps. Restart
Noctalia after installation if it was already running.

<div align="center">

### ~/. my dotfiles ~/. :house:&nbsp;

#### \> Managed with dotbot :robot:&nbsp;

</div>

## Setup

### Requisitos

- CachyOS con Niri y Fish ya inicializados, de modo que existan
  `~/.config/niri/config.kdl` y `~/.config/fish/config.fish`.
- `git`, `jq`, `niri`, `foot`, `kitty`, `fish`, `starship`, `pfetch`,
  `noctalia-shell`, `noctalia-qs`, `brave-bin` y `ttf-hack-nerd`.
- Abre Noctalia al menos una vez antes de instalar para que cree
  `~/.config/noctalia/settings.json`.

Run the CachyOS installer:

```bash
bash install.sh
```

The script initializes Dotbot when needed and installs the Niri, Fish, Foot,
Kitty and Starship configuration. It also sets Foot as Noctalia's terminal and
adds it to the launcher without replacing your other pinned apps. Restart
Noctalia after installation if it was already running.

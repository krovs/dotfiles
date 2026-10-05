<div align="center">

### ~/. my dotfiles ~/. :house:&nbsp;

#### \> Managed with dotbot :robot:&nbsp;

</div>

## Setup

### Requirements

- CachyOS with Niri and Fish already initialized, so that
  `~/.config/niri/config.kdl` and `~/.config/fish/config.fish` exist.
- Niri 26.04 or later and Noctalia 5 or later, provided by the CachyOS Niri
  desktop installation.
- `git`, `python`, `foot`, `kitty`, `fish`, `starship`, and Nerd Fonts.

Run the CachyOS installer:

```bash
bash install.sh
```

The script initializes Dotbot when needed and links the Niri, Noctalia, Fish,
Foot, Kitty and Starship configuration. It adds the Niri `custom.kdl` include,
sets Foot as the default terminal, and validates Niri and Noctalia.

Noctalia uses a single `~/.config/noctalia/config.toml`, linked to the exported
configuration in this repository. The same configuration is used on desktop
and work laptop. Wallpaper files remain local; paths use `~` for the current
user's home directory. Calendar accounts are configured locally and are not
included in this public repository.

Changes made through Noctalia's interface are saved in
`~/.local/state/noctalia/settings.toml` and take priority over these files.
Use **Export Config → Merged User Config** to save a new design, remove any
private account information, and replace `.config/noctalia/config.toml`.
No splitting into multiple files is required.
Log out and back in after the first installation so Noctalia inherits Niri's
terminal environment.

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
sets Kitty as the default terminal, and validates Niri and Noctalia. It loads
the pfetch greeting and Starship at the end of Fish initialization so that
the CachyOS configuration does not override them.

## Fish configuration

`install.sh` installs missing Fish dependencies with Pacman (using sudo),
then downloads the plugins declared in `.config/fish/fish_plugins` with Fisher.
When dependencies are missing, Pacman refreshes its databases and upgrades the
system in the same transaction (`-Syu --needed`) to avoid stale package URLs.
Downloaded plugins live under Fish's user data directory (`~/.local/share/fish/plugins`
by default), outside this repository. Run the installer again to update them.
Git, AWS CLI v2 and kubectl are required for their respective integrations.
The dependency installer upgrades AWS CLI v1 to v2 for SSO and profile listing.

| Plugin or functionality | What it does | Commands and shortcuts |
| --- | --- | --- |
| Fisher | Manages the plugins declared in `fish_plugins` | `fisher list`, `fisher update` |
| Git shortcuts | Expands shortcuts for common Git commands | `gss` → `git status -s`; `gd` → `git diff`; `gco branch` → `git checkout branch`; `gp` → `git push` |
| zoxide | Remembers visited directories and jumps to matching paths | `z terraform`; `zi` opens an interactive directory picker |
| fzf history | Searches previous commands | `Ctrl+R` |
| fzf files | Finds files and directories with previews | `Ctrl+Alt+F` |
| fzf Git commits | Searches commit history | `Ctrl+Alt+L` |
| fzf Git changes | Searches changed files | `Ctrl+Alt+S` |
| fzf processes | Searches running processes and inserts a process ID | `Ctrl+Alt+P` |
| fzf variables | Searches shell variables | `Ctrl+V` |
| AWS profiles | Selects a profile from `.aws/config`, including SSO profiles, for the current shell | `asp` opens a picker; `asp profile-name` selects directly |
| AWS SSO | Logs in using the selected profile | `awsl` → `aws sso login` |
| AWS completion | Completes services, commands and options using `aws_completer` | Type `aws ec2 describe-` and press `Tab` |
| Kubernetes completion | Completes kubectl commands and resource names | `k` → `kubectl`; press `Tab` to complete |
| Kubernetes contexts | Switches the selected context or namespace | `kctx` → `kubectx`; `kns` → `kubens`; run either without arguments for a picker |
| Kubernetes resources | Lists pods, services and nodes | `kgp` → `kubectl get pods`; `kgs` → `kubectl get services`; `kgn` → `kubectl get nodes` |
| Kubernetes troubleshooting | Describes pods, reads logs and runs commands inside containers | `kdp pod` → `kubectl describe pod pod`; `kl pod` → `kubectl logs pod`; `ke pod -- sh` → `kubectl exec -it pod -- sh` |
| Terraform shortcuts | Expands common Terraform commands | `tf` → `terraform`; `tfi` → `terraform init`; `tfp` → `terraform plan`; `tfv` → `terraform validate` |
| direnv | Loads project environment variables on entry and restores them on exit | Create `.envrc`, then run `direnv allow` |
| autopair | Automatically closes quotes, parentheses and brackets | Works while typing commands |
| done | Sends a notification when a long command finishes | Works automatically |

Abbreviations expand when you press Space or Enter. Kubernetes resource completion
requires access to the selected cluster. The fzf file picker uses `fd` for file
searches and `bat` for previews.

zoxide learns directories as you visit them. For example, run `cd ~/Projects/my-project`,
then `cd ~`; afterwards, `z my-project` can jump back and `zi` can offer it in the picker.

AWS profiles come from `aws configure list-profiles`. Existing environment
credentials can take precedence over the selected profile. To load a profile
automatically for a project, create an `.envrc`:

```bash
export AWS_PROFILE=dev
export AWS_REGION=eu-west-1
```

Replace `dev` with one of your profiles and run `direnv allow` in that directory.
For SSO profiles, use `awsl` to log in.

The Starship Kubernetes segment appears only in directories containing Helm,
Kustomize, Skaffold or Helmfile files, a `kubernetes`, `k8s`, `helm` or `charts`
folder, or a `.kubernetes` marker file. It shows the current kubectl context.
Starship's own command notifications are disabled so that done handles them.

Open a new Fish session after installation. AWS configuration and credentials,
Kubernetes configuration, directory history and project environment files stay
local to each machine.

Noctalia uses a single `~/.config/noctalia/config.toml`, linked to the exported
configuration in this repository. The same configuration is used on all
machines. Wallpaper files remain local; paths use `~` for the current
user's home directory. Calendar accounts are configured locally and are not
included in this public repository.

Changes made through Noctalia's interface are saved in
`~/.local/state/noctalia/settings.toml` and take priority over these files.
Use **Export Config → Merged User Config** to save a new design, remove any
private account information, and replace `.config/noctalia/config.toml`.
No splitting into multiple files is required.
Log out and back in after the first installation so Noctalia inherits Niri's
terminal environment.

Kitty uses Fish and opens with one terminal pane filling the window. The
`splits` layout controls how additional panes are arranged; it does not create
them at startup. `Ctrl+Shift+Enter` adds a pane and chooses the split direction
automatically; `Ctrl+Shift+\` adds a side-by-side pane and `Ctrl+Shift+-` adds
a pane above/below. New panes start in the current
working directory. `Ctrl+Shift+Z` toggles a focused panel view (stack layout).
`Mod+Return` opens Kitty. Log out and back in to update the terminal environment
for Noctalia and other running applications.

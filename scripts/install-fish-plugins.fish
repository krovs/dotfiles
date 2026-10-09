#!/usr/bin/env fish
# Run after Dotbot has linked fish_plugins and conf.d.
source (path dirname (status filename))/../.config/fish/conf.d/00-plugins.fish

set -l wanted_plugins (string match -r '^[^\s]+$' < $__fish_config_dir/fish_plugins)
if not functions -q fisher
    set -l bootstrap (command mktemp)
    command curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o $bootstrap
    set -l download_status $status
    if test $download_status -ne 0
        command rm -f $bootstrap
        exit $download_status
    end
    source $bootstrap
    command rm -f $bootstrap
end

fisher update
# Keep the declaration intact if Fisher drops a plugin after a failed download.
printf '%s\n' $wanted_plugins > $__fish_config_dir/fish_plugins
# Fisher can return success even when a download fails; verify each plugin.
for plugin in $wanted_plugins
    if not contains -- (string lower -- $plugin) $_fisher_plugins
        printf 'Missing Fish plugin: %s. Run the installer again.\n' $plugin >&2
        exit 1
    end
end

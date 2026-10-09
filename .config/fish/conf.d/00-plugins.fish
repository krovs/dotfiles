# Keep downloaded plugins outside the versioned configuration.
set -g fisher_path $__fish_user_data_dir/plugins
if not contains -- $fisher_path/functions $fish_function_path
    set -p fish_function_path $fisher_path/functions
end
if not contains -- $fisher_path/completions $fish_complete_path
    set -p fish_complete_path $fisher_path/completions
end

if status is-interactive
    for plugin_config in $fisher_path/conf.d/*.fish
        source $plugin_config
    end
end

# Shared integrations for every machine using these dotfiles.
status is-interactive; or return

if command -q zoxide
    zoxide init fish | source
end
if command -q direnv
    direnv hook fish | source
end
if command -q kubectl
    kubectl completion fish | source
end

# Use the installed AWS CLI's completion data, including new services.
if command -q aws_completer
    function __dotfiles_aws_complete
        set -lx COMP_LINE (commandline -cp)
        set -lx COMP_POINT (string length -- "$COMP_LINE")
        command aws_completer 2>/dev/null
    end
    complete -c aws -f -a '(__dotfiles_aws_complete)'
end
complete -c asp -f -a '(command aws configure list-profiles 2>/dev/null)'

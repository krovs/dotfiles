function asp --description 'Select an AWS profile from config, including SSO profiles'
    if test (count $argv) -gt 1
        printf 'Usage: asp [profile]\n' >&2
        return 2
    end
    if not command -q aws
        printf 'asp: AWS CLI is not installed.\n' >&2
        return 1
    end
    if not string match -q 'aws-cli/2.*' -- (command aws --version 2>&1)
        printf 'asp: AWS CLI v2 is required for profile selection and SSO. Run bash scripts/install-fish-tools.sh from your dotfiles.\n' >&2
        return 1
    end

    set -l profiles (command aws configure list-profiles)
    set -l aws_status $status
    test $aws_status -eq 0; or return $aws_status
    if test (count $profiles) -eq 0
        printf 'asp: No AWS profiles configured.\n' >&2
        return 1
    end

    set -l profile $argv[1]
    if test (count $argv) -eq 0
        if not command -q fzf
            printf 'asp: Install fzf or use asp <profile>.\n' >&2
            return 1
        end
        set profile (printf '%s\n' $profiles | fzf --prompt='AWS profile > ' --height=40% --reverse)
        set -l selection_status $status
        test $selection_status -eq 0; or return $selection_status
    end
    if not contains -- "$profile" $profiles
        printf 'asp: Unknown AWS profile: %s\n' "$profile" >&2
        return 1
    end

    set -gx AWS_PROFILE "$profile"
    printf 'AWS_PROFILE=%s\n' "$AWS_PROFILE"
end

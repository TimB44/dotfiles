function mrt --argument-names repo_path
    if test -z "$repo_path"
        echo "Usage: mrt <repo[/subdir]>"
        return 1
    end

    set -l dir "$HOME/lucid/$repo_path"
    if not test -d "$dir"
        echo "repo not found: $dir"
        return 1
    end

    set -l git_root (git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
    if test -z "$git_root"
        echo "not a git repository: $dir"
        return 1
    end
    set -l name (basename "$git_root")

    if not tmux has-session -t "$name" 2>/dev/null
        tmux new-session -d -s "$name" -c "$dir"
    end

    if set -q TMUX
        tmux switch-client -t "$name"
    else
        tmux attach-session -t "$name"
    end
end

function __mrt_complete
    set -l token (commandline -ct)
    set -l saved_pwd $PWD
    builtin cd "$HOME/lucid"
    complete -C"cd $token"
    builtin cd "$saved_pwd"
end

complete -c mrt -f -a "(__mrt_complete)"

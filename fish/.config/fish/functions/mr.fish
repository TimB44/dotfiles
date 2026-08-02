function mr --argument-names repo_path
    if test -z "$repo_path"
        echo "Usage: mr <repo[/subdir]>"
        return 1
    end

    builtin cd "$HOME/lucid/$repo_path"
end

function __mr_complete
    set -l token (commandline -ct)
    set -l saved_pwd $PWD
    builtin cd "$HOME/lucid"
    complete -C"cd $token"
    builtin cd "$saved_pwd"
end

complete -c mr -f -a "(__mr_complete)"

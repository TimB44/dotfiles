fish_add_path "$HOME/.local/bin"

# The Mac router recreates this socket when its persistent SSH connection
# reconnects, so every remote shell can keep using one stable path.
set -gx SSH_AUTH_SOCK "$HOME/.ssh/mac-agent.sock"

if status is-interactive
    set -U fish_color_command blue
end

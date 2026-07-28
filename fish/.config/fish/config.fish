fish_add_path "$HOME/.local/bin"

# The Mac router recreates this socket when its persistent SSH connection
# reconnects, so every remote shell can keep using one stable path.
set -gx SSH_AUTH_SOCK "$HOME/.ssh/mac-agent.sock"

# Browser requests cross the persistent Mac SSH sidecar while Mosh carries the terminal.
set -gx BROWSER devbox-browser-forwarder
set -gx DEVBOX_BROWSER_SOCKET "/tmp/devbox-agent-ssh-$USER-browser.sock"

if status is-interactive
    set -U fish_color_command blue
end

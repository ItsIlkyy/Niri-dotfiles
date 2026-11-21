if status is-interactive

	set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.config"
source $XDG_CONFIG_HOME/fish/conf.d/aliases.fish
source $XDG_CONFIG_HOME/fish/conf.d/yazi-shell.fish

    set -g fish_greeting ""
    # Commands to run in interactive sessions can go here
fastfetch
end


# Hermes Agent command
fish_add_path "$HOME/.local/bin"


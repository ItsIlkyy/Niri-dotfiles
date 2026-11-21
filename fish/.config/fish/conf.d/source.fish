# User Dirs
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"


# Local Bin
set -x PATH "$HOME/.local/bin" $PATH

zoxide init fish | source

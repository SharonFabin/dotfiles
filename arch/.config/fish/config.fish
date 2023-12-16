if status is-interactive
    # Commands to run in interactive sessions can go here
    #starship init fish | source
    export PATH="$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin/:$PATH"
    export TERM=kitty
    export LC_ALL=en_IL.utf8
    export LANG=en_IL.utf8
    alias vim nvim
    alias tmux "env TERM=screen-256color-bce tmux"
    # fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
end

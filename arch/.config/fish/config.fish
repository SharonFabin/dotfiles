if status is-interactive
    # Commands to run in interactive sessions can go here
    #starship init fish | source
    export PATH="$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin/:$PATH"
    export TERM=kitty
    export LC_ALL=en_IL.utf8
    export LANG=en_IL.utf8
    # export GOOGLE_CLOUD_PROJECT="coral-burner-457508-a7"
    # export GOOGLE_CLOUD_LOCATION="us-east5"
    export AWS_REGION=us-east-2
    export GOOGLE_CLOUD_LOCATION="global"
    # export GOOGLE_GENAI_USE_VERTEXAI=true
    export CLAUDE_CODE_USE_BEDROCK=1
    # export CLAUDE_CODE_USE_VERTEX=1
    # export CLOUD_ML_REGION=us-east5
    # export CLOUD_ML_REGION=global
    # export ANTHROPIC_VERTEX_PROJECT_ID=coral-burner-457508-a7
    # export VERTEX_REGION_CLAUDE_3_5_HAIKU=us-east5
    export CLAUDE_CODE_NOTIFY_ON_COMPLETION=true
    alias vim nvim
    alias tmux "env TERM=screen-256color-bce tmux"
    # fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
end

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/sharon/.local/share/coursier/bin"
# <<< coursier install directory <<<

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

alias claude="/home/sharon/.claude/local/claude"

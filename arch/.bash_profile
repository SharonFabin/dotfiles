# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export LC_ALL=en_IL.utf8
export LANG=en_IL.utf8
xsetroot -cursor_name left_ptr

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"

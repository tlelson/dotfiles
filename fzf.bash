# Setup fzf
# ---------
if [[ ! "$PATH" == */tmp/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/tmp/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.vim/plugged/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.vim/plugged/fzf/shell/key-bindings.bash"



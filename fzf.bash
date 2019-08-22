# Setup fzf
# ---------
if [[ ! "$PATH" == */tmp/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/tmp/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/tmp/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/tmp/.fzf/shell/key-bindings.bash"

# My FZF Settings
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border -m'

fif() {
  if [ ! "$#" -ge 1 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages $1 | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 $1 || rg --ignore-case --pretty --context 10 $1 {}"
}

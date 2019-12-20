# Setup fzf
# ---------
if [[ ! "$PATH" == */home/arsham/Projects/Go/github.com/junegunn/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/arsham/Projects/Go/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/arsham/Projects/Go/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/arsham/Projects/Go/github.com/junegunn/fzf/shell/key-bindings.zsh"

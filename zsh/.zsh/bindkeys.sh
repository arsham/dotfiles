zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':completion:*:make::' tag-order targets variables
zstyle ':fzf-tab:complete:*:*' fzf-preview '([[ -f $realpath ]] && (bat --style=numbers --color=always $realpath || cat $realpath)) || ([[ -d $realpath ]] && (tree -C $realpath | less)) || echo $realpath 2> /dev/null | head -200'
zstyle ':fzf-tab:*' fzf-bindings 'tab:toggle'

# The plugin will auto execute this zvm_before_init function for partial
# searching of the history.
function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-beginning-search-backward
  zvm_bindkey viins '^[[B' history-beginning-search-forward
  zvm_bindkey vicmd '^[[A' history-beginning-search-backward
  zvm_bindkey vicmd '^[[B' history-beginning-search-forward

}
bindkey '^x^e' edit-command-line
bindkey '^[l' clear-screen

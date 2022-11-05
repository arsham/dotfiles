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

##############################################################################
### Enable completion caching, use rehash to clear
# Credit goes to
# https://github.com/umgbhalla/dotstow/blob/main/base/zsh/.config/zsh/completion.zsh
##############################################################################
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # set list-colors to enable filename colorizing
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive tab complete , Smart matching of dashed values, e.g. f-b matching foo-bar
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:*' switch-group ',' '.' # switch group using `,` and `.`
##############################################################################

# history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':completion:*:make::' tag-order targets variables
zstyle ':fzf-tab:complete:*:*' fzf-preview '([[ -f $realpath ]] && (bat --style=numbers --color=always $realpath || cat $realpath)) || ([[ -d $realpath ]] && (tree -C $realpath | less)) || echo $realpath 2> /dev/null | head -200'
zstyle ':fzf-tab:*' fzf-bindings 'tab:toggle'

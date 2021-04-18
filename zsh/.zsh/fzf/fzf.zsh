# Setup fzf
# ---------

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "$DOTFILES/fzf/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Default key bindings
# ------------
# source "/usr/share/fzf/key-bindings.zsh"

export FZF_DEFAULT_OPTS="
--height=80%
--layout=reverse
--border
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
--color info:254,prompt:37,spinner:108,pointer:235,marker:235
--bind alt-j:preview-down,alt-k:preview-up
--multi
--info=inline
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-f:page-down,ctrl-b:page-up'
"


# note that you can get key binding codes with "showkey -a"
# '^I' is for <tab>
# '^'  is for CTRL
# '^]' is for ALT

# bindkey '^T' fzf-completion
#export FZF_COMPLETION_TRIGGER=''
# bindkey '^I' $fzf_default_completion
export FZF_CTRL_R_OPTS='--sort'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'tree -C {} | head -200'"

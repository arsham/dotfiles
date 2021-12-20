# Setup fzf
# ---------

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "$DOTFILES/fzf/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Default key bindings
# ------------
[[ -f "/usr/share/fzf/key-bindings.zsh" ]] && source "/usr/share/fzf/key-bindings.zsh"

export FZF_DEFAULT_COMMAND="fd -H -I -i -p -L --type f -E '.git'"
export FZF_DEFAULT_OPTS="
--height=80%
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254,bg:#1F2527
--color info:254,prompt:37,spinner:108,pointer:235,marker:235
--multi
--info=inline
--history=/home/arsham/.local/share/fzf-history/history-files
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--preview-window hidden,border-none
--bind '?:toggle-preview'
--bind 'ctrl-/:change-preview-window(right,80%|hidden|right,20%|right)'
--bind 'ctrl-a:select-all,ctrl-d:deselect-all'
--bind 'alt-j:preview-down,alt-k:preview-up'
--bind 'ctrl-f:page-down,ctrl-b:page-up'
--bind alt-h:next-history,alt-l:previous-history
--bind 'tab:toggle-out,shift-tab:toggle-in'
"


# note that you can get key binding codes with "showkey -a"
# '^I' is for <tab>
# '^'  is for CTRL
# '^]' is for ALT

# bindkey '^T' fzf-completion
# export FZF_COMPLETION_TRIGGER=''
# bindkey '^I' $fzf_default_completion
export FZF_CTRL_R_OPTS='--sort --layout=reverse'
export FZF_ALT_C_OPTS="--preview -m"
export FZF_CTRL_T_OPTS="--preview -m"

# Use fd instead of the default find command for listing path candidates.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

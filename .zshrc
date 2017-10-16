POWERLEVEL9K_MODE=awesome-patched
source ~/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES

    git
    docker
    command-not-found
    ssh-agent
    gitfast
    git-extras
    tmux
    golang
    docker-compose
    psprint/history-search-multi-word
    colored-man-pages
    z
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    httpie
    pip
    virtualenv
    virtualenvwrapper

EOBUNDLES

# zsh settings
export HISTFILE=/home/arsham/Dropbox/Home/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF8
export EDITOR=nano
export VISUAL=nano

# zsh functions
export fpath=(
    ~/dotfiles/functions
    "${fpath[@]}"
)

if [[ -d ~/dotfiles/functions ]]; then
   for func in $(find ~/dotfiles/functions -type f -exec realpath {} +); do
      unhash -f $func 2>/dev/null
      autoload +X $func
   done
fi

# Load the theme.
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs disk_usage ram battery)
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=4
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S \uE868  %d/%m}"

## Information about the icon unicodes are available in https://github.com/bhilburn/powerlevel9k/blob/master/functions/icons.zsh
## Also running get_icon_names will show you the list
POWERLEVEL9K_HOME_ICON=$'\uE12C '
POWERLEVEL9K_HOME_SUB_ICON=$'\uE18D '
#POWERLEVEL9K_RAM_ICON=$'\uE1E2 '
POWERLEVEL9K_EXECUTION_TIME_ICON=$'\UE89C '
POWERLEVEL9K_FOLDER_ICON=$'\uE818 '
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_PYTHON_ICON=$'\UE63C '

# Apply theme
antigen theme bhilburn/powerlevel9k powerlevel9k

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/.zaliases ] && source ~/dotfiles/.zaliases

# Tell Antigen that you're done.
antigen apply

# fzf settings

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40% --reverse --border
--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254
--color info:254,prompt:37,spinner:108,pointer:235,marker:235'

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
export FZF_CTRL_R_OPTS='--sort'

source ~/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES

    git
    docker
    pip
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

EOBUNDLES

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time ram)
POWERLEVEL9K_MODE='awesome-fopatched'

export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.utf8
export EDITOR=nano
export VISUAL=nano

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/functions ] && source ~/dotfiles/functions
[ -f ~/dotfiles/.zaliases ] && source ~/dotfiles/.zaliases

# Tell Antigen that you're done.
antigen apply

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

EOBUNDLES

# Syntax highlighting bundle.
#antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme agnoster

antigen theme bhilburn/powerlevel9k powerlevel9k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time ram)
POWERLEVEL9K_MODE='awesome-fopatched'

export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export LANG=en_GB.UTF-8
export EDITOR=nano
export VISUAL=nano

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/functions ] && source ~/dotfiles/functions

# Tell Antigen that you're done.
antigen apply

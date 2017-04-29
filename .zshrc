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
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme agnoster

export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
. ~/dotfiles/functions

# Tell Antigen that you're done.
antigen apply

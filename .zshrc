source ~/antigen/bin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle pip
antigen bundle command-not-found
antigen bundle ssh-agent
antigen bundle gitfast 
antigen bundle git-extras 
antigen bundle tmux
antigen bundle golang
antigen bundle docker-compose
antigen bundle psprint/history-search-multi-word
antigen bundle zsh-navigation-tools

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

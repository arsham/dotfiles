autoload -Uz compinit
compinit -u

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
plugins=(gitfast git-extras pip django docker celery python tmux golang openssl git docker-compose)

source $ZSH/oh-my-zsh.sh
export LANG=en_GB.UTF-8
export vblank_mode=0

autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

source ~/.zaliases
unsetopt correct_all

eval $(ssh-agent) > /dev/null

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin"

export EDITOR=nano
export VISUAL=nano

#fpath=($fpath functions)
. ~/dotfiles/functions
zstyle ':completion:*' menu select

[ -f ~/.zshrc-local ] && source ~/.zshrc-local

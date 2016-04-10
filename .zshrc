# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="gentoo"
ZSH_THEME="agnoster"
#ZSH_THEME="powerline"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gitfast git-extras pip django docker celery python tmux golang openssl)
#git

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LANG=en_GB.UTF-8
export vblank_mode=0


# bindkey "\C-r" history-incremental-pattern-search-backward
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward


# Search backwards and forwards with a pattern
#bindkey -M vicmd '/' history-incremental-pattern-search-backward
#bindkey -M vicmd '?' history-incremental-pattern-search-forward

autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


#ubuntu search
#bindkey "\e[A" up-line-or-beginning-search
#bindkey "\e[B" down-line-or-beginning-search

#arch search
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward


bindkey "${terminfo[kcuu1]}" up-line-or-search
bindkey "${terminfo[kcud1]}" down-line-or-search


source ~/.zaliases
unsetopt correct_all

autoload -U compinit
compinit -u

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Xms6G -Xmx6G'

eval $(ssh-agent) > /dev/null

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin"

export EDITOR=nano
export VISUAL=nano

export WORKON_HOME="$HOME/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

export ES_HEAP_SIZE=6g
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#fpath=(`pwd`/arsham_functions $fpath)
. ~/dotfiles/functions

[ -f ~/.zshrc-local ] && source ~/.zshrc-local

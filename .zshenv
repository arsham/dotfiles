DOTFILES=~/dotfiles

# zsh-completion-generator folder
GENCOMPL_FPATH=$DOTFILES/completions
export HISTFILE=/home/arsham/Dropbox/Home/.zsh_history

fpath=($GENCOMPL_FPATH $DOTFILES/functions "${fpath[@]}")

# fix for oh-my-zsh tweaks that let's installing some plugins
ZSH="${HOME}/.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
DISABLE_AUTO_UPDATE=true

export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF8
export EDITOR=nano
export VISUAL=nano
export CFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong"
export CXXFLAGS="${CFLAGS}"

export GOPATH=$HOME/Projects/Go
export PATH="/usr/lib/ccache/bin/:$GOPATH/bin:$PATH"

. $DOTFILES/zsh_conf/powerlevel9k.zsh-theme

# For Qt development in go
export QT_WEBKIT=true
export QT_PKG_CONFIG=true
export CGO_CXXFLAGS_ALLOW=".*"
export CGO_LDFLAGS_ALLOW=".*"
export CGO_CFLAGS_ALLOW=".*"

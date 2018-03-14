# completion generator
export GENCOMPL_FPATH=~/dotfiles/completions

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
    golang
    colored-man-pages
    z
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    pip
    virtualenv
    virtualenvwrapper
    RobSis/zsh-completion-generator
    boot2docker
    emoji

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

if [[ -d ~/dotfiles/widgets ]]; then
   for func in $(find ~/dotfiles/widgets -type f -exec realpath {} +); do
      source $func
   done
fi

. ~/dotfiles/zsh_conf/powerlevel9k.zsh-theme

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/.zaliases ] && source ~/dotfiles/.zaliases

# Tell Antigen that you're done.
antigen apply

# fzf settings
. ~/dotfiles/zsh_conf/fzf

[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

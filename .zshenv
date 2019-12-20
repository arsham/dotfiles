DOTFILES=$HOME/dotfiles

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

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

export PATH="/usr/lib/ccache/bin/:$HOME/go/bin:$PATH"

. $DOTFILES/zsh_conf/powerlevel9k.zsh-theme

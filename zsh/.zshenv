ZSH_HOME=$HOME/.zsh
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc
export CCACHE_DIR=$XDG_CACHE_HOME/ccache
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export CARGO_HOME=$XDG_DATA_HOME/cargo
export K9SCONFIG=$XDG_CONFIG_HOME/k9s

# zsh-completion-generator folder
GENCOMPL_FPATH=$ZSH_HOME/completions
export HISTFILE=$HOME/Dropbox/Home/.zsh_history

fpath=($GENCOMPL_FPATH $ZSH_HOME/functions "${fpath[@]}" autoloaded)

# fix for oh-my-zsh tweaks that let's installing some plugins
ZSH="${HOME}/.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
DISABLE_AUTO_UPDATE=true

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
setopt share_history
export HISTTIMEFORMAT="[%F %T] "

# these variables moved here to override values in plugins.
export HISTSIZE=10000000
export SAVEHIST=10000000
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PAGER='nvim +Man!'

export CFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro"
export MAKEFLAGS="-j$(nproc)"
export CARCH="x86_64"
export CHOST="x86_64-pc-linux-gnu"
export CPPFLAGS="-D_FORTIFY_SOURCE=2"

source $ZSH_HOME/lazy_completions.sh
source $ZSH_HOME/bindkeys.sh

export PATH=/usr/lib/ccache/bin/:$HOME/go/bin:$PATH
export PATH=$PATH:$ZSH_HOME/plugins/git
export PATH=$PATH:$ZSH_HOME/plugins/kubectl
export PATH=$PATH:$HOME/.node_modules/bin
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.config/awesome/scripts
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:$HOME/.nimble/bin
export npm_config_prefix=~/.node_modules
export DOCKER_BUILDKIT=1

export WORDCHARS=""

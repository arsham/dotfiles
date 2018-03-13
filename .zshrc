export ZPLUG_HOME=$HOME/.zplug
[[ -d ~/.zplug ]] || {
  mkdir -p $ZPLUG_HOME
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source ~/.zplug/init.zsh && zplug update
}
source ~/.zplug/init.zsh

# zsh-completion-generator folder
export GENCOMPL_FPATH=~/dotfiles/completions

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

. ~/dotfiles/zsh_conf/powerlevel9k.zsh-theme

zplug "junegunn/fzf-bin",                        from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
zplug "bhilburn/powerlevel9k",                   use:powerlevel9k.zsh-theme, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "lib/key-bindings",                        from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting",       defer:2
zplug "modules/git",                             from:prezto
zplug "modules/docker",                          from:prezto
zplug "plugins/command-not-found",               from:oh-my-zsh
zplug "modules/ssh-agent",                       from:prezto
zplug "modules/golang",                          from:prezto
zplug "modules/colored-man-pages",               from:prezto
zplug "modules/z",                               from:prezto
zplug "modules/pip",                             from:prezto
zplug "tarruda/zsh-autosuggestions"
zplug "modules/virtualenv",                      from:prezto
zplug "modules/virtualenvwrapper",               from:prezto
zplug "plugins/RobSis/zsh-completion-generator", from:oh-my-zsh
zplug "modules/boot2docker",                     from:prezto
zplug "modules/completion",                      from:prezto
zplug "plugins/emoji",                           from:oh-my-zsh
# zplug 'zplug/zplug',                             hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  zplug install
fi


zplug load

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
[ -f ~/dotfiles/.zaliases ] && source ~/dotfiles/.zaliases

# fzf settings
. ~/dotfiles/zsh_conf/fzf

# history search
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

zstyle ':prezto:module:autosuggestions' color 'yes'

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

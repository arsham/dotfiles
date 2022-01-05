figurine $(whoami)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To improve performance, see https://htr3n.github.io/2018/07/faster-zsh/

# To profile zsh startup, uncomment the followin.
# PROFILE_ZSH=true
# ZPROF=true

if [ "$PROFILE_ZSH" = true ] ; then
    mkdir -p $HOME/tmp/zsh_profiles
    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '

    LOG_FILE=$(mktemp $HOME/tmp/zsh_profiles/zsh_profile.XXXXXXXX)
    exec 3>&2 2>$LOG_FILE

    setopt XTRACE
fi

if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

source $ZSH_HOME/install_deps.sh

source $ZSH_HOME/zsh_plugins.sh 2> /dev/null
if [ $? -ne 0 ]; then
    antibody bundle < $ZSH_HOME/zsh_plugins.txt > $ZSH_HOME/zsh_plugins.sh
    source $ZSH_HOME/zsh_plugins.sh
fi

source $ZSH_HOME/zsh_common

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

# these variables moved here to override values in plugins.
export HISTSIZE=9999999999
export SAVEHIST=999999999
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF8
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

[ -f ~/.zshrc-local ] && source ~/.zshrc-local

if [ "$PROFILE_ZSH" = true ] ; then
    unsetopt XTRACE
    exec 2>&3 3>&-
    echo "Logfile location is exported to LOG_FILE variable"
    echo "You can remove this directory once you are finished: $HOME/tmp/zsh_profiles"
    echo "Consider running this: time zsh -i -c echo"
    echo "To see the results: zsh_profiling.sh $LOG_FILE | head"
fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi

export WORDCHARS=""
bindkey '^x^e' edit-command-line

source $ZSH_HOME/extra/_fubectl

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
xset r rate 250 60
setxkbmap -option caps:escape

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZSH_HOME/p10k.zsh ]] || source $ZSH_HOME/p10k.zsh

eval "$(zoxide init zsh --cmd cd)"

# vim: ft=zsh:nowrap

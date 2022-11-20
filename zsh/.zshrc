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

source $ZSH_HOME/install_deps.sh
source /usr/share/zsh-antidote/antidote.zsh

source $ZSH_HOME/zsh_plugins.sh 2> /dev/null
if [ $? -ne 0 ]; then
    antidote bundle < $ZSH_HOME/zsh_plugins.txt > $ZSH_HOME/zsh_plugins.sh
    source $ZSH_HOME/zsh_plugins.sh
fi

source $ZSH_HOME/zsh_common

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

export WORKON_HOME=~/.virtualenvs
[ -f /usr/bin/virtualenvwrapper_lazy.sh ] && source /usr/bin/virtualenvwrapper_lazy.sh

[ -f ~/.zshrc-local ] && source ~/.zshrc-local

if [ "$PROFILE_ZSH" = true ] ; then
    unsetopt XTRACE
    exec 2>&3 3>&-
    echo "Logfile location is exported to LOG_FILE variable"
    echo "You can remove this directory once you are finished: $HOME/tmp/zsh_profiles"
    echo "Consider running this: time zsh -i -c echo"
    echo "To see the results: zsh_profiling.sh $LOG_FILE | head"
fi

function my_init() {
    source $ZSH_HOME/fzf/fzf.zsh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(my_init)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZSH_HOME/p10k.zsh ]] || source $ZSH_HOME/p10k.zsh

eval "$(zoxide init zsh --cmd cd)"
source $ZSH_HOME/plugins/abbreviations

# vim: ft=zsh nowrap

# Remember to link .zshrc in your home folder.

source $DOTFILES/.zsh_plugins.sh 2> /dev/null
if [ $? -ne 0 ]; then
    antibody bundle < $DOTFILES/.zsh_plugins.txt > $DOTFILES/.zsh_plugins.sh
    source $DOTFILES/.zsh_plugins.sh
fi

. $DOTFILES/zsh_conf/zsh_common

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

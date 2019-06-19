#!/bin/sh
ln -s dotfiles/.zshrc ~/.zshrc 2> /dev/null
ln -s dotfiles/.zaliases ~/.zaliases 2> /dev/null
ln -s dotfiles/.zshenv ~/.zshenv 2> /dev/null
ln -s dotfiles/.drirc ~/.drirc 2> /dev/null
ln -s /home/arsham/dotfiles/zsh_conf/.fzf.zsh ~/.fzf.zsh 2> /dev/null
ln -s dotfiles/.gitconfig ~/.gitconfig 2> /dev/null
ln -s dotfiles/.makepkg.conf ~/.makepkg.conf 2> /dev/null
ln -s dotfiles/.tmux.conf ~/.tmux.conf 2> /dev/null
rm -rf $DOTFILES/.zsh_plugins.sh

if ! which fzf > /dev/null; then
    go get -u github.com/junegunn/fzf
    ln -s $DOTFILES/zsh_conf/.fzf.zsh ~/ 2> /dev/null
fi

if ! which figurine > /dev/null; then
    go get -u github.com/arsham/figurine
fi

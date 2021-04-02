#!/bin/sh
cd ../
git clone git@github.com:tomv564/LSP
git clone https://git.kuroku.io/GoSublime -b development
git clone git@github.com:arsham/HaoGist
git clone git@github.com:arsham/sublime-mate
git clone git@github.com:arsham/GoRename
sudo pacman -S python-pip
sudo pip install -U "python-language-server[all]"
yay -S dockerfile-language-server-bin yaml-language-server-bin

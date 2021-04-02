#!/bin/sh
update() {
    cd ../$1
    git pull origin
    cd ../User
}

for dir in LSP HaoGist sublime-mate GoRename GoSublime; do
    echo "Updating $dir"
    update $dir
done

sudo pip install -U "python-language-server[all]"

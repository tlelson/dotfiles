#!/usr/bin/env bash

echo "Setting up vim and vimrc ... "
for file in vim  vimrc
do
    echo "looking for ~/.${file} .."
    if [ -h ~/.${file} ]; then # Is it a sybolic link ?
        echo "  Already exists as symbolic link. Not linking to new dotfiles version.  If you want it remove your current one ..."
    elif [ -e ~/.${file}  ]; then # Does it exist (implies not symbolic link)?
        echo "  File exists.  Moving to ${file}_old"
        mv ~/.${file} ~/.${file}_old
        ln -s $(pwd)/${file} ~/.${file}
    else
        echo "  File not found. Linking to new dotfiles version ... "
        ln -s $(pwd)/${file} ~/.${file}
    fi
done

echo "1.    Test if vim has lua: ':echo has(\"lua\")' ... in vim.  This needs to be '1'"
echo "      for ubuntu install: vim-nox"
echo "      for mac: brew install vim --with-lua"
echo "2.    :PluginInstall"

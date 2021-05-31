#!/usr/bin/env bash

# Setup Plugin manager
echo "Making a .vim/ for file specific settings"
if [ -d ~/.vim ];
    then
        echo "~/.vim already exists";
    else
        echo "~/.vim does not exist or is not a directory.";
        rm -rf ~/.vim
        mkdir ~/.vim
fi
ln -s $(pwd)/after ~/.vim/after
echo 'Setting up vim with `junegunn/vim-plug` .... '
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Copying vimrc"
for file in vimrc
do
    echo "looking for ~/.${file} .."
    if [ -h ~/.${file} ]; then # Is it a sybolic link ?
        echo "  Already exists as symbolic link. Not linking to new dotfiles version.  If you want it, remove your current one ..."
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
echo "2.    !! Install go and node before the installing YCM."
echo "3.    Open vim and do the followining to get bundles:"
echo "          :PlugInstall"

#!/usr/bin/env bash

# Setup Config
echo "Making a .config/nvim/ for configuration"
if [ -d ~/.config/nvim ];
    then
        echo "~/.config/nvim already exists. Moving to /tmp . Review it before next shutdown!";
        mv ~/.config/nvim /tmp
    else
        echo "~/.config/nvim does not exist or is not a directory.";
fi

rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim
echo "dotfiles/nvim linked to ~/.config/nvim ..."

echo 'Downloading latest stable release of neo-vim .... '
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo /etc/alternatives/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x /etc/alternatives/nvim

echo "Unlinkimg current vim ..."
rm $(which vim)
ln -s /usr/local/bin/vim /etc/alternatives/nvim

echo "3.    Open vim and install plugins with:"
echo "          :PackerInstall"

#!/usr/bin/env bash

# Setup Config
echo "Making a .config/nvim/ for configuration"
if [ -d ~/.config/nvim ]; then
	echo '~/.config/nvim already exists. Moving to /tmp . Review it before next shutdown!'
	# required
	mv ~/.config/nvim{,.bak}

	# optional but recommended
	mv ~/.local/share/nvim{,.bak}
	mv ~/.local/state/nvim{,.bak}
	mv ~/.cache/nvim{,.bak}
else
	echo '~/.config/nvim does not exist or is not a directory.'
fi

if [ ! -d ~/.config ]; then
	mkdir ~/.config
fi

git clone https://github.com/tlelson/nvim.git ~/.config/nvim

if [[ $OSTYPE == "linux"* ]]; then
	echo 'Downloading latest stable release of neo-vim .... '
	curl -fLo /etc/alternatives/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod +x /etc/alternatives/nvim

	echo "Call with 'nvim' or relink manually ..."
	#rm $(which vim)
	#ln -s /etc/alternatives/nvim /usr/local/bin/nvim

elif [[ $OSTYPE == "darwin"* ]]; then
	echo 'Neo-vim alread downloaded by `setup.sh`. Linking `vim` to `nvim` ...'
	ln -s $(which nvim) $(brew --prefix)/bin/vim
fi

echo "3.    Open vim and install plugins with:"
echo "          :Lazy

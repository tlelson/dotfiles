#!/usr/bin/env bash

echo "Copying dotfiles into location ..."
for file in mybashrc bash_profile htoprc gitconfig gitignore jshintrc gitattributes eslintrc.js jnettop tigrc tmux.conf.local ctags ripgreprc npmrc yamllint.yaml tmux.conf; do
	echo "looking for ~/.${file} .."
	if [ -h ~/.${file} ]; then # Is it a sybolic link ?
		echo "  Already exists as symbolic link. Not linking to new dotfiles version.  If you want it remove your current one ..."
	elif [ -e ~/.${file} ]; then # Does it exist (implies not symbolic link)?
		echo "  File exists.  Moving to ${file}_old"
		mv ~/.${file} ~/.${file}_old
		ln -s $(pwd)/${file} ~/.${file}
	else
		echo "  File not found. Linking to new dotfiles version ... "
		ln -s $(pwd)/${file} ~/.${file}
	fi
done

echo 'Copy config files into `.config` ...'
for file in $(ls ./config); do
	echo "ln -s $(pwd)/config/$file ~/.config/$file"
done

# Set use my bash config
echo "Sourcing '~/.mybashrc' from system '~/.bashrc' ... "
echo "source ~/.mybashrc" >>~/.bashrc

# Setup Ipython preferences
# Notice that two files go up.  The higher one has access to the `c` config object
# and the other doesn't.  There may be a way to merge them but its fine for now
echo "Setting up ipython auto start config ..."
mkdir -p ~/.ipython/profile_default/startup/
ln -s $(pwd)/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -s $(pwd)/ipython_setup.ipy ~/.ipython/profile_default/startup/ipython_setup.ipy

mkdir -p ~/.w3m
ln -s $(pwd)/w3m-keymap ~/.w3m/keymap

if [[ $OSTYPE == "darwin"* ]]; then
	echo "darwin based system detected. Assuming MacOS"
	echo "Changing default shell back to bash ..."
	chsh -s /bin/bash
	echo "Installing homebrew ..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "Installing homebrew packages ..."
	echo 'DO NOT `conda init` when it askes you to !'
	brew install $(grep -v '#' brew-leaves.out | xargs)
	ln -s $(pwd)/bashrc_osx ~/.bashrc_os
elif (command -v dnf); then
	echo "'dnf' found. Assuming CentOS-ish ..."
	sudo dnf update && sudo dnf upgrade -y
	sudo dnf install -y $(grep -v "#" dnf-packs | xargs)
	ln -s $(pwd)/bashrc_linux ~/.bashrc_os
elif (command -v yum); then
	echo "'yum' found. Assuming Old CentOS-ish ..."
	sudo yum update && sudo yum upgrade -y
	sudo yum install -y $(grep -v "#" dnf-packs | xargs)
	ln -s $(pwd)/bashrc_linux ~/.bashrc_os
elif (command -v apt); then
	echo "'apt' found. Assuming debian ..."

	# Add conda repo
	curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
	sudo install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
	gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | \
		sudo tee -a /etc/apt/sources.list.d/conda.list

	sudo apt update && sudo apt upgrade -y
	sudo apt install -y $(grep -v "#" apt-packs | xargs)
	ln -s $(pwd)/bashrc_linux ~/.bashrc_os

	source /opt/conda/etc/profile.d/conda.sh  # to get `conda`
else
	echo "Unknown system ... "
fi
	echo "Setting up python/node sandbox ..."
	conda create -y -n general python ipython nodejs

if [[ ! -z "${WSL_DISTRO_NAME}" ]]; then
	echo "$(whoami) ALL = (root) NOPASSWD: /etc/init.d/dbus" | sudo tee -a /etc/sudoers.d/dbus
fi

echo 'LS_COLORS have been pre-generated with `vivid` (https://github.com/sharkdp/vivid)'
echo "	If they don't work for your system, disable or regenerate var in dotfiles/bashrc_linux"
echo ""
echo 'RESTART your shell ... resolve fzf errors by running `setup_vim.sh`.  Or install it manually.'


echo "Copying dotfiles into location ..."
for file in mybashrc  bash_profile  htoprc gitconfig  tmux.conf gitignore  jshintrc gitattributes eslintrc.js jnettop tigrc tmux.conf.local dircolors fzf.bash
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

# Set use my bash config
echo "Sourcing '~/.mybashrc' from system '~/.bashrc' ... "
echo "source ~/.mybashrc" >> .~/.bashrc

# Setup Ipython preferences      # TODO: Does this need to be *.ipy ??
echo "Setting up ipython auto start config ..."
mkdir -p ~/.ipython/profile_default/startup/
ln -s $(pwd)/ipython_setup.ipy ~/.ipython/profile_default/startup/ipython_setup.ipy

# Set up TMUX
echo "Using tmux config from `https://github.com/gpakosz/.tmux`.  See repo for details ..."
git clone https://github.com/gpakosz/.tmux.git ~/dotfiles/.tmux
ln -s -f ~/dotfiles/.tmux/.tmux.conf ~/.tmux.conf
# This needs to exist long term for the attached scripts

echo "To configure your required applications use:"
echo 'for MacOS'
echo '    $ brew install $(cat brew-leaves.out)'
echo 'or for debian:'
echo '    $ sudo apt install -y $(grep -v '#' apt-packs | xargs )'

echo ""
echo "Note the following packages must be installed from source: [fzf, prettyping]"

echo ""
echo "If you're running on WSL.  Fix mounts and permissions with:"
echo "  $ cp etc_wsl.conf /etc/wsl.conf"

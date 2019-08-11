

for file in mybashrc  bash_profile  htoprc gitconfig  tmux.conf gitignore  jshintrc gitattributes eslintrc.js jnettop tigrc tmux.conf.local dircolors
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
echo "source ~/.mybashrc" >> .~/.bashrc

# Setup Ipython preferences
mkdir -p ~/.ipython/profile_default/startup/
ln -s $(pwd)/ipython_setup.py ~/.ipython/profile_default/startup/ipython_setup.py

# setup Python pudb preferences
#ln -s $(pwd)/pudb.cfg ~/.config/pudb/pudb.cfg

echo "Rename your .bashrc_old to .bashrc_local if you want its settings."

# Set up TMUX
echo "Using tmux config from `https://github.com/gpakosz/.tmux`.  See repo for details ..."
git clone https://github.com/gpakosz/.tmux.git ~/dotfiles/.tmux
ln -s -f ~/dotfiles/.tmux/.tmux.conf ~/.tmux.conf
# This needs to exist long term for the attached scripts


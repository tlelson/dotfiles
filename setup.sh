# Nix based system setup

# Install curl
sudo apt install curl git -y

# Get dotfiles repo
mkdir -p ~/.config
git clone --branch nix-home-manager https://github.com/tlelson/dotfiles.git ~/.config/home-manager

# Install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Restart shell (hash -r?)

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# /home/min/.config/home-manager/home.nix

# nix-env --query --installed
# shows only home-manager installed
#
# Cleanup
sudo apt remove curl git  # These are managed by HM now

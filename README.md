# Install Nix on WSL

Assume we use the Debain as our base system, first install the required packages
to bootstrap the `Nixpkgs`.

```bash
sudo apt-get update
sudo apt-get install curl xz-utils
```

Install the `nixpkgs`, and source the `nix.sh` to enter the promised land.

```bash
curl -L https://nixos.org/nix/install | sh
source $HOME/.nix-profile/etc/profile.d/nix.sh
```

Subscribe the `home-manager` channel, and install the `home-manager`.

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

nix-channel --update

nix-shell '<home-manager>' -A install
```

Install the git client, then clone `nix-config`

```bash
nix-env -iA gitAndTools.gitFull
git clone https://github.com/kunxi/nix-config.git ~/.config/nixpkgs
```

Then run `home-manager` to finish the deployment.

```bash
home-manager switch
```

Add the `zsh` to trusted shells, then switch to zsh

```bash
echo /home/bookstack/.nix-profile/bin/zsh | sudo tee -a /etc/shells
chsh -s /home/bookstack/.nix-profile/bin/zsh
```

Restart the shell, and you should expect the familiar zsh with *pure* theme.
Ensure the `locale = "C.UTF-8"` is set, otherwise the autocomplete will mess
up the prompts.
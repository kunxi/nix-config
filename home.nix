{ config, pkgs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./rust.nix
    ./python.nix
    ./nodejs/default.nix
    ./minizinc/default.nix
  ];

  home = {
    packages = with pkgs; [
      htop
      ripgrep
      file
      openssh
      strace
      ltrace
      inetutils
      wget
      gcc
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = locale;
      LC_ALL = locale;
    };

    username = username;
    homeDirectory = homedir;
    stateVersion = "21.11";
  };

  programs.home-manager.enable = true;

  # Use nix-direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # neovim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      # TODO: need more plugins here.
    ];
  };

  # Invoke home-manager: `home-manager switch` to deploy the change, to switch
  # the shell:
  #  $ echo /home/bookstack/.nix-profile/bin/zsh | sudo tee -a /etc/shells
  #  $ chsh -s /home/bookstack/.nix-profile/bin/zsh

  # ssh
  programs.ssh = {
    enable = true;
    # TODO: add more configuration here.
  };

}


{ config, pkgs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./git.nix
    ./neovim.nix
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

  # ssh
  programs.ssh = {
    enable = true;
    # TODO: add more configuration here.
  };

}


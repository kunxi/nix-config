{ config, pkgs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./cli.nix
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
    ./rust.nix
    ./cloud.nix
    ./python.nix
    ./nodejs/default.nix
    ./minizinc/default.nix
    ./tmux.nix
  ];

  home = {
    packages = with pkgs; [
      datamash
      file
      gcc
      graphviz
      htop
      inetutils
      ltrace
      openssh
      patch
      rlwrap  # rlwrap sqlite3 foo.db for readline support.
      sqlite
      strace
      wget
      # TODO: add gm, ffmpeg with CUDA 
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


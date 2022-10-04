{ config, pkgs, ... }:

let
  locale = "en_US.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
    ./rust.nix
    ./devops.nix
    ./python.nix
    ./nodejs/default.nix
    ./minizinc/default.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  programs.home-manager.enable = true;
  
  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "22.11";
  };

  home.sessionVariables = {
      LANG = locale;
      LC_ALL = locale;
      EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # dig
    # gcc
    # gnumake
    # inetutils
    #ltrace
    # strace
    autoconf
    bat # cat replacement written in Rust
    curl
    datamash
    direnv
    docker
    docker-compose
    dos2unix
    exa
    fd
    file
    fzf
    graphviz
    gradle
    htop
    httpie
    jq
    just
    mdcat
    neofetch
    nomad
    openssh
    patch
    parallel
    podman
    pre-commit
    redis
    ripgrep
    rlwrap  # rlwrap sqlite3 foo.db for readline support.
    sd # sed replacement
    skim # fuzzy finder
    sqlite
    starship
    tealdeer
    tokei # Handy tool to see lines of code by language
    tree
    unzip
    vscode
    wget
    xsv
    yarn
    # TODO: add gm, ffmpeg with CUDA 
  ];


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


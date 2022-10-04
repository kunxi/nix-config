{ config, pkgs, ... }:

let
  locale = "en_US.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";

  devopsPackages = with pkgs; [
    awscli
    aws-sam-cli
    aws-iam-authenticator

    kubectl
    kubectx
    kubernetes-helm
    skaffold
    tilt

    terraform
    vault
  ];

  pythonPackages = with pkgs.python310Packages; [
    black
    cookiecutter
    flake8
    ipython
    pip
    python
    setuptools

    # python, if we want to use conda
    # First time use:
    # $ conda-shell
    # $ conda-install
    # Normal use:
    # $ conda-shell
    # $ conda install ipython numpy
    # conda
  ];

in
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./zsh.nix
    ./rust.nix
    ./nodejs/default.nix
    ./minizinc/default.nix
    ./tmux.nix
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
    zoxide
    # TODO: add gm, ffmpeg with CUDA
  ] ++ devopsPackages ++ pythonPackages;


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


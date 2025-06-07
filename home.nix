{ config, pkgs, ... }:

let
  locale = "en_US.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";

  linuxPackages = with pkgs; [
    binutils
    dig
    gcc
    gnumake
    inetutils
    ltrace
    strace
  ];

  macOSPackages = with pkgs; [];
in
{
  imports = [
    # ./crypto.nix
    ./git.nix
    ./devops.nix
    ./devel.nix
    ./neovim.nix
    ./zsh/default.nix
    ./python.nix
    ./rust.nix
    ./nodejs/default.nix
    ./minizinc/default.nix
    ./tmux.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.home-manager.enable = true;

  home = {
    username = username;
    homeDirectory = homedir;
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
  };

  home.sessionVariables = {
    LANG = locale;
    LC_ALL = locale;
    LC_CTYPE = locale;
  };

  home.packages = with pkgs; [
    # bat # cat replacement written in Rust
    bc
    curlFull
    datamash # stats
    dos2unix
    fd  # find
    file
    fzf
    graphviz
    htop
    imagemagick
    iperf3
    # just  # make alternative
    # mdcat
    # neofetch
    # nomad
    openssh
    parallel
    # podman
    restic  # backup
    # sd  # sed replacement
    # skim # fuzzy finder
    unzip
    wget
    # zoxide  # cd
    # TODO: add gm, ffmpeg with CUDA
  ] ++ pythonPackages
    ++ lib.optionals pkgs.hostPlatform.isLinux linuxPackages
    ++ lib.optionals pkgs.hostPlatform.isDarwin macOSPackages
  ;

  # ssh
  programs.ssh = {
    enable = true;
    # TODO: add more configuration here.
  };
}

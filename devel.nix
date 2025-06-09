{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv

    autoconf
    cmake
    httpie
    jq
    patch
    pre-commit
    pv  # progress view
    ripgrep
    rlwrap  # rlwrap sqlite3 foo.db for readline support.
    tree
    tealdeer  # tldr
    tokei # Handy tool to see lines of code by language

    # Database
    redis
    sqlite
  ];

  # Use nix-direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

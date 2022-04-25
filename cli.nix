# The command line utils for productivities
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat         # a cat clone
    fd          # replace find
    ripgrep     # replace grep
    zoxide      # replace cd
    dust        # replace du
  ];
}
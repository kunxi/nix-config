{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
  ];

  # Add fzf keybindings.
  programs.zsh.initExtra = ''
      # fzf autocomplete
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
  '';
}
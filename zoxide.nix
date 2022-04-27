{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zoxide
  ];

  # Add fzf keybindings.
  programs.zsh.initExtra = ''
      # zoxide installation
      eval "$(zoxide init zsh)"
  '';
}

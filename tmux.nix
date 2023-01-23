{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    sensibleOnTop  = true;
    plugins = with pkgs; [
      tmuxPlugins.pain-control
      tmuxPlugins.copycat
      tmuxPlugins.yank
      tmuxPlugins.logging
    ];

    # TODO: still need the configure the theme for eye-candy.
  };
}

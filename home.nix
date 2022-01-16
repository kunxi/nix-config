{ config, pkgs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./git/default.nix
    ./zsh/default.nix
    ./rust/default.nix
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

      # python, using conda
      # First time use:
      # $ conda-shell
      # $ conda-install
      # Normal use:
      # $ conda-shell
      # $ conda install ipython numpy
      conda
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = locale;
      LC_ALL = locale;
      TMUX_TMPDIR = "/tmp";
    };

    username = username;
    homeDirectory = homedir;
    stateVersion = "21.11";
  };

  programs.home-manager.enable = true;

  # tmux
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

  # Use nix-direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # neovim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      # TODO: need more plugins here.
    ];
  };

  # Invoke home-manager: `home-manager switch` to deploy the change, to switch
  # the shell:
  #  $ echo /home/bookstack/.nix-profile/bin/zsh | sudo tee -a /etc/shells
  #  $ chsh -s /home/bookstack/.nix-profile/bin/zsh

  # ssh
  programs.ssh = {
    enable = true;
    # TODO: add more configuration here.
  };

}


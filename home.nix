{ config, pkgs, ... }:

let
  locale = "C.UTF-8";
  homedir = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  imports = [
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

      # nodej
      nodejs-14_x
      yarn

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

  # git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    userName = "Kun Xi";
    userEmail = "kunxi@kunxi.org";
    aliases = {
      a = "add";
      br = "branch";
      st = "status";
      ss = "status --short";
      ci = "commit";
      di = "diff";
      co = "checkout";
      w = "whatchanged";
      vimdiff = "difftool --tool=vimdiff -y";
      vd = "difftool --tool=vimdiff -y";
      od = "difftool --tool=opendiff -y";
      unstage = "reset HEAD";
      lol = "log --oneline --graph --decorate";
      hist = "log --all --graph --pretty='[%C(cyan)%h%Creset]%C(bold cyan)%d%Creset %s'";
      showdiff = "!sh -c 'git difftool --tool=vimdiff -y $1^ $1' -";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      wl = "walklog";
      dt = "difftool";
    };

    extraConfig = {
      core = {
        editor = "nvim";
        preloadingindex = true;
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };

      merge.tool = "vimdiff";
      diff.tool = "vimdiff";
      difftool.prompt = false;
      pull.rebaes = true;
      push.default = "current";
    };

    # TODO: add gitignore.
  };

  # zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
  };

  programs.zsh.prezto =  {
    enable = true;

    color = true;
    pmodules = [
      "environment"
      "terminal"
      "editor"
      "history"
      "directory"
      "spectrum"
      "utility"
      "completion"
      "prompt"
      "syntax-highlighting"
      "autosuggestions"
      "ssh"
      "ruby"
      "python"
      "node"
    ];
    editor.keymap = "emacs";
    editor.dotExpansion = true;
    prompt.theme = "pure";

    python.virtualenvInitialize = true;
    python.virtualenvAutoSwitch = true;
    ruby.chrubyAutoSwitch = true;

    ssh.identities = [ "id_rsa" "id_rsa2" "id_github" ];

    syntaxHighlighting.highlighters = [ "main" "brackets" "pattern" "line" "cursor" "root" ];

    terminal = {
      autoTitle = true;
      windowTitleFormat = "%n@%m: %s";
      tabTitleFormat = "%m: %s";
      multiplexerTitleFormat = "%s";
    };
    utility.safeOps = true;

    extraConfig = ''
      source $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
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


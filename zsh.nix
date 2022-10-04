{ config, pkgs, ... }:

{
  # Invoke home-manager: `home-manager switch` to deploy the change, to switch
  # the shell:
  #  $ echo /home/bookstack/.nix-profile/bin/zsh | sudo tee -a /etc/shells
  #  $ chsh -s /home/bookstack/.nix-profile/bin/zsh

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    initExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys to Git
      if [ -e ~/.envrc ]; then
        . ~/.envrc
      fi

      path+=("$HOME/bin")

      # fzf autocomplete
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # zoxide installation
      eval "$(zoxide init zsh)"
    '';
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
    # prompt.theme = "pure";

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

  };

  programs.zsh.zplug = {
    enable = false;
    plugins = [
      { name = "b4b4r07/enhancd"; tags = [use:init.sh]; }
    ];
  };
}

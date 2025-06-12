{ config, lib, pkgs, ... }:

{
  # Invoke home-manager: `home-manager switch` to deploy the change, to switch
  # the shell:
  #  $ echo /home/bookstack/.nix-profile/bin/zsh | sudo tee -a /etc/shells
  #  $ chsh -s /home/bookstack/.nix-profile/bin/zsh

  # use starship, and no-nerd-font preset, see issue #576
  programs.starship.enable = true;

  home.file = {
    "starship.config" = {
      source = ./no-nerd-font.toml;
      target = ".config/starship.toml";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;

    shellAliases = rec {
      k = "kubectl";
      ls = "eza";
    };

    initContent = ''
      # Source the nix-daemon if file exists.
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi

      # Otherwise, fallback to the single-user mode.
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys to Git
      if [ -e ~/.envrc ]; then
        . ~/.envrc
      fi

      path+=("$HOME/bin")
      if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
        path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")
      fi

      # fzf autocomplete
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # zoxide installation
      # eval "$(zoxide init zsh)"

      if (( ''$+WSL_DISTRO_NAME )); then
        # WSL-specific aliases
        alias pbcopy=clip.exe
      fi
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
      "gpg"
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

    ssh.identities = [ "id_rsa" "id_rsa2" "id_github" "id_ecdsa" "id_ed25519" ];

    syntaxHighlighting.highlighters = [ "main" "brackets" "pattern" "line" "cursor" "root" ];

    terminal = {
      autoTitle = true;
      windowTitleFormat = "%n@%m: %s";
      tabTitleFormat = "%m: %s";
      multiplexerTitleFormat = "%s";
    };
    utility.safeOps = true;

  };
}

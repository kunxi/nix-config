{ config, pkgs, ... }:
{
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
      path+=("$HOME/bin")
    '';
  };

}

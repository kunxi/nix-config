{ config, pkgs, ... }:

{
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
        autocrlf = true;
        eol = "lf";
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };

      merge = {
        tool = "vimdiff";
        conflictStyle = "diff3";
      };

      diff = {
        tool = "vimdiff";
        wsErrorHighlight = "all";
        colorMoved = true;
        colorMovedWS = "allow-indentation-change";
      };

      pull = {
        rebaes = true;
        default = "current";
      };

      log.date = "local";
      rebase.autosquash = true;
      stash.showPath = true;
      tag.sort = "version:refname";
      difftool.prompt = false;
    };

    # TODO: add gitignore.
  };
}
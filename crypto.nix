{ config, pkgs, ... }:

{
  linuxPackage = with pkgs; [
    pinentry
  ];

  home.packages = with pkgs; [
    gnupg
    pass
  ] ++ lib.optionals pkgs.hostPlatform.isLinux linuxPackage;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
  };

  # NO need to setup GPG_TTY, the gpg module of prezto handles it.
  # TODO: setup SSH_AUTH_SOCK and use gpg-agent to manage ssh sessions.
}


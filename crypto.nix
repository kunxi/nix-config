{ config, pkgs, ... }:

let 
  linuxPackages = with pkgs; [
    pinentry
  ];
in
{
  home.packages = with pkgs; [
    gnupg
    pass
  ] ++ lib.optionals pkgs.hostPlatform.isLinux linuxPackages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
  };
}


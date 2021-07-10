{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs-14_x
    yarn
  ];

  home.file = {
    "npmrc" = {
      source = ./npmrc;
      target = ".npmrc";
    };
  };
}

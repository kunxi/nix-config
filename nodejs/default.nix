{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs-18_x
    yarn
  ];

  home.file = {
    "npmrc" = {
      source = ./npmrc;
      target = ".npmrc";
    };
  };
}

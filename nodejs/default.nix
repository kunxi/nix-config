{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs-18_x
    yarn
    nodePackages.lerna
    nodePackages.jsonlint
  ];

  home.file = {
    "npmrc" = {
      source = ./npmrc;
      target = ".npmrc";
    };
  };
}
